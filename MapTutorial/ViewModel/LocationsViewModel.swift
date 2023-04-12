//
//  LocationsViewModel.swift
//  MapTutorial
//
//  Created by Martin Kaeser on 10.04.23.
//

import Foundation
import MapKit
import SwiftUI


class LocationsViewModel: ObservableObject, Identifiable {
    
    //All loaded locations
    @Published var locations : [Location]
    
    //current location on the map
    @Published var mapLocation : Location {
        didSet {
            updateMapRegion(location: mapLocation)
        }
    }
    //current Map Region
    @Published var mapRegion : MKCoordinateRegion = MKCoordinateRegion()
    let mapSpan = MKCoordinateSpan(latitudeDelta: 0.1, longitudeDelta: 0.1)
    
    
    //show list of locations
    @Published var showLocationsList : Bool = false
    
    // show location detail via sheet
    
    @Published var sheetLocation : Location? = nil
    
    
    init() {
        let locations = LocationsDataService.locations
        self.locations = locations
        self.mapLocation = locations.first!
        //technically our initializer stops here.
        
        self.updateMapRegion(location: locations.first!)
    }
    
    private func updateMapRegion(location: Location) {
        withAnimation(.easeInOut) {
            mapRegion = MKCoordinateRegion(
                center: location.coordinates,
                span: mapSpan)
        }
    }
    func toggleLocationsList () {
        withAnimation(.easeInOut) {
            showLocationsList = !showLocationsList
        }
    }
    func showNextLocation (location : Location) {
        withAnimation(.easeInOut) {
            mapLocation = location
            showLocationsList = false
        }
    }
    
    func nextButtonPressed() {
        //get the current index
//        let currentIndex = locations.firstIndex { location in
//            return location == mapLocation
//        }
        //same as above in shorthand
        guard let currentIndex = locations.firstIndex(where: {$0 == mapLocation}) else {
            print("Could not find current index in locations array! Should never exectute")
            return
        }
        //Check if current index is valid -> We need this to make sure that our nextLocation Function doesnt potentially crash
        let nextIndex = currentIndex + 1
        guard locations.indices.contains(nextIndex) else {
            //next index is no valid
            //restard from 0
            guard let firstLocation = locations.first else {return}
            showNextLocation(location: firstLocation)
            return}
        //Next index IS valid
        let nextLocation = locations [nextIndex]
        showNextLocation(location: nextLocation)
    }
}
