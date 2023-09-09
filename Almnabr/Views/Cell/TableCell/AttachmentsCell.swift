//
//  AttachmentsCell.swift
//  Almnabr
//
//  Created by MacBook on 16/11/2021.
//  Copyright © 2021 Samar Akkila. All rights reserved.
//

import UIKit

class AttachmentsCell: UITableViewCell {

    @IBOutlet weak var btn_Select: UIButton!
    @IBOutlet weak var btn_delete: UIButton!
    @IBOutlet weak var tfTitle: UITextField!
    
    @IBOutlet weak var lblNo: UILabel!
    @IBOutlet weak var viewBack: UIView!
    
    
    var btnDeleteAction : (()->())?
    var btnUploadAction : (()->())?
    var btnEndEditingAction : (()->())?
    
    
    
    @IBAction func didReCancelButtonPressd(_ sender: Any) {
        btnDeleteAction!()
    }
    
    @IBAction func didReUploadButtonPressd(_ sender: Any) {
        btnUploadAction!()
    }
    
    @IBAction func didEndEditingButtonPressd(_ sender: Any) {
        btnEndEditingAction?()
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        selectionStyle = .none
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
