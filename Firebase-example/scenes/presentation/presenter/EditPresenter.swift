//
//  EditPresenter.swift
//  Firebase-example
//
//  Created by ryoku on 2018/02/22.
//  Copyright © 2018 ryoku. All rights reserved.
//

import Foundation

protocol EditPresenter {
    var delegate: EditViewDelegate? {get set}
    
    func load(id: String)
    func doneButtonDidPush(model user: UserModel)
}

class EditPresenterImpl: BasePresenter, EditPresenter {
    
    weak var delegate: EditViewDelegate?
    
    var getUser: GetUserUseCase
    var updateUser: UpdateUserUseCase
    
    init(getUser: GetUserUseCase, updateUser: UpdateUserUseCase) {
        self.getUser = getUser
        self.updateUser = updateUser
    }
    
    func load(id: String) {
        self.getUser.invoke(id: id) {
            [unowned self] result in
            
            switch result {
                case .success(let user):
                    self.delegate?.setUserData(user: user)
                case .failure(let error):
                    self.delegate?.showErrorAlert(message: error.message)
            }
        }
    }
    
    func doneButtonDidPush(model user: UserModel) {
        self.updateUser.invoke(model: user) {
            [unowned self] result in
            
            switch result {
                case .success(let user):
                    self.delegate?.setUserData(user: user)
                    self.delegate?.popToRootViewControler()
                case .failure(let error):
                    self.delegate?.showErrorAlert(message: error.message)
            }
        }
    }

}
