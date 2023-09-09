//
//  PersonDetailsTableViewCell.swift
//  Almnabr
//
//  Created by Hany Alkahlout on 26/06/2022.
//  Copyright © 2022 Samar Akkila. All rights reserved.
//

import UIKit

class PersonDetailsTableViewCell: UITableViewCell {
    @IBOutlet weak var nameLAbel: UILabel!
    @IBOutlet weak var typeLabel: UILabel!
    @IBOutlet weak var viewCheckImageView: UIImageView!
    @IBOutlet weak var viewTimeLabel: UILabel!
    @IBOutlet weak var lastViewTimeLable: UILabel!
    @IBOutlet weak var actionCheckImageView: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func setData(data:TransactionsPersons){
        nameLAbel.text = data.person_name ?? ""
        typeLabel.text = data.transaction_persons_type ?? ""
        viewCheckImageView.tintColor = data.transactions_persons_view == "1" ? .green : .gray
        viewTimeLabel.text = data.transactions_persons_view_datetime ?? ""
        actionCheckImageView.tintColor = data.transactions_persons_action_status == "1" ? .green : .gray
        
    }
}
