//
//  MapTutorialApp.swift
//  MapTutorial
//
//  Created by Martin Kaeser on 10.04.23.
//

import SwiftUI

@main
struct MapTutorialApp: App {
    @StateObject private var vm = LocationsViewModel()
    
    var body: some Scene {
        WindowGroup {
            LocationsView()
                .environmentObject(vm)
        }
    }
}
