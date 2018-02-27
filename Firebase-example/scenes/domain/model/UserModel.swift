//
//  UserModel.swift
//  Shine_for_iOS
//
//  Created by ryoku on 2018/02/07.
//  Copyright © 2018 ryoku. All rights reserved.
//

import Foundation

class UserModel: BaseModel {
    
    var id: String = ""
    var name: String = ""
    
    override init() {
    }
    
    init(entity: UserEntity) {
        self.id   = entity.id ?? ""
        self.name = entity.name ?? ""
    }
}
