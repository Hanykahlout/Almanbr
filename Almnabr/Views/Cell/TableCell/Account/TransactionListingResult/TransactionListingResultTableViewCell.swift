//
//  TransactionListingResultTableViewCell.swift
//  Almnabr
//
//  Created by Hany Alkahlout on 07/03/2023.
//  Copyright © 2023 Samar Akkila. All rights reserved.
//

import UIKit

class TransactionListingResultTableViewCell: UITableViewCell {

    @IBOutlet weak var requestNumberLabel: UILabel!
    @IBOutlet weak var referenceNoLabel: UILabel!
    @IBOutlet weak var transactionTypeLabel: UILabel!
    @IBOutlet weak var transactionDateLabel: UILabel!
    @IBOutlet weak var accountCodeLabel: UILabel!
    @IBOutlet weak var accountNameLabel: UILabel!
    @IBOutlet weak var debitLabel: UILabel!
    @IBOutlet weak var creditLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    
    var transactionButtonAction:(()->Void)?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    
    func setData(data:ReceiptTransaction){
        requestNumberLabel.text = data.reference_number ?? ""
        referenceNoLabel.text = data.account_code ?? ""
        transactionTypeLabel.text = getTransactionType(from: data.transaction_request_type ?? "")
        transactionDateLabel.text = data.transaction_history_date ?? ""
        accountCodeLabel.text = data.account_cost_id ?? ""
        accountNameLabel.text = data.account_name ?? ""
        debitLabel.text = data.debit_amount ?? ""
        creditLabel.text = data.credit_amount ?? ""
        descriptionLabel.text = data.transaction_history_description ?? ""
         
    }
    
    
    private func getTransactionType(from code:String) -> String{
        switch code {
        case "":
            return "All"
        case "REC":
            return "Receipts"
        case "PAY":
            return "Payments"
        case "JRN":
            return "Journal Voucher"
        case "SIV":
            return "Selling Invoices"
        case "PIV":
            return "Purchase Invoice"
        default:
            break
        }
        return "----"
    }
    
    
    @IBAction func transactionAction(_ sender: Any) {
        transactionButtonAction?()
    }
    
    @IBAction func viewAction(_ sender: Any) {
    }
}
