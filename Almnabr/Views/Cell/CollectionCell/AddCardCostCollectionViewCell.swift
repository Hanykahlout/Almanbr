//
//  AddCardCostCollectionViewCell.swift
//  Almnabr
//
//  Created by Hany Alkahlout on 02/02/2023.
//  Copyright © 2023 Samar Akkila. All rights reserved.
//

import UIKit

class AddCardCostCollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var cardTitleLable: UILabel!
    @IBOutlet weak var cardLabel: UILabel!
    @IBOutlet weak var amountLabel: UILabel!
    
    var didClickOnDelete: (()->Void)?
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    
    func setData(cardTitle:String,data:(SearchBranchRecords?,String)){
        cardTitleLable.text = cardTitle
        cardLabel.text = data.0?.label ?? ""
        amountLabel.text = data.1
    }
    
    
    @IBAction func deleteAction(_ sender: Any) {
        didClickOnDelete?()
    }
}
