//
//  UserTableViewCell.swift
//  Almnabr
//
//  Created by Hany Alkahlout on 26/06/2022.
//  Copyright © 2022 Samar Akkila. All rights reserved.
//

import UIKit

class UserTableViewCell: UITableViewCell {

    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var positionsLabel: UILabel!
    @IBOutlet weak var servicePositionsLabel: UILabel!
    @IBOutlet weak var serviceProjectNameLabel: UILabel!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func setData(data:ModuleUersRecords){
        nameLabel.text = data.name ?? ""
        titleLabel.text = data.title ?? ""
        positionsLabel.text = data.groupname ?? ""
        servicePositionsLabel.text = data.project_group_name ?? ""
        serviceProjectNameLabel.text = data.quotation_subject ?? ""
    }
    
    
}
