//
//  MainCoordinator.swift
//  GCTest
//
//  Created by Santiago Borjon on 10/08/21.
//

import UIKit

class MainCoordinator: Coordinator {
    var navigationController: UINavigationController
    
    init(_ navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    func start() {
        let vc = MainViewController()
        vc.coordinator = self
        navigationController.pushViewController(vc, animated: false)
    }
    
    func showDetail() {
        let vc = DetailViewController()
        vc.coordinator = self
        navigationController.pushViewController(vc, animated: true)
    }
}
