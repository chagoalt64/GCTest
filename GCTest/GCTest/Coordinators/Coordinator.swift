//
//  Coordinator.swift
//  GCTest
//
//  Created by Santiago Borjon on 10/08/21.
//

import Foundation
import UIKit

protocol Coordinator {
    var navigationController: UINavigationController { get set }
    
    func start()
}
