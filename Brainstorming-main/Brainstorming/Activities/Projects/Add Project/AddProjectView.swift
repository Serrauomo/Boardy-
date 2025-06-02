//
//  AddProjectView.swift
//  Brainstorming
//
//  Created by Andrés Zamora on 18/11/24.
//

import SwiftUI

struct AddProjectView: View {
  
  // MARK: Properties
  
  @State var addProjectOO: AddProjectOO = AddProjectOO()
  @Binding var selectedCollaboratorsOO: SelectedCollaboratorsOO
  var onAddProject: (() -> Void)
  
  // MARK: Body
  
  var body: some View {
    List {
      Section {
        TextField("Project name", text: $addProjectOO.name)
        TextField("Description (Optional)", text: $addProjectOO.description)
      }
      if !selectedCollaboratorsOO.collaborators.isEmpty {
        SelectedCollaboratorsView(selectedCollaboratorsOO: $selectedCollaboratorsOO)
      }
    }
    .navigationTitle("New Project")
    .toolbar {
      toolbarContent
    }
  }
  
  // MARK: Views
  
  var toolbarContent: some ToolbarContent {
    ToolbarItem {
      Button("Add") {
        Task {
          await addProjectOO.createProject(collaborators: selectedCollaboratorsOO.collaborators.map(\.id), completion: onAddProject)
        }
      }
      .disabled(selectedCollaboratorsOO.collaborators.isEmpty)
    }
  }
}

#Preview {
  AddProjectView(selectedCollaboratorsOO: .constant(SelectedCollaboratorsOO()), onAddProject: {})
}
