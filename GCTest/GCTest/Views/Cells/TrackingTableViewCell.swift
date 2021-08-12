//
//  TrackingTableViewCell.swift
//  GCTest
//
//  Created by Santiago Borjon on 10/08/21.
//

import UIKit

class TrackingTableViewCell: UITableViewCell {

    //MARK: - Private Vars
    private var cellView = UIView()
    private var nameLabel = MarginLabel()
    private var distanceLabel = MarginLabel()
    private var distanceTitleLabel = MarginLabel()
    
    //MARK: - Initializers
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        prepareInterface()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: - Private Methods
    private func prepareInterface() {
        //Prepare cellView
        addSubview(cellView)
        cellView.layer.borderWidth = 1
        cellView.layer.cornerRadius = 6.0
        cellView.layer.shadowColor = UIColor.black.cgColor
        cellView.layer.shadowOpacity = 0.5
        cellView.layer.shadowOffset = .zero
        cellView.layer.shadowRadius = 3
        cellView.layer.shadowPath = UIBezierPath(rect: cellView.bounds).cgPath
        cellView.layer.shouldRasterize = true
        cellView.layer.rasterizationScale = UIScreen.main.scale
        cellView.layer.borderColor = UIColor.purple.cgColor
        cellView.pin(to: self, top: 8, leading: 16, trailing: -16, bottom: -8)
        
        //Add labels to cellView
        cellView.addSubview(nameLabel)
        nameLabel.numberOfLines = 0
        nameLabel.adjustsFontSizeToFitWidth = true
        nameLabel.translatesAutoresizingMaskIntoConstraints = false
        nameLabel.topAnchor.constraint(equalTo: cellView.topAnchor).isActive = true
        nameLabel.leadingAnchor.constraint(equalTo: cellView.leadingAnchor).isActive = true
        nameLabel.trailingAnchor.constraint(equalTo: cellView.trailingAnchor).isActive = true
        nameLabel.heightAnchor.constraint(equalToConstant: 25).isActive = true
        
        cellView.addSubview(distanceTitleLabel)
        distanceTitleLabel.text = "Distancia:"
        distanceTitleLabel.translatesAutoresizingMaskIntoConstraints = false
        distanceTitleLabel.topAnchor.constraint(equalTo: nameLabel.bottomAnchor).isActive = true
        distanceTitleLabel.leadingAnchor.constraint(equalTo: cellView.leadingAnchor).isActive = true
        distanceTitleLabel.bottomAnchor.constraint(equalTo: cellView.bottomAnchor).isActive = true
        distanceTitleLabel.widthAnchor.constraint(equalToConstant: 95).isActive = true
        
        cellView.addSubview(distanceLabel)
        distanceLabel.translatesAutoresizingMaskIntoConstraints = false
        distanceLabel.topAnchor.constraint(equalTo: nameLabel.bottomAnchor).isActive = true
        distanceLabel.bottomAnchor.constraint(equalTo: cellView.bottomAnchor).isActive = true
        distanceLabel.leadingAnchor.constraint(equalTo: distanceTitleLabel.trailingAnchor).isActive = true
        distanceLabel.trailingAnchor.constraint(equalTo: cellView.trailingAnchor).isActive = true
    }
    
    //MARK: - Public Methods
    func set(name: String, distance: String) {
        nameLabel.text = name
        distanceLabel.text = distance
    }
}
