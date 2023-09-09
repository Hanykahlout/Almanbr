//
//  ProjectRequestCell.swift
//  Almnabr
//
//  Created by MacBook on 11/01/2022.
//  Copyright © 2022 Samar Akkila. All rights reserved.
//

import UIKit

class ProjectRequestCell: UITableViewCell {
   
    @IBOutlet weak var viewBack: UIView!
    @IBOutlet weak var viewResult: UIView!
    @IBOutlet weak var viewcolor: UIView!
    @IBOutlet weak var lblPlatformTitle: UILabel!
    @IBOutlet weak var lblDivision: UILabel!
    @IBOutlet weak var lblChapter: UILabel!
    @IBOutlet weak var lblPlatformCodeSystem: UILabel!
    @IBOutlet weak var lblUnit: UILabel!
    @IBOutlet weak var lblByPhases: UILabel!
    @IBOutlet weak var lblLevel: UILabel!
    @IBOutlet weak var lblBarcode: UILabel!
    @IBOutlet weak var lblRequestNo : UILabel!
    @IBOutlet weak var lblKeyLastStepOpened: UILabel!
    
    @IBOutlet weak var lblGroupType: UILabel!
    @IBOutlet weak var lblResult: UILabel!
    
    var btn_Action : (()->())?
    
    
    @IBAction func didReButtonPressd(_ sender: Any) {
        btn_Action!()
    }
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        selectionStyle = .none
        self.viewBack.setBorderGray()
        self.viewResult.backgroundColor =  HelperClassSwift.acolor.getUIColor()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
