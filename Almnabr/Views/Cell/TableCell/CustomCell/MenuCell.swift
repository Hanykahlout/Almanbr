//
//  MenuCell.swift
//  Almnabr
//
//  Created by MacBook on 26/09/2021.
//  Copyright © 2021 Samar Akkila. All rights reserved.
//

import UIKit

class MenuCell: UITableViewCell {

    
    @IBOutlet weak var icon: UIImageView!
    @IBOutlet weak var icon_dropdown: UIImageView!
    @IBOutlet weak var lbl_title: UILabel!
    
    var isOpened:Bool = false
    var btnAction : (()->())?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        selectionStyle = .none
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

    @IBAction func Action(_ sender: Any) {
       // btnAction!()
    }
}
