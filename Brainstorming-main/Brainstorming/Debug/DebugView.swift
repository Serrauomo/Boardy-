//
//  DebugView.swift
//  Brainstorming
//
//  Created by Alessio Garzia Marotta Brusco on 15/11/24.
//

import SwiftUI

struct DebugView: View {
    var body: some View {
        VStack {
            Button("Remove Token") {
                AuthenticationManager.main.authenticationToken = AuthenticationManager.AuthenticationToken("")
            }
            
            Button("Print Token") {
                print(AuthenticationManager.main.authenticationToken ?? "No Token")
            }
        }
    }
}
