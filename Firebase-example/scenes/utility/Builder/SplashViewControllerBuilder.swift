//
//  SplashViewControllerBuilder.swift
//  Firebase-example
//
//  Created by ryoku on 2018/02/20.
//  Copyright © 2018 ryoku. All rights reserved.
//

import Foundation

struct SplashViewControllerBuilder: BaseViewControllerBuilder {
    
    typealias ViewController = SplashViewController
    
    static func build() ->ViewController {
        
        let vc = SplashViewController.createViewController()
        let datastore = FireBaseAuth()
        let repository = AuthenticateRepositoryImpl(dataStore: datastore)
        let usecase = LoginCheckUseCaseImpl(authRepository: repository)
        let presenter = SplashPresenterImpl(loginCheck: usecase)
        vc.presenter = presenter
        
        return vc
    }
}
