//
//  Idea.swift
//  Brainstorming
//
//  Created by Alessio Garzia Marotta Brusco on 08/11/24.
//

import Foundation

struct Idea: Identifiable, Decodable {
    let iterations: [Iteration]
    
    var id: UUID { UUID() }
}
