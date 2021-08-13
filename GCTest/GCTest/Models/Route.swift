//
//  Route.swift
//  GCTest
//
//  Created by Santiago Borjon on 11/08/21.
//

import Foundation
import CoreLocation
import GoogleMaps
import CoreData

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
    
    init(_ route: RouteDAO) {
        self.name = route.name ?? ""
        self.iniLat = route.iniLat ?? ""
        self.iniLon = route.iniLon ?? ""
        self.endLat = route.endLat ?? ""
        self.endLon = route.endLon ?? ""
        self.path = route.path ?? ""
        self.startDate = route.startDate ?? Date()
        self.endDate = route.endDate ?? Date()
        self.distance = route.distance
    }
    
    func distanceToKm() -> String {
        return String(format: "%.3f Km", (distance / 1000))
    }
    
    func getRouteTime() -> String {
        let difference = endDate - startDate
        return String(format: "%02d:%02d:%02d", difference.hour ?? 0, difference.minute ?? 0, difference.second ?? 0)
    }
    
    func getInitCoordinates() -> CLLocationCoordinate2D {
        return CLLocationCoordinate2DMake(Double(iniLat) ?? 0, (Double(iniLon) ?? 0))
    }
    
    func getEndCoordinates() -> CLLocationCoordinate2D {
        return CLLocationCoordinate2DMake(Double(endLat) ?? 0, (Double(endLon) ?? 0))
    }
    
    func getPath() -> GMSPath {
        return GMSPath(fromEncodedPath: path) ?? GMSPath()
    }
    
    static func routesFromDAO(_ items: [RouteDAO]) -> [Route] {
        var routes = [Route]()
        items.forEach { item in
            let route = Route(item)
            routes.append(route)
        }
        return routes
    }
}
