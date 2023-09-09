//
//  ProjectTVCell.swift
//  Almnabr
//
//  Created by MacBook on 04/03/2022.
//  Copyright © 2022 Samar Akkila. All rights reserved.
//

import UIKit

class ProjectTVCell: UITableViewCell {

    @IBOutlet weak var lblId: UILabel!
    @IBOutlet weak var lblTitle: UILabel!
    @IBOutlet weak var lblBranch: UILabel!
    @IBOutlet weak var lblType: UILabel!
    @IBOutlet weak var lblCustomers: UILabel!
    @IBOutlet weak var lblWriter: UILabel!
    @IBOutlet weak var lblDate: UILabel!
    @IBOutlet weak var viewBack: UIView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
       
        
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
