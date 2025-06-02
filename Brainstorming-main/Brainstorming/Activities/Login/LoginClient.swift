//
//  LoginClient.swift
//  Brainstorming
//
//  Created by Alessio Garzia Marotta Brusco on 15/11/24.
//

import Foundation

actor LoginClient: Client {
    // Useless right now…
    var data: AuthenticationManager.AuthenticationToken?
    
    @MainActor
    func login(email: String, password: String) async throws {
        let (token, response) = try await call(DefinedEndpoints.login, input: User.LoginData(email: email.lowercased(), passwordHash: password))
        try await handle(response)
        
        guard let token else { throw ClientError.noOutputData }
        AuthenticationManager.main.authenticationToken = token
    }
}
