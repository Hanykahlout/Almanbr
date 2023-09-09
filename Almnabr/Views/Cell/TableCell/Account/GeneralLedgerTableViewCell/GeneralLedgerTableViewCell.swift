//
//  GeneralLedgerTableViewCell.swift
//  Almnabr
//
//  Created by Hany Alkahlout on 27/02/2023.
//  Copyright © 2023 Samar Akkila. All rights reserved.
//

import UIKit

class GeneralLedgerTableViewCell: UITableViewCell {

    @IBOutlet weak var accountCodeLabel: UILabel!
    @IBOutlet weak var accountNameLabel: UILabel!
    @IBOutlet weak var openingBalanceLabel: UILabel!
    @IBOutlet weak var transactionDebitLabel: UILabel!
    @IBOutlet weak var transactionCreditLabel: UILabel!
    @IBOutlet weak var closingBalanceLabel: UILabel!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func setData(data:GeneralLedgerRecord){
        accountCodeLabel.text = data.account_code ?? "----"
        accountNameLabel.text = data.account_name ?? "----"
        openingBalanceLabel.text = data.opening_balance ?? "----"
        transactionDebitLabel.text = data.transaction_debit ?? "----"
        transactionCreditLabel.text = data.transaction_credit ?? "----"
        closingBalanceLabel.text = data.closing_balance ?? "----"
    }
    
}
