//
//  FireBaseUserDB.swift
//  Shine_for_iOS
//
//  Created by ryoku on 2018/02/05.
//  Copyright © 2018 ryoku. All rights reserved.
//

import Foundation
import FirebaseDatabase
import FirebaseAuth

protocol UserDB {
    func fetch(id: String, complete: @escaping (Result<UserEntity, UserError>) ->Void)
    func list(complete: @escaping (Result<[UserEntity], UserError>) ->Void)
    func write(user: UserEntity, complete: @escaping (Result<UserEntity, UserError>) ->Void)
    func update(user: UserEntity, complete: @escaping (Result<UserEntity, UserError>) ->Void)
    func remove(id: String, complete: @escaping (Result<String, UserError>) ->Void)
}

class FireBaseUserDB: BaseDataStore, UserDB {
    
    lazy var usersReference: DatabaseReference = {
        return Database.database().reference().child("users")
    }()
    
    var userId: String {
        get {
            return (Auth.auth().currentUser?.uid)!
        }
    }
    
    func fetch(id: String, complete: @escaping (Result<UserEntity, UserError>) ->Void) {
        usersReference.child(id).observe(.value, with: {
            (snapshot) in
            
            let userData: [String: AnyObject] = snapshot.value as? [String: AnyObject] ?? [:]
            let user = self.convertToUserEntity(from: userData, with: id)
            if let user = user {
                complete(Result.success(user))
            } else {
                complete(Result.failure(UserError.userNotExist))
            }
        })
    }
    
    func list(complete: @escaping (Result<[UserEntity], UserError>) ->Void) {
        
        usersReference.observe(.value, with: {
            (snapshot) in
            var users: [UserEntity] = []
            let userDictionary = snapshot.value as? [String : AnyObject] ?? [:]

            for userData in userDictionary {
                let id = userData.key
                let userData = userData.value as? [String : AnyObject] ?? [:]

                if let user = self.convertToUserEntity(from: userData, with: id) {
                    users.append(user)
                }
            }
            complete(Result.success(users))
        })
    }
    
    func write(user: UserEntity, complete: @escaping (Result<UserEntity, UserError>) ->Void) {
        
        let id = getNewId()

        self.usersReference.childByAutoId()
            .setValue(user.convetJson()) {  (error, databaseReference) in

                if let _ = error {
                    complete(Result.failure(UserError.unknownError))
                    return
                }
                
                databaseReference.observe(.value) {
                    [unowned self] (snapshot) in
                    if snapshot.exists() {
                        let userData = snapshot.value as? [String: AnyObject] ?? [:]
                        if let user = self.convertToUserEntity(from: userData, with: id) {
                        
                            print("user.name: \(user.name)")
                            complete(Result.success(user))
                        } else {
                            complete(Result.failure(UserError.userNotExist))
                        }
                    }
                }
            }

    }
    
    func update(user: UserEntity, complete: @escaping (Result<UserEntity, UserError>) ->Void) {
        
        usersReference.child(user.id!).updateChildValues(user.convetJson()) {
            [unowned self] (error, databaseReference) in
            if let _ = error {
                complete(Result.failure(UserError.unknownError))
            }
            databaseReference.observe(.value) {
                [unowned self] (snapshot) in
                if snapshot.exists() {
                    let userData = snapshot.value as? [String: AnyObject] ?? [:]
                    if let userEntity = self.convertToUserEntity(from: userData, with: user.id!) {
                        complete(Result.success(userEntity))
                    } else {
                        complete(Result.failure(UserError.userNotExist))
                    }
                }
            }
        }
    }
    
    func remove(id: String, complete: @escaping (Result<String, UserError>) ->Void) {

        usersReference.child(id).removeValue {
            (error, databaseReference) in
                if let _ = error {
                    complete(Result.failure(UserError.unknownError))
                }
                databaseReference.observe(.value) {
                    (snapshot) in
                    if snapshot.exists() {
                        complete(Result.failure(UserError.userNotExist))
                    } else {
                        complete(Result.success("delete success."))
                    }
               }
        }
    }
    
    private func convertToUserEntity(from userData: [String : AnyObject], with id: String) ->UserEntity? {
        var user: UserEntity? = nil
        if let name = userData["name"] as? String {
            user = UserEntity(id: id, name: name)
        }
        return user
    }
    
    private func getNewId() ->String {
        let idRef = usersReference.childByAutoId()
        let id = idRef.key
        
         return id
    }
}


enum UserError: Error {

    case userNotExist
    case deleteFailure
    case unknownError

    var message: String {
        switch self {
        case .userNotExist:
            return "User does not exist."
        case .deleteFailure:
            return "Delete failure."
        case .unknownError:
            return "error"
        }
    }
}
