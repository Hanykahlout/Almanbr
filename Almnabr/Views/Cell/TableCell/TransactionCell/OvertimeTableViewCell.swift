//
//  OvertimeTableViewCell.swift
//  Almnabr
//
//  Created by Hany Alkahlout on 28/11/2022.
//  Copyright © 2022 Samar Akkila. All rights reserved.
//

import UIKit

class OvertimeTableViewCell: UITableViewCell {

    @IBOutlet weak var hoursLabel: UILabel!
    @IBOutlet weak var amountLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func setData(data:Form_ovr1_records){
        hoursLabel.text = data.overtime_hours ?? "----"
        amountLabel.text = data.overtime_amount ?? "----"
        dateLabel.text = "\(data.overtime_date_english ?? "--") - \(data.overtime_date_arabic ?? "--")"
        
    }
    
}
