//
//  SignUpUserViewController.swift
//  Shine_for_iOS
//
//  Created by ryoku on 2018/02/03.
//  Copyright © 2018 ryoku. All rights reserved.
//

import Foundation
import UIKit

class SignUpUserViewController: UIViewController {
    
    static func createViewController() ->UIViewController {
        let vc = Segue<SignUpViewController>.signUp.instantiateInitialViewController()
        return vc
    }
    
    @IBOutlet weak var name: CustomTextField!
    @IBOutlet weak var nameError: UILabel!
    @IBOutlet weak var password: CustomTextField!
    @IBOutlet weak var passwordError: UILabel!
    @IBOutlet weak var nextButton: CustomButton!
    
    @IBAction func nameEditing(_ sender: Any) {
        hideErrorMessage(label: .name)
        presenter!.name = name.text
        presenter!.stateUserNextButton()
    }
    @IBAction func passwordEditing(_ sender: Any) {
        hideErrorMessage(label: .pasword)
        presenter!.password = password.text
        presenter!.stateUserNextButton()
    }
    
    var presenter: SignUpPresenter?  {
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
        
        password.delegate = self

        name.text = presenter!.name
        presenter!.stateUserNextButton()
        navigationController?.view.addSubview(activeIndicator)
    }
    
    // view touches to close keybourd
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesBegan(touches, with: event)
        
        view.endEditing(true)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == Segue<SignUpViewController>.signUp.identity {
            let signUpVC = segue.destination as? SignUpViewController
            signUpVC?.presenter = self.presenter
        }
    }
    
    override func shouldPerformSegue(withIdentifier identifier: String, sender: Any?) -> Bool {
        let nameResult = presenter!.validName()
        let passResult = presenter!.validPassword()
        
        return nameResult && passResult
    }
}

extension SignUpUserViewController: UITextFieldDelegate {
    // tapped enter to close keyboard
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
}

extension SignUpUserViewController: SignUpDelegate {
    
    func showErrorMessage(label: SignUpLabel, errMsg: String) {
        
        switch label {
        case .name :
            nameError.text = errMsg
            name.layer.borderColor = UIColor.MyTheme.error.cgColor
        case .pasword :
            passwordError.text = errMsg
            password.layer.borderColor = UIColor.MyTheme.error.cgColor
        default:
            break
        }
    }
    
    func hideErrorMessage(label: SignUpLabel) {
        
        switch label {
        case .name :
            nameError.text = nil
            name.layer.borderColor =  UIColor.MyTheme.textBorder.cgColor
        case .pasword :
            passwordError.text = nil
            password.layer.borderColor = UIColor.MyTheme.textBorder.cgColor
        default:
            break
        }
    }

    func buttonEnable() {
        nextButton.isEnabled = true
        nextButton.alpha = Alpha.enable
    }
    
    func buttonDisabe() {
        nextButton.isEnabled = false
        nextButton.alpha = Alpha.disable
    }
    
    func showActivityIndicator() {
        activeIndicator.startAnimating()
    }
    
    func stopActivityIndicator() {
        activeIndicator.stopAnimating()
    }
    
    func showErrorAlert(errMsg: String) {
        let alert = UIAlertController(title: "error", message: errMsg, preferredStyle: .alert)
        let okAction = UIAlertAction(title: "ok", style: .default)
        alert.addAction(okAction)
        
        self.present(alert, animated: true, completion: nil)
    }
    
    func gotoTopViewController() {
        AppDelegate.shared.rootViewController.showTopScreen()
    }
}
