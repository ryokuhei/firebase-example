//
//  CreatePresenter.swift
//  Firebase-example
//
//  Created by ryoku on 2018/02/23.
//  Copyright © 2018 ryoku. All rights reserved.
//

import Foundation

protocol CreatePresenter {
    var delegate: CreateDelegate? {get set}
    func doneButtonDidPush(model user: UserModel)
}

class CreatePresenterImpl: BasePresenter, CreatePresenter {
    
    weak var delegate: CreateDelegate?
    
    let createUser: CreateUserUseCase
    
    init(createUser: CreateUserUseCase) {
        self.createUser = createUser
    }
    
    func doneButtonDidPush(model user: UserModel) {
        delegate?.showActivityIndicator()
        print("doneButtonDidPush")
        createUser.invoke(model: user) { [unowned self] result in
            
        print("createUser result")
            switch result {
            case .success(_):
                self.delegate?.popToRootViewController()
                
            case .failure(let error):
                
                self.delegate?.showErrorMessage(message: error.message)
            }
            
            self.delegate?.stopActivityIndicator()
        }

    }
    
    
}
