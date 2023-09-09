//
//  NotesCell.swift
//  Almnabr
//
//  Created by MacBook on 16/12/2021.
//  Copyright © 2021 Samar Akkila. All rights reserved.
//

import UIKit

class NotesCell: UITableViewCell {

    @IBOutlet weak var btn_delete: UIButton!
    @IBOutlet weak var btn_upload: UIButton!
    @IBOutlet weak var lbl_No: UILabel!
    @IBOutlet weak var lbl_Title: UILabel!
    @IBOutlet weak var lbl_Result: UILabel!
    @IBOutlet weak var tf_Title: UITextField!
    @IBOutlet weak var view_Title: UIView!
    
    var btnUploadAction : (()->())?
    var btnDeleteAction : (()->())?
    var btnEndEditingAction : (()->())?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        selectionStyle = .none
    }

    @IBAction func didReUploadButtonPressd(_ sender: Any) {
        btnUploadAction!()
    }
    
    @IBAction func didReCancelButtonPressd(_ sender: Any) {
        btnDeleteAction!()
    }
    
    @IBAction func didEndEditingButtonPressd(_ sender: Any) {
        btnEndEditingAction?()
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
