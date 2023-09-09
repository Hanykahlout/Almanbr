//
//  JobDetailsShowTableViewCell.swift
//  Almnabr
//
//  Created by Hany Alkahlout on 17/11/2022.
//  Copyright © 2022 Samar Akkila. All rights reserved.
//

import UIKit

class JobDetailsShowTableViewCell: UITableViewCell {

    @IBOutlet weak var postionLabel: UILabel!
    
    @IBOutlet weak var descriptionLabel: UILabel!
    
    
    @IBOutlet weak var onDateLabel: UILabel!
    
    @IBOutlet weak var writerLabel: UILabel!
    
    @IBOutlet weak var needLicencesLabel: UILabel!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func setData(data:JobDetailsRecord){
        postionLabel.text = data.postition_name ?? ""
        descriptionLabel.text = data.job_descriptions ?? ""
        onDateLabel.text = data.created_datetime ?? ""
        writerLabel.text = data.position_writer ?? ""
        needLicencesLabel.text = data.settings_need_licence ?? "" == "1" ? "Yes" : "No"
    }
    
    
    
    
}
