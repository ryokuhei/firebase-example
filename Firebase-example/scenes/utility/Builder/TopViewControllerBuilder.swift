//
//  TopViewControllerBuilder.swift
//  Firebase-example
//
//  Created by ryoku on 2018/02/20.
//  Copyright © 2018 ryoku. All rights reserved.
//

import Foundation
import UIKit

struct TopViewControllerBuilder: BaseViewControllerBuilder {
    
    typealias ViewController = TopViewController

    static func build() ->ViewController {
        
        let vc = TopViewController.createViewController()
        let dataStore = FireBaseUserDB()
        let repository = UserRepository(dataStore: dataStore)
        let translator = UserTranslatorImpl()
        let getUserList = GetUserListUseCaseImpl(userRepository: repository, userTranslator: translator)
        let deleteUser = DeleteUserUseCaseImpl(repository: repository)
        let presenter = TopPresenterImpl(getUserList: getUserList, deleteUser: deleteUser)
        vc.presenter = presenter
        
        return vc
    }
}
