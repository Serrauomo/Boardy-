//
//  TestViewModel.swift
//  Brainstorming
//
//  Created by Alessio Garzia Marotta Brusco on 14/11/24.
//

import Foundation

@MainActor
@Observable
class TestProvider {
    let client = TestClient()
    
    var projects = [Project]()
    var boards = [Board]()
    var email = ""
    
    func getEmail() async {
        do {
            email = try await client.getUserEmail()
        } catch {
            print(error.localizedDescription)
        }
    }
    
    func getProjects() async {
       do {
            projects = try await client.getAllProjects()
        } catch {
            print(error.localizedDescription)
        }
    }
    
    func getBoards(for projectID: Project.ID) async {
       do {
           boards = try await client.getBoards(for: projectID)
        } catch {
            print(error.localizedDescription)
        }
    }
    
    func createBoard(projectID: Project.ID, name: String, guidelines: String) async {
        do {
            let data = Board.CreateBoardData(projectID: projectID, name: name, guidelines: guidelines)
            try await client.createBoard(data: data)
        } catch {
            print(error.localizedDescription)
        }
    }
}
