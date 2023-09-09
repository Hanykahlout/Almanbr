//
//  CreateTransactionTableViewCell.swift
//  Almnabr
//
//  Created by Hany Alkahlout on 12/10/2022.
//  Copyright © 2022 Samar Akkila. All rights reserved.
//

import UIKit

class CreateTransactionTableViewCell: UITableViewCell {
    @IBOutlet weak var countLabel: UILabel!
    @IBOutlet weak var titleLabel: UILabel!
    
    var didSelectedRecord: (() -> Void)?
    
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    @IBAction func recordAction(_ sender: Any) {
        didSelectedRecord?()
    }
    
    
}
