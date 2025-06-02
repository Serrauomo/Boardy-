//
//  Board.swift
//  Brainstorming
//
//  Created by Alessio Garzia Marotta Brusco on 11/11/24.
//

import Foundation

struct Board: Identifiable, Decodable, Hashable {
    enum CodingKeys: String, CodingKey {
        case id = "boardID"
        case name
        case guidelines
        case createdAt
        case isCompleted
        case ideas = "ideaItems"
        case pendingIterationID
        case canvasData
    }
    
    struct CreateBoardData: Codable {
        let projectID: Project.ID
        let name: String
        let guidelines: String
    }
    
    struct UpdateBoardData: Encodable {
        let iterationID: Iteration.ID
        let boardID: Board.ID
        let canvasData: Data
        
        init(iterationID: Iteration.ID, boardID: Board.ID, canvasData: Data) {
            self.iterationID = iterationID
            self.boardID = boardID
            self.canvasData = canvasData
        }
        
        init(iteration: Iteration, boardID: Board.ID) {
            self.boardID = boardID
            iterationID = iteration.id
            canvasData = iteration.canvasData
        }
    }
    
    let id: UUID
    let name: String
    let guidelines: String?
    let createdAt: Date
    let thumbnailData: Data
    let isCompleted: Bool
    
    let ideas: [Idea]?    
    var pendingIteration: Iteration?
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }
    
    static let example = Board(
        id: UUID(),
        name: "App name",
        guidelines: "We need an app name! Start thinking of something catchy that will make our app stand out.",
        createdAt: .now,
        thumbnailData: Data(),
        isCompleted: false,
        ideas: nil,
        pendingIteration: Iteration(id: nil, order: nil, canvasData: Data())
    )
    
    static func ==(lhs: Board, rhs: Board) -> Bool {
        lhs.id == rhs.id
    }
}

extension Board {
    init(from decoder: any Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.id = try container.decode(UUID.self, forKey: .id)
        self.name = try container.decode(String.self, forKey: .name)
        if let guidelines = try container.decodeIfPresent(String.self, forKey: .guidelines) {
          self.guidelines = guidelines
        } else {
          self.guidelines = nil
        }
        self.createdAt = try container.decode(Date.self, forKey: .createdAt)
        self.isCompleted = try container.decode(Bool.self, forKey: .isCompleted)
        self.ideas = try container.decodeIfPresent([Idea].self, forKey: .ideas)
        
        let canvasData = try container.decode(Data.self, forKey: .canvasData)
        thumbnailData = canvasData
        
        if let pendingIterationID = try container.decodeIfPresent(UUID.self, forKey: .pendingIterationID) {
            pendingIteration = Iteration(id: pendingIterationID, order: nil, canvasData: canvasData)
        } else {
            pendingIteration = nil
        }
    }
}
