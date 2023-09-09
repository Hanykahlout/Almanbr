//
//  profileAttachmentsTVCell.swift
//  Almnabr
//
//  Created by MacBook on 09/04/2022.
//  Copyright © 2022 Samar Akkila. All rights reserved.
//

import UIKit

class profileAttachmentsTVCell: UITableViewCell {

    @IBOutlet weak var lblType: UILabel!
    @IBOutlet weak var lblSubject: UILabel!
    @IBOutlet weak var lblFileExtention : UILabel!
    @IBOutlet weak var lblFileLevel: UILabel!
    @IBOutlet weak var lblWriter: UILabel!
    @IBOutlet weak var lblOnDate: UILabel!
    @IBOutlet weak var viewBack: UIView!
    
    
    var btnLinkAction : (()->())?
    
    @IBAction func didReLinkButtonPressd(_ sender: Any) {
       // btnLinkAction!()
    }
    
    
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
