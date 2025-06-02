//
//  User.swift
//  Brainstorming
//
//  Created by Alessio Garzia Marotta Brusco on 08/11/24.
//

//NO USERNAME = EMAIL

import Foundation

struct User: Identifiable, Codable, Hashable {
    enum CodingKeys: String, CodingKey {
        case id
        case email
        case firstName
        case lastName
    }
    
    struct LoginData: Codable {
        let email: String
        let passwordHash: String
    }
    
    struct CreateUserData: Codable {
        let email: String
        let firstname: String
        let lastname: String
        let passwordHash: String
    }
    
    let id: UUID
    let email: String
    let firstName: String
    let lastName: String
  public var fullname: String {
    return "\(firstName) \(lastName)"
  }
    
    init(id: UUID, email: String, firstName: String, lastName: String) {
        self.id = id
        self.email = email
        self.firstName = firstName
        self.lastName = lastName
    }
    
    init(from decoder: any Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.id = (try? container.decode(UUID.self, forKey: .id)) ?? UUID()
        self.email = try container.decode(String.self, forKey: .email)
        self.firstName = try container.decode(String.self, forKey: .firstName)
        self.lastName = try container.decode(String.self, forKey: .lastName)
    }
    
    static let example = User(id: UUID(), email: "appleseedJohnny123@apple.com", firstName: "John", lastName: "Appleseed")
}
