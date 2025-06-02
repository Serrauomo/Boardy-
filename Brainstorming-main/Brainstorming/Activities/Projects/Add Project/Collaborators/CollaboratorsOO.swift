//
//  CollaboratorsOO.swift
//  Test
//
//  Created by Andrés Zamora on 02/11/24.
//

import Foundation

@MainActor
@Observable
class CollaboratorsOO {
  let client = TestClient()
  private var collaborators = [User]()
  var searchText = ""
  
  var searchResults: [User] {
    if searchText.isEmpty {
      return collaborators
    } else {
      return collaborators.filter { $0.fullname.lowercased().contains(searchText.lowercased()) }
    }
  }
  
  func fetchCollaborators() async {
    do {
      self.collaborators = try await client.getUsers()
    } catch {
      print(error.localizedDescription)
    }
  }
  
}
