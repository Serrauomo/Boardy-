//
//  BoardViewModel.swift
//  Brainstorming
//
//  Created by Alessio Garzia Marotta Brusco on 17/11/24.
//

import Foundation
import PencilKit
import SwiftUI

extension BoardView {
    @MainActor
    @Observable
    class ViewModel {
        let client = BoardClient()
        
        var toolPicker = PKToolPicker()
        var isEditable = true
        
        var board: Board
        let projectID: Project.ID
        
        var canvasView = PKCanvasView()
        var interactionEnabled = true
        
        init(board: Board, projectID: Project.ID) {
            self.board = board
            self.projectID = projectID
            
            if let pendingIteration = board.pendingIteration {
                canvasView.drawing = (try? PKDrawing(data: pendingIteration.canvasData)) ?? PKDrawing()
            } else {
                canvasView.drawing = (try? PKDrawing(data: board.thumbnailData)) ?? PKDrawing()
                interactionEnabled = false
            }
        }
        
        var guidelinesText: LocalizedStringKey {
            LocalizedStringKey((board.guidelines ?? "").isEmpty ? "No guidelines! Let the ideas flow through you…" : (board.guidelines ?? ""))
        }
        
        func updateBoard(completion: (() -> Void)) async {
            do {
                guard let pendingIteration = board.pendingIteration else { return }
                interactionEnabled = false
                
                let updateData = Board.UpdateBoardData(
                    iterationID: pendingIteration.id,
                    boardID: board.id,
                    canvasData: canvasView.drawing.dataRepresentation()
                )
                
                try await client.updateBoard(with: updateData, projectID: projectID)
                completion()
                //if let updated {
                //    board = updated
                //}
                
                //interactionEnabled = updated?.pendingIteration != nil
            } catch {
                print(error.localizedDescription)
            }
        }
        
    }
}
