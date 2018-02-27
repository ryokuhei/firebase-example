//
//  .swift.swift
//  Shine_for_iOS
//
//  Created by ryoku on 2018/01/27.
//  Copyright © 2018 ryoku. All rights reserved.
//

import Foundation
import Firebase

class AuthenticateRepositoryImpl: BaseRepository, AuthenticateRepository {
    
    var dataStore: UserAuth
    
    init(dataStore: UserAuth) {
        self.dataStore = dataStore
    }

    func login(_ mail: String, _ password: String,_ completion: @escaping (Result<User, SignInError>) ->Void) {
        dataStore.login(mail, password, completion)
    }
    func login(_ credential: AuthCredential,_ completion: @escaping (Result<User, SignInError>) ->Void) {
        dataStore.login(credential, completion)
    }
    
    func loginCheck() ->Result<User, SignInError> {
        return dataStore.loginCheck()
    }
    
    func sigin(_ mail: String, _ password: String, _ completion: @escaping (Result<User, SignUpError>) ->Void) {
        dataStore.createUser(mail, password, completion)
    }
}

protocol AuthenticateRepository {

    func login(_ mail: String, _ password: String,_ completion: @escaping (Result<User, SignInError>) ->Void)
    func login(_ credential: AuthCredential,_ completion: @escaping (Result<User, SignInError>) ->Void)
    func loginCheck() ->Result<User, SignInError>
    func sigin(_ mail: String, _ password: String, _ completion: @escaping (Result<User, SignUpError>) ->Void)

}
