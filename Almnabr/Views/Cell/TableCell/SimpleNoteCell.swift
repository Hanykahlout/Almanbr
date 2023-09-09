//
//  SimpleNoteCell.swift
//  Almnabr
//
//  Created by MacBook on 20/03/2022.
//  Copyright © 2022 Samar Akkila. All rights reserved.
//

import UIKit

class SimpleNoteCell: UITableViewCell {

    @IBOutlet weak var btn_delete: UIButton!
    @IBOutlet weak var lblNumber: UILabel!
    @IBOutlet weak var tf_Title: UITextField!
    @IBOutlet weak var viewBack: UIView!
    
    var btnDeleteAction : (()->())?
    var btnEndEditingAction : (()->())?
    
    @IBAction func didEndEditingButtonPressd(_ sender: Any) {
        btnEndEditingAction?()
    }
    
    @IBAction func didReCancelButtonPressd(_ sender: Any) {
        btnDeleteAction!()
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
       
        selectionStyle = .none
       
        lblNumber.font = .kufiRegularFont(ofSize: 13)
        tf_Title.font = .kufiRegularFont(ofSize: 13)
       
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
