//
//  SignupViewControllerBuilder.swift
//  Firebase-example
//
//  Created by ryoku on 2018/02/20.
//  Copyright © 2018 ryoku. All rights reserved.
//

import Foundation
struct SignUpViewControllerBuilder: BaseViewControllerBuilder {
    
    typealias ViewController = SignUpMailViewController
    
    static func build() ->ViewController {
        
        let vc = SignUpViewController.createViewController()
        
        let authDataStore = FireBaseAuth()
        let authRepository = AuthenticateRepositoryImpl(dataStore: authDataStore)
        let signupUseCase = SignUpUseCaseImpl(authRepository: authRepository)
        
        let userDB = FireBaseUserDB()
        let userRepository = UserRepository(dataStore: userDB)
        let translator = UserTranslatorImpl()
        
        let createUserUseCase = CreateUserUseCaseImpl(userRepository: userRepository, userTranslator: translator)
        let presenter = SignUpPresenterImpl(signup: signupUseCase, createUser: createUserUseCase)
        vc.presenter = presenter
        
        return vc
    }
}
