//
//  StatementAccountsResultTableViewCell.swift
//  Almnabr
//
//  Created by Hany Alkahlout on 26/02/2023.
//  Copyright © 2023 Samar Akkila. All rights reserved.
//

import UIKit

class StatementAccountsResultTableViewCell: UITableViewCell {

    @IBOutlet weak var requestNumberLabel: UILabel!
    @IBOutlet weak var referenceNoLabel: UILabel!
    @IBOutlet weak var transactionDateLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var debitTotalLabel: UILabel!
    @IBOutlet weak var creditTotalLabel: UILabel!
    @IBOutlet weak var balanceLabel: UILabel!
    @IBOutlet weak var statusLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func setData(data:StatementAccountsRecord){
        requestNumberLabel.text = data.transaction_number ?? "----"
        referenceNoLabel.text = data.reference_number ?? "----"
        transactionDateLabel.text = data.transaction_date ?? "----"
        descriptionLabel.text = data.description ?? "----"
        debitTotalLabel.text = data.debit ?? "----"
        creditTotalLabel.text = data.credit ?? "----"
        balanceLabel.text = data.balance ?? "----"
        statusLabel.text = data.status == "C" ? "Credit" : "Debit"
        
    }
    
}
