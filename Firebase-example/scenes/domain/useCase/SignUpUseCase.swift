//
//  SignUpUseCase.swift
//  Shine_for_iOS
//
//  Created by ryoku on 2018/01/29.
//  Copyright © 2018 ryoku. All rights reserved.
//

import Foundation
import Firebase

class SignUpUseCaseImpl: BaseUseCase, SignUpUseCase {
    
    var authRepository: AuthenticateRepository
    
    init(authRepository: AuthenticateRepository) {
        self.authRepository = authRepository
    }
    
    func invoke(_ mail: String, _ password: String, _ completion: @escaping (Result<User, SignUpError>) ->Void) {
        authRepository.sigin(mail, password, completion)
    }
}

protocol SignUpUseCase {
    func invoke(_ mail: String, _ password: String, _ completion: @escaping (Result<User, SignUpError>) ->Void)
}
