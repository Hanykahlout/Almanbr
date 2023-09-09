//
//  InvoiceSettingsTableViewCell.swift
//  Almnabr
//
//  Created by Hany Alkahlout on 05/01/2023.
//  Copyright © 2023 Samar Akkila. All rights reserved.
//

import UIKit

class InvoiceSettingsTableViewCell: UITableViewCell {

    @IBOutlet weak var paymentModeLabel: UILabel!
    @IBOutlet weak var invoiceTypeLabel: UILabel!
    @IBOutlet weak var onDateLabvel: UILabel!
    @IBOutlet weak var writerLabel: UILabel!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func setData(data:InvoiceSettingsRecord){
        paymentModeLabel.text = data.payment_mode_name ?? ""
        invoiceTypeLabel.text = data.invoice_type ?? ""
        onDateLabvel.text = data.invoice_created_datetime ?? ""
        writerLabel.text = data.name ?? ""
    }
}
