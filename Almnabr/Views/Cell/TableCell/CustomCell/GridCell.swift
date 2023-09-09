//
//  GridCell.swift
//  Almnabr
//
//  Created by MacBook on 07/10/2021.
//  Copyright © 2021 Samar Akkila. All rights reserved.
//

import UIKit

class GridCell: UICollectionViewCell {
   // static var reuseIdentifier: String { return "cell" }

    
    @IBOutlet weak var lbldash: UILabel!
    @IBOutlet weak var lblNo: UILabel!
    @IBOutlet weak var lblDesc: UILabel!
    @IBOutlet weak var lblFrom: UILabel!
    @IBOutlet weak var lblTo: UILabel!
    @IBOutlet weak var lblBarCode: UILabel!
    @IBOutlet weak var lblType: UILabel!
    @IBOutlet weak var lblModule: UILabel!
    @IBOutlet weak var lblForm: UILabel!
    @IBOutlet weak var lblWriter: UILabel!
    @IBOutlet weak var lblSubmitter: UILabel!
    @IBOutlet weak var lblLastUpdate: UILabel!
    @IBOutlet weak var lblStatus: UILabel!
    

    
    func setRecord( dash: String,
                    transaction_request_id: String,
                    transaction_request_description: String,
                    transaction_from_name: String,
                    transaction_to_name: String,
                    barcode: String,
                    transactions_type_name: String,
                    module_name: String,
                    transaction_request_user_name_writer: String,
                    transactions_submitter_user_name: String,
                    transactions_date_last_update: String,
                    transaction_request_status: String) {
        //label.text = record
        lbldash.text = dash
        lblNo.text = transaction_request_id
        lblDesc.text = transaction_request_description
        lblFrom.text = transaction_from_name
        lblTo.text = transaction_to_name
        lblBarCode.text = barcode
        lblType.text = transactions_type_name
        lblModule.text = module_name
        lblForm.text = ""
        lblWriter.text = transaction_request_user_name_writer
        lblSubmitter.text = transactions_submitter_user_name
        lblLastUpdate.text = transactions_date_last_update
        lblStatus.text = transaction_request_status
    }

    override func layoutSubviews() {
        super.layoutSubviews()

//        let thickness = 1 / (window?.screen.scale ?? 1)
//        let size = bounds.size
//        rightSeparator.frame = CGRect(x: size.width - thickness, y: 0, width: thickness, height: size.height)
//        bottomSeparator.frame = CGRect(x: 0, y: size.height - thickness, width: size.width, height: thickness)
    }


}
