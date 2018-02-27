//
//  LoginViewController.swift
//  Shine_for_iOS
//
//  Created by ryoku on 2018/01/27.
//  Copyright © 2018 ryoku. All rights reserved.
//

import Foundation
import UIKit
import Firebase
import GoogleSignIn

protocol LoginDelegate: class {
    func showActivityIndicator()
    func stopActivityIndicator()
    func showErrorMessage(label: LoginLabel,errMsg: String)
    func hideErrorMessage(label: LoginLabel)
    func showErrorAlert(errMsg: String)
    func gotoTopViewController()
    func signInButtonEnable()
    func signInButtonDisable()
}

class LoginViewController: UIViewController, GIDSignInUIDelegate {

    static func createViewController() ->LoginViewController {
        let vc = Segue<LoginViewController>.login.instantiateInitialViewController()
        return vc
    }
    
    @IBOutlet weak var mailAddress: UITextField!
    @IBOutlet weak var mailError: UILabel!
    @IBOutlet weak var password: UITextField!
    @IBOutlet weak var passError: UILabel!
    
    @IBOutlet weak var signIn: UIButton!
    
    @IBAction func gotoTop(_ sender: Any) {
       self.gotoTopViewController()
    }
    @IBAction func maillEditing(_ sender: Any) {
        hideErrorMessage(label: .mailAddress)
        presenter!.mailAddress = mailAddress.text
        presenter!.signInButtonState()
    }

    @IBAction func passwordEditing(_ sender: Any) {
        hideErrorMessage(label: .password)
        presenter!.password = password.text
        presenter!.signInButtonState()
    }

    var presenter: LoginPresenter? {
        didSet {
            presenter!.delegate = self
        }
    }

    lazy var activityIndicator: UIActivityIndicatorView = {
        let indicator = UIActivityIndicatorView(activityIndicatorStyle: UIActivityIndicatorViewStyle.whiteLarge)
        indicator.frame = navigationController?.view.bounds ?? view.bounds
        indicator.backgroundColor = UIColor(white: 0, alpha: 0.4)
        
        return indicator
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        mailAddress.delegate = self
        password.delegate = self
        GIDSignIn.sharedInstance().uiDelegate = self
        GIDSignIn.sharedInstance().delegate = self

        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "sign up", style: .plain, target: self, action: #selector(signUpButtonPushed))

        // signIn Button
        signIn.isEnabled = false
        signIn.alpha = 0.4
        signIn.addTarget(self, action: #selector(signInButtonPushed), for: .touchUpInside)
        
        navigationController?.view.addSubview(activityIndicator) ?? view.addSubview(activityIndicator)
    }
    
    @objc func signInButtonPushed() {
        print("signInButtonPushed")
        presenter!.signInButtonDidPush()
    }

    @objc func signUpButtonPushed() {
        
        let signUpVC = SignUpViewControllerBuilder.build()
        self.navigationController?.pushViewController(signUpVC, animated: true)
        
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesBegan(touches, with: event)
        
        view.endEditing(true)
    }
    
}

extension LoginViewController: UITextFieldDelegate {
    
    // enterキー押下でキーボードをとじるように実装
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        mailAddress.resignFirstResponder()
        password.resignFirstResponder()
        return true
    }
}

extension LoginViewController: LoginDelegate {
    
    func showActivityIndicator() {
//        navigationController?.view.backgroundColor = UIColor.white
        self.activityIndicator.startAnimating()
    }
    
    func stopActivityIndicator() {
        self.activityIndicator.stopAnimating()
//        navigationController?.view.backgroundColor = UIColor.white
    }
    
    func showErrorMessage(label: LoginLabel, errMsg: String) {
        switch label {
            case .mailAddress:
                mailAddress.layer.borderColor = UIColor.MyTheme.error.cgColor
                mailError.text = errMsg
            case .password:
                password.layer.borderColor = UIColor.MyTheme.error.cgColor
                passError.text = errMsg
        }
    }
    
    func hideErrorMessage(label: LoginLabel) {
        switch label {
        case .mailAddress:
            mailAddress.layer.borderColor = UIColor.MyTheme.textBorder.cgColor
            mailError.text = nil
        case .password:
            password.layer.borderColor = UIColor.MyTheme.textBorder.cgColor
            passError.text = nil
        }
    }

    func showErrorAlert(errMsg: String) {
        
        let alert = UIAlertController(title: "Error", message: errMsg, preferredStyle: UIAlertControllerStyle.alert)
        let okAction = UIAlertAction(title: "ok", style: .default)
        alert.addAction(okAction)
        
        self.present(alert, animated: true, completion: nil)
        
    }
    
    func gotoTopViewController() {
        AppDelegate.shared.rootViewController.showTopScreen()
    }
    
    func signInButtonEnable() {
        signIn.isEnabled = true
        signIn.alpha = Alpha.enable
    }
    
    func signInButtonDisable() {
        signIn.isEnabled = false
        signIn.alpha = Alpha.disable
    }
    
}



extension LoginViewController: GIDSignInDelegate {
    
    func application(_ app: UIApplication, open url: URL, options: [UIApplicationOpenURLOptionsKey : Any] = [:]) -> Bool {
        return GIDSignIn.sharedInstance().handle(url, sourceApplication: options[UIApplicationOpenURLOptionsKey.sourceApplication] as? String, annotation: options[UIApplicationOpenURLOptionsKey.annotation])
    }
    
    func sign(_ signIn: GIDSignIn!, didSignInFor user: GIDGoogleUser!, withError error: Error!) {
        presenter!.googleSign(signIn, didSignInFor: user, withError: error)
    }
}

enum LoginLabel: String {
    case mailAddress = "mailAddress"
    case password = "password"
}
