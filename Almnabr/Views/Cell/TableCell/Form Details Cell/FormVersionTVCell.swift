//
//  FormVersionTVCell.swift
//  Almnabr
//
//  Created by MacBook on 26/03/2022.
//  Copyright © 2022 Samar Akkila. All rights reserved.
//

import UIKit

class FormVersionTVCell: UITableViewCell {

    @IBOutlet weak var lblTransactionNo: UILabel!
    @IBOutlet weak var lblUnit: UILabel!
    @IBOutlet weak var lblWL: UILabel!
    @IBOutlet weak var lblBarCode: UILabel!
    @IBOutlet weak var lblEvalutionResult: UILabel!
    @IBOutlet weak var lblDate: UILabel!
    @IBOutlet weak var viewBack: UIView!
    @IBOutlet weak var viewStatus: UIView!
    @IBOutlet weak var btnAction: UIButton!
    
    
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
