//
//  ProjectContentOO.swift
//  Brainstorming
//
//  Created by Andrés Zamora on 19/11/24.
//

import Foundation

@MainActor
@Observable
class ProjectBoardsOO {
    let client = TestClient()
    var boards: [Board] = []
    
    func fetchBoards(project: Project?) async {
        do {
            guard let projectId = project?.id else {
                return
            }
            self.boards = try await client.getBoards(for: projectId)
        } catch {
            print(error.localizedDescription)
        }
    }
    
    func collaborators(for project: Project?) async -> String {
        do {
            guard let project else { return "" }
            let userEmail = try await client.getUserEmail()
            
            var collaborators = project.collaborators
            collaborators.removeAll { $0.email == userEmail }
            
            return collaborators
                .map(\.fullname)
                .joined(separator: ", ")
        } catch {
            print(error.localizedDescription)
            return ""
        }
    }
}
