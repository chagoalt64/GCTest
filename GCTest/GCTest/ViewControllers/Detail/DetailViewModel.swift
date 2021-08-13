//
//  DetailViewModel.swift
//  GCTest
//
//  Created by Santiago Borjon on 10/08/21.
//

import UIKit

protocol DetailViewModelDelegate: NSObjectProtocol {
    func didDeleteRoute()
}

class DetailViewModel: NSObject {
    
    //MARK: - Private Vars
    private weak var delegate: DetailViewModelDelegate?
    private var route: Route
    
    //MARK: - Initializers
    init(route: Route) {
        self.route = route
        super.init()
    }
        
    //MARK: - Public Methods
    func setDelegate(_ delegate: DetailViewModelDelegate) {
        self.delegate = delegate
    }
    
    func getRoute() -> Route {
        return route
    }
    
    func deleteRoute() {
        guard let delegate = delegate else { return }
        if CoreDataManager.shared.deleteRoute(route) {
            delegate.didDeleteRoute()
        }
    }
}
