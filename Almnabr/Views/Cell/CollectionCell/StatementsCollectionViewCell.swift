//
//  StatementsCollectionViewCell.swift
//  Almnabr
//
//  Created by Hany Alkahlout on 04/03/2023.
//  Copyright © 2023 Samar Akkila. All rights reserved.
//

import UIKit

class StatementsCollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var amountLabel: UILabel!
    @IBOutlet weak var accountNameLabel: UILabel!
    @IBOutlet weak var actionStackView: UIStackView!
    @IBOutlet weak var accountCodeLabel: UILabel!
    
    var transactionButtonAction:(()->Void)?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

        
    func setData(data:AssetsRecord){
        actionStackView.isHidden = data.transaction_allow != "0"
        amountLabel.text = data.amount ?? "----"
        accountNameLabel.text = data.account_name ?? "----"
        accountCodeLabel.text = data.account_code ?? "----"
    }
    
    @IBAction func transactionAction(_ sender: Any) {
        transactionButtonAction?()
    }
}
