//
//  GetUserList.swift
//  Firebase-example
//
//  Created by ryoku on 2018/02/19.
//  Copyright © 2018 ryoku. All rights reserved.
//

import Foundation


class GetUserListUseCaseImpl: BaseUseCase, GetUserListUseCase {
    
    var userRepository: UserRepository
    var userTranslator: UserTranslator
    
    init(userRepository: UserRepository, userTranslator: UserTranslator) {
        self.userRepository = userRepository
        self.userTranslator = userTranslator
    }

    func invoke(completion: @escaping (Result<[UserModel], UserError>) ->Void) {
        userRepository.getUserList {
            result in
            switch result {
                case .success(let users):
                    let userModels = users.map { self.userTranslator.translateToModel(from: $0) }
                    completion(Result.success(userModels))
                
                case .failure(let error):
                    completion(Result.failure(error))
            }
        }

    }
}

protocol GetUserListUseCase {
    func invoke(completion: @escaping (Result<[UserModel], UserError>) ->Void)
}
