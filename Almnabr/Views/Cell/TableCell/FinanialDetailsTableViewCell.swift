//
//  FinanialDetailsTableViewCell.swift
//  Almnabr
//
//  Created by Hany Alkahlout on 27/11/2022.
//  Copyright © 2022 Samar Akkila. All rights reserved.
//

import UIKit

class FinanialDetailsTableViewCell: UITableViewCell {

    
    @IBOutlet weak var transactionTypeLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var statusLabel: UILabel!
    @IBOutlet weak var amountLabel: UILabel!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    
    func setData(data:FinanialDetailsRecord){
        transactionTypeLabel.text = data.transaction_key ?? "----"
        dateLabel.text = data.finincal_date_english ?? ""
        if let status = data.approved_status{
            statusLabel.text = status == "1" ? "Approved" : "Rejected"
        }
        amountLabel.text = data.finincal_amount ?? ""
    }
    
    
    
    
    
    
    
}
