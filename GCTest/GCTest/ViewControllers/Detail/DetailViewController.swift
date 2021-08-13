//
//  DetailViewController.swift
//  GCTest
//
//  Created by Santiago Borjon on 10/08/21.
//

import UIKit
import GoogleMaps

class DetailViewController: BaseViewController {

    //MARK: - Private Vars
    private var viewModel: DetailViewModel?
    
    private var mapView = GMSMapView(frame: CGRect.zero)
    private var dataView = DetailDataView(frame: CGRect.zero)
    
    //MARK: - LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        prepareInterface()
        prepareData()
    }
    
    //MARK: - Private Methods
    private func prepareInterface() {
        //Title
        navigationItem.title = "Tracking Detail"

        //Change TopView Size
        resizeTopView(factor: 3/4)
        
        //Add mapView
        topView.addSubview(mapView)
        mapView.translatesAutoresizingMaskIntoConstraints = false
        mapView.topAnchor.constraint(equalTo: topView.topAnchor).isActive = true
        mapView.leadingAnchor.constraint(equalTo: topView.leadingAnchor).isActive = true
        mapView.trailingAnchor.constraint(equalTo: topView.trailingAnchor).isActive = true
        mapView.heightAnchor.constraint(equalToConstant: view.bounds.width).isActive = true
        mapView.isUserInteractionEnabled = false
        mapView.setMinZoom(1, maxZoom: 19)

        //Add dataView
        topView.addSubview(dataView)
        dataView.translatesAutoresizingMaskIntoConstraints = false
        dataView.topAnchor.constraint(equalTo: mapView.bottomAnchor).isActive = true
        dataView.leadingAnchor.constraint(equalTo: topView.leadingAnchor).isActive = true
        dataView.trailingAnchor.constraint(equalTo: topView.trailingAnchor).isActive = true
        dataView.bottomAnchor.constraint(equalTo: topView.bottomAnchor).isActive = true
        
        //Create a stack for the buttons
        let buttonsStack = UIStackView()
        buttonsStack.alignment = .fill
        buttonsStack.axis = .horizontal
        buttonsStack.contentMode = .scaleToFill
        buttonsStack.distribution = .fillEqually
        buttonsStack.spacing = 16.0
        bottomView.addSubview(buttonsStack)
        buttonsStack.pin(to: bottomView, top: 16.0, leading: 16.0, trailing: -16.0, bottom: -16.0)
        
        //Add share button
        let shareButton = UIButton()
        shareButton.setAttributedTitle(NSAttributedString(string: "SHARE", attributes: Menlo.menloBoldMedium(.white).attributes), for: .normal)
        shareButton.backgroundColor = .blue
        shareButton.addTarget(self, action: #selector(sharePressed), for: .touchUpInside)
        shareButton.layer.cornerRadius = 6.0
        buttonsStack.addArrangedSubview(shareButton)

        //Add delete button
        let deleteButton = UIButton()
        deleteButton.setAttributedTitle(NSAttributedString(string: "DELETE", attributes: Menlo.menloBoldMedium(.white).attributes), for: .normal)
        deleteButton.backgroundColor = .red
        deleteButton.addTarget(self, action: #selector(deletePressed), for: .touchUpInside)
        deleteButton.layer.cornerRadius = 6.0
        buttonsStack.addArrangedSubview(deleteButton)
    }
    
    private func prepareData() {
        guard let viewModel = viewModel else { return }
        
        //Set labels info
        dataView.titleLabel.attributedText = NSAttributedString(string: viewModel.getRoute().name, attributes: Menlo.menloBoldLarge(.black).attributes)
        dataView.distanceLabel.attributedText = NSAttributedString(string: viewModel.getRoute().distanceToKm(), attributes: Menlo.menloRegularSmall(.black).attributes)
        dataView.timeLabel.attributedText = NSAttributedString(string: viewModel.getRoute().getRouteTime(), attributes: Menlo.menloRegularSmall(.black).attributes)
        
        //Set pins on map
        let startMarker = GMSMarker()
        startMarker.position = viewModel.getRoute().getInitCoordinates()
        startMarker.icon = GMSMarker.markerImage(with: .green)
        startMarker.appearAnimation = .pop
        startMarker.map = mapView
        
        let endMarker = GMSMarker()
        endMarker.position = viewModel.getRoute().getEndCoordinates()
        endMarker.icon = GMSMarker.markerImage(with: .red)
        endMarker.appearAnimation = .pop
        endMarker.map = mapView
        
        //Set route Path
        let path = viewModel.getRoute().getPath()
        let polyLine = GMSPolyline()
        polyLine.strokeWidth = 2.0
        polyLine.strokeColor = .purple
        polyLine.path = path
        polyLine.map = mapView
        
        //Move the map to fit the path
        let bounds = GMSCoordinateBounds(path: path)
        let update = GMSCameraUpdate.fit(bounds, withPadding: 50)
        self.mapView.animate(with: update)
    }
    
    //MARK: - Public Methods
    func setViewModel(_ viewModel: DetailViewModel) {
        self.viewModel = viewModel
        self.viewModel?.setDelegate(self)
    }
    
    //MARK: - Selectors
    @objc func sharePressed() {
        // set up activity view controller
        let activityViewController = UIActivityViewController(activityItems: [topView.asImage()], applicationActivities: nil)
        activityViewController.popoverPresentationController?.sourceView = self.mapView

        // present the view controller
        self.present(activityViewController, animated: true, completion: nil)
    }
    
    @objc func deletePressed() {
        guard let viewModel = viewModel else { return }
        viewModel.deleteRoute()
    }
}

extension DetailViewController: DetailViewModelDelegate {
    func didDeleteRoute() {
        self.navigationController?.popViewController(animated: true)
    }
}
