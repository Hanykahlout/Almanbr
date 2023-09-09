//
//  AccountHistoryTableViewCell.swift
//  Almnabr
//
//  Created by Hany Alkahlout on 22/02/2023.
//  Copyright © 2023 Samar Akkila. All rights reserved.
//

import UIKit

class AccountHistoryTableViewCell: UITableViewCell {

    @IBOutlet weak var actionLabel: UILabel!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var notesEnLabel: UILabel!
    @IBOutlet weak var notesArLabel: UILabel!
    @IBOutlet weak var onDataLabel: UILabel!
    
    
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func setData(data:AccountHistoryRecord){
        actionLabel.text = data.account_operation ?? "----"
        nameLabel.text = data.name ?? "----"
        notesEnLabel.text = data.description_en ?? "----"
        notesArLabel.text = data.description_ar ?? "----"
        onDataLabel.text = data.log_action_date ?? "-----"
    }
    
}
