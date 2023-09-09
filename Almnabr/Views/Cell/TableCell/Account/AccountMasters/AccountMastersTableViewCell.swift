//
//  AccountMastersTableViewCell.swift
//  Almnabr
//
//  Created by Hany Alkahlout on 12/01/2023.
//  Copyright © 2023 Samar Akkila. All rights reserved.
//

import UIKit

class AccountMastersTableViewCell: UITableViewCell {

    @IBOutlet weak var branchLabel: UILabel!
    @IBOutlet weak var accountCodeLabel: UILabel!
    @IBOutlet weak var currenciesLabel: UILabel!
    @IBOutlet weak var titleEnglishLabel: UILabel!
    @IBOutlet weak var titleArabicLabel: UILabel!
    @IBOutlet weak var parentAccountTypeLabel: UILabel!
    @IBOutlet weak var balanceSheetGroupLabel: UILabel!
    @IBOutlet weak var supportSubAccountLabel: UILabel!
    @IBOutlet weak var costCenterSupportLabel: UILabel!
    @IBOutlet weak var VATNumberLabel: UILabel!
    @IBOutlet weak var writerLabel: UILabel!
    @IBOutlet weak var createdDateLabel: UILabel!
    @IBOutlet weak var deleteButton: UIButton!
    
    @IBOutlet weak var branchesButton: UIButton!
    
    
    @IBOutlet weak var nameLabel: UILabel!
    
    
    var branchesButtonAction: (()->Void)?
    var addButtonAction: (()->Void)?
    var deleteButtonAction: (()->Void)?
    var editButtonAction: (()->Void)?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    
    func setData(data:AccountMastersRecord){
        nameLabel.text = data.name ?? "----"
        self.branchesButton.isHidden = data.children?.isEmpty ?? true
        branchLabel.text = data.branch_name ?? "----"
        accountCodeLabel.text = data.account_masters_code ?? "----"
        currenciesLabel.text = data.currencylabel ?? "----"
        titleEnglishLabel.text = data.account_masters_name_en ?? "----"
        titleArabicLabel.text = data.account_masters_name_ar ?? "----"
        parentAccountTypeLabel.text = data.accountlabel ?? "----"
        balanceSheetGroupLabel.text = data.balancelabel ?? "----"
        supportSubAccountLabel.text = data.account_masters_support == "1" ? "Yes" : "No"
        costCenterSupportLabel.text = data.cost_center_support == "1" ? "Yes" : "No"
        VATNumberLabel.text = "----"
        writerLabel.text = data.writer_name ?? "----"
        createdDateLabel.text = data.account_masters_created_datetime ?? "----"
        deleteButton.isHidden = data.account_masters_support == "1"
    }
    
    
    @IBAction func branchesAction(_ sender: Any) {
        branchesButtonAction?()
    }
    
    
    @IBAction func deleteAction(_ sender: Any) {
        deleteButtonAction?()
    }
 
    @IBAction func editAction(_ sender: Any) {
        editButtonAction?()
    }
    
    @IBAction func addAction(_ sender: Any) {
        addButtonAction?()
    }
    
    
    
    
    
    
    
}
