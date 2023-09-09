//
//  CreateJournalVoucherTableViewCell.swift
//  Almnabr
//
//  Created by Hany Alkahlout on 16/02/2023.
//  Copyright © 2023 Samar Akkila. All rights reserved.
//

import UIKit

class CreateJournalVoucherTableViewCell: UITableViewCell {

    @IBOutlet weak var accountCodeLabel: UILabel!
    @IBOutlet weak var debitAmountLabel: UILabel!
    @IBOutlet weak var creditAmountLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var referenceNoLabel: UILabel!
    @IBOutlet weak var notesLabel: UILabel!
    
    var didSelectOnDelete: (()->Void)?
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
  
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func setData(data:JournalVoucherData){
        accountCodeLabel.text = data.accountCode?.label ?? "----"
        debitAmountLabel.text = data.debitAmount ?? "----"
        creditAmountLabel.text = data.creditAmount ?? "----"
        descriptionLabel.text = data.description ?? "----"
        referenceNoLabel.text = data.referenceNo ?? "----"
        notesLabel.text = data.notes ?? "----"
    }
    
    @IBAction func deleteAction(_ sender: Any) {
        didSelectOnDelete?()
    }
}
