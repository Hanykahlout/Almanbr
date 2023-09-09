//
//  CodeTypeTableViewCell.swift
//  Almnabr
//
//  Created by Hany Alkahlout on 25/08/2022.
//  Copyright © 2022 Samar Akkila. All rights reserved.
//

import UIKit

class CodeTypeTableViewCell: UITableViewCell {

    @IBOutlet weak var typeLabel: UILabel!
    @IBOutlet weak var exampleLabel: UILabel!
    @IBOutlet weak var radioButton: UIButton!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
