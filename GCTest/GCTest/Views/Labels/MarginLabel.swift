//
//  MarginLabel.swift
//  GCTest
//
//  Created by Santiago Borjon on 10/08/21.
//

import UIKit

class MarginLabel: UILabel {

    override func drawText(in rect: CGRect) {
        let insets = UIEdgeInsets.init(top: 0, left: 8, bottom: 0, right: 8)
        super.drawText(in: rect.inset(by: insets))
    }
    
}
