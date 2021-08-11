//
//  DetailViewController.swift
//  GCTest
//
//  Created by Santiago Borjon on 10/08/21.
//

import UIKit

class DetailViewController: BaseViewController {
    
    //MARK: - LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        prepareInterface()
    }
    
    //MARK: - Private Methods
    private func prepareInterface() {
        //Title
        navigationItem.title = "Tracking Detail"
    }
}
