//
//  Client.swift
//  Brainstorming
//
//  Created by Alessio Garzia Marotta Brusco on 10/11/24.
//

// Auth bearer token in header.

import Foundation

protocol Client: Actor {
    associatedtype ClientData: Decodable
    
    var data: ClientData { get async throws }
    
    func call<Input: Encodable, Output: Decodable>(_ endpoint: Endpoint<Input, Output>, input: Input?) async throws -> (output: Output?, response: URLResponse)
    func handle(_ response: URLResponse) throws
}

extension Client {
    @discardableResult
    func call<Input: Encodable, Output: Decodable>(_ endpoint: Endpoint<Input, Output>, input: Input? = nil) async throws -> (output: Output?, response: URLResponse) {
        var request = endpoint.request
        
        if await AuthenticationManager.main.isAuthenticated {
            await handleAuthorization(for: &request)
        }
        
        switch endpoint.method {
        case .get:
            return try await callGet(request, input: input)
            
        case .post, .put:
            return try await callPostPut(request, input: input)
            
        default:
            fatalError()
        }
    }
    
    func handle(_ response: URLResponse) throws {
        guard let httpResponse = response as? HTTPURLResponse else {
            throw ClientError.invalidResponse
        }
        
        guard httpResponse.statusCode != 401 else {
            throw ClientError.badAuthorization
        }
        
        guard (200...299).contains(httpResponse.statusCode) else {
            throw ClientError.serverError
        }
    }
    
    fileprivate func handleAuthorization(for request: inout URLRequest) async {
        guard let token = await AuthenticationManager.main.authenticationToken else { return }
        request.addValue("Bearer \(token.tokenValue)", forHTTPHeaderField: "Authorization")
    }
    
    fileprivate func callGet<Input: Encodable, Output: Decodable>(_ request: URLRequest, input: Input?) async throws -> (Output?, URLResponse) {
        var request = request
        
        if let projectID = input as? Project.ID,
           let url = request.url,
            let urlWithParams = URL(string: url.absoluteString.replacingOccurrences(of: ":projectID", with: projectID.uuidString))
        {
            request.url = urlWithParams
        }
        
        let (data, response) = try await URLSession.shared.data(for: request)
        
        let decoder = JSONDecoder()
        decoder.dateDecodingStrategy = .iso8601
        let decoded = try decoder.decode(Output.self, from: data)
       
        return (decoded, response)
    }
    
    fileprivate func callPostPut<Input: Encodable, Output: Decodable>(_ request: URLRequest, input: Input?) async throws -> (Output?, URLResponse) {
        guard let input else { throw ClientError.noInputData }
        
        if let loginData = input as? User.LoginData {
            return try await handleLogin(request, loginData: loginData)
        } else {
            let uploadData = try JSONEncoder().encode(input)
            let (data, response) = try await URLSession.shared.upload(for: request, from: uploadData)
            
            print(String(data: data, encoding: .utf8))
            
            return (nil, response)
        }
    }
    
    fileprivate func handleLogin<Output: Decodable>(_ request: URLRequest, loginData: User.LoginData) async throws -> (Output, URLResponse) {
        var request = request
        let base64Encoded = "\(loginData.email):\(loginData.passwordHash)".data(using: .utf8)?.base64EncodedString() ?? ""
        
        request.setValue(
            "Basic \(base64Encoded)",
            forHTTPHeaderField: "Authorization"
        )
        
        let (data, response) = try await URLSession.shared.data(for: request)
        let token = try JSONDecoder().decode(Output.self, from: data)
        return (token, response)
    }
}
