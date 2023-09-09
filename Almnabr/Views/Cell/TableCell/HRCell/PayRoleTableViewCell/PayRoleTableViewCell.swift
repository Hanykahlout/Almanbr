//
//  PayRoleTableViewCell.swift
//  Almnabr
//
//  Created by Hany Alkahlout on 24/11/2022.
//  Copyright © 2022 Samar Akkila. All rights reserved.
//

import UIKit

class PayRoleTableViewCell: UITableViewCell {

    @IBOutlet weak var requestNumberLabel: UILabel!
    @IBOutlet weak var subjectLabel: UILabel!
    @IBOutlet weak var monthLabel: UILabel!
    @IBOutlet weak var numberOfEmployeesLabel: UILabel!
    @IBOutlet weak var amountLabel: UILabel!
    @IBOutlet weak var lastStepOpenedLabel: UILabel!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func setData(data:PayRoleData){
        requestNumberLabel.text = data.transaction_request_id ?? "----"
        subjectLabel.text = data.subject ?? "----"
        monthLabel.text = "\(data.salary_month ?? "--")/\(data.salary_year ?? "--")"
        numberOfEmployeesLabel.text = data.number_of_employees ?? "----"
        amountLabel.text = data.total_amount ?? "----"
        lastStepOpenedLabel.text = data.transaction_request_last_step ?? "----"
    }
    
}
