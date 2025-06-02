//
//  LoginView.swift
//  Brainstorming
//
//  Created by Alessio Garzia Marotta Brusco on 15/11/24.
//

import SwiftUI

struct LoginView: View {
  @State private var viewModel = ViewModel()
  @Binding var isLoggedIn: Bool
  
  var body: some View {
    VStack(spacing: 20) {
      Image("Logo")
        .resizable()
        .scaledToFit()
        .frame(width: 200, height: 200)
        .padding(.bottom, 20)
      
      TextField("Email", text: $viewModel.email)
        .padding()
        .frame(maxWidth: .infinity)
        .cornerRadius(8)
        .textContentType(.emailAddress)
        .textInputAutocapitalization(.never)
        .overlay(
          RoundedRectangle(cornerRadius: 8)
            .stroke(Color(.systemGray4), lineWidth: 1)
        )
      
      SecureField("Password", text: $viewModel.password)
        .padding()
        .frame(maxWidth: .infinity)
        .cornerRadius(8)
        .overlay(
          RoundedRectangle(cornerRadius: 8)
            .stroke(Color(.systemGray4), lineWidth: 1)
        )
      
      Button()
      {
        Task {
          await viewModel.login()
        }
      } label: {
        Text("Login")
        .font(.headline)
        .padding(.vertical, 12)
        .frame(maxWidth: .infinity)
        .background(.tint)
        .foregroundColor(.white)
        .cornerRadius(8)
      }
    }
    .frame(maxWidth: 300)
    .padding()
    .onChange(of: viewModel.isLoggedIn) { _, value in
      isLoggedIn = value
    }
  }
}

#Preview {
  LoginView(isLoggedIn: .constant(true))
}
