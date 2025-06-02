//
//  Project.swift
//  Brainstorming
//
//  Created by Alessio Garzia Marotta Brusco on 08/11/24.
//

import Foundation

struct Project: Identifiable, Codable, Hashable {
    struct CreateProjetData: Codable {
        let name: String
        let description: String
        let collaborators: [UUID]
    }
    
    let id: UUID
    var name: String
    var description: String
    var collaborators: [User]
}
