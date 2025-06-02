//
//  Iteration.swift
//  Brainstorming
//
//  Created by Alessio Garzia Marotta Brusco on 08/11/24.
//

import Foundation

struct Iteration: Identifiable, Decodable, Equatable {
    let id: UUID
    let order: Int?
    let canvasData: Data
    
    init(id: UUID?, order: Int?, canvasData: Data) {
        self.id = id ?? UUID()
        self.order = order
        self.canvasData = canvasData
    }
    
    static func ==(lhs: Iteration, rhs: Iteration) -> Bool {
        lhs.id == rhs.id
    }
}
