//
//  CornTransactionTVCell.swift
//  Almnabr
//
//  Created by MacBook on 05/10/2021.
//  Copyright © 2021 Samar Akkila. All rights reserved.
//

import UIKit

class CornTransactionTVCell: UITableViewCell {

    
    @IBOutlet weak var lblNo: UILabel!
    @IBOutlet weak var lblFormName: UILabel!
    @IBOutlet weak var lblError: UILabel!
    @IBOutlet weak var lblAttempt: UILabel!
    @IBOutlet weak var lblLastUpdate: UILabel!
    @IBOutlet weak var viewBack: UIView!
    @IBOutlet weak var btnDelete: UIButton!
    
    var btn_Action : (()->())?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        selectionStyle = .none
        
        
        self.viewBack.layer.applySketchShadow(
          color: .gray,
          alpha: 0.6,
          x: 0,
          y: 1,
          blur: 1,
          spread: 0)
        
    }

   
    
    
    @IBAction func didReButtonPressd(_ sender: Any) {
//        btn_Action!()
    }
    
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
