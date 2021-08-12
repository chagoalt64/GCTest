//
//  LocationManager.swift
//  GCTest
//
//  Created by Santiago Borjon on 11/08/21.
//

import Combine
import CoreLocation

protocol LocationManagerDelegate: NSObjectProtocol {
    func didUpdateCurrentLocation(_ location: CLLocation)
}

class LocationManager: NSObject {
    
    //MARK: - Private Vars
    private lazy var locationManager: CLLocationManager = {
        let manager = CLLocationManager()
        manager.delegate = self
        manager.desiredAccuracy = kCLLocationAccuracyBestForNavigation
        manager.allowsBackgroundLocationUpdates = true
        manager.showsBackgroundLocationIndicator = true
        return manager
    }()
    
    private weak var delegate: LocationManagerDelegate?
    private var lastTracking: CLLocation?
    
    //MARK: - Initializer
    init(delegate: LocationManagerDelegate) {
        super.init()
        self.delegate = delegate
    }
    
    //MARK: Public Methods
    func requestLocationAuth() {
        let status = CLLocationManager.authorizationStatus()
        switch status {
        case .notDetermined:
            locationManager.requestWhenInUseAuthorization()
        default:
            break
        }
    }
    
    func start() {
        locationManager.startUpdatingLocation()
    }
    
    func stop() {
        locationManager.stopUpdatingLocation()
    }
    
    //MARK: - Private Methods
    private func didUpdateCurrentLocation(_ location: CLLocation) {
        guard let delegate = delegate else { return }
        delegate.didUpdateCurrentLocation(location)
    }
}

extension LocationManager: CLLocationManagerDelegate {
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        guard let mostRecentLocation = locations.last else { return }
        guard let lastSaved = lastTracking else {
            lastTracking = mostRecentLocation
            didUpdateCurrentLocation(mostRecentLocation)
            return
        }
        
        if ((mostRecentLocation.timestamp - lastSaved.timestamp).second ?? 0) >= 5 {
            lastTracking = mostRecentLocation
            didUpdateCurrentLocation(mostRecentLocation)
        }
    }
}
