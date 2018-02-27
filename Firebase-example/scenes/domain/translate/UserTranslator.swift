//
//  UserTranslate.swift
//  Shine_for_iOS
//
//  Created by ryoku on 2018/02/07.
//  Copyright © 2018 ryoku. All rights reserved.
//

import Foundation

protocol UserTranslator {
    func translateToModel(from name: String) ->UserModel
    func translateToModel(from entity: UserEntity) ->UserModel
    func translateToEntity(from model: UserModel) ->UserEntity
    
}

class UserTranslatorImpl: BaseTranslator, UserTranslator {
    
    func translateToModel(from name: String) ->UserModel {
        let user = UserModel()
        user.name = name
        return user
        
    }
    
    func translateToModel(from entity: UserEntity) ->UserModel {
        let user = UserModel(entity: entity)
        return user
    }
    
    func translateToEntity(from model: UserModel) ->UserEntity {
        let user = UserEntity(id: model.id, name: model.name)
        return user
    }
}
