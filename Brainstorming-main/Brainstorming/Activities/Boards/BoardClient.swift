//
//  BoardClient.swift
//  Brainstorming
//
//  Created by Alessio Garzia Marotta Brusco on 17/11/24.
//

import Foundation

actor BoardClient: Client {
  var data: VoidType { .init() }
  
  func updateBoard(with boardData: Board.UpdateBoardData, projectID: Project.ID) async throws {
    let (_, updateResponse) = try await call(DefinedEndpoints.updateBoard, input: boardData)
    
    try handle(updateResponse)
  }
}
