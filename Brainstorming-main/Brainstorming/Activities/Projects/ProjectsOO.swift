//
//  ProjectsOO.swift
//  Brainstorming
//
//  Created by Andrés Zamora on 18/11/24.
//

import Foundation

@MainActor
@Observable
class ProjectsOO {
  var projects: [Project] = []
  let client = TestClient()
  
  func fetchProjects() async {
    do {
      self.projects = try await client.getAllProjects()
    } catch {
      print(error.localizedDescription)
    }
  }
}
