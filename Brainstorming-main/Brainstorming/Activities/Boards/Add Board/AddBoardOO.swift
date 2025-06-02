//
//  AddBoardOO.swift
//  Brainstorming
//
//  Created by Andrés Zamora on 19/11/24.
//

import Foundation

@MainActor
@Observable
class AddBoardOO {
  let client = TestClient()
  var boardName: String = ""
  var boardGuidelines: String = ""
  
  func createBoard(projectId: UUID, completion: (() -> Void)) async {
    do {
      let boardData = Board.CreateBoardData(projectID: projectId,
                                            name: boardName,
                                            guidelines: boardGuidelines)
      try await client.createBoard(data: boardData)
      completion()
    } catch {
      print(error.localizedDescription)
    }
  }
  
}
