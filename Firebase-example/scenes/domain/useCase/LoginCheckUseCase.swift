//
//  LoginCheckUseCase.swift
//  Shine_for_iOS
//
//  Created by ryoku on 2018/01/27.
//  Copyright © 2018 ryoku. All rights reserved.
//

import Foundation
import Firebase

class LoginCheckUseCaseImpl: BaseUseCase, LoginCheckUseCase {
    
    var authRepository: AuthenticateRepository
    
    init(authRepository: AuthenticateRepository) {
        self.authRepository = authRepository
    }
    
    func invoke() ->Result<User, SignInError> {
        let result = authRepository.loginCheck()
        
        return result
    }
}

protocol LoginCheckUseCase {
    func invoke() ->Result<User, SignInError>
}
