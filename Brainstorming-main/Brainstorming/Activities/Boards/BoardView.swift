//
//  BoardView.swift
//  Brainstorming
//
//  Created by Alessio Garzia Marotta Brusco on 15/11/24.
//

import SwiftUI
import PencilKit

// Send Button doesn't animate, don't know why (it's not because of the overaly on the canvas, it just doesn't animate, also without the canvas).

struct BoardView: View {
    @State private var viewModel: ViewModel
    var onUpdateBoard: (() -> Void)
    
    @State private var showGuidelines = false
    
    init(board: Board, projectID: Project.ID, onUpdateBoard: @escaping (() -> Void)) {
        self.onUpdateBoard = onUpdateBoard
        viewModel = ViewModel(board: board, projectID: projectID)
    }
    
    var body: some View {
        ZStack {
            Color(.systemGroupedBackground)
            CanvasView(canvasView: $viewModel.canvasView)
                .ignoresSafeArea()
                .onAppear {
                    viewModel.toolPicker.setVisible(viewModel.isEditable, forFirstResponder: viewModel.canvasView)
                    viewModel.toolPicker.addObserver(viewModel.canvasView)
                    viewModel.canvasView.becomeFirstResponder()
                }
            
        }
        .overlay(alignment: .bottomTrailing) {
            sendSketchButton
                .padding(30)
        }
        .navigationTitle(viewModel.board.name)
        .toolbar {
            ToolbarItem(placement: .principal) {
                VStack(alignment: .leading) {
                    Text(viewModel.board.name)
                        .font(.headline)
                    
                    Text("Created on \(viewModel.board.createdAt.formatted(date: .abbreviated, time: .omitted))")
                        .font(.subheadline.weight(.medium))
                        .foregroundStyle(.secondary)
                }
            }
            
            ToolbarItem(placement: .topBarTrailing) {
                Button("Guidelines", systemImage: "list.bullet.clipboard") {
                    showGuidelines.toggle()
                }
                .popover(isPresented: $showGuidelines) {
                    VStack(alignment: .leading) {
                        Text("Guidelines")
                            .font(.title3.bold())
                        
                        Divider()
                            .padding(.top, -4)
                        
                        ScrollView {
                            Text(viewModel.guidelinesText)
                        }
                        .frame(height: 350)
                    }
                    .padding()
                    .frame(maxWidth: 250)
                }
            }
        }
        .toolbarRole(.editor)
        .navigationBarTitleDisplayMode(.inline)
        .toolbarBackgroundVisibility(.visible, for: .navigationBar)
    }
    
    var sendSketchButton: some View {
        Button {
            Task {
                await viewModel.updateBoard(completion: onUpdateBoard)
            }
        } label: {
            Image(systemName: "arrow.up.circle.fill")
                .resizable()
                .fontWeight(.medium)
                .frame(width: 60, height: 60)
                .padding(6)
                .background(.white, in: .circle)
                .compositingGroup()
        }
        .buttonStyle(.pressable)
        .shadow(color: .black.opacity(0.2), radius: 10)
        .accessibilityLabel("Submit Sketch")
    }
}

#Preview {
    BoardView(board: .example, projectID: .init(), onUpdateBoard: {})
}
