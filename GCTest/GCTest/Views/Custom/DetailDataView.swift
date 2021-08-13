//
//  DetailDataView.swift
//  GCTest
//
//  Created by Santiago Borjon on 12/08/21.
//

import UIKit

class DetailDataView: UIView {
    
    //MARK: - Public Vars
    var titleLabel = MarginLabel()
    var distanceLabel = MarginLabel()
    var timeLabel = MarginLabel()
    
    //MARK: - Private Vars
    private var verticalStack = UIStackView()
    private var horizontalStack = UIStackView()

    //MARK: - Initializers
    override init(frame: CGRect) {
        super.init(frame: frame)
        prepareInterface()
    }
    
    func prepareInterface() {
        //Set view background color
        backgroundColor = .white
        
        //Setup verticalStack
        addSubview(verticalStack)
        verticalStack.pin(to: self)
        verticalStack.axis = .vertical
        verticalStack.alignment = .fill
        verticalStack.contentMode = .scaleToFill
        verticalStack.distribution = .fillEqually
        verticalStack.spacing = 0.0
        
        //Setup titleLabel
        titleLabel.numberOfLines = 0
        titleLabel.adjustsFontSizeToFitWidth = true
        titleLabel.textAlignment = .center
        verticalStack.addArrangedSubview(titleLabel)
        
        //Setup horizontalStack
        horizontalStack.axis = .horizontal
        horizontalStack.alignment = .fill
        horizontalStack.contentMode = .scaleToFill
        horizontalStack.distribution = .fillEqually
        horizontalStack.spacing = 0.0
        verticalStack.addArrangedSubview(horizontalStack)
        
        //Setup distance and title
        distanceLabel.adjustsFontSizeToFitWidth = true
        distanceLabel.textAlignment = .center
        let distanceTitleLabel = MarginLabel()
        distanceTitleLabel.textAlignment = .center
        distanceTitleLabel.adjustsFontSizeToFitWidth = true
        distanceTitleLabel.attributedText = NSAttributedString(string: "Distancia:", attributes: Menlo.menloBoldMedium(.black).attributes)
        
        let distanceStack = UIStackView()
        distanceStack.axis = .vertical
        distanceStack.alignment = .fill
        distanceStack.contentMode = .scaleToFill
        distanceStack.distribution = .fillEqually
        distanceStack.spacing = 0.0
        distanceStack.addArrangedSubview(distanceTitleLabel)
        distanceStack.addArrangedSubview(distanceLabel)
        horizontalStack.addArrangedSubview(distanceStack)
        
        //Setup time and title
        timeLabel.adjustsFontSizeToFitWidth = true
        timeLabel.textAlignment = .center
        let timeTitleLabel = UILabel()
        timeTitleLabel.textAlignment = .center
        timeTitleLabel.adjustsFontSizeToFitWidth = true
        timeTitleLabel.attributedText = NSAttributedString(string: "Tiempo:", attributes: Menlo.menloBoldMedium(.black).attributes)
        horizontalStack.addArrangedSubview(timeTitleLabel)
        
        let timeStack = UIStackView()
        timeStack.axis = .vertical
        timeStack.alignment = .fill
        timeStack.contentMode = .scaleToFill
        timeStack.distribution = .fillEqually
        timeStack.spacing = 0.0
        timeStack.addArrangedSubview(timeTitleLabel)
        timeStack.addArrangedSubview(timeLabel)
        horizontalStack.addArrangedSubview(timeStack)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
