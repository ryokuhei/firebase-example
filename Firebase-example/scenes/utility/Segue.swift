//
//  Segue.swift
//  Shine_for_iOS
//
//  Created by ryoku on 2018/01/11.
//  Copyright © 2018 ryoku. All rights reserved.
//

import Foundation
import UIKit

enum Segue<VC: UIViewController> {
    
    case splash
    case top
    case drawer
    case login
    case signUpMail
    case signUpUser
    case signUp
    
    var storyboard: String {
        switch self {
        case .splash:
            return "splash"
        case .top :
            return "top"
        case .drawer :
            return "drawer"
        case .login :
            return "login"
        case .signUpMail :
            return "signUp"
        case .signUpUser :
            return "signUp"
        case .signUp :
            return "signUp"
            
        }
    }
    
    var identity: String {
        switch self {
            
        case .signUpMail:
            return "signUpMail"
        case .signUpUser:
            return "signUpUser"
        case .signUp:
            return "signUp"
        default:
           return ""
        }
        
    }
    
    func instantiateInitialViewController(bundle: Bundle? = nil) ->VC {
        
        let storyboard = UIStoryboard(name: self.storyboard, bundle: bundle)

        let vc = storyboard.instantiateInitialViewController() as! VC

        return vc
    }
    
}
