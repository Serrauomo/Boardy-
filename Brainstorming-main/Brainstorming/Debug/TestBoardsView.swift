//
//  TestBoardsView.swift
//  Brainstorming
//
//  Created by Alessio Garzia Marotta Brusco on 14/11/24.
//

import SwiftUI

struct MyView: View {
    let provider: TestProvider
    let projectID: UUID
    
    var body: some View {
        NavigationStack {
            List {
                ForEach(provider.boards) { board in
                    Text(board.name)
                        .font(.headline)
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
            .toolbar {
                ToolbarItem(placement: .topBarTrailing) {
                    Button("Add project", systemImage: "plus") {
                        Task {
                            try? await provider.client.createTestProject()
                            await provider.getProjects()
                        }
                    }
                }
            }
        }
    }
}
