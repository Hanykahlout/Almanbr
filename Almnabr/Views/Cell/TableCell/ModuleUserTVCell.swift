//
//  ModuleUserTVCell.swift
//  Almnabr
//
//  Created by MacBook on 14/04/2022.
//  Copyright © 2022 Samar Akkila. All rights reserved.
//

import UIKit

class ModuleUserTVCell: UITableViewCell {
    
    @IBOutlet weak var lblName: UILabel!
    @IBOutlet weak var lblTitle: UILabel!
    @IBOutlet weak var lblPositions : UILabel!
    @IBOutlet weak var lblServicePositions: UILabel!
    @IBOutlet weak var lblServiceProjectName: UILabel!
    @IBOutlet weak var viewBack: UIView!
     
    
    override func awakeFromNib() {
        super.awakeFromNib()
        selectionStyle = .none
        viewBack.layer.shadowColor = UIColor.systemGray.cgColor
        viewBack.layer.shadowOpacity = 0.8
        viewBack.layer.shadowOffset = .zero
        viewBack.layer.shadowRadius = 4
        viewBack.layer.cornerRadius = 20
    }

    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
