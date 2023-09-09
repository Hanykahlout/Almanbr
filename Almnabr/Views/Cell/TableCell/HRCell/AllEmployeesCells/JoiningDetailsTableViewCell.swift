//
//  JoiningDetailsTableViewCell.swift
//  Almnabr
//
//  Created by Hany Alkahlout on 17/11/2022.
//  Copyright © 2022 Samar Akkila. All rights reserved.
//

import UIKit
import SCLAlertView
class JoiningDetailsTableViewCell: UITableViewCell {

    @IBOutlet weak var typeLabel: UILabel!
    @IBOutlet weak var startDateLabel: UILabel!
    @IBOutlet weak var statusLabel: UILabel!
    
    private var urlPath = ""
    
    var docAction: (()->Void)?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func setData(data:JoiningDetailsRecord){
        typeLabel.text = data.joining_type_value ?? ""
        startDateLabel.text = data.joining_start_date_english ?? ""
        statusLabel.text = data.approved_status ?? "" == "1" ? "Approved" : "Rejected"
        urlPath = data.link ?? ""
    }
    
    
    @IBAction func docAction(_ sender: Any) {
        docAction?()
    }
    

    
    
}
