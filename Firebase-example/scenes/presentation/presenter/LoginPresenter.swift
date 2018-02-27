//
//  LoginPresenter.swift
//  Shine_for_iOS
//
//  Created by ryoku on 2018/01/27.
//  Copyright © 2018 ryoku. All rights reserved.
//

import Foundation
import Firebase
import GoogleSignIn

protocol LoginPresenter {
    var delegate: LoginDelegate? { get set }
    var mailAddress: String? { get set }
    var password: String? { get set }
    
    
    func signInButtonState()
    func signInButtonDidPush()
    func googleSign(_ signIn: GIDSignIn!, didSignInFor user: GIDGoogleUser!, withError error: Error!)
}

class LoginPresenterImpl: BasePresenter, LoginPresenter {
    
    weak var delegate: LoginDelegate?
    
    var mailAddress: String?
    var password: String?
    
    var userLogin: LoginUseCase

    init(userLogin: LoginUseCase) {
        self.userLogin = userLogin
    }
    
    func signInButtonState() {
        if mailAddress?.count ?? 0 > 0
            && password?.count ?? 0 > 0 {
            
            delegate?.signInButtonEnable()
        } else {
            delegate?.signInButtonDisable()
        }
    }

    func signInButtonDidPush() {

        let mailResult = validateMail()
        let passResult = validatePasswrod()
        
        if mailResult && passResult {
            delegate?.showActivityIndicator()
            self.userLogin(mailAddress!, password!)
        }
    }
    
    func googleSign(_ signIn: GIDSignIn!, didSignInFor user: GIDGoogleUser!, withError error: Error!) {
        
        if let error = error {
            print(error.localizedDescription)
            return
        }
        
        let auth = user.authentication
        
        let credential = GoogleAuthProvider.credential(withIDToken: (auth?.idToken)!, accessToken: (auth?.accessToken)!)
        
            delegate?.showActivityIndicator()
            self.userLogin(credential)
    }

    private func userLogin(_ mailAddress: String, _ password: String) {
        

        userLogin.invoke(mailAddress, password) {
            [unowned self] result in
            
            self.delegate?.stopActivityIndicator()
            
            switch result {
            case .success(_):
                self.delegate?.gotoTopViewController()
            case .failure(let error):
                self.delegate?.showErrorAlert(errMsg: error.message)
            }
        }
    }
    
    private func userLogin(_ credential: AuthCredential) {
        

        userLogin.invoke(credential) {
            [unowned self] result in
            
            self.delegate?.stopActivityIndicator()
            
            switch result {
            case .success(_):
                self.delegate?.gotoTopViewController()
            case .failure(let error):
                self.delegate?.showErrorAlert(errMsg: error.message)
            }
        }
    }
    
    private func validateMail() ->Bool {
        var result = true
        if !(mailAddress?.contains("@") ?? false) {
            let message = "invalid mailAddress format."
            delegate?.showErrorMessage(label: .mailAddress, errMsg: message)
            result = false
        }
    
        return result
    }
    
    private func validatePasswrod() ->Bool {
        var result = true
        
        if !(password?.count ?? 0 >= 5){
            let message = "5 characters or more. "
            delegate?.showErrorMessage(label: .password, errMsg: message)
            result = false
        }
    
        return result
    }
}
