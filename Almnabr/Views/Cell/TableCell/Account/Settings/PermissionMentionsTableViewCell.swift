//
//  PermissionMentionsTableViewCell.swift
//  Almnabr
//
//  Created by Hany Alkahlout on 03/01/2023.
//  Copyright © 2023 Samar Akkila. All rights reserved.
//

import UIKit

class PermissionMentionsTableViewCell: UITableViewCell {

    
    @IBOutlet weak var userNameLabel: UILabel!
    @IBOutlet weak var branchLabel: UILabel!
    @IBOutlet weak var groupsLabel: UILabel!
    @IBOutlet weak var permissionLabel: UILabel!
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

    func setData(data:Records){
        userNameLabel.text = data.mention_name ?? ""
        branchLabel.text = data.branch_name ?? ""
        groupsLabel.text = data.group_name ?? ""
        permissionLabel.text = "\(data.permitname ?? "") (\(data.private_value ?? ""))"
        writerLabel.text = data.creator_name ?? ""
        onDateLabel.text = data.create_date ?? ""
    }
    
}
