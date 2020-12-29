//
//  LandmarkCommand.swift
//  Landmarks
//
//  Created by Brian Zhang on 2020-12-28.
//

import SwiftUI

struct LandmarkCommands: Commands {
    private struct MenuContent: View {
        @FocusedBinding(\.selectedLandmark) var selectedLandmark
        
        var body: some View {
            Button("\(selectedLandmark?.isFavorite == true ? "Remove" : "Mark") as Favorite") {
                selectedLandmark?.isFavorite.toggle()
            }
            .keyboardShortcut("f", modifiers: [.shift, .option])
            .disabled(selectedLandmark == nil)
        }
    }
    
    // computed body property like what's in a view structure
    var body: some Commands {
        SidebarCommands()
        CommandMenu("Landmark") {
            MenuContent()
        }
    }
}

private struct SelectedLandmarkKey: FocusedValueKey {
    typealias Value = Binding<Landmark>
}

extension FocusedValues {
    var selectedLandmark: Binding<Landmark>? {
        get { self[SelectedLandmarkKey.self] }
        set {
            self[SelectedLandmarkKey.self] = newValue }
    }
}
