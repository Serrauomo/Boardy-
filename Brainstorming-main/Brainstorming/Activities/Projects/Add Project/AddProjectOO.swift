//
//  AddProjectOO.swift
//  Test
//
//  Created by Andrés Zamora on 04/11/24.
//

import Foundation

@MainActor
@Observable
class AddProjectOO {
  let client = TestClient()
  var name: String = ""
  var description: String = ""
  
  func createProject(collaborators: [UUID], completion: (() -> Void)) async {
    do {
      let projectData = Project.CreateProjetData(name: name,
                                                 description: description,
                                                 collaborators: collaborators
      )
      try await client.createProject(data: projectData)
      completion()
    } catch {
      print(error.localizedDescription)
    }
  }
  
}
