//
//  DetailPresenter.swift
//  Firebase-example
//
//  Created by ryoku on 2018/02/21.
//  Copyright © 2018 ryoku. All rights reserved.
//

import Foundation

protocol DetailPresenter {
    
    var delegate: DetailViewDelegate? { get set }
    
    func leadUserData(id: String)
    func editButtonDidPush(id: String)
    
}

class DetailPresenterImpl: BasePresenter, DetailPresenter {
    
    weak var delegate: DetailViewDelegate?
    
    var getUser: GetUserUseCase

    init(getUserUserCase: GetUserUseCase) {
        self.getUser = getUserUserCase
    }
    
    func leadUserData(id: String) {
        getUser.invoke(id: id) { [unowned self] result in
            switch result {
            case .success(let user) :
                self.delegate?.setUserData(user: user)
            case .failure(let error):
                self.delegate?.showErrorAlert(message: error.message)
            }
            
        }
    }
    
    func editButtonDidPush(id: String) {
        delegate?.pushEditViewController(id: id)
    }
}
