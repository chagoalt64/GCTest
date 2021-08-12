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
    
    func showDetail(route: Route) {
        let vm = DetailViewModel(route: route)
        let vc = DetailViewController()
        vc.setViewModel(vm)
        vc.coordinator = self
        navigationController.pushViewController(vc, animated: true)
    }
}
