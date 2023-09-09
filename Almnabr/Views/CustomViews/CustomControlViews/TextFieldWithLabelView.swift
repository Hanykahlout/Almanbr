//
//  TextFieldWithLabelView.swift
//  Almnabr
//
//  Created by MacBook on 23/09/2021.
//  Copyright © 2021 Samar Akkila. All rights reserved.
//

import UIKit

class TextFieldWithLabelView: UIView {
    @IBOutlet var mainContainerView: UIView!
    @IBOutlet weak var lblTitle: UILabel!
    @IBOutlet weak var txtField: UITextField!
    @IBOutlet weak var parentView: UIView!
    @IBOutlet weak var hideShowPassword: UIButton!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        initNib()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        initNib()
    }
    
    func initNib() {
        let bundle = Bundle(for: TextFieldWithLabelView.self)
        bundle.loadNibNamed("TextFieldWithLabelView", owner: self, options: nil)
        addSubview(mainContainerView)
        mainContainerView.frame = bounds
        mainContainerView.autoresizingMask = [.flexibleHeight, .flexibleWidth]
        mainContainerView.backgroundColor = .clear
        parentView.backgroundColor = #colorLiteral(red: 0.9607843137, green: 0.9647058824, blue: 0.9725490196, alpha: 1)

        //lblTitle.textColor = "5D5D5D".getUIColor()
        txtField.textColor = "5D5D5D".getUIColor()
        txtField.backgroundColor = .clear
        txtField.layer.borderColor = #colorLiteral(red: 0.9607843137, green: 0.9647058824, blue: 0.9725490196, alpha: 1)
        parentView.layer.borderColor = #colorLiteral(red: 0.9607843137, green: 0.9647058824, blue: 0.9725490196, alpha: 1)
        parentView.layer.borderWidth = 0.5
        parentView.layer.cornerRadius = 7.0
        txtField.setLeftRightPaddingPoints(5, 5)
    }
    
    @IBAction func hideShowPassAction(_ sender: Any) {
        hideShowPassword.isSelected = !hideShowPassword.isSelected
        txtField.isSecureTextEntry = !hideShowPassword.isSelected
    }
    
    
}
