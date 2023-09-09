//
//  TicketTVCell.swift
//  Almnabr
//
//  Created by MacBook on 18/04/2022.
//  Copyright © 2022 Samar Akkila. All rights reserved.
//

import UIKit

class TicketTVCell: UITableViewCell {

    @IBOutlet weak var lblSubject: UILabel!
    @IBOutlet weak var lblType: UILabel!
    @IBOutlet weak var lblpriority: UILabel!
    @IBOutlet weak var lblStatus: UILabel!
    @IBOutlet weak var lblModule: UILabel!
    @IBOutlet weak var lblDateCreated: UILabel!
    @IBOutlet weak var btnEdit: UIButton!
    @IBOutlet weak var btnDelete: UIButton!
    @IBOutlet weak var viewBack: UIView!
    
    var btnEditAction : (()->())?
    var btnDeleteAction : (()->())?
    
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
    
    @IBAction func didEditButtonPressd(_ sender: Any) {
        btnEditAction!()
    }
    
    @IBAction func didDeleteButtonPressd(_ sender: Any) {
        btnDeleteAction!()
    }
}
