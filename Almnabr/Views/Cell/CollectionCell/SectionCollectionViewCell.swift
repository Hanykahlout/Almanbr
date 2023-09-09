//
//  SectionCollectionViewCell.swift
//  Almnabr
//
//  Created by Hany Alkahlout on 08/06/2022.
//  Copyright © 2022 Samar Akkila. All rights reserved.
//

import UIKit

class SectionCollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var bgView: UIView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var sectionImageview: UIImageView!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    func setData(data:SectionInfo){
        bgView.backgroundColor = data.bgColor
        titleLabel.textColor = data.bgColor
        titleLabel.text = data.title
        sectionImageview.image = data.icon
        
    }

}
