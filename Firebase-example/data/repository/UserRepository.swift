//
//  UserRepository.swift
//  Shine_for_iOS
//
//  Created by ryoku on 2018/02/05.
//  Copyright © 2018 ryoku. All rights reserved.
//

import Foundation

protocol UserRepositoryProtocol {
    func createUser(entity user: UserEntity, completion: @escaping (Result<UserEntity, UserError>) ->Void)
    func getUserList(completion: @escaping (Result<[UserEntity], UserError>) ->Void)
    func getUser(id: String, completion: @escaping (Result<UserEntity, UserError>) ->Void)
    func updateUser(entity user: UserEntity, completion: @escaping (Result<UserEntity, UserError>) ->Void)
    func deleteUser(id: String, completion: @escaping (Result<String, UserError>) ->Void)
}

class UserRepository: BaseRepository, UserRepositoryProtocol {

    var userDB: UserDB
    
    init(dataStore: UserDB) {
        self.userDB = dataStore
    }
    
    func getUserList(completion: @escaping (Result<[UserEntity], UserError>) ->Void) {
        userDB.list(complete: completion)
    }
    
    func getUser(id: String, completion: @escaping (Result<UserEntity, UserError>) ->Void) {
        userDB.fetch(id: id, complete: completion)
    }
    
    func createUser(entity user: UserEntity, completion: @escaping (Result<UserEntity, UserError>) ->Void) {
        userDB.write(user: user, complete: completion)
    }

    func updateUser(entity user: UserEntity, completion: @escaping (Result<UserEntity, UserError>) ->Void) {
        userDB.update(user: user, complete: completion)
    }
    
    func deleteUser(id: String, completion: @escaping (Result<String, UserError>) ->Void) {
        userDB.remove(id: id, complete: completion)
    }
}


