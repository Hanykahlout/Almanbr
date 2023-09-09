//
//  ApprovalTVCell.swift
//  Almnabr
//
//  Created by MacBook on 08/03/2022.
//  Copyright © 2022 Samar Akkila. All rights reserved.
//

import UIKit

class ApprovalTVCell: UITableViewCell {
    
    
    @IBOutlet weak var lblNo: UILabel!
    @IBOutlet weak var lblDesc: UILabel!
    @IBOutlet weak var lblFrom: UILabel!
    @IBOutlet weak var lblTo: UILabel!
    @IBOutlet weak var lblType: UILabel!
    @IBOutlet weak var lblModule: UILabel!
    @IBOutlet weak var lblWriter: UILabel!
    @IBOutlet weak var lbldate: UILabel!
    @IBOutlet weak var lblApprovalType: UILabel!
    
    @IBOutlet weak var viewStatus: UIView!
    @IBOutlet weak var viewBack: UIView!
    
    
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
