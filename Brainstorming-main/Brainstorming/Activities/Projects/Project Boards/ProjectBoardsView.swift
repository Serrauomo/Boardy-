//
//  ProjectBoardsView.swift
//  Brainstorming
//
//  Created by Andrés Zamora on 01/11/24.
//

import SwiftUI

struct ProjectBoardsView: View {
    
    @Binding var project: Project?
    @State private var projectBoardsOO = ProjectBoardsOO()
    @State private var selectedBoard: Board?
    @State private var showAddBoard = false
    @State private var loading = false
    @Binding var columnVisibility: NavigationSplitViewVisibility
    @State private var navigationPath: [Board] = []
    @State private var collaboratorsText = ""
    
    @Namespace private var namespace
    
    var body: some View {
        NavigationStack(path: $navigationPath) {
            Group {
                if projectBoardsOO.boards.isEmpty {
                    if loading {
                        ProgressView()
                    } else {
                        ContentUnavailableView("No boards yet.", systemImage: "rectangle.slash")
                    }
                } else {
                    boardsGrid
                }
            }
            .navigationTitle(project?.name ?? "")
            .toolbar {
                if project != nil {
                    upperToolbar
                }
            }
            .onChange(of: project) { _, newProject in
                Task {
                    loading = true
                    await projectBoardsOO.fetchBoards(project: newProject)
                    loading = false
                    
                    collaboratorsText = await projectBoardsOO.collaborators(for: newProject)
                }
            }
            .sheet(isPresented: $showAddBoard) {
                AddBoardView(projectId: project!.id) {
                    Task {
                        await projectBoardsOO.fetchBoards(project: project)
                        showAddBoard = false
                    }
                }
            }
            .navigationDestination(for: Board.self) { board in
                BoardView(board: board, projectID: project!.id) {
                    Task {
                        await projectBoardsOO.fetchBoards(project: project)
                        navigationPath.removeLast()
                    }
                }
                .navigationTransition(.zoom(sourceID: board.id, in: namespace))
            }
        }
    }
    
    // MARK: - Views
    
    var boardsGrid: some View {
        let columns = [
            GridItem(.adaptive(minimum: 175))
        ]
        return ScrollView {
            LazyVGrid(columns: columns, spacing: 20) {
                ForEach(projectBoardsOO.boards) { board in
                    Button {
                        Task { @MainActor in
                            columnVisibility = .detailOnly
                            try? await Task.sleep(for: .seconds(0.1))
                            navigationPath.append(board)
                        }
                    } label: {
                        VStack {
                            PencilKitPreviewView(drawingData: board.thumbnailData)
                            Text(board.name)
                        }
                        .navigationTransition(.zoom(sourceID: board.id, in: namespace))
                    }
                }
            }
            .padding(20)
        }
    }
    
    @ToolbarContentBuilder var upperToolbar: some ToolbarContent {
        ToolbarItem(placement: .topBarTrailing) {
            Button {
                showAddBoard.toggle()
            } label: {
                Image(systemName: "plus")
            }
        }
        
        ToolbarItem(placement: .topBarLeading) {
            Text(collaboratorsText)
                .font(.subheadline)
        }
    }
}
