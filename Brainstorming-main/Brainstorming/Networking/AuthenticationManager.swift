//
//  AuthenticationManager.swift
//  Brainstorming
//
//  Created by Alessio Garzia Marotta Brusco on 13/11/24.
//

import Foundation
import Security

@MainActor
class AuthenticationManager {
  struct AuthenticationToken: Decodable {
    let tokenValue: String
    
    init(_ tokenValue: String) {
      self.tokenValue = tokenValue
    }
  }
  
  let service = "com.alessiobrusco.Brainstorming"
  static let main = AuthenticationManager()
  
  var authenticationToken: AuthenticationToken? {
    get { loadToken() }
    set { save(newValue) }
  }
  
  var isAuthenticated: Bool {
    authenticationToken?.tokenValue.isEmpty == false
  }
  
  @discardableResult
  func save(_ authToken: AuthenticationToken?) -> Bool {
    guard let tokenData = authToken?.tokenValue.data(using: .utf8) else { return false }
    
    let query: [String: Any] = [
      kSecClass as String: kSecClassGenericPassword,
      kSecAttrService as String: service,
      kSecAttrAccount as String: "authToken",
      kSecValueData as String: tokenData
    ]
    
    SecItemDelete(query as CFDictionary)
    
    let status = SecItemAdd(query as CFDictionary, nil)
    return status == errSecSuccess
  }
  
  func loadToken() -> AuthenticationToken? {
    let query: [String: Any] = [
      kSecClass as String: kSecClassGenericPassword,
      kSecAttrService as String: service,
      kSecAttrAccount as String: "authToken",
      kSecMatchLimit as String: kSecMatchLimitOne,
      kSecReturnData as String: true
    ]
    var item: CFTypeRef?
    let status = SecItemCopyMatching(query as CFDictionary, &item)
    if status != errSecSuccess {
      return nil
    }
    guard let tokenData = item as? Data else {
      return nil
    }
    guard let tokenValue = String(data: tokenData, encoding: .utf8) else {
      return nil
    }
    return AuthenticationToken(tokenValue)
  }
  
  func clear() {
    let query: [String: Any] = [
      kSecClass as String: kSecClassGenericPassword,
      kSecAttrService as String: service
    ]
    SecItemDelete(query as CFDictionary)
  }
  
  private init() { }
}
