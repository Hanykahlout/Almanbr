//
//  CostCenterTableViewCell.swift
//  Almnabr
//
//  Created by Hany Alkahlout on 08/01/2023.
//  Copyright © 2023 Samar Akkila. All rights reserved.
//

import UIKit

class CostCenterTableViewCell: UITableViewCell {
    
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var branchLabel: UILabel!
    @IBOutlet weak var costCenterCodeLabel: UILabel!
    @IBOutlet weak var titleEnglishLabel: UILabel!
    @IBOutlet weak var titleArabicLabel: UILabel!
    @IBOutlet weak var supportSubAccountLabel: UILabel!
    @IBOutlet weak var createdDateLabel: UILabel!
    @IBOutlet weak var writerLabel: UILabel!
    
    
    @IBOutlet weak var addButton: UIButton!
    @IBOutlet weak var editButton: UIButton!
    @IBOutlet weak var deletButton: UIButton!
    
    @IBOutlet weak var branchesButton: UIButton!
    
    
    var addCostCenterAction: (()->Void)?
    var deleteCostCenterAction: (()->Void)?
    var editCostCenterAction: (()->Void)?
    var branchesButtonAction: (()->Void)?
    
    
    func setData(data:CostCentersRecord){
        branchesButton.isHidden = data.children?.isEmpty ?? true
        nameLabel.text = data.name ?? "----"
        branchLabel.text = data.branch_name ?? "----"
        costCenterCodeLabel.text = data.cost_center_code ?? "----"
        titleEnglishLabel.text = data.cost_center_name_en ?? "----"
        titleArabicLabel.text = data.cost_center_name_ar ?? "----"
        supportSubAccountLabel.text = data.cost_center_sub ?? "" == "1" ? "Yes" : "No"
        createdDateLabel.text = data.cost_center_created_datetime ?? "----"
        writerLabel.text = data.writer_name ?? "----"
    }
    
    
    @IBAction func addCostCenter(_ sender: Any) {
        addCostCenterAction?()
    }
    
    
    @IBAction func deleteCostAction(_ sender: Any) {
        deleteCostCenterAction?()
    }
    
    
    @IBAction func editCostAction(_ sender: Any) {
        editCostCenterAction?()
    }
    
    
    @IBAction func branchesAction(_ sender: Any){
        branchesButtonAction?()
    }
    
    
}



