//
//  SettingsTableViewCell.swift
//  Almnabr
//
//  Created by Hany Alkahlout on 01/06/2022.
//  Copyright © 2022 Samar Akkila. All rights reserved.
//

import UIKit
protocol SettingsTableViewCellDelegate{
    func deleteAction(indexPath:IndexPath)
        
}

typealias SettingsDelegate = SettingsTableViewCellDelegate & UIViewController
class SettingsTableViewCell: UITableViewCell {

    @IBOutlet weak var userNameLabel: UILabel!
    
    @IBOutlet weak var branchLabel: UILabel!
    
    @IBOutlet weak var groupsLabel: UILabel!
    
    @IBOutlet weak var permissionsLabel: UILabel!
    
    @IBOutlet weak var writerLabel: UILabel!
    
    @IBOutlet weak var onDateLabel: UILabel!
    
    weak var delegate:SettingsDelegate?
    private var indexPath:IndexPath!
    
    func setDate(data:Records,indexPath:IndexPath){
        self.indexPath = indexPath
        userNameLabel.text = data.mention_name ?? ""
        branchLabel.text = data.branch_name ?? ""
        groupsLabel.text = data.group_name ?? ""
        let private_value = (data.private_value ?? "").uppercased()
        permissionsLabel.text = "\(data.permitname ?? "") \(private_value)"
        writerLabel.text = data.creator_name ?? ""
        onDateLabel.text = data.create_date ?? ""
        
    }
    
    @IBAction func deleteAction(_ sender: Any) {
        delegate?.deleteAction(indexPath: indexPath)
    }
    
    
    
}
