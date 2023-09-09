//
//  MyTrannsactionTVCell.swift
//  Almnabr
//
//  Created by MacBook on 08/03/2022.
//  Copyright © 2022 Samar Akkila. All rights reserved.
//

import UIKit

class MyTrannsactionTVCell: UITableViewCell {

    @IBOutlet weak var lblNo: UILabel!
    @IBOutlet weak var lblDesc: UILabel!
    @IBOutlet weak var lblFrom: UILabel!
    @IBOutlet weak var lblForm: UILabel!
    @IBOutlet weak var lblTo: UILabel!
    @IBOutlet weak var lblBarCode: UILabel!
    @IBOutlet weak var lblType: UILabel!
    @IBOutlet weak var lblModule: UILabel!
    @IBOutlet weak var lblWriter: UILabel!
    @IBOutlet weak var lblSubmitter: UILabel!
    @IBOutlet weak var lblLastUpdate: UILabel!
    @IBOutlet weak var lblStatus: UILabel!
    @IBOutlet weak var viewStatus: UIView!
    @IBOutlet weak var viewBack: UIView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        selectionStyle = .none
        viewBack.layer.shadowColor = UIColor.systemGray5.cgColor
        viewBack.layer.shadowOpacity = 0.8
        viewBack.layer.shadowOffset = .zero
        viewBack.layer.shadowRadius = 4
        
        if L102Language.currentAppleLanguage() == "ar" {
            lblNo.textAlignment = .right
            lblDesc.textAlignment = .right
            lblFrom.textAlignment = .right
            lblForm.textAlignment = .right
            lblTo.textAlignment = .right
            lblBarCode.textAlignment = .right
            lblType.textAlignment = .right
            lblModule.textAlignment = .right
            lblWriter.textAlignment = .right
            lblSubmitter.textAlignment = .right
            lblLastUpdate.textAlignment = .right
            lblStatus.textAlignment = .right
        }
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
