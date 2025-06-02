//
//  BrainstormingApp.swift
//  Brainstorming
//
//  Created by Alessio Garzia Marotta Brusco on 06/11/24.
//

import SwiftUI

@main
struct BrainstormingApp: App {
  @State private var debugPresented = false
  
  init() {
    clearKeychainOnFirstLaunch()
  }
  
  var body: some Scene {
    WindowGroup {
      ContentView()
        .sheet(isPresented: $debugPresented) {
            DebugView()
                .presentationDetents([.medium])
        }
        .gesture(
            TapGesture(count: 3)
                .onEnded { _ in
                    debugPresented.toggle()
                }
        )
    }
  }
  
  func clearKeychainOnFirstLaunch() {
    let isFirstLaunch = !UserDefaults.standard.bool(forKey: "hasLaunchedBefore")
    if isFirstLaunch {
      AuthenticationManager.main.clear()
      UserDefaults.standard.set(true, forKey: "hasLaunchedBefore")
    }
  }
}
