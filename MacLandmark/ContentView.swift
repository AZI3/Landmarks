//
//  ContentView.swift
//  MacLandmark
//
//  Created by Brian Zhang on 2020-12-28.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        LandmarkList()
//            .frame(width: 700, height: 300)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
            .environmentObject(ModelData())
    }
}
