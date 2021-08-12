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
        topView.layer.masksToBounds = true
        bottomView.backgroundColor = .blue
        bottomView.layer.masksToBounds = true
    }
    
    //MARK: - Public Methods
    func resizeTopView(factor: CGFloat) {
        stackView.distribution = .fill
        topView.translatesAutoresizingMaskIntoConstraints = false
        topView.heightAnchor.constraint(equalToConstant: view.frame.height * factor).isActive = true
    }
    
    func showMessageAlert(_ message: String, title: String = "Atención", handler: ((UIAlertAction) -> Void)?) {
        let messageAlert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        messageAlert.addAction(UIAlertAction(title: "OK", style: .cancel, handler: handler))
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
    
    func showInputAlert(title: String = "", message: String = "", placeholder: String = "", _ completion: @escaping (_ name: String) -> ()) {
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)

        alertController.addTextField { (textField : UITextField!) -> Void in
            textField.placeholder = placeholder
        }

        let doneAction = UIAlertAction(title: "Done", style: .default, handler: { alert -> Void in
            let textField = alertController.textFields![0] as UITextField
            guard let text = textField.text, !text.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty else {
                self.present(alertController, animated: true, completion: nil)
                return
            }
            completion(text)
        })
        alertController.addAction(doneAction)
        
        self.present(alertController, animated: true, completion: nil)
    }
}
