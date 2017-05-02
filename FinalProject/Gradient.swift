//
//  Gradient.swift
//  FinalProject
//
//  Created by Ji Hwan Seung on 23/04/2017.
//  Copyright © 2017 Ji Hwan Seung. All rights reserved.
//

import Foundation
import UIKit

class Gradient {
    
    var colorSets = [String: [CGColor]]()
    
    
    init() {
        self.colorSets["day"] = [changeToCGColor(hexcode: "4EDDEB"), changeToCGColor(hexcode: "484CEB")]
        self.colorSets["night"] = [changeToCGColor(hexcode: "031F7D"), changeToCGColor(hexcode: "3A578F")]
        self.colorSets["dawn"] = [changeToCGColor(hexcode: "00018C"), changeToCGColor(hexcode: "E2FEFF")]
        self.colorSets["sunset"] = [changeToCGColor(hexcode: "FF1ABA"), changeToCGColor(hexcode: "9E3210")]
    }
    
    
    func changeToCGColor(hexcode: String) -> CGColor {
        
//        var hex = hexcode
//        
//        if hex.hasPrefix("#") {
//            hex.remove(at: hexcode.startIndex)
//        }
//        
//        var rgbValue: Int32 = 0
//        Scanner(string: hex).scanInt32(&rgbValue)
//        
//        let red = CGFloat((rgbValue & 0xFF0000) >> 16) / 255.0
//        let green = CGFloat((rgbValue & 0x00FF00) >> 8) / 255.0
//        let blue = CGFloat(rgbValue & 0x0000FF) / 255.0
        
//        return UIColor(red: red, green: green, blue: blue, alpha: 1.0).cgColor
        
        let hex = hexcode.trimmingCharacters(in: CharacterSet.alphanumerics.inverted)
        var int = UInt32()
        Scanner(string: hex).scanHexInt32(&int)
        let a, r, g, b: UInt32
        switch hex.characters.count {
        case 3: // RGB (12-bit)
            (a, r, g, b) = (255, (int >> 8) * 17, (int >> 4 & 0xF) * 17, (int & 0xF) * 17)
        case 6: // RGB (24-bit)
            (a, r, g, b) = (255, int >> 16, int >> 8 & 0xFF, int & 0xFF)
        case 8: // ARGB (32-bit)
            (a, r, g, b) = (int >> 24, int >> 16 & 0xFF, int >> 8 & 0xFF, int & 0xFF)
        default:
            (a, r, g, b) = (255, 0, 0, 0)
        }
        
        return UIColor(red: CGFloat(r)/255, green: CGFloat(g)/255, blue: CGFloat(b)/255, alpha: CGFloat(a)/255).cgColor
    }
    
}
