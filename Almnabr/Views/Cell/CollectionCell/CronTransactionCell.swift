//
//  CronTransactionCell.swift
//  Almnabr
//
//  Created by MacBook on 07/10/2021.
//  Copyright © 2021 Samar Akkila. All rights reserved.
//

import UIKit

class CronTransactionCell: UICollectionViewCell {
    
    @IBOutlet weak var lbldash: UILabel!
    @IBOutlet weak var lblNo: UILabel!
    @IBOutlet weak var lblFormName: UILabel!
    @IBOutlet weak var lblAttempt: UILabel!
    @IBOutlet weak var lblLastUpdate: UILabel!
    @IBOutlet weak var lblError: UILabel!
    @IBOutlet weak var btnDelete: UIButton!
    

    
    func setRecord( dash: String,
                    transaction_request_id: String,
                    transaction_key: String,
                    transactions_cronjob_try_to_submitting: String,
                    transactions_cronjob_last_update: String,
                    transactions_cronjob_error: String) {
        
        lbldash.text = dash
        lblNo.text = transaction_request_id
        lblFormName.text = transaction_key
        lblAttempt.text = transactions_cronjob_try_to_submitting
        lblLastUpdate.text = transactions_cronjob_last_update
        lblError.text = transactions_cronjob_error
    }

    
    
    override func layoutSubviews() {
        super.layoutSubviews()

//        let thickness = 1 / (window?.screen.scale ?? 1)
//        let size = bounds.size
//        rightSeparator.frame = CGRect(x: size.width - thickness, y: 0, width: thickness, height: size.height)
//        bottomSeparator.frame = CGRect(x: 0, y: size.height - thickness, width: size.width, height: thickness)
    }


}
