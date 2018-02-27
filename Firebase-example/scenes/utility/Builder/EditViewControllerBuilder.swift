//
//  EditViewControllerBuilder.swift
//  Firebase-example
//
//  Created by ryoku on 2018/02/22.
//  Copyright © 2018 ryoku. All rights reserved.
//

import Foundation

struct EditViewControllerBuilder: BaseViewControllerBuilder {
    
    static var id: String?
    
    typealias ViewController = EditViewController
    
    static func build() ->ViewController {
        
        let vc = EditViewController.createViewController(id: id!)
        let dataStore = FireBaseUserDB()
        let repository = UserRepository(dataStore: dataStore)
        let translator = UserTranslatorImpl()
        let getUser = GetUserUseCaseImpl(repository: repository, translator: translator)
        let updateUser = UpdateUserUseCaseImpl(userRepository: repository, userTranslator: translator)
        let presenter = EditPresenterImpl(getUser: getUser, updateUser: updateUser)
        vc.presenter = presenter
        
        return vc
    }
}
