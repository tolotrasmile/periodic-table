//
// Created by Tolotra on 03/08/2017.
// Copyright (c) 2017 Etech. All rights reserved.
//

import UIKit

extension UIColor {

    static func fromHex(hex: String) -> UIColor {

        var cString: String = hex.stringByTrimmingCharactersInSet(NSCharacterSet.whitespaceAndNewlineCharacterSet() as NSCharacterSet).uppercaseString

        if (cString.hasPrefix("#")) {
            cString = cString.substringFromIndex(cString.startIndex.advancedBy(1))
        }

        if ((cString.characters.count) != 6) {
            return UIColor.grayColor()
        }

        var rgbValue: UInt32 = 0
        NSScanner(string: cString).scanHexInt(&rgbValue)

        return UIColor(
                red: CGFloat((rgbValue & 0xFF0000) >> 16) / 255.0,
                green: CGFloat((rgbValue & 0x00FF00) >> 8) / 255.0,
                blue: CGFloat(rgbValue & 0x0000FF) / 255.0,
                alpha: CGFloat(1.0)
        )
    }
}