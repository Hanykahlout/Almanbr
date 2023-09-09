//
//  InsuranceTVCell.swift
//  Almnabr
//
//  Created by MacBook on 05/04/2022.
//  Copyright © 2022 Samar Akkila. All rights reserved.
//

import UIKit

class InsuranceTVCell: UITableViewCell {

    @IBOutlet weak var lblDependentName: UILabel!
    @IBOutlet weak var lblDependentID: UILabel!
    @IBOutlet weak var lblInsuranceNumber: UILabel!
    @IBOutlet weak var lblInsuranceDate: UILabel!
    @IBOutlet weak var lblInsuranceRelationship: UILabel!
    @IBOutlet weak var lblWriter: UILabel!
    @IBOutlet weak var lblDate: UILabel!
    @IBOutlet weak var lblOnUpdate: UILabel!
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
