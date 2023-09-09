//
//  ProjectRequestTVCell.swift
//  Almnabr
//
//  Created by MacBook on 04/03/2022.
//  Copyright © 2022 Samar Akkila. All rights reserved.
//

import UIKit

class ProjectRequestTVCell: UITableViewCell {
    
     @IBOutlet weak var viewBack: UIView!
     @IBOutlet weak var viewResult: UIView!
     @IBOutlet weak var viewStep: UIView!
     @IBOutlet weak var lblPlatformTitle: UILabel!
     @IBOutlet weak var lblDivision: UILabel!
     @IBOutlet weak var lblChapter: UILabel!
     @IBOutlet weak var lblPlatformCodeSystem: UILabel!
     @IBOutlet weak var lblUnit: UILabel!
     @IBOutlet weak var lblByPhases: UILabel!
     @IBOutlet weak var lblLevel: UILabel!
     @IBOutlet weak var lblBarcode: UILabel!
     @IBOutlet weak var lblRequestNo : UILabel!
    @IBOutlet weak var lblStep: UILabel!
     
     @IBOutlet weak var lblGroupType: UILabel!
     @IBOutlet weak var lblResult: UILabel!
     
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
