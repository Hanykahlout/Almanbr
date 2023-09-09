//
//  CategoryCell.swift
//  Almnabr
//
//  Created by MacBook on 29/03/2022.
//  Copyright © 2022 Samar Akkila. All rights reserved.
//

import UIKit

class CategoryCell: UICollectionViewCell {
    
    @IBOutlet weak var img_Category: UIImageView!
    @IBOutlet weak var lblTitle: UILabel!
    @IBOutlet weak var viewBack: UIView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        viewBack.layer.shadowColor = UIColor.systemGray5.cgColor
        viewBack.layer.shadowOpacity = 0.8
        viewBack.layer.shadowOffset = .zero
        viewBack.layer.shadowRadius = 4
        
    }
    
}
