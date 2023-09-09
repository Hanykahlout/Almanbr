//
//  TaskTVCell.swift
//  Almnabr
//
//  Created by MacBook on 25/04/2022.
//  Copyright © 2022 Samar Akkila. All rights reserved.
//

import UIKit

class TaskTVCell: UITableViewCell {

    @IBOutlet weak var lbltask_no: UILabel!
    @IBOutlet weak var lblticket_no: UILabel!
    @IBOutlet weak var lbltitle: UILabel!
    @IBOutlet weak var img_lock: UIImageView!
    @IBOutlet weak var btn_edit: UIButton!
    @IBOutlet weak var btn_changeStatus: UIButton!
    @IBOutlet weak var viewBack: UIView!
    @IBOutlet weak var viewNumber: UIView!
    @IBOutlet weak var img_check: UIImageView!
    @IBOutlet weak var lbl_totalPoints: UILabel!
    @IBOutlet weak var lbl_relatedTask: UILabel!
    @IBOutlet weak var stack_totalPoints: UIStackView!
    @IBOutlet weak var stack_related: UIStackView!
     
    @IBOutlet weak var btnImportant: UIButton!
    @IBOutlet weak var btnStatus: UIButton!
    
    var btnEditAction : (()->())?
    var btnChangeStatusAction : (()->())?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        selectionStyle = .none
        viewBack.layer.shadowColor = UIColor.systemGray.cgColor
        viewBack.layer.shadowOpacity = 0.8
        viewBack.layer.shadowOffset = .zero
        viewBack.layer.shadowRadius = 4
        viewBack.layer.cornerRadius = 10
        
        viewNumber.setBorderGray()
    }
   
    
    
    @IBAction func didReEditButtonPressd(_ sender: Any) {
        btnEditAction!()
    }
    
    @IBAction func didChangeStatusButtonPressd(_ sender: Any) {
        btnChangeStatusAction!()
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
