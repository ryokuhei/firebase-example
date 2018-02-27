//
//  UserEntity.swift
//  Shine_for_iOS
//
//  Created by ryoku on 2018/02/05.
//  Copyright © 2018 ryoku. All rights reserved.
//

import Foundation

struct UserEntity {
    
    let id: String?
    let name: String?
    
    func convetJson() ->[String: Any] {
        var user = [String: Any]()
        user["name"] = self.name

        return user
    }
}
