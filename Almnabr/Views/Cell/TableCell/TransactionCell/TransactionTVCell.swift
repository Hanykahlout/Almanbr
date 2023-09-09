//
//  TransactionTVCell.swift
//  Almnabr
//
//  Created by MacBook on 02/10/2021.
//  Copyright © 2021 Samar Akkila. All rights reserved.
//

import UIKit

class TransactionTVCell: UITableViewCell {

    
    @IBOutlet weak var lblNo: UILabel!
    @IBOutlet weak var lblDesc: UILabel!
    @IBOutlet weak var lblFrom: UILabel!
    @IBOutlet weak var lblTo: UILabel!
    @IBOutlet weak var lblBarCode: UILabel!
    @IBOutlet weak var lblType: UILabel!
    @IBOutlet weak var lblModule: UILabel!
    @IBOutlet weak var lblWriter: UILabel!
    @IBOutlet weak var lblSubmitter: UILabel!
    @IBOutlet weak var lblLastUpdate: UILabel!
    @IBOutlet weak var lblStatus: UILabel!
    @IBOutlet weak var viewBack: UIView!
    @IBOutlet weak var img_mark: UIImageView!
    
    @IBOutlet weak var lbKeylNo: UILabel!
    @IBOutlet weak var lblKeyDesc: UILabel!
    @IBOutlet weak var lblKeyFrom: UILabel!
    @IBOutlet weak var lblKeyTo: UILabel!
    @IBOutlet weak var lblKeyBarCode: UILabel!
    @IBOutlet weak var lblKeyType: UILabel!
    @IBOutlet weak var lblKeyModule: UILabel!
    @IBOutlet weak var lblKeyForm: UILabel!
    @IBOutlet weak var lblKeyWriter: UILabel!
    @IBOutlet weak var lblKeySubmitter: UILabel!
    @IBOutlet weak var lblKeyLastUpdate: UILabel!
    @IBOutlet weak var lblKeyStatus: UILabel!

    @IBOutlet weak var btnDelete: UIButton!
    
   
    
   // func setRecord(
//                    transaction_request_id: String,
//                    transaction_request_description: String,
//                    transaction_from_name: String,
//                    transaction_to_name: String,
//                    barcode: String,
//                    transactions_type_name: String,
//                    module_name: String,
//                    transaction_request_user_name_writer: String,
//                    transactions_submitter_user_name: String,
//                    transactions_date_last_update: String,
//                    transaction_request_status: String) {
//
//        lblNo.text = transaction_request_id
//        lblDesc.text = transaction_request_description
//        lblFrom.text = transaction_from_name
//        lblTo.text = transaction_to_name
//        lblBarCode.text = barcode
//        lblType.text = transactions_type_name
//        lblModule.text = module_name
//        lblWriter.text = transaction_request_user_name_writer
//        lblSubmitter.text = transactions_submitter_user_name
//        lblLastUpdate.text = transactions_date_last_update
//        lblStatus.text = transaction_request_status
//    }

    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        selectionStyle = .none
        self.lblKeyForm.isHidden = true
        self.viewBack.layer.applySketchShadow(
          color: .black,
          alpha: 0.6,
          x: 0,
          y: 13,
          blur: 16,
          spread: 0)
        
        // Initialization code
        
//        lbKeylNo.font = .kufiBoldFont(ofSize: 14)
//        lblKeyDesc.font = .kufiBoldFont(ofSize: 14)
//        lblKeyFrom.font = .kufiBoldFont(ofSize: 14)
//        lblKeyTo.font = .kufiBoldFont(ofSize: 14)
//        lblKeyBarCode.font = .kufiBoldFont(ofSize: 14)
//        lblKeyType.font = .kufiBoldFont(ofSize: 14)
//        lblKeyModule.font = .kufiBoldFont(ofSize: 14)
//        lblKeyWriter.font = .kufiBoldFont(ofSize: 14)
//        lblKeySubmitter.font = .kufiBoldFont(ofSize: 14)
//        lblKeyLastUpdate.font = .kufiBoldFont(ofSize: 14)
//        lblKeyStatus.font = .kufiBoldFont(ofSize: 14)
        
//        lbKeylNo.textColor = HelperClassSwift.acolor.getUIColor()
//        lblKeyDesc.textColor = HelperClassSwift.acolor.getUIColor()
//        lblKeyFrom.textColor = HelperClassSwift.acolor.getUIColor()
//        lblKeyTo.textColor = HelperClassSwift.acolor.getUIColor()
//        lblKeyBarCode.textColor = HelperClassSwift.acolor.getUIColor()
//        lblKeyType.textColor = HelperClassSwift.acolor.getUIColor()
//        lblKeyModule.textColor = HelperClassSwift.acolor.getUIColor()
//        lblKeyWriter.textColor = HelperClassSwift.acolor.getUIColor()
//        lblKeySubmitter.textColor = HelperClassSwift.acolor.getUIColor()
//        lblKeyLastUpdate.textColor = HelperClassSwift.acolor.getUIColor()
//        lblKeyStatus.textColor = HelperClassSwift.acolor.getUIColor()
        
        
       
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
