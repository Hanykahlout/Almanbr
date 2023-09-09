//
//  TaskUsersCVCell.swift
//  Almnabr
//
//  Created by MacBook on 15/05/2022.
//  Copyright © 2022 Samar Akkila. All rights reserved.
//

import UIKit

class TaskUsersCVCell: UICollectionViewCell {

    @IBOutlet weak var lblTitle: UILabel!
    @IBOutlet weak var img_user: UIImageView!
    @IBOutlet weak var viewBack: UIView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
//        viewBack.setBorderGray()
//        viewBack.setRounded(10)
        img_user.setRounded()
        
    }

}
