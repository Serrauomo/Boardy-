//
//  ContentView.swift
//  Brainstorming
//
//  Created by Alessio Garzia Marotta Brusco on 06/11/24.
//

import SwiftUI

struct ContentView: View {
  
  @State private var isLoggedIn: Bool
  
  init() {
    isLoggedIn = AuthenticationManager.main.isAuthenticated
  }
  
  var body: some View {
    contentView()
  }
  
  @ViewBuilder
  private func contentView() -> some View {
    if !isLoggedIn {
      LoginView(isLoggedIn: $isLoggedIn)
    } else {
      MainView()
    }
  }
  
}

#Preview {
  ContentView()
}
