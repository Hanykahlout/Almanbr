//
//  FormVersionCell.swift
//  Almnabr
//
//  Created by MacBook on 11/11/2021.
//  Copyright © 2021 Samar Akkila. All rights reserved.
//

import UIKit

class FormVersionCell: UITableViewCell {

    
    @IBOutlet weak var lblNo: UILabel!
    @IBOutlet weak var lblTransactionNo: UILabel!
    @IBOutlet weak var lblUnit: UILabel!
    @IBOutlet weak var lblWorklevel: UILabel!
    @IBOutlet weak var lblBarcode: UILabel!
    @IBOutlet weak var lblEvaluationResult: UILabel!
    @IBOutlet weak var lblDate: UILabel!
    @IBOutlet weak var btnAction: UIButton!
    @IBOutlet weak var viewBack: UIView!
    @IBOutlet weak var viewColor: UIView!
    
    
    var btn_Action : (()->())?
    
    
    @IBAction func didReButtonPressd(_ sender: Any) {
        btn_Action?()
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
