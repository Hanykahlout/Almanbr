//
//  TransactionViewerTableViewCell.swift
//  Almnabr
//
//  Created by Hany Alkahlout on 23/02/2023.
//  Copyright © 2023 Samar Akkila. All rights reserved.
//

import UIKit

class TransactionViewerTableViewCell: UITableViewCell {

    @IBOutlet weak var accountNameLabel: UILabel!
    @IBOutlet weak var costCentersLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var referenceNoLabel: UILabel!
    @IBOutlet weak var notesLabel: UILabel!
    @IBOutlet weak var debitLabel: UILabel!
    @IBOutlet weak var creditLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func setData(data:ReceiptTransaction){
        accountNameLabel.text = data.account_name ?? "----"
        costCentersLabel.text = data.cost_center_name ?? "----"
        descriptionLabel.text = data.transaction_history_description ?? "----"
        referenceNoLabel.text = data.transaction_history_ref_number ?? "----"
        notesLabel.text = data.transaction_history_notes ?? "----"
        debitLabel.text = data.debit_amount ?? "----"
        creditLabel.text = data.credit_amount ?? "----"
    }
}
