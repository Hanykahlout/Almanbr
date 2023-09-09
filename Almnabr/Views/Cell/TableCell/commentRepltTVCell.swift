//
//  commentRepltTVCell.swift
//  Almnabr
//
//  Created by MacBook on 29/06/2022.
//  Copyright © 2022 Samar Akkila. All rights reserved.
//

import UIKit

class commentRepltTVCell: UITableViewCell {

    @IBOutlet weak var lblUserName: UILabel!
    @IBOutlet weak var lblDate: UILabel!
    @IBOutlet weak var lblComment: UILabel!
    @IBOutlet weak var imgUser: UIImageView!
    @IBOutlet weak var viewBack: UIView!
    
    var btnEditAction : (()->())?
    var btnDeleteAction : (()->())?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        selectionStyle = .none
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    
    @IBAction func didDeleteButtonPressd(_ sender: Any) {
        btnDeleteAction!()
    }
    
    
    @IBAction func didEditButtonPressd(_ sender: Any) {
        btnEditAction!()
    }
    
}
