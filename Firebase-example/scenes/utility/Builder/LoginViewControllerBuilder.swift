//  Firebase-example
//
//  Created by ryoku on 2018/02/20.
//  Copyright © 2018 ryoku. All rights reserved.
//

import Foundation
struct LoginViewControllerBuilder: BaseViewControllerBuilder {
    
    typealias ViewController = LoginViewController
    
    static func build() ->ViewController {
        
        let vc = LoginViewController.createViewController()
        let dataStore = FireBaseAuth()
        let repository = AuthenticateRepositoryImpl(dataStore: dataStore)
        let usecase = LoginUseCaseImpl(authRepository: repository)
        let presenter = LoginPresenterImpl(userLogin: usecase)
        vc.presenter = presenter
        
        return vc
    }
}
