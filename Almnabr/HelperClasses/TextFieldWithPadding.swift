//
//  TextFieldWithPadding.swift
//  Almnabr
//
//  Created by Hany Alkahlout on 21/11/2022.
//  Copyright © 2022 Samar Akkila. All rights reserved.
//

import UIKit
class TextFieldWithPadding: UITextField {

    let padding = UIEdgeInsets(top: 0, left: 15, bottom: 0, right: 15)

    override open func textRect(forBounds bounds: CGRect) -> CGRect {
        return bounds.inset(by: padding)
    }

    override open func placeholderRect(forBounds bounds: CGRect) -> CGRect {
        return bounds.inset(by: padding)
    }

    override open func editingRect(forBounds bounds: CGRect) -> CGRect {
        return bounds.inset(by: padding)
    }
}
