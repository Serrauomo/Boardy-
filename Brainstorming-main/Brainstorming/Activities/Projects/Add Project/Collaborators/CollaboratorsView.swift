//
//  CollaboratorsView.swift
//  Test
//
//  Created by Andrés Zamora on 02/11/24.
//

import SwiftUI

struct CollaboratorsView: View {
    
    // MARK: Properties
    
    @State var collaboratorsOO = CollaboratorsOO()
    @State var selectedCollaboratorsOO = SelectedCollaboratorsOO()
    var onAddProject: (() -> Void)
    
    // MARK: Body
    
    var body: some View {
        NavigationStack {
            VStack {
                collaboratorsList
            }
            .navigationTitle("Add Collaborators")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                toolbarContent
            }
        }
        .searchable(text: $collaboratorsOO.searchText, placement: .navigationBarDrawer(displayMode: .always))
        .onAppear() {
            Task {
                await collaboratorsOO.fetchCollaborators()
            }
        }
    }
    
    // MARK: Views
    
    var collaboratorsList: some View {
        VStack {
            List {
                if !selectedCollaboratorsOO.collaborators.isEmpty {
                    SelectedCollaboratorsView(selectedCollaboratorsOO: $selectedCollaboratorsOO)
                }
                Section("Available collaborators") {
                    ForEach(collaboratorsOO.searchResults) { collaborator in
                        CollaboratorRow(collaborator: collaborator, selectedRows: $selectedCollaboratorsOO.collaborators)
                    }
                }
            }
        }
    }
    
    var toolbarContent: some ToolbarContent {
        ToolbarItem {
            NavigationLink("Next", destination: AddProjectView(selectedCollaboratorsOO: $selectedCollaboratorsOO, onAddProject: onAddProject))
                .disabled(selectedCollaboratorsOO.collaborators.isEmpty)
        }
    }
    
}

fileprivate struct CollaboratorRow: View {
    
    // MARK: Properties
    
    var collaborator: User
    @Binding var selectedRows: Array<User>
    var isSelected: Bool { selectedRows.contains(collaborator) }
    
    // MARK: Body
    
    var body: some View {
        HStack {
            Text(collaborator.fullname)
            Spacer()
            Image(systemName: isSelected ? "checkmark.circle" : "circle")
        }
        .contentShape(Rectangle())
        .onTapGesture {
            withAnimation {
                toggleSelection()
            }
        }
    }
    
    // MARK: Methods
    
    func toggleSelection() {
        if isSelected {
            // Remove the collaborator from the selected rows
            selectedRows.removeAll { $0.id == collaborator.id }
        } else {
            // Add the collaborator to the selected rows
            selectedRows.append(collaborator)
        }
    }
}

#Preview {
    CollaboratorsView(onAddProject: {})
}
