//
//  ProjectsView.swift
//  Brainstorming
//
//  Created by Alessio Garzia Marotta Brusco on 08/11/24.
//

import SwiftUI

struct ProjectsView: View {
  
  var projectsOO: ProjectsOO = ProjectsOO()
  @State var showAddProject = false
  @State var showUserAccount = false
  @Binding var selectedProject: Project?
  
  var body: some View {
    projectsList
      .navigationTitle("Projects")
      .toolbar {
        bottomToolbar
        upperToolbar
      }
      .refreshable {
        Task {
          await projectsOO.fetchProjects()
        }
      }
      .onAppear() {
        Task {
          await projectsOO.fetchProjects()
        }
      }
      .sheet(isPresented: $showAddProject) {
        CollaboratorsView {
          // Refresh the projects list when a new project is added
          Task {
            await projectsOO.fetchProjects()
            showAddProject = false
          }
        }
      }
  }
  
  // MARK: - Views
  
  var projectsList: some View {
    List(projectsOO.projects, selection: $selectedProject) { project in
      NavigationLink(value: project) {
        Text(project.name)
      }
    }
    .listStyle(.sidebar)
  }
  
  var bottomToolbar: some ToolbarContent {
    ToolbarItemGroup(placement: .bottomBar) {
      Button {
        showAddProject.toggle()
      }  label: {
        Image(systemName: "folder.badge.plus")
      }
      Spacer()
        
        Image(.contrastLogo)
            .resizable()
            .frame(width: 32, height: 32)
            .cornerRadius(6)
    }
  }
  
  var upperToolbar: some ToolbarContent {
    ToolbarItem() {
      Button {
        showUserAccount.toggle()
      } label: {
        Image(systemName: "person.circle")
      }
      .popover(isPresented: $showUserAccount) {
        AccountView()
      }
    }
  }
  
  // MARK: - Methods
  
  func rowView(project: Project) -> some View {
    HStack {
      Text(project.name)
    }
  }
}
