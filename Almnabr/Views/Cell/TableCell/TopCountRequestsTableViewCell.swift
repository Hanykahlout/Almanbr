//
//  TopCountRequestsTableViewCell.swift
//  Almnabr
//
//  Created by Hany Alkahlout on 11/10/2022.
//  Copyright © 2022 Samar Akkila. All rights reserved.
//

import UIKit

class TopCountRequestsTableViewCell: UITableViewCell {

    @IBOutlet weak var countLabel: UILabel!
    @IBOutlet weak var platformLabel: UILabel!
    @IBOutlet weak var platformCodeSystemLabel: UILabel!
    @IBOutlet weak var workLevelLabel: UILabel!
    @IBOutlet weak var transactionsLabel: UILabel!
    @IBOutlet weak var totalUnitsLabel: UILabel!
    @IBOutlet weak var totalRecordsLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func setData(index:Int,data:TopCountRequestsRecords){
        countLabel.text = "# \(index)"
        platformLabel.text = data.platform_subject ?? ""
        platformCodeSystemLabel.text = data.platform_code_system ?? ""
        workLevelLabel.text = data.platform_work_level_title ?? ""
        transactionsLabel.text = data.total_transactions ?? ""
        totalUnitsLabel.text = data.total_units ?? ""
        totalRecordsLabel.text = data.total ?? ""
    }
    
    
    
    
}
