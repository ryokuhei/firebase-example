//
//  color.swift
//  Shine_for_iOS
//
//  Created by ryoku on 2018/02/04.
//  Copyright © 2018 ryoku. All rights reserved.
//
import Foundation
import UIKit

extension UIColor {
    struct MyTheme {
        static let error = #colorLiteral(red: 0.9976895452, green: 0.1691693664, blue: 0.006793463137, alpha: 1)
        static var text = #colorLiteral(red: 0.9999960065, green: 1, blue: 1, alpha: 1)
        static var textBorder = #colorLiteral(red: 0.7233663201, green: 0.7233663201, blue: 0.7233663201, alpha: 1)
        static var label = #colorLiteral(red: 0.9999960065, green: 1, blue: 1, alpha: 1)
        static var labelBorder = #colorLiteral(red: 0.7233663201, green: 0.7233663201, blue: 0.7233663201, alpha: 1)
        static var button = #colorLiteral(red: 0, green: 0.4784313725, blue: 1, alpha: 1)
        static var buttonBorder = #colorLiteral(red: 0.3327096403, green: 0.3238574266, blue: 0.9031389952, alpha: 1)
    }
}

class Alpha {
    static let enable: CGFloat = 1.0
    static let disable: CGFloat = 0.4
}
