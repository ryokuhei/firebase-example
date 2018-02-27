//
//  CreateUserUseCase.swift
//  Firebase-example
//
//  Created by ryoku on 2018/02/19.
//  Copyright © 2018 ryoku. All rights reserved.
//

import Foundation

protocol CreateUserUseCase {
    func invoke(model user: UserModel, completion: @escaping (Result<UserModel, UserError>) ->Void)
}

class CreateUserUseCaseImpl: BaseUseCase, CreateUserUseCase {
    
    var userRepository: UserRepository
    var userTranslator: UserTranslator
    
    init(userRepository: UserRepository, userTranslator: UserTranslator) {
        self.userRepository = userRepository
        self.userTranslator = userTranslator
    }
    
    func invoke(model user: UserModel, completion: @escaping (Result<UserModel, UserError>) ->Void) {
        let userEntity = userTranslator.translateToEntity(from: user)
        userRepository.createUser(entity: userEntity) {
            result in
            switch result {
            case .success(let userEntity):
                let userModel = self.userTranslator.translateToModel(from: userEntity)
                completion(Result.success(userModel))
                
            case .failure(let error):
                completion(Result.failure(error))
            }
        }
        
    }
}


