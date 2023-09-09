//
//  AccountsTrialResultTableViewCell.swift
//  Almnabr
//
//  Created by Hany Alkahlout on 02/03/2023.
//  Copyright © 2023 Samar Akkila. All rights reserved.
//

import UIKit

class AccountsTrialResultTableViewCell: UITableViewCell {

    @IBOutlet weak var transactionButton: UIButton!
    @IBOutlet weak var accountCodeLabel: UILabel!
    @IBOutlet weak var accountNameLabel: UILabel!
    @IBOutlet weak var openingDebitLabel: UILabel!
    @IBOutlet weak var openingCreditLabel: UILabel!
    @IBOutlet weak var openingBalanceLabel: UILabel!
    @IBOutlet weak var transactionDebitLabel: UILabel!
    @IBOutlet weak var transactionCreditLabel: UILabel!
    @IBOutlet weak var closingDebitLabel: UILabel!
    @IBOutlet weak var closingCreditLabe: UILabel!
    @IBOutlet weak var closingBalanceLabel: UILabel!
    
    var transactionButtonAction:(()->Void)?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func setData(data:GeneralLedgerRecord){
        transactionButton.isHidden = data.transaction_allow != "1"
        accountCodeLabel.text = data.account_code ?? "----"
        accountNameLabel.text = data.account_name ?? "----"
        openingDebitLabel.text = data.opening_debit ?? "----"
        openingCreditLabel.text = data.opening_credit ?? "----"
        openingBalanceLabel.text = data.opening_balance ?? "----"
        transactionDebitLabel.text = data.transaction_debit ?? "----"
        transactionCreditLabel.text = data.transaction_credit ?? "----"
        closingDebitLabel.text = data.closing_debit ?? "----"
        closingCreditLabe.text = data.closing_credit ?? "----"
        closingBalanceLabel.text = data.closing_balance ?? "----"
    }
    
    
    @IBAction func transactionAction(_ sender: Any) {
        
        transactionButtonAction?()
    }
}
