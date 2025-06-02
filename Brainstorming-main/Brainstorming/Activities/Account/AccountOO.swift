//
//  AccountOO.swift
//  Brainstorming
//
//  Created by Andrés Zamora on 19/11/24.
//

import Foundation

@MainActor
@Observable
class AccountOO {
  var user: User?
  let client = TestClient()
  
  func getInitials() -> String {
    let firstnameInitial = user?.firstName.first?.uppercased() ?? ""
    let lastnameInitial = user?.lastName.first?.uppercased() ?? ""
    return "\(firstnameInitial)\(lastnameInitial)"
  }
  
  func fetchUserAccount() async {
    do {
      self.user = try await client.getUserAccount()
    } catch {
      print(error.localizedDescription)
    }
  }
}
