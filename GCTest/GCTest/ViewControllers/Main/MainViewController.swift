//
//  MainViewController.swift
//  GCTest
//
//  Created by Santiago Borjon on 10/08/21.
//

import UIKit

class MainViewController: BaseViewController {
    
    //MARK: - Private Vars
    private lazy var playButton: UIBarButtonItem = {
        return UIBarButtonItem(barButtonSystemItem: .play, target: self, action: #selector(startTracking))
    }()
    
    private lazy var pauseButton: UIBarButtonItem = {
        return UIBarButtonItem(barButtonSystemItem: .pause, target: self, action: #selector(pauseTracking))
    }()
    
    private var tableView = UITableView()

    private enum Cells:String {
        case trackingCell = "trackingCell"
    }
    
    //MARK: - LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        prepareInterface()
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
        tableView.register(TrackingTableViewCell.self, forCellReuseIdentifier: Cells.trackingCell.rawValue)
        
        //Add tableView to bottomView
        bottomView.addSubview(tableView)
        tableView.pin(to: bottomView)
    }
    
    //MARK: - Selectors
    @objc func startTracking() {
        navigationItem.rightBarButtonItem = pauseButton
    }
    
    @objc func pauseTracking() {
        navigationItem.rightBarButtonItem = playButton
    }
}

extension MainViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        guard let coordinator = coordinator else { return }
        coordinator.showDetail()
    }
}

extension MainViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return "Historico"
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 5
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 66
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: Cells.trackingCell.rawValue) as! TrackingTableViewCell
        cell.set(name: "Holi", distance: "42")
        return cell
    }
}
