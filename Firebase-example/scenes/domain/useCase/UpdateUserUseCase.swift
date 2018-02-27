//
//  UpdateUserUseCase.swift
//  Firebase-example
//
//  Created by ryoku on 2018/02/19.
//  Copyright © 2018 ryoku. All rights reserved.
//

import Foundation

protocol UpdateUserUseCase {
    func invoke(model user: UserModel, completion: @escaping (Result<UserModel, UserError>) ->Void)
}

class UpdateUserUseCaseImpl: BaseUseCase, UpdateUserUseCase {
    
    var userRepository: UserRepository
    var tanslator: UserTranslator
    
    init(userRepository: UserRepository, userTranslator: UserTranslator) {
        self.userRepository = userRepository
        self.tanslator = userTranslator
    }
    
    func invoke(model user: UserModel, completion: @escaping (Result<UserModel, UserError>) ->Void) {
        let userEntity: UserEntity = tanslator.translateToEntity(from: user)

        userRepository.updateUser(entity: userEntity) {
            result in
            switch result {
            case .success(let user):
                let userModel = self.tanslator.translateToModel(from: user)
                completion(Result.success(userModel))
                
            case .failure(let error):
                completion(Result.failure(error))
            }
        }
        
    }
}
