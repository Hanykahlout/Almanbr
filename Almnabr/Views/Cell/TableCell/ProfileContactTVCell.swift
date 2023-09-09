//
//  ProfileContactTVCell.swift
//  Almnabr
//
//  Created by MacBook on 12/04/2022.
//  Copyright © 2022 Samar Akkila. All rights reserved.
//

import UIKit

class ProfileContactTVCell: UITableViewCell {
 
    @IBOutlet weak var lblPersonName: UILabel!
    @IBOutlet weak var lblMobile: UILabel!
    @IBOutlet weak var lblEmail : UILabel!
    @IBOutlet weak var lblContactAddress: UILabel!
    @IBOutlet weak var lblWriter: UILabel!
    @IBOutlet weak var lblOnDate: UILabel!
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
