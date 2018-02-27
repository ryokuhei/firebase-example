//
//  BaseBuilder.swift
//  Firebase-example
//
//  Created by ryoku on 2018/02/20.
//  Copyright © 2018 ryoku. All rights reserved.
//

import Foundation
import UIKit

protocol BaseViewControllerBuilder {
    associatedtype ViewController: UIViewController
    
    static func build() ->ViewController
}
