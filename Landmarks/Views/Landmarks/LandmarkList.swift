//
//  LandmarkList.swift
//  Landmarks
//
//  Created by Brian Zhang on 2020-12-08.
//

import SwiftUI

struct LandmarkList: View {
    
    @EnvironmentObject var modelData: ModelData
    
    @State private var showFavoritesOnly = false
    
    @State private var filter = FilterCategory.all
    
    @State private var selectedLandmark: Landmark?
    
    enum FilterCategory: String, CaseIterable, Identifiable {
        var id: FilterCategory { self }
        
        case all = "All"
        case rivers = "Rivers"
        case lakes = "Lakes"
        case mountains = "Mountains"
    }
    
    var filteredLandmarks: [Landmark] {
        modelData.landmarks.filter { landmark in
            (!showFavoritesOnly || landmark.isFavorite)
                && (filter == .all || filter.rawValue == landmark.category.rawValue)
        }
    }
    
    var title: String {
        let title = filter == .all ? "Landmarks" : filter.rawValue
        return showFavoritesOnly ? "Favorite \(title)" : title
    }
    
    // Find the landmark stored in the model, and not a copy.
    var index: Int? {
        modelData.landmarks.firstIndex { $0.id == self.selectedLandmark?.id}
    }
    
    var body: some View {
        NavigationView {
            List(selection: $selectedLandmark) {
                ForEach(filteredLandmarks) { landmark in
                    NavigationLink(
                        destination: LandmarkDetail(landmark: landmark)) {
                        LandmarkRow(landmark: landmark)
                    }
                    .tag(landmark)
                }
                
            }
            .navigationTitle(title)
            .frame(minWidth: 300)
            .toolbar {
                ToolbarItem {
                    Menu {
                        Picker("Category", selection: $filter) {
                            ForEach(FilterCategory.allCases) { category in
                                Text(category.rawValue).tag(category)
                            }
                        }
                        .pickerStyle(InlinePickerStyle())
                        
                        Toggle(isOn: $showFavoritesOnly) {
                            Text("Favorites Only")
                        }
                    } label: {
                        Label("filter", systemImage: "slider.horizontal.3")
                    }
                    
                }
            }
            
            Text("Select a landmark")
        }
        .focusedValue(\.selectedLandmark, $modelData.landmarks[index ?? 0])
    }
}

struct LandmarkList_Previews: PreviewProvider {
    static let modelData = ModelData()
    static var previews: some View {
        LandmarkList()
            .environmentObject(modelData)
    }
}
