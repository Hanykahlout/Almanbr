//
//  BlockAccountsTableViewCell.swift
//  Almnabr
//
//  Created by Hany Alkahlout on 08/01/2023.
//  Copyright © 2023 Samar Akkila. All rights reserved.
//

import UIKit

class BlockAccountsTableViewCell: UITableViewCell {

    @IBOutlet weak var startDateLabel: UILabel!
    @IBOutlet weak var endDateLabel: UILabel!
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
    
    
    func setData(data:BlockAccountsRecord){
        startDateLabel.text = data.start_date ?? "----"
        endDateLabel.text = data.end_date ?? "----"
        dateLabel.text = data.created_datetime ?? "----"
        writerLabel.text = data.writer ?? "----"
        
    }
    
}
