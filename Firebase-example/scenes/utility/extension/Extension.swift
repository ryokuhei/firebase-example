//
//  Extension.swift
//  Shine_for_iOS
//
//  Created by ryoku on 2018/01/31.
//  Copyright © 2018 ryoku. All rights reserved.
//

import Foundation
import UIKit

public struct Extension<Base> {
    let base: Base
    
    init(_ base: Base) {
        self.base = base
    }
}

public protocol ExtensionCompatible {
    associatedtype CompatibleType
    
    static var ex: Extension<CompatibleType>.Type { get }
    var ex: Extension<CompatibleType> { get }
}

extension ExtensionCompatible {
    
    public static var ex: Extension<Self>.Type  {
        return Extension<Self>.self
    }
    public var ex: Extension<Self> {
        return Extension(self)
    }
}

extension String: ExtensionCompatible {}

