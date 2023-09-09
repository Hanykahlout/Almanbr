//
//  FormTransactionTVCell.swift
//  Almnabr
//
//  Created by MacBook on 10/03/2022.
//  Copyright © 2022 Samar Akkila. All rights reserved.
//

import UIKit

class FormTransactionTVCell: UITableViewCell {

    @IBOutlet weak var lblCode: UILabel!
    @IBOutlet weak var lblplatform: UILabel!
    @IBOutlet weak var lblTemplate: UILabel!
    @IBOutlet weak var lblGroup1: UILabel!
    @IBOutlet weak var lblGroup2: UILabel!
    @IBOutlet weak var lblGroupType: UILabel!
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
