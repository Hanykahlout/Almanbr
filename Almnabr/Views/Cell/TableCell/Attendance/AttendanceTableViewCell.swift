//
//  AttendanceTableViewCell.swift
//  Almnabr
//
//  Created by Hany Alkahlout on 30/10/2022.
//  Copyright © 2022 Samar Akkila. All rights reserved.
//

import UIKit

class AttendanceTableViewCell: UITableViewCell {

    @IBOutlet weak var idNumberLabel: UILabel!
    @IBOutlet weak var nameEnglishLabel: UILabel!
    @IBOutlet weak var nameArabicLabel: UILabel!
    @IBOutlet weak var statusLabel: UILabel!
    @IBOutlet weak var writerLabel: UILabel!
    
    var updateAction: (()->Void)?
    var deleteAction: (()->Void)?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
 
    func setData(data:AttendanceGroupsRecords){
        idNumberLabel.text = data.group_id ?? "----"
        nameEnglishLabel.text = data.group_title_english ?? "----"
        nameArabicLabel.text = data.group_title_arabic ?? "----"
        statusLabel.text = data.un_restricted_group == "1" ? "Manager" : "Employee"
        writerLabel.text = data.writer ?? ""
    }
    
    @IBAction func editAction(_ sender: Any) {
        updateAction?()
    }
    
    
    @IBAction func deleteAction(_ sender: Any) {
        deleteAction?()
    }
    
    
}
