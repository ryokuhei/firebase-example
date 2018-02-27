//
//  FireBaseAuth.swift
//  Shine_for_iOS
//
//  Created by ryoku on 2018/01/27.
//  Copyright © 2018 ryoku. All rights reserved.
//

import Foundation
import FirebaseAuth

protocol UserAuth {
    func login(_ email: String,_ password: String,_ completion: @escaping (Result<User, SignInError>) -> Void)
    func login(_ credenticatials: AuthCredential, _ completion: @escaping (Result<User, SignInError>) ->Void)
    func loginCheck() ->Result<User, SignInError>
    func createUser(_ mail: String,_ password: String,_ completion: @escaping(Result<User, SignUpError>) ->Void)
}

class FireBaseAuth: UserAuth {

    func login(_ email: String,_ password: String,_ completion: @escaping (Result<User, SignInError>) -> Void) {
        
        Auth.auth().signIn(withEmail: email, password: password) {
            (user, error)  in
            
            var result: Result<User, SignInError> = Result.failure(SignInError.unknownError)
            if let error = error {
                switch error._code {
                case 17009:
                    result = Result.failure(SignInError.incorrectPassowrd)
                case 17011:
                    result = Result.failure(SignInError.userNotExist)
                default:
                    print("errorNo: \(error._code)")
                    result = Result.failure(SignInError.unknownError)
                }
            }
            if let user = user {
                result = Result.success(user)
            }
            completion(result)

        }
    }
    
    func login(_ credenticatials: AuthCredential, _ completion: @escaping (Result<User, SignInError>) ->Void) {
        
        Auth.auth().signIn(with: credenticatials) {
            (user, error) in
            
            var result: Result<User, SignInError> = Result.failure(SignInError.unknownError)
            
            if let error =  error {
                switch error._code {
                case 17009:
                    result = Result.failure(SignInError.incorrectPassowrd)
                case 17011:
                    result = Result.failure(SignInError.userNotExist)
                default:
                    print("errorNo: \(error._code)")
                    result = Result.failure(SignInError.unknownError)
                }
            }
            if let user = user {
                result = Result.success(user)
            }
            completion(result)
        }
    }

    func loginCheck() ->Result<User, SignInError> {
        
        var result: Result<User, SignInError> = Result.failure(SignInError.unknownError)

        let user = Auth.auth().currentUser
        
        if let user = user {
            result = Result.success(user)
        }
        
        return result
    }
    
    func createUser(_ mail: String,_ password: String,_ completion: @escaping (Result<User, SignUpError>) ->Void) {
        
        Auth.auth().createUser(withEmail: mail, password: password) {
            (user, error) in
            
            var result: Result<User, SignUpError> = Result.failure(SignUpError.unknownError)
            if let error = error {
                print(error)
                print("error_Code")
                print(error._code)
                switch error._code {
                case 17007:
                    result = Result.failure(SignUpError.registeredMail)
                case 17008:
                    result = Result.failure(SignUpError.mailFormatWrong)
                case 17026:
                    result = Result.failure(SignUpError.passwordIsShort)
                case 17999:
                    result = Result.failure(SignUpError.invalidMailOrPassword)
                default:
                    print("errorNo: \(error._code)")
                    result = Result.failure(SignUpError.unknownError)
                }
            }
            
            if let user = user {
                result = Result.success(user)
            }
            completion(result)
        }
    }
}

enum SignInError: Error {
    
    case incorrectPassowrd
    case userNotExist
    case unknownError
    
    var message: String {
        switch self {
        case .incorrectPassowrd:
            return "The password you’ve entered is incorrect."
        case .userNotExist:
            return "User does not exist."
        case .unknownError:
            return "error"
        }
    }
}

enum SignUpError: Error {
    
    case registeredMail
    case mailFormatWrong
    case passwordIsShort
    case invalidMailOrPassword
    case unknownError
    
    var message: String {
        switch self {
        case .registeredMail:
            return "Registered e-mail address."
        case .mailFormatWrong:
            return "Mail format is wrong."
        case .passwordIsShort:
            return "Password is short. (6 characters or more)"
        case .invalidMailOrPassword:
            return "Mail or password is invalid."
        case .unknownError:
            return "error"
        }
    }
}
