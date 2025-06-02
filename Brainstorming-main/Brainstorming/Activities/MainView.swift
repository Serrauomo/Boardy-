//
//  MainView.swift
//  Brainstorming
//
//  Created by Andrés Zamora on 18/11/24.
//

import SwiftUI

struct MainView: View {
  @State private var selectedProject: Project?
  @State private var columnVisibility: NavigationSplitViewVisibility = .all
  
  var body: some View {
    NavigationSplitView(columnVisibility: $columnVisibility) {
      ProjectsView(selectedProject: $selectedProject)
    } detail: {
      ProjectBoardsView(project: $selectedProject, columnVisibility: $columnVisibility)
    }
  }
}

#Preview {
  MainView()
}
