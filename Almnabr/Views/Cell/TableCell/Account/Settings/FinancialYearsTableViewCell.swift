//
//  FinancialYearsTableViewCell.swift
//  Almnabr
//
//  Created by Hany Alkahlout on 05/01/2023.
//  Copyright © 2023 Samar Akkila. All rights reserved.
//

import UIKit

class FinancialYearsTableViewCell: UITableViewCell {

    @IBOutlet weak var financialDateLabel: UILabel!
    @IBOutlet weak var statusView: UIView!
    @IBOutlet weak var writerLabel: UILabel!
    @IBOutlet weak var onDateLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func setData(data:FinancialYearRecord){
        financialDateLabel.text = "\(data.finance_start_date ?? "--") - \(data.finance_end_date ?? "--")"
        statusView.backgroundColor = data.finance_status ?? "" == "1" ? .green : .gray
        writerLabel.text = data.writer_name ?? "----"
        onDateLabel.text = data.created_date ?? "----"
    }
    
}
