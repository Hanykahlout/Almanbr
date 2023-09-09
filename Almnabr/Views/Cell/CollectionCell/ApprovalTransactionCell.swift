//
//  ApprovalTransactionCell.swift
//  Almnabr
//
//  Created by MacBook on 07/10/2021.
//  Copyright © 2021 Samar Akkila. All rights reserved.
//

import UIKit

class ApprovalTransactionCell: UICollectionViewCell {

    
    @IBOutlet weak var lbldash: UILabel!
    @IBOutlet weak var lblNo: UILabel!
    @IBOutlet weak var lblDesc: UILabel!
    @IBOutlet weak var lblFrom: UILabel!
    @IBOutlet weak var lblTo: UILabel!
    @IBOutlet weak var lblType: UILabel!
    @IBOutlet weak var lblModule: UILabel!
    @IBOutlet weak var lblForm: UILabel!
    @IBOutlet weak var lblWriter: UILabel!
    @IBOutlet weak var lblTransactionDate: UILabel!
    @IBOutlet weak var lblApprovalType: UILabel!
    

    
    func setRecord( dash: String,
                    transaction_request_id: String,
                    transaction_request_description: String,
                    transaction_from_name: String,
                    transaction_to_name: String,
                    transactions_type_name: String,
                    module_name: String,
                    transactions_name:String,
                    transaction_request_user_name_writer: String,
                    create_datetime: String,
                    transaction_request_type_of_approval: String) {
        
        lbldash.text = dash
        lblNo.text = transaction_request_id
        lblDesc.text = transaction_request_description
        lblFrom.text = transaction_from_name
        lblTo.text = transaction_to_name
        lblType.text = transactions_type_name
        lblModule.text = module_name
        lblForm.text = transactions_name
        lblWriter.text = transaction_request_user_name_writer
        lblTransactionDate.text = create_datetime
        lblApprovalType.text = transaction_request_type_of_approval
    }

    override func layoutSubviews() {
        super.layoutSubviews()

//        let thickness = 1 / (window?.screen.scale ?? 1)
//        let size = bounds.size
//        rightSeparator.frame = CGRect(x: size.width - thickness, y: 0, width: thickness, height: size.height)
//        bottomSeparator.frame = CGRect(x: 0, y: size.height - thickness, width: size.width, height: thickness)
    }


}
