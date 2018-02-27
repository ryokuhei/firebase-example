//
//  Result.swift
//  Shine_for_iOS
//
//  Created by ryoku on 2018/01/28.
//  Copyright © 2018 ryoku. All rights reserved.
//

import Foundation

enum Result<T, Error: Swift.Error> {
    case success(T)
    case failure(Error)
    
    init(value: T) {
        self = .success(value)
    }
    init(error: Error) {
        self = .failure(error)
    }
}

