//
//  QuotationTableViewCell.swift
//  Almnabr
//
//  Created by Hany Alkahlout on 14/12/2022.
//  Copyright © 2022 Samar Akkila. All rights reserved.
//

import UIKit

class QuotationTableViewCell: UITableViewCell {

    @IBOutlet weak var quotationNumberLabel: UILabel!
    @IBOutlet weak var subjectLabel: UILabel!
    @IBOutlet weak var grandTotalLabel: UILabel!
    @IBOutlet weak var taxAmountLabel: UILabel!
    @IBOutlet weak var netAmountLabel: UILabel!
    @IBOutlet weak var submittedDateLabel: UILabel!
    @IBOutlet weak var approvedDateLabel: UILabel!
    @IBOutlet weak var statusLabel: UILabel!
    @IBOutlet weak var writerLabel: UILabel!
    @IBOutlet weak var settingsButton: UIButton!
    
    var didClickOnFile : (() -> Void)?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func setData(data:QuotationRecord){
        quotationNumberLabel.text = data.projects_quotation_id ?? "----"
        subjectLabel.text = data.quotation_subject ?? "----"
        grandTotalLabel.text = data.quotation_grand_total ?? "----"
        taxAmountLabel.text = data.quotation_tax_amount ?? "----"
        netAmountLabel.text = data.quotation_net_amount ?? "----"
        submittedDateLabel.text = data.quotation_created_date ?? "----"
        approvedDateLabel.text = data.quotation_approved_date ?? "----"
        statusLabel.text = data.projects_quotation_status ?? "0" == "1" ? "Approved" : "Pending"
        writerLabel.text = data.writer ?? "----"
        
    }
    
    
    @IBAction func settingsAction(_ sender: Any) {
        didClickOnFile?()
    }
    
    
    
}
