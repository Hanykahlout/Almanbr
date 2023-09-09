//
//  VacationFormCell.swift
//  Almnabr
//
//  Created by MacBook on 07/04/2022.
//  Copyright © 2022 Samar Akkila. All rights reserved.
//

import UIKit

class VacationFormCell: UITableViewCell {

    @IBOutlet weak var lblVacationType: UILabel!
    @IBOutlet weak var lblStartDate: UILabel!
    @IBOutlet weak var lblEndDate: UILabel!
    @IBOutlet weak var lblTotalDays: UILabel!
    @IBOutlet weak var lblStatus: UILabel!
    @IBOutlet weak var viewBack: UIView!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        selectionStyle = .none
        viewBack.layer.shadowColor = UIColor.systemGray.cgColor
        viewBack.layer.shadowOpacity = 0.8
        viewBack.layer.shadowOffset = .zero
        viewBack.layer.shadowRadius = 4
        viewBack.layer.cornerRadius = 20
        
    }
    

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
