//
//  ByPhasesCell.swift
//  Almnabr
//
//  Created by MacBook on 09/11/2021.
//  Copyright © 2021 Samar Akkila. All rights reserved.
//

import UIKit

class ByPhasesCell: UITableViewCell {

    
    @IBOutlet weak var lblNo: UILabel!
    @IBOutlet weak var lblzones: UILabel!
    @IBOutlet weak var lblBlocks: UILabel!
    @IBOutlet weak var lblClusters: UILabel!
    @IBOutlet weak var lblUnits: UILabel!
    @IBOutlet weak var lblWorklevels: UILabel!
    @IBOutlet weak var btnDelete: UIButton!
    @IBOutlet weak var viewBack: UIView!
    
    var btnDeleteAction : (()->())?
    
    
    @IBAction func didReCancelButtonPressd(_ sender: Any) {
        btnDeleteAction!()
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
