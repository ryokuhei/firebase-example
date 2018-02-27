//
//  TopPresenter.swift
//  Firebase-example
//
//  Created by ryoku on 2018/02/19.
//  Copyright © 2018 ryoku. All rights reserved.
//

import Foundation


protocol TopPresenter: class {
    
    var delegate:TopDelegate? {get set}
    func loadUserList()
    func cellDidTap(user: UserModel)
    func addButtonDidPush()
    func deleteButtonDidPush(id: String)
}

class TopPresenterImpl: BasePresenter, TopPresenter {

    weak var delegate: TopDelegate?
    
    var getUserList : GetUserListUseCase
    var deleteUser : DeleteUserUseCase
    
    init(getUserList: GetUserListUseCase, deleteUser: DeleteUserUseCase) {
        self.getUserList = getUserList
        self.deleteUser = deleteUser
    }

    func loadUserList() {
        self.delegate?.showIndicator()
        getUserList.invoke(completion: {
            [unowned self] result in
            switch result {
            case .success(let userModels):
                self.delegate?.reloadTableView(userModels: userModels)
            case .failure(let error):
                self.delegate?.showErrorAlert(errMsg: error.message)
            }
            
            self.delegate?.stopIndicator()
        })
    }
    
    func cellDidTap(user: UserModel) {
        delegate?.pushDetailViewController(id: user.id)
    }
    
    func addButtonDidPush() {
        delegate?.pushCreateViewController()
    }
    
    func deleteButtonDidPush(id: String) {
        delegate?.showIndicator()
        
        deleteUser.invoke(id: id) {
            [unowned self] result in
            switch result {
            case .success(_):
                self.loadUserList()
            case .failure(let error):
                self.delegate?.showErrorAlert(errMsg: error.message)
            }
            self.delegate?.stopIndicator()
        }
    }
    
}

