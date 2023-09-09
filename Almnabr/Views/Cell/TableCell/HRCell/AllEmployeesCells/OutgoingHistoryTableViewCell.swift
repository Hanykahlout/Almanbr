//
//  OutgoingHistoryTableViewCell.swift
//  Almnabr
//
//  Created by Hany Alkahlout on 27/06/2022.
//  Copyright © 2022 Samar Akkila. All rights reserved.
//

import UIKit

class OutgoingHistoryTableViewCell: UITableViewCell {

    @IBOutlet weak var nameLAbel: UILabel!
    @IBOutlet weak var notesLabel: UILabel!
    @IBOutlet weak var onDateLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
    }
    
    func setData(data:TransactionsContractRecord){
        nameLAbel.text = data.transactions_records_user_name ?? ""
        notesLabel.text = data.transactions_records_note ?? ""
        onDateLabel.text = data.transactions_records_datetime ?? ""
    }
    
    

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
