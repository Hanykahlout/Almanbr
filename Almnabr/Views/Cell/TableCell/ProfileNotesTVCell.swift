//
//  ProfileNotesTVCell.swift
//  Almnabr
//
//  Created by MacBook on 09/04/2022.
//  Copyright © 2022 Samar Akkila. All rights reserved.
//

import UIKit

class ProfileNotesTVCell: UITableViewCell {

    @IBOutlet weak var lblDescription: UILabel!
    @IBOutlet weak var lblRemainderDate: UILabel!
    @IBOutlet weak var lblLinkwithLists: UILabel!
    @IBOutlet weak var lblCreatedDate: UILabel!
    @IBOutlet weak var lblWriter: UILabel!
    @IBOutlet weak var viewBack: UIView!
    @IBOutlet weak var viewStatus: UIView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
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
