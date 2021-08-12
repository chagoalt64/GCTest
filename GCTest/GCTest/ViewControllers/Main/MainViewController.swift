//
//  MainViewController.swift
//  GCTest
//
//  Created by Santiago Borjon on 10/08/21.
//

import UIKit
import GoogleMaps

class MainViewController: BaseViewController {
    
    //MARK: - Private Vars
    private lazy var viewModel: MainViewModel = {
        let viewModel = MainViewModel()
        viewModel.delegate = self
        return viewModel
    }()
    
    private lazy var playButton: UIBarButtonItem = {
        return UIBarButtonItem(barButtonSystemItem: .play, target: self, action: #selector(startTracking))
    }()
    
    private lazy var pauseButton: UIBarButtonItem = {
        return UIBarButtonItem(barButtonSystemItem: .pause, target: self, action: #selector(pauseTracking))
    }()
    
    private var tableView = UITableView()
    private var mapView = GMSMapView(frame: CGRect.zero)
    private var polyLine = GMSPolyline()
    
    //MARK: - LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        prepareInterface()
        viewModel.beginTracking()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        viewModel.reloadData()
    }

    //MARK: - Private Methods
    private func prepareInterface() {
        //Title
        navigationItem.title = "My Trackings"
        
        //Set NavBar button
        navigationItem.rightBarButtonItem = playButton
        
        //Prepare TableView
        tableView.delegate = self
        tableView.dataSource = self
        tableView.separatorStyle = .none
        tableView.layer.masksToBounds = true
        tableView.clipsToBounds = true
        tableView.register(TrackingTableViewCell.self, forCellReuseIdentifier: Cells.trackingCell.rawValue)
        
        //Add tableView to bottomView
        bottomView.addSubview(tableView)
        tableView.pin(to: bottomView)
        
        //Add MapView
        topView.addSubview(mapView)
        mapView.pin(to: topView)
        mapView.setMinZoom(1, maxZoom: 19)
        
        //Prepare PolyLine
        polyLine.strokeWidth = 2.0
        polyLine.strokeColor = .purple
    }
    
    //MARK: - Selectors
    @objc func startTracking() {
        navigationItem.rightBarButtonItem = pauseButton
        mapView.clear()
        viewModel.startRoute()
    }
    
    @objc func pauseTracking() {
        if viewModel.stopRoute() {
            navigationItem.rightBarButtonItem = playButton
        }
    }
}

extension MainViewController {
    enum Cells:String {
        case trackingCell = "trackingCell"
    }
}

extension MainViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        guard let coordinator = coordinator else { return }
        coordinator.showDetail(route: viewModel.getRoutes()[indexPath.row])
    }
}

extension MainViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let title = UILabel()
        title.attributedText = NSAttributedString(string: "Historico", attributes: Menlo.menloRegularMedium(.white).attributes)
        title.backgroundColor = .black
        title.textAlignment = .center
        return title
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.getRoutes().count
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 66
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let route = viewModel.getRoutes()[indexPath.row]
        let cell = tableView.dequeueReusableCell(withIdentifier: Cells.trackingCell.rawValue) as! TrackingTableViewCell
        cell.set(name: route.name, distance: route.distanceToKm())
        return cell
    }
}

extension MainViewController: MainViewModelDelegate {

    func displayStartingPoint(_ location: CLLocation) {        
        let marker = GMSMarker()
        marker.position = CLLocationCoordinate2DMake(location.coordinate.latitude, location.coordinate.longitude)
        marker.icon = GMSMarker.markerImage(with: .green)
        marker.appearAnimation = .pop
        marker.title = "Start"
        marker.map = mapView
    }
    
    func updateRoutePath(_ path: GMSPath) {
        polyLine.map = nil
        polyLine.path = path
        polyLine.map = mapView
        
        let bounds = GMSCoordinateBounds(path: path)
        let update = GMSCameraUpdate.fit(bounds, withPadding: 50)
        self.mapView.animate(with: update)
    }
    
    func displayEndPoint(_ location: CLLocation) {
        let marker = GMSMarker()
        marker.position = CLLocationCoordinate2DMake(location.coordinate.latitude, location.coordinate.longitude)
        marker.icon = GMSMarker.markerImage(with: .red)
        marker.appearAnimation = .pop
        marker.title = "End"
        marker.map = mapView
    }
    
    func askForRouteName() {
        showInputAlert(title: "Give this route a name", placeholder: "My Awesome Route") { [weak self] name in
            self?.viewModel.saveRoute(with: name)
        }
    }
    
    func updateTableView() {
        tableView.reloadData()
    }

    func updateCurrentLocationPin(_ location: CLLocation) {
        mapView.clear()
        mapView.camera = GMSCameraPosition.camera(withLatitude: location.coordinate.latitude, longitude: location.coordinate.longitude, zoom: 17.5)
        
        let marker = GMSMarker()
        marker.position = CLLocationCoordinate2DMake(location.coordinate.latitude, location.coordinate.longitude)
        marker.icon = GMSMarker.markerImage(with: .blue)
        marker.appearAnimation = .none
        marker.title = "You're here"
        marker.map = mapView
    }
}
