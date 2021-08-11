//
//  BaseViewController.swift
//  GCTest
//
//  Created by Santiago Borjon on 10/08/21.
//

import UIKit

class BaseViewController: UIViewController {
    
    //MARK: - Private Vars
    private var stackView = UIStackView()
    
    //MARK: - Public Vars
    weak var coordinator: MainCoordinator?
    var topView = UIView()
    var bottomView = UIView()
    
    //MARK: - LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        prepareInterface()
    }
    
    //MARK: - Private Methods
    private func prepareInterface() {
        view.backgroundColor = .white
        
        //Add the StackView
        view.addSubview(stackView)
        stackView.pin(to: view)
        
        //Stackview properties
        stackView.axis = .vertical
        stackView.alignment = .fill
        stackView.contentMode = .scaleToFill
        stackView.distribution = .fillEqually
        stackView.spacing = 0.0
        
        //Add top and bottom views to the stack
        stackView.addArrangedSubview(topView)
        stackView.addArrangedSubview(bottomView)
        
        topView.backgroundColor = .red
        bottomView.backgroundColor = .blue
    }
    
    //MARK: - Public Methods
    func showMessageAlert(_ message: String, title: String = "Atención") {
        let messageAlert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        messageAlert.addAction(UIAlertAction(title: "OK", style: .cancel, handler: nil))
        self.present(messageAlert, animated: true, completion: nil)
    }
    
    func showErrorAlert(_ message: String, title: String = "Error") {
        let errorAlert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        errorAlert.addAction(UIAlertAction(title: "OK", style: .cancel, handler: nil))
        self.present(errorAlert, animated: true, completion: nil)
    }
    
    func showOptionAlert(title: String = "Atención", _ message: String,
                         okHandler: ((UIAlertAction) -> Void)?,
                         cancelHandler: ((UIAlertAction) -> Void)?) {
        let optionAlert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        
        let okAction = UIAlertAction(title: "OK", style: .default, handler: okHandler)
        optionAlert.addAction(okAction)
        
        let cancelAction = UIAlertAction(title: "Cancelar", style: .cancel, handler: cancelHandler)
        optionAlert.addAction(cancelAction)
        
        self.present(optionAlert, animated: true, completion: nil)
    }
}
