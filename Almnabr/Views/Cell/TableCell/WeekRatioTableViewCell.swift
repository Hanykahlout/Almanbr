//
//  WeekRatioTableViewCell.swift
//  Almnabr
//
//  Created by Hany Alkahlout on 27/10/2022.
//  Copyright © 2022 Samar Akkila. All rights reserved.
//

import UIKit

class WeekRatioTableViewCell: UITableViewCell {

    @IBOutlet weak var weekLabel: UILabel!
    @IBOutlet weak var ratioLabel: UILabel!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func setData(data: RatioWeekData){
        weekLabel.text = data.number_of_days ?? ""
        ratioLabel.text = data.total_hours ?? ""
    }
    
}
