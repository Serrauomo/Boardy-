//
//  TestView.swift
//  Brainstorming
//
//  Created by Alessio Garzia Marotta Brusco on 14/11/24.
//

import SwiftUI

struct TestView: View {
  @State private var provider = TestProvider()
  
  @State private var showingCreateBoard = false
  @State private var boardName = ""
  @State private var boardGuidelines = ""
  
  var body: some View {
    NavigationStack {
      projectsList
        .navigationTitle("My Projects")
        .toolbar {
          ToolbarItem(placement: .topBarLeading) {
            Text(provider.email)
          }
          
          ToolbarItem(placement: .topBarTrailing) {
            Button("Add project", systemImage: "plus") {
              Task {
                try? await provider.client.createTestProject()
                await provider.getProjects()
              }
            }
          }
        }
        .navigationDestination(for: UUID.self) { projectID in
          boardsList(projectID: projectID)
            .alert("New Board", isPresented: $showingCreateBoard) {
              TextField("Name", text: $boardName)
              TextField("Guidelines", text: $boardGuidelines)
              
              Button("Cancel", role: .cancel) { }
              
              Button("Add") {
                Task {
                  await provider.createBoard(projectID: projectID, name: boardName, guidelines: boardGuidelines)
                  boardName = ""
                  boardGuidelines = ""
                  
                  await provider.getBoards(for: projectID)
                }
              }
            }
            .toolbar {
              ToolbarItem(placement: .topBarTrailing) {
                Button("Add board", systemImage: "plus") {
                  showingCreateBoard.toggle()
                }
              }
            }
            .navigationDestination(for: Board.self) { board in
              BoardView(board: board, projectID: projectID) { }
                .navigationTitle(board.name)
            }
        }
    }
  }
  
  var projectsList: some View {
    List {
      ForEach(provider.projects) { project in
        NavigationLink(value: project.id) {
          HStack {
            VStack(alignment: .leading) {
              Text(project.name)
                .font(.headline)
              
              Text(project.description)
            }
            
            Spacer()
            
            Text(collaboratorsListText(for: project.collaborators))
          }
          .padding(8)
        }
      }
    }
    .task {
      await provider.getProjects()
      await provider.getEmail()
    }
    .refreshable {
      Task {
        await provider.getProjects()
        await provider.getEmail()
      }
    }
  }
  
  func boardsList(projectID: Project.ID) -> some View {
    List {
      ForEach(provider.boards) { board in
        NavigationLink(value: board) {
          Text(board.name)
            .font(.headline)
        }
      }
    }
    .refreshable {
      Task {
        await provider.getBoards(for: projectID)
      }
    }
    .task {
      await provider.getBoards(for: projectID)
    }
    .navigationTitle(provider.projects.filter { $0.id == projectID }.first?.name ?? "Boards")
  }
  
  func collaboratorsListText(for collaborators: [User]) -> String {
    collaborators
      .map { "\($0.firstName) \($0.lastName)" }
      .joined(separator: ", ")
  }
}

#Preview {
  TestView()
}
