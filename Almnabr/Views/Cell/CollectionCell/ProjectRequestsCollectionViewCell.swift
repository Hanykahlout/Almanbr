//
//  ProjectRequestsCollectionViewCell.swift
//  Almnabr
//
//  Created by Hany Alkahlout on 16/10/2022.
//  Copyright © 2022 Samar Akkila. All rights reserved.
//

import UIKit

class ProjectRequestsCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var platformNameLabel: UILabel!
    @IBOutlet weak var resultCodeLabel: UILabel!
    @IBOutlet weak var groupTypeNameLabel: UILabel!
    @IBOutlet weak var group1NameLabel: UILabel!
    @IBOutlet weak var group2NameLabel: UILabel!
    @IBOutlet weak var platformCodeSystemLabel: UILabel!
    @IBOutlet weak var unitIDLabel: UILabel!
    @IBOutlet weak var phaseShortCodeLabel: UILabel!
    @IBOutlet weak var levelNameLabel: UILabel!
    @IBOutlet weak var transactionRequestLastStepLabel: UILabel!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    func setData(data:ProjectRequestRecord){
        platformNameLabel.text = data.platform_name ?? ""
        resultCodeLabel.text = data.result_code ?? ""
        groupTypeNameLabel.text = data.group_type_name ?? ""
        group1NameLabel.text = data.group1_name ?? ""
        group2NameLabel.text = data.group2_name ?? ""
        platformCodeSystemLabel.text = data.platform_code_system ?? ""
        unitIDLabel.text = data.unit_id ?? ""
        phaseShortCodeLabel.text = data.phase_short_code ?? ""
        levelNameLabel.text = data.level_name ?? ""
        transactionRequestLastStepLabel.text = data.transaction_request_last_step ?? ""
    }
    

}
