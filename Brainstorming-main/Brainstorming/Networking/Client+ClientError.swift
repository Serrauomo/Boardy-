//
//  Client+ClientError.swift
//  Brainstorming
//
//  Created by Alessio Garzia Marotta Brusco on 12/11/24.
//

import Foundation

enum ClientError: Error {
    case noInputData
    case invalidResponse
    case serverError
    case noOutputData
    case badAuthorization
}
