//
//  SelectedCollaboratorsOO.swift
//  Test
//
//  Created by Andrés Zamora on 04/11/24.
//

import Foundation

@Observable
class SelectedCollaboratorsOO {
  var collaborators = [User]()
  
  func getInitials(from collaborator: User) -> String {
    let firstnameInitial = collaborator.firstName.first?.uppercased() ?? ""
    let lastnameInitial = collaborator.lastName.first?.uppercased() ?? ""
    return "\(firstnameInitial)\(lastnameInitial)"
  }
}
