//
//  Endpoint.swift
//  Brainstorming
//
//  Created by Alessio Garzia Marotta Brusco on 10/11/24.
//

import Foundation

struct Endpoint<Input: Encodable, Output: Decodable>: Equatable {
    let url: URL
    let method: HTTPMethod
    
    var request: URLRequest {
        var request = URLRequest(url: url)
        request.httpMethod = method.string
        
        if method == .post || method == .put {
            request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        }
        
        return request
    }
    
    init(
        _ method: HTTPMethod,
        baseURL: URL = URL(string: "https://brainstorming-api-bf48e0b92a17.herokuapp.com/api/")!,
        path: String
    ) {
        self.method = method
        url = baseURL.appendingPathComponent(path)
    }
}
