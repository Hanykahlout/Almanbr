//
//  NotificationCell.swift
//  Almnabr
//
//  Created by MacBook on 23/11/2021.
//  Copyright © 2021 Samar Akkila. All rights reserved.
//

import UIKit

class NotificationCell: UITableViewCell {

    @IBOutlet weak var lblTitle: UILabel!
    @IBOutlet weak var lblSubTitle: UILabel!
    @IBOutlet weak var lblDate: UILabel!
    @IBOutlet weak var imgNotify: UIImageView!
    @IBOutlet weak var btnDelete: UIButton!
    @IBOutlet weak var viewBack: UIView!
    
    var btnDeleteAction : (()->())?
    
    
    @IBAction func didReCancelButtonPressd(_ sender: Any) {
        btnDeleteAction!()
    }
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        selectionStyle = .none
        
        viewBack.layer.shadowColor = UIColor.systemGray5.cgColor
        viewBack.layer.shadowOpacity = 0.8
        viewBack.layer.shadowOffset = .zero
        viewBack.layer.shadowRadius = 4
        
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
