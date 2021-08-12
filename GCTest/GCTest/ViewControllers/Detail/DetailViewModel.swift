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
    
    //MARK: - Public Vars
    weak var delegate: DetailViewModelDelegate?
    
    //MARK: - Private Vars
    private var route: Route
    
    //MARK: - Initializers
    init(route: Route) {
        self.route = route
        super.init()
    }
    
}
