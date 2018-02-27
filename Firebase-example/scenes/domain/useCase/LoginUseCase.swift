//
//  LoginUseCase.swift
//  Shine_for_iOS
//
//  Created by ryoku on 2018/01/28.
//  Copyright © 2018 ryoku. All rights reserved.
//

import Foundation
import Firebase

class LoginUseCaseImpl: BaseUseCase, LoginUseCase{
    
    let authRepository: AuthenticateRepository
    
    init(authRepository: AuthenticateRepository) {
        self.authRepository = authRepository
    }
    
    func invoke(_ mail: String, _ password: String, _ completion: @escaping (Result<User, SignInError>) ->Void) {
        authRepository.login(mail, password, completion)
    }
    
    func invoke(_ credential: AuthCredential, _ completion: @escaping (Result<User, SignInError>) ->Void) {
        authRepository.login(credential, completion)
    }
}

protocol LoginUseCase {
    func invoke(_ mail: String, _ password: String, _ completion: @escaping (Result<User, SignInError>) ->Void)
    func invoke(_ credential: AuthCredential, _ completion: @escaping (Result<User, SignInError>) ->Void)
}
