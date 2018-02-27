//
//  SignUpPresenter.swift
//  Shine_for_iOS
//
//  Created by ryoku on 2018/01/27.
//  Copyright © 2018 ryoku. All rights reserved.
//

import Foundation

protocol SignUpPresenter {
    var mail: String? {get set}
    var name: String? {get set}
    var password: String? { get set }
    var delegate: SignUpDelegate? {get set}
    
    func stateSignUpButton()
    func stateMailNextButton()
    func stateUserNextButton()
    func signUpButtonDidPush()
    func validMail() ->Bool
    func validName() ->Bool
    func validPassword() ->Bool
}

class SignUpPresenterImpl: BasePresenter, SignUpPresenter {
    
    var mail: String?
    var name: String?
    var password: String?

    weak var delegate: SignUpDelegate?
    
    var signup: SignUpUseCase
    var createUser: CreateUserUseCase

    init(signup: SignUpUseCase, createUser: CreateUserUseCase) {
        self.signup = signup
        self.createUser = createUser
    }
    
    func stateSignUpButton() {
        if mail?.count ?? 0 > 0
        && name?.count ?? 0 > 0
        && password?.count ?? 0 > 0 {
            delegate?.buttonEnable()
        } else {
            delegate?.buttonDisabe()
        }
    }
    
    func stateMailNextButton() {
        if mail?.count ?? 0 > 0 {
            delegate?.buttonEnable()
        } else {
            delegate?.buttonDisabe()
        }
    }
    
    func stateUserNextButton() {
        if name?.count ?? 0 > 0
        && password?.count ?? 0 > 0 {
            delegate?.buttonEnable()
        } else {
            delegate?.buttonDisabe()
        }
    }
    
    func signUpButtonDidPush() {
        
        if let mail = mail,
           let name = name,
           let pass = password {
            
            signUpUser(mail, pass, name)
            
        } else {
            delegate?.showErrorAlert(errMsg: "not exist mail or name or password")
        }
        

    }
    
    private func signUpUser(_ mail: String, _ password: String, _ name: String) {
        
        delegate?.showActivityIndicator()
        
        signup.invoke(mail, password) {
            [unowned self] result in
            
            self.delegate?.stopActivityIndicator()

            switch result {
                case .success(_):
                    let user = UserModel()
                    user.name = self.name!
                    self.createUser(model: user)
//                    self.delegate?.gotoTopViewController()
                case .failure(let error):
                    self.delegate?.showErrorAlert(errMsg: error.message)
            }
        }
    }
    
    private func createUser(model user: UserModel) {
        
        createUser.invoke(model: user) {
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
    
    func validMail() ->Bool {
        var result = true
        
        if !(mail?.contains("@") ?? false) {
            let message = "invalid mail format."
            delegate?.showErrorMessage(label: .mail, errMsg: message)
            result = false
        }
        
        return result
    }
    func validName() ->Bool {
        var result = true
        if name?.count ?? 0 < 3 {
            let message = "3 characters or more. "
            delegate?.showErrorMessage(label: .name, errMsg: message)
            result = false
        }
        
        return result
    }
    
    func validPassword() ->Bool {
        var result = true
        if password?.count ?? 0 < 5 {
            let message = "5 characters or more. "
            delegate?.showErrorMessage(label: .pasword, errMsg: message)
            result = false
        }
        
        return result
    }
}
