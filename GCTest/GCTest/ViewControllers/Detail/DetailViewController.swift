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
    
    //MARK: - LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        prepareInterface()
    }
    
    //MARK: - Private Methods
    private func prepareInterface() {
        //Title
        navigationItem.title = "Tracking Detail"
        
        //Change TopView Size
        resizeTopView(factor: 3/5)
    }
    
    //MARK: - Public Methods
    func setViewModel(_ viewModel: DetailViewModel) {
        self.viewModel = viewModel
        self.viewModel?.delegate = self
    }
}

extension DetailViewController: DetailViewModelDelegate {
    func didDeleteRoute() {
        self.navigationController?.popViewController(animated: true)
    }
}
