//
//  AccountView.swift
//  Brainstorming
//
//  Created by Andrés Zamora on 19/11/24.
//

import SwiftUI

struct AccountView: View {
  
  var accountOO: AccountOO = AccountOO()
  
  var body: some View {
    VStack(spacing: 20) {
      Text(accountOO.getInitials())
        .font(.system(size: 40))
        .frame(width: 100, height: 100)
        .background(Color.gray.opacity(0.3))
        .clipShape(.circle)
        .foregroundColor(.white)
        .shadow(radius: 5)
      Text(accountOO.user?.fullname ?? "")
      Text(accountOO.user?.email ?? "")
    }
    .padding()
    .onAppear() {
      Task {
        await accountOO.fetchUserAccount()
      }
    }
  }
}

#Preview {
  AccountView()
}
