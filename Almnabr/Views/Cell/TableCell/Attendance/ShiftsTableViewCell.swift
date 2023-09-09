//
//  ShiftsTableViewCell.swift
//  Almnabr
//
//  Created by Hany Alkahlout on 02/11/2022.
//  Copyright © 2022 Samar Akkila. All rights reserved.
//

import UIKit

class ShiftsTableViewCell: UITableViewCell {

    @IBOutlet weak var idNumberLabel: UILabel!
    @IBOutlet weak var nameEnglishLabel: UILabel!
    @IBOutlet weak var nameArabicLabel: UILabel!
    @IBOutlet weak var writerLabel: UILabel!
    
    var editAction: (() -> Void)?
    var calenderClockAction: (() -> Void)?
    var deleteAction: (() -> Void)?
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func setData(data:ShiftsRecords){
        idNumberLabel.text = data.shift_id ?? ""
        nameEnglishLabel.text = data.shift_title_english ?? ""
        nameArabicLabel.text = data.shift_title_arabic ?? ""
        writerLabel.text = data.writer ?? ""
    }
    
    
    @IBAction func editAction(_ sender: Any) {
        editAction?()
    }
    
    
    @IBAction func calenderClockAction(_ sender: Any) {
        calenderClockAction?()
    }
    
    
    @IBAction func deleteAction(_ sender: Any) {
        deleteAction?()
    }
    
    
    
}
