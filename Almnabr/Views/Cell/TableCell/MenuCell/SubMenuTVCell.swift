//
//  SubMenuTVCell.swift
//  Almnabr
//
//  Created by MacBook on 04/10/2021.
//  Copyright © 2021 Samar Akkila. All rights reserved.
//

import UIKit

class SubMenuTVCell: UITableViewCell {

    
    @IBOutlet weak var icon: UIImageView!
    @IBOutlet weak var icon_dropdown: UIImageView!
    @IBOutlet weak var lbl_title: UILabel!
    

    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
