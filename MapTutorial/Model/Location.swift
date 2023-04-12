//
//  Location.swift
//  MapTutorial
//
//  Created by Martin Kaeser on 10.04.23.
//

import Foundation
import MapKit


struct Location: Identifiable, Equatable {
  
    
    
    let name : String
    let cityName : String
    let coordinates : CLLocationCoordinate2D
    let description : String
    let imageNames : [String]
    let link : String
    
    //identifiable
    var id : String {
        name + cityName
    }
    //Equatable
    static func == (lhs: Location, rhs: Location) -> Bool {
        lhs.id == rhs.id
    }
}
