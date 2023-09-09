//
//  TaskUserTVCell.swift
//  Almnabr
//
//  Created by MacBook on 07/05/2022.
//  Copyright © 2022 Samar Akkila. All rights reserved.
//

import UIKit

class TaskUserTVCell: UITableViewCell {

    @IBOutlet weak var lblUser: UILabel!
    @IBOutlet weak var lblFirstName: UILabel!
    @IBOutlet weak var lblLastName: UILabel!
    @IBOutlet weak var btnUnfollow: UIButton!
    @IBOutlet weak var btnLock: UIButton!
    @IBOutlet weak var viewBack: UIView!
    
    var btnUnfollowAction : (()->())?
    var btnLockAction : (()->())?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        selectionStyle = .none
//        viewBack.layer.shadowColor = UIColor.systemGray.cgColor
//        viewBack.layer.shadowOpacity = 0.8
//        viewBack.layer.shadowOffset = .zero
//        viewBack.layer.shadowRadius = 4
//        viewBack.layer.cornerRadius = 20
    }
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    
    @IBAction func didFollowButtonPressd(_ sender: Any) {
        btnUnfollowAction!()
    }
    
    @IBAction func didLockButtonPressd(_ sender: Any) {
        btnLockAction!()
    }
    
    
}
