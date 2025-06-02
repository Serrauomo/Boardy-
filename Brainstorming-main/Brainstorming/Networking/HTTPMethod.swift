//
//  HTTPMethod.swift
//  Brainstorming
//
//  Created by Alessio Garzia Marotta Brusco on 11/11/24.
//

import Foundation

enum HTTPMethod: String {
    case get
    case post
    case put
    case delete
    
    var string: String {
        String(describing: self).uppercased()
    }
}
