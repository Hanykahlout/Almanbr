//
//  TaskHistoryCell.swift
//  Almnabr
//
//  Created by MacBook on 27/04/2022.
//  Copyright © 2022 Samar Akkila. All rights reserved.
//

import UIKit

class TaskHistoryCell: UITableViewCell {
    
    @IBOutlet weak var lbl_emp_name: UILabel!
    @IBOutlet weak var lbl_insert_date: UILabel!
    @IBOutlet weak var lbl_title: UILabel!
    @IBOutlet weak var viewBack: UIView!
     
    
    override func awakeFromNib() {
        super.awakeFromNib()
        selectionStyle = .none
        viewBack.layer.shadowColor = UIColor.systemGray.cgColor
        viewBack.layer.shadowOpacity = 0.5
        viewBack.layer.shadowOffset = .zero
        viewBack.layer.shadowRadius = 4
        viewBack.layer.cornerRadius = 10
        
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
