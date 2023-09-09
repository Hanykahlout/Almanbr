//
//  PayRoleReviewersTableViewCell.swift
//  Almnabr
//
//  Created by Hany Alkahlout on 24/11/2022.
//  Copyright © 2022 Samar Akkila. All rights reserved.
//

import UIKit

class PayRoleReviewersTableViewCell: UITableViewCell {

    
    @IBOutlet weak var reviewerIDNumberLabel: UILabel!
    @IBOutlet weak var usernameLabel: UILabel!
    @IBOutlet weak var employeeNumberLabel: UILabel!
    @IBOutlet weak var nameLabel: UILabel!
    
    var didClickDeleteButton : (()->Void)?
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func setData(data:PayRoleReviewersRecord){
        reviewerIDNumberLabel.text = data.reviewer_id ?? "----"
        usernameLabel.text = data.user_username ?? "----"
        employeeNumberLabel.text = data.user_id ?? "----"
        nameLabel.text = data.firstname_english ?? "-----"
        
        
        
        
    }
    
    @IBAction func deleteAction(_ sender: Any) {
        didClickDeleteButton?()
    }
    
    
    
}
