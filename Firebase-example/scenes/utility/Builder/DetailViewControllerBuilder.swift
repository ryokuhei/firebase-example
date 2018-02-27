//
//  DetailViewControllerBuilder.swift
//  Firebase-example
//
//  Created by ryoku on 2018/02/20.
//  Copyright © 2018 ryoku. All rights reserved.
//

import Foundation

struct DetailViewControllerBuilder: BaseViewControllerBuilder {
    
    static var id: String?
    
    typealias ViewController = DetailViewController
    
    static func build() ->ViewController {
        
        let vc = DetailViewController.createViewController(id: id!)
        let dataStore = FireBaseUserDB()
        let repository = UserRepository(dataStore: dataStore)
        let translator = UserTranslatorImpl()
        let getUser = GetUserUseCaseImpl(repository: repository, translator: translator)
        let presenter = DetailPresenterImpl(getUserUserCase: getUser)
        vc.presenter = presenter
        
        return vc
    }
}
