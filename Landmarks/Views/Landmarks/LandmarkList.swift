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
    
    var filteredLandmarks: [Landmark] {
        modelData.landmarks.filter { landmark in
            !showFavoritesOnly || landmark.isFavorite
        }
    }
    
    var body: some View {
        NavigationView {
            List() {
                Toggle(isOn: $showFavoritesOnly) {
                    Text("Favorites Only")
                }
                ForEach(filteredLandmarks) { landmark in
                    NavigationLink(
                        destination: LandmarkDetail(landmark: landmark)) {
                        LandmarkRow(landmark: landmark)
                    }
                }
                
            }
            .navigationTitle("Lankmarks")
        }
    }
}

struct LandmarkList_Previews: PreviewProvider {
    static let modelData = ModelData()
    static var previews: some View {
        LandmarkList()
            .environmentObject(modelData)
    }
}
