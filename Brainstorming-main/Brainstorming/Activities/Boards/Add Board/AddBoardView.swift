//
//  AddBoardView.swift
//  Brainstorming
//
//  Created by Andrés Zamora on 19/11/24.
//

import SwiftUI

struct AddBoardView: View {
    
    var projectId: UUID
    @State var addBoardOO = AddBoardOO()
    var onAddBoard: (() -> Void)
    
    var body: some View {
        NavigationStack {
            Form {
                Section {
                    TextField("Board Name", text: $addBoardOO.boardName)
                }
                
                Section("Guidelines") {
                    TextEditor(text: $addBoardOO.boardGuidelines)
                        .frame(height: 300)
                }
            }
            .navigationTitle("New Board")
            .overlay(alignment: .bottom) {
                Button {
                    Task {
                        await addBoardOO.createBoard(projectId: projectId, completion: onAddBoard)
                    }
                } label: {
                    Text("Add")
                        .font(.headline)
                        .padding(.vertical, 12)
                        .frame(maxWidth: .infinity)
                        .background(.tint)
                        .foregroundColor(.white)
                        .cornerRadius(8)
                }
                .frame(maxWidth: .infinity)
                .padding()
            }
        }
    }
}

#Preview {
    AddBoardView(projectId: .init(), onAddBoard: {  })
}
