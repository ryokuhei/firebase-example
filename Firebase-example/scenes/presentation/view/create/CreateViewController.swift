//
//  CreateViewController.swift
//  Firebase-example
//
//  Created by ryoku on 2018/02/23.
//  Copyright © 2018 ryoku. All rights reserved.
//

import Foundation
import UIKit

protocol CreateDelegate: class {
    func popToRootViewController()
    func showActivityIndicator()
    func stopActivityIndicator()
    func showErrorMessage(message: String)
}

class CreateViewController: UIViewController {
    
    static func createViewController() ->CreateViewController {
        let storyboard = UIStoryboard(name: "create", bundle: nil)
        let vc = storyboard.instantiateInitialViewController() as! CreateViewController
        return vc
    }
    
    @IBOutlet weak var nameText: UITextField!
    
    var presenter: CreatePresenter? {
        didSet {
            presenter?.delegate = self
        }
    }
    
    lazy var activityIndicator: UIActivityIndicatorView = {
        let indicator = UIActivityIndicatorView(activityIndicatorStyle: UIActivityIndicatorViewStyle.whiteLarge)
        indicator.backgroundColor = UIColor(white: 0, alpha: 0.4)
        indicator.frame = self.navigationController?.view.bounds ?? self.view.bounds
        return indicator
    }()
    
    lazy var doneButton: UIBarButtonItem = {
        let button = UIBarButtonItem(barButtonSystemItem: .done, target: self, action: #selector(doneButtonDidTap))
        return button
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.addSubview(activityIndicator)
        self.navigationItem.setRightBarButton(doneButton, animated: true)
        
    }
    
    @objc func doneButtonDidTap() {
        let user = UserModel()
        user.name = nameText.text ?? ""
        presenter?.doneButtonDidPush(model: user)
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesBegan(touches, with: event)
        view.endEditing(true)
    }
}

extension CreateViewController: UITextFieldDelegate {
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        nameText.resignFirstResponder()
        
        return true
    }
}

extension CreateViewController: CreateDelegate {
    
    func showErrorMessage(message: String) {
        let alert = UIAlertController(title: "error", message: message, preferredStyle: .alert)
        self.present(alert, animated: true, completion: nil)
    }

    func popToRootViewController() {
        self.navigationController?.popToRootViewController(animated: true)
    }
    
    func showActivityIndicator() {
        activityIndicator.startAnimating()
    }
    
    func stopActivityIndicator() {
        activityIndicator.stopAnimating()
    }
    
    
}
