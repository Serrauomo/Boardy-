//
//  DefinedEndpoints.swift
//  Brainstorming
//
//  Created by Alessio Garzia Marotta Brusco on 11/11/24.
//

import Foundation

enum DefinedEndpoints {
    static let createUser = Endpoint<User.CreateUserData, VoidType>(.post, path: "users/")
    
    static let login = Endpoint<User.LoginData, AuthenticationManager.AuthenticationToken>(.post, path: "users/login/")
    static let logout = Endpoint<VoidType, VoidType>(.post, path: "users/logout/") // remove the token from keychain

    static let usersAll = Endpoint<VoidType, [User]>(.get, path: "users/")
    static let userAccount = Endpoint<VoidType, User>(.get, path: "users/account/")
    
    static let createProject = Endpoint<Project.CreateProjetData, Project>(.post, path: "projects/")
    static let projectsAll = Endpoint<VoidType, [Project]>(.get, path: "projects/")

    static let createBoard = Endpoint<Board.CreateBoardData, VoidType>(.post, path: "boards/")
    static let boardsByProjectID = Endpoint<Project.ID, [Board]>(.get, path: "projects/:projectID/boards/")

    static let updateBoard = Endpoint<Board.UpdateBoardData, VoidType>(.put, path: "boards/")
    
    // Voting…
    // TODO: Deletion…
}
