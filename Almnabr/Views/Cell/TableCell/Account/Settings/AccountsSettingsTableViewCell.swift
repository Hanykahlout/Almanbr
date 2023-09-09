//
//  AccountsSettingsTableViewCell.swift
//  Almnabr
//
//  Created by Hany Alkahlout on 04/01/2023.
//  Copyright © 2023 Samar Akkila. All rights reserved.
//

import UIKit

class AccountsSettingsTableViewCell: UITableViewCell {

    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var typeLabel: UILabel!
    @IBOutlet weak var statusView: UIView!
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var writerLabel: UILabel!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func setData(data:AccountSettingsRecord,searchTypes:[SearchBranchRecords]){
        
        titleLabel.text = data.title ?? "-----"
        typeLabel.text = searchTypes.first(where: {$0.value == (data.setting_type_code ?? "")})?.label ?? "-----"
        dateLabel.text = data.setting_created_datetime ?? "-----"
        writerLabel.text = data.setting_writer ?? "-----"
        statusView.backgroundColor = data.setting_status ?? "" == "1" ? .green : .gray
    }
    
}
