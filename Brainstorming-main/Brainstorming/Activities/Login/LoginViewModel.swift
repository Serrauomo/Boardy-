//
//  LoginViewModel.swift
//  Brainstorming
//
//  Created by Alessio Garzia Marotta Brusco on 15/11/24.
//

import Foundation

extension LoginView {
  @MainActor
  @Observable
  class ViewModel {
    let client = LoginClient()
    
    var email = ""
    var password = ""
    var wrongCredentials = false
    
    var isLoggedIn = false
    
    func login() async {
      do {
        try await client.login(email: email, password: password)
        isLoggedIn = true
      } catch  {
        if let error = error as? ClientError, error == .badAuthorization {
          wrongCredentials = true
        } else {
          print(error.localizedDescription)
        }
      }
    }
  }
}
