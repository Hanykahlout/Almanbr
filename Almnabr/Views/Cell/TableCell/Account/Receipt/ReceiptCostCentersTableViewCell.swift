//
//  ReceiptCostCentersTableViewCell.swift
//  Almnabr
//
//  Created by Hany Alkahlout on 19/02/2023.
//  Copyright © 2023 Samar Akkila. All rights reserved.
//

import UIKit

class ReceiptCostCentersTableViewCell: UITableViewCell {
    
    @IBOutlet weak var accountNameLabe: UILabel!
    @IBOutlet weak var creditAmountLabel: UILabel!
    @IBOutlet weak var debitAmountLabel: UILabel!
    @IBOutlet weak var costNameLabel: UILabel!
    @IBOutlet weak var amountLabel: UILabel!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func setData(data:CardCostData){
        accountNameLabe.text = data.account_name ?? "----"
        creditAmountLabel.text = data.credit_amount ?? "----"
        debitAmountLabel.text = data.debit_amount ?? "----"
        costNameLabel.text = data.cost_name ?? "----"
        amountLabel.text = data.amount ?? "----"
    }
    
}
