//
//  TextCVCell.swift
//  Almnabr
//
//  Created by MacBook on 03/03/2022.
//  Copyright © 2022 Samar Akkila. All rights reserved.
//

import UIKit

class TextCVCell: UICollectionViewCell {

    @IBOutlet weak var lblTitle: UILabel!
    @IBOutlet weak var viewBack: UIView!
 
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
        viewBack.backgroundColor = HelperClassSwift.acolor.getUIColor()
        viewBack.setRounded(10)
        lblTitle.textColor = .white
        lblTitle.font = .kufiRegularFont(ofSize: 13)
        
    }

}
