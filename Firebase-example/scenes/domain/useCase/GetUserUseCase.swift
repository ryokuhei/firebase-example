//
//  GetUserUseCase.swift
//  Firebase-example
//
//  Created by ryoku on 2018/02/22.
//  Copyright © 2018 ryoku. All rights reserved.
//
import Foundation

protocol GetUserUseCase {
    func invoke(id: String, completion: @escaping (Result<UserModel, UserError>) ->Void)
}

class GetUserUseCaseImpl: BaseUseCase, GetUserUseCase {

    var repository: UserRepository
    var translator: UserTranslator
    
    init(repository: UserRepository, translator: UserTranslator) {
        self.repository = repository
        self.translator = translator
    }
    
    func invoke(id: String, completion: @escaping (Result<UserModel, UserError>) ->Void) {
        repository.getUser(id: id) { [unowned self] result in
            switch result {
            case .success(let user):
                let userModel = self.translator.translateToModel(from: user)
                completion(Result.success(userModel))
            case .failure(let error):
                completion(Result.failure(error))
            }
        }
    }
}
