//
//  RelatedFormTVCell.swift
//  Almnabr
//
//  Created by MacBook on 12/03/2022.
//  Copyright © 2022 Samar Akkila. All rights reserved.
//

import UIKit

class RelatedFormTVCell: UITableViewCell {
    
    @IBOutlet weak var lblNumber: UILabel!
    @IBOutlet weak var lblunit: UILabel!
    @IBOutlet weak var lblWorkLevel: UILabel!
    @IBOutlet weak var lblEvalution: UILabel!
    @IBOutlet weak var lblRelatedForms: UILabel!
    @IBOutlet weak var viewBack: UIView!
    
    @IBOutlet weak var viewStatus: UIView!
    @IBOutlet weak var btnFile: UIButton!
    
    var btn_Action : (()->())?
    
    
    @IBAction func didReButtonPressd(_ sender: Any) {
        btn_Action!()
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        selectionStyle = .none
        
        viewBack.layer.shadowColor = UIColor.systemGray5.cgColor
        viewBack.layer.shadowOpacity = 0.8
        viewBack.layer.shadowOffset = .zero
        viewBack.layer.shadowRadius = 4
        
    }
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
