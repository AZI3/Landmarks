//
//  LandmarksApp.swift
//  Landmarks
//
//  Created by Brian Zhang on 2020-12-08.
//

import SwiftUI

@main
struct LandmarksApp: App {
    @StateObject private var modelData = ModelData()
    
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environmentObject(modelData)
        }
    }
}
