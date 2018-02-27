//
//  DeleteUserUseCase.swift
//  Firebase-example
//
//  Created by ryoku on 2018/02/27.
//  Copyright © 2018 ryoku. All rights reserved.
//

import Foundation

protocol DeleteUserUseCase {
    func invoke(id: String, completion: @escaping (Result<String, UserError>) ->Void)
}

class DeleteUserUseCaseImpl: BaseUseCase, DeleteUserUseCase {
    
    var repository: UserRepository

    init(repository: UserRepository) {
        self.repository = repository
    }
    
    func invoke(id: String, completion: @escaping (Result<String, UserError>) ->Void) {
        
        repository.deleteUser(id: id) { result in
            switch result {
            case .success(let message):
                completion(Result.success(message))
            case .failure(let error):
                completion(Result.failure(error))
            }
        }
    }
}
