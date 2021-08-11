//
//  CustomNavigationController.swift
//  GCTest
//
//  Created by Santiago Borjon on 10/08/21.
//

import UIKit

class CustomNavigationController: UINavigationController {

    override func viewDidLoad() {
        super.viewDidLoad()
        prepareInterface()
    }
    
    func prepareInterface() {
        navigationBar.isTranslucent = false
        navigationBar.tintColor = .white
        navigationBar.barStyle = .black
    }
}
