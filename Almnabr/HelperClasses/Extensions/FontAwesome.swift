//
//  FontAwesome.swift
//  Almnabr
//
//  Created by MacBook on 28/09/2021.
//  Copyright © 2021 Samar Akkila. All rights reserved.
//


import UIKit

class FontAwesome: NSObject {
    
    static func codeToFontAwesome(_ code:String) -> String {
        if let int32 = UInt32(hexString: code), let unicode = UnicodeScalar(int32) {
            let unicode = Character(unicode)
            return unicode.description
        }
        return "\u{e900}"
    }
    
}

extension UILabel {
    
    func setFontawsome(code:String,size:Int) {
        text = FontAwesome.codeToFontAwesome(code)
        //font = MyTools.appFont(.FontAwsome, size: size)
    }
    
}

extension UInt32 {
    init?(hexString: String) {
        let scanner = Scanner(string: hexString)
        var hexInt = UInt32.min
        let success = scanner.scanHexInt32(&hexInt)
        if success {
            self = hexInt
        } else {
            return nil
        }
    }
}
