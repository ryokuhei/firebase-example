//
//  CreateViewControllerBuilder.swift
//  Firebase-example
//
//  Created by ryoku on 2018/02/23.
//  Copyright © 2018 ryoku. All rights reserved.
//

import Foundation

struct CreateViewControllerBuilder: BaseViewControllerBuilder {
    
    typealias ViewController = CreateViewController
    
    static func build() ->ViewController {
        
        let vc = CreateViewController.createViewController()
        let dataStore = FireBaseUserDB()
        let repository = UserRepository(dataStore: dataStore)
        let translator = UserTranslatorImpl()
        let createUser = CreateUserUseCaseImpl(userRepository: repository, userTranslator: translator)
        let presenter = CreatePresenterImpl(createUser: createUser)
        vc.presenter = presenter
        
        return vc
    }
}
