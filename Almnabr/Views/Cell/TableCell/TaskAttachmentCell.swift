//
//  TaskAttachmentCell.swift
//  Almnabr
//
//  Created by MacBook on 25/04/2022.
//  Copyright © 2022 Samar Akkila. All rights reserved.
//

import UIKit

class TaskAttachmentCell: UITableViewCell {

    @IBOutlet weak var lblname: UILabel!
    @IBOutlet weak var lblType: UILabel!
    @IBOutlet weak var lblDate: UILabel!
    @IBOutlet weak var viewBack: UIView!
     
    var btnDeleteAction : ((Int)->())?
    var btnDownloadAction : (()->())?
    var index:Int?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        selectionStyle = .none
        viewBack.layer.shadowColor = UIColor.systemGray.cgColor
        viewBack.layer.shadowOpacity = 0.8
        viewBack.layer.shadowOffset = .zero
        viewBack.layer.shadowRadius = 4
        viewBack.layer.cornerRadius = 10
    }
   
    
    
    @IBAction func didReCancelButtonPressd(_ sender: Any) {
        if let index = index {
            btnDeleteAction!(index)
        }
    }
    
    @IBAction func didReDownloadButtonPressd(_ sender: Any) {
        btnDownloadAction?()
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    
}
