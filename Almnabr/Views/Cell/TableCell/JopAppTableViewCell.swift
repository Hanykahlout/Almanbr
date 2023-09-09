//
//  JopAppTableViewCell.swift
//  Almnabr
//
//  Created by Hany Alkahlout on 06/12/2022.
//  Copyright © 2022 Samar Akkila. All rights reserved.
//

import UIKit

class JopAppTableViewCell: UITableViewCell {
    
    @IBOutlet weak var statusButton: UIButton!
    
    @IBOutlet weak var statusLabel: UILabel!
    
    @IBOutlet weak var emailLabel: UILabel!
    
    @IBOutlet weak var empNameLabel: UILabel!
    
    @IBOutlet weak var idNumberLabel: UILabel!
    
    @IBOutlet weak var mobileLabel: UILabel!
    
    var didClickOnDelete: (()->Void)?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }

    
    func setData(data:JobAppRecord){
        empNameLabel.text = data.name ?? "----"
        idNumberLabel.text = data.employee_id_number ?? "----"
        mobileLabel.text = data.primary_mobile ?? "----"
        emailLabel.text = data.primary_email ?? "----"
        let status = data.employee_status ?? ""
        switch status{
        case "1":
            statusLabel.text = "Approved"
            statusButton.tintColor = .green
        case "2":
            statusLabel.text = "Pending"
            statusButton.tintColor = .orange
        case "3":
            statusLabel.text = "Rejected"
            statusButton.tintColor = .red
        case "4":
            statusLabel.text = "Waiting"
            statusButton.tintColor = .blue
        default: break
        }
    }
    
    
    @IBAction func trashAction(_ sender: Any) {
        didClickOnDelete?()
    }
    
    
    
}
