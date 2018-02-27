//
//  SignUpViewController.swift
//  Shine_for_iOS
//
//  Created by ryoku on 2018/01/27.
//  Copyright © 2018 ryoku. All rights reserved.
//

import Foundation
import UIKit

protocol SignUpDelegate: class {
    func buttonEnable()
    func buttonDisabe()
    func showErrorMessage(label: SignUpLabel, errMsg: String)
    func hideErrorMessage(label: SignUpLabel)
    func showActivityIndicator()
    func stopActivityIndicator()
    func showErrorAlert(errMsg: String)
    func gotoTopViewController()
}

class SignUpViewController: UIViewController {
    
    static func createViewController() ->SignUpMailViewController {
        let vc = Segue<SignUpMailViewController>.signUpMail.instantiateInitialViewController()
        return vc
    }
    
    @IBOutlet weak var name: UILabel!
    @IBOutlet weak var signUpButton: CustomButton!
    
    var presenter: SignUpPresenter? {
        didSet {
            presenter?.delegate = self
        }
    }

    lazy var activeIndicator : UIActivityIndicatorView = {
        let activeIndicator = UIActivityIndicatorView(activityIndicatorStyle: UIActivityIndicatorViewStyle.whiteLarge)
        activeIndicator.backgroundColor = UIColor(white: 0, alpha: Alpha.disable)
        activeIndicator.frame = navigationController?.view.bounds ?? view.bounds

        return activeIndicator
    }()

    override func viewDidLoad() {
        super.viewDidLoad()

        presenter!.delegate = self
        name.text = presenter?.name

        presenter!.stateSignUpButton()
        signUpButton.addTarget(self, action: #selector(signUpButtonPushed), for: .touchUpInside)
        
        navigationController?.view.addSubview(activeIndicator)
    }
    
    // view touches to close keybourd
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesBegan(touches, with: event)
        
        view.endEditing(true)
    }
    
    @objc private func signUpButtonPushed() {
        presenter?.signUpButtonDidPush()
    }
}

extension SignUpViewController: UITextFieldDelegate {
    // tapped enter to close keyboard
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
}

extension SignUpViewController: SignUpDelegate {

    func buttonEnable() {
        signUpButton.isEnabled = true
        signUpButton.alpha = Alpha.enable
    }
    
    func buttonDisabe() {
        signUpButton.isEnabled = false
        signUpButton.alpha = Alpha.disable
    }
    func showErrorMessage(label: SignUpLabel, errMsg: String) {
        print(errMsg)
    }
    
    func hideErrorMessage(label: SignUpLabel) {
    }

    func showActivityIndicator() {
        activeIndicator.startAnimating()
    }
    
    func stopActivityIndicator() {
        activeIndicator.stopAnimating()
    }
    
    func showErrorAlert(errMsg: String) {
        activeIndicator.stopAnimating()
        let alert = UIAlertController(title: "error", message: errMsg, preferredStyle: .alert)
        let okAction = UIAlertAction(title: "ok", style: .default)
        
        alert.addAction(okAction)
        
        self.present(alert, animated: true, completion: nil)
    }
    
    func gotoTopViewController() {
        activeIndicator.stopAnimating()
        AppDelegate.shared.rootViewController.showTopScreen()
    }
}



enum SignUpLabel: String {
    
    case mail = "mail"
    case name = "name"
    case pasword = "password"
    
}
