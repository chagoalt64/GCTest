//
//  MainViewModel.swift
//  GCTest
//
//  Created by Santiago Borjon on 10/08/21.
//

import UIKit
import CoreLocation
import GoogleMaps

protocol MainViewModelDelegate: NSObjectProtocol {
    func updateCurrentLocationPin(_ location: CLLocation) //Shows current location of the user
    
    func displayStartingPoint(_ location: CLLocation) //Displays a green marker to indicate the start of the route
    func updateRoutePath(_ path: GMSPath) //Updates the map polyline
    func displayEndPoint(_ location: CLLocation) //Displays a red marker when the route is finished
    func askForRouteName() //Displays an alert with a textfield to save the route name
    
    func updateTableView() //Reloads the tableview data
}

class MainViewModel: NSObject {
    
    //MARK: - Public Vars
    weak var delegate: MainViewModelDelegate?
    
    //MARK: - Private Vars
    private lazy var locationManager: LocationManager = {
        return LocationManager(delegate: self)
    }()
    
    private var mode = Mode.current
    private var routes = [Route]()
    private var currentRoute: Route?
    private var currentRouteLocations = [CLLocation]()
    
    //MARK: - Initializers
    override init() {
        super.init()
        locationManager.requestLocationAuth()
    }
    
    //MARK: - Private Methods
    private func updateCurrentLocation(_ location: CLLocation) {
        guard let delegate = delegate else { return }
        delegate.updateCurrentLocationPin(location)
    }
    
    private func updateCurrentRoute(_ location: CLLocation) {
        guard let delegate = delegate else { return }
        if currentRouteLocations.isEmpty {
            delegate.displayStartingPoint(location)
        }
        currentRouteLocations.append(location)
        delegate.updateRoutePath(createPath(from: currentRouteLocations))
    }
    
    private func createPath(from locations: [CLLocation]) -> GMSPath {
        let path = GMSMutablePath()
        locations.forEach { location in
            path.add(location.coordinate)
        }
        return path
    }
    
    //MARK: - Public Methods
    func reloadData() {
        //TODO: Reload from CoreData

        guard let delegate = delegate else { return }
        delegate.updateTableView()
    }
    
    func getRoutes() -> [Route] {
        return routes
    }
    
    func beginTracking() {
        mode = .current
        locationManager.start()
    }
    
    func startRoute() {
        currentRoute = nil
        currentRouteLocations = [CLLocation]()
        mode = .route
    }
    
    func stopRoute() -> Bool {
        //The route must have at least one
        if currentRouteLocations.count > 0 {
            //Stop trackings
            locationManager.stop()
            //Init the Route object
            let path = createPath(from: currentRouteLocations)
            currentRoute = Route(start: currentRouteLocations[0],
                                 end: currentRouteLocations[currentRouteLocations.count-1],
                                 path: path.encodedPath(),
                                 distance: path.length(of: .geodesic))
            //Draw the end pin and ask for the route name
            guard let delegate = delegate else { return false }
            delegate.displayEndPoint(currentRouteLocations[currentRouteLocations.count-1])
            delegate.askForRouteName()
            return true
        }
        return false
    }
    
    func saveRoute(with name: String) {
        guard var currentRoute = currentRoute else { return }
        
        //Set the route name
        currentRoute.name = name
        
        //TODO: Save to CoreData

        //TEMP - Append to the array and reload the tableview
        routes.append(currentRoute)
        
        //Reloads the data
        reloadData()
        //Start tracking the current location again
        beginTracking()
    }
}

extension MainViewModel {
    enum Mode {
        case current
        case route
    }
}

extension MainViewModel: LocationManagerDelegate {
    func didUpdateCurrentLocation(_ location: CLLocation) {
        switch mode {
        case .current:
            updateCurrentLocation(location)
        case .route:
            updateCurrentRoute(location)
        }
    }
}
