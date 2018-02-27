//
//  EditViewController.swift
//  Firebase-example
//
//  Created by ryoku on 2018/02/22.
//  Copyright © 2018 ryoku. All rights reserved.
//

import Foundation
import UIKit

protocol EditViewDelegate: class {
    func setUserData(user: UserModel)
    func showErrorAlert(message: String)
    func popToRootViewControler()
    func showIndicator()
    func stopIndicator()
}

class EditViewController: UIViewController {
    
    var id: String?
    
    @IBOutlet weak var nameText: UITextField!

    var presenter: EditPresenter? {
        didSet {
            presenter?.delegate = self
        }
    }
    
    lazy var activityIndicator: UIActivityIndicatorView = {
        let indicator = UIActivityIndicatorView()
        indicator.frame = self.navigationController?.view.bounds ?? self.view.bounds
        indicator.backgroundColor = UIColor(white: 0, alpha: 0.4)
        
        return indicator
        
    }()
    
    
    static func createViewController(id: String) ->EditViewController {
        
        let storyboard = UIStoryboard(name: "edit", bundle: nil)
        let vc = storyboard.instantiateInitialViewController() as! EditViewController
        vc.id = id
        
        return vc
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        presenter?.load(id: id!)
        
        let doneButtton = UIBarButtonItem(barButtonSystemItem: .done, target: self, action: #selector(self.doneButtonDidPush))
        self.navigationItem.setRightBarButton(doneButtton, animated: true)
    }
    
    @objc func doneButtonDidPush() {
        let name = self.nameText.text ?? ""
        let user = UserModel()
        user.id = id!
        user.name = name
        presenter?.doneButtonDidPush(model: user)
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesBegan(touches, with: event)
        view.endEditing(true)
    }
}

extension EditViewController: UITextFieldDelegate {
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        
        nameText.resignFirstResponder()
        
        return true
    }
    
}

extension EditViewController: EditViewDelegate {
    func setUserData(user: UserModel) {
        self.nameText.text = user.name
    }
    
    func showErrorAlert(message: String) {
        let alert = UIAlertController(title: "error", message: message, preferredStyle: .alert)
        let okAction = UIAlertAction(title: "ok", style: .default, handler: nil)
        alert.addAction(okAction)
        
        self.present(alert, animated: true, completion: nil)
    }
    
    func popToRootViewControler() {
        self.navigationController?.popToRootViewController(animated: true)
    }
    func showIndicator() {
        self.activityIndicator.startAnimating()
        
    }
    func stopIndicator() {
        self.activityIndicator.stopAnimating()
    }
    
}
