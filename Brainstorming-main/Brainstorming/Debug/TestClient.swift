//
//  TestClient.swift
//  Brainstorming
//
//  Created by Alessio Garzia Marotta Brusco on 13/11/24.
//

import Foundation

actor TestClient: Client {
    var data: VoidType {
        get async {
          .init()
        }
    }
    
    func login() async throws -> String {
        let (token, response) = try await call(DefinedEndpoints.login, input: User.LoginData(email: "alessio@icloud.com", passwordHash: "1q2w3e4r"))
        try handle(response)
        return token?.tokenValue ?? "Error"
    }
    
    func getAllProjects() async throws -> [Project] {
        let (projects, response) = try await call(DefinedEndpoints.projectsAll)
        try handle(response)
        return projects ?? []
    }
    
    func createTestProject() async throws {
        let projectData = Project.CreateProjetData(
            name: "My New Project",
            description: "This is a wonderful project I created.",
            collaborators: []
        )
        
        let (_, response) = try await call(DefinedEndpoints.createProject, input: projectData)
        try handle(response)
    }
  
  func createProject(data: Project.CreateProjetData) async throws {
      let (_, response) = try await call(DefinedEndpoints.createProject, input: data)
      try handle(response)
  }
    
    func createBoard(data: Board.CreateBoardData) async throws {
        let (_, response) = try await call(DefinedEndpoints.createBoard, input: data)
        try handle(response)
    }
    
    func getBoards(for projectID: Project.ID) async throws -> [Board] {
        let (boards, response) = try await call(DefinedEndpoints.boardsByProjectID, input: projectID)
        try handle(response)
        return boards ?? []
    }
    
    func getUserEmail() async throws -> String {
        let (user, response) = try await call(DefinedEndpoints.userAccount)
        try handle(response)
        return user?.email ?? "Error"
    }
  
  func getUsers() async throws -> [User] {
    let (users, response) = try await call(DefinedEndpoints.usersAll)
    try handle(response)
    return users ?? []
  }
  
  func getUserAccount() async throws -> User? {
    let (user, response) = try await call(DefinedEndpoints.userAccount)
      try handle(response)
      return user
  }
}
