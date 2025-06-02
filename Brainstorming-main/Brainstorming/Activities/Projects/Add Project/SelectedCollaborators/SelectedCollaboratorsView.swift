//
//  SelectedCollaboratorsView.swift
//  Test
//
//  Created by Andrés Zamora on 04/11/24.
//

import SwiftUI

struct SelectedCollaboratorsView: View {
  
  @Binding var selectedCollaboratorsOO: SelectedCollaboratorsOO
  
  init(selectedCollaboratorsOO: Binding<SelectedCollaboratorsOO>) {
    self._selectedCollaboratorsOO = selectedCollaboratorsOO
  }
  
  var body: some View {
    ScrollView(.horizontal, showsIndicators: false) {
      HStack(spacing: 20) {
        ForEach(selectedCollaboratorsOO.collaborators) { collaborator in
          VStack {
            Text(selectedCollaboratorsOO.getInitials(from: collaborator))
              .font(.system(size: 40))
              .frame(width: 75, height: 75)
              .background(Color.gray.opacity(0.3))
              .clipShape(.circle)
              .foregroundColor(.white)
              .shadow(radius: 5)
            Text(collaborator.firstName)
          }
          .overlay(alignment: .topTrailing) {
            Button {
              selectedCollaboratorsOO.collaborators.removeAll { $0.id == collaborator.id }
            } label: {
              Image(systemName: "xmark.circle.fill")
                .foregroundStyle(.white, .gray)
                .font(.system(size: 25))
            }
          }
          .transition(.scale)
        }
      }
    }
    .animation(.default, value: selectedCollaboratorsOO.collaborators)
    .scrollBounceBehavior(.basedOnSize, axes: [.horizontal])
  }
}

#Preview {
  SelectedCollaboratorsView(selectedCollaboratorsOO: .constant(SelectedCollaboratorsOO()))
}
