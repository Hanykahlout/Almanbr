//
//  OpeningBalanceTableViewCell.swift
//  Almnabr
//
//  Created by Hany Alkahlout on 30/01/2023.
//  Copyright © 2023 Samar Akkila. All rights reserved.
//

import UIKit

class OpeningBalanceTableViewCell: UITableViewCell {

    @IBOutlet weak var accountMastersCodeLabel: UILabel!
    @IBOutlet weak var accountNameLabel: UILabel!
    @IBOutlet weak var debitAmountLabel: UILabel!
    @IBOutlet weak var creditAmountLabel: UILabel!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func setData(data:OpeningBalanceRecord){
        accountMastersCodeLabel.text = data.account_masters_id ?? ""
        accountNameLabel.text = data.account_name ?? ""
        debitAmountLabel.text = data.debit_amount ?? ""
        creditAmountLabel.text = data.credit_amount ?? ""
    }
    
}
