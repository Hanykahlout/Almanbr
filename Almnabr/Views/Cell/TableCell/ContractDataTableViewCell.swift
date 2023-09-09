//
//  ContractDataTableViewCell.swift
//  Almnabr
//
//  Created by Hany Alkahlout on 25/08/2022.
//  Copyright © 2022 Samar Akkila. All rights reserved.
//

import UIKit

class ContractDataTableViewCell: UITableViewCell {

    @IBOutlet weak var descriptionEnLabel: UILabel!
    @IBOutlet weak var descriptionArabicLabel: UILabel!
    @IBOutlet weak var typeLabel: UILabel!


    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
        
    
    func setDate(data:AdditionalTermsRecords){
        descriptionEnLabel.text = data.terms_content_english ?? ""
        descriptionArabicLabel.text = data.terms_content_arabic ?? ""
        typeLabel.text = data.terms_type ?? ""
        
    }
    
    
}
