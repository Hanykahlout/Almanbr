//
//  FinanceInfoTableViewCell.swift
//  Almnabr
//
//  Created by Hany Alkahlout on 19/07/2022.
//  Copyright © 2022 Samar Akkila. All rights reserved.
//

import UIKit

class FinanceInfoTableViewCell: UITableViewCell {
    @IBOutlet weak var paidDaysLabel: UILabel!
    @IBOutlet weak var unpaidDayLabel: UILabel!
    @IBOutlet weak var creditAmountLabel: UILabel!
    @IBOutlet weak var debitAmountLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func setData(data:Finance){
        paidDaysLabel.text = String(data.paid_days ?? "--")
        unpaidDayLabel.text = String(data.unpaid_days ?? "--")
        creditAmountLabel.text = String(data.credit_amount ?? "--")
        debitAmountLabel.text = String(data.debit_amount ?? "--")
        descriptionLabel.text = data.finance_description ?? "--"
        dateLabel.text = "\(data.finance_month ?? "--") / \(data.finance_year ?? "--")"
        
    }
    
}
