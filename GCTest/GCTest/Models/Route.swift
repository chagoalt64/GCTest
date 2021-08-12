//
//  Route.swift
//  GCTest
//
//  Created by Santiago Borjon on 11/08/21.
//

import Foundation
import CoreLocation

struct Route {
    var name: String
    var iniLat: String
    var iniLon: String
    var endLat: String
    var endLon: String
    var path: String
    var startDate: Date
    var endDate: Date
    var distance: Double
    
    init(start: CLLocation, end: CLLocation, path: String, distance: Double) {
        self.name = ""
        self.iniLat = "\(start.coordinate.latitude)"
        self.iniLon = "\(start.coordinate.longitude)"
        self.endLat = "\(end.coordinate.latitude)"
        self.endLon = "\(end.coordinate.longitude)"
        self.path = path
        self.startDate = start.timestamp
        self.endDate = end.timestamp
        self.distance = distance
    }
    
    func distanceToKm() -> String {
        return String(format: "%.3f Km", (distance / 1000))
    }
}
