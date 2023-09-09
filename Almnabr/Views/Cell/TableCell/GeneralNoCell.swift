//
//  GeneralNoCell.swift
//  Almnabr
//
//  Created by MacBook on 09/11/2021.
//  Copyright © 2021 Samar Akkila. All rights reserved.
//

import UIKit

class GeneralNoCell: UITableViewCell {

    
    @IBOutlet weak var lblNo: UILabel!
    @IBOutlet weak var lblUnit: UILabel!
    @IBOutlet weak var lblWorklevels: UILabel!
    @IBOutlet weak var btnDelete: UIButton!
    
    
    var btnDeleteAction : (()->())?
    
    
    @IBAction func didReCancelButtonPressd(_ sender: Any) {
        btnDeleteAction!()
    }
    
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        selectionStyle = .none
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
