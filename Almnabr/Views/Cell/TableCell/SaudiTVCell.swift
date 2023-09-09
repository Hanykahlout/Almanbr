//
//  SaudiTVCell.swift
//  Almnabr
//
//  Created by MacBook on 20/12/2021.
//  Copyright © 2021 Samar Akkila. All rights reserved.
//

import UIKit

class SaudiTVCell: UITableViewCell {
    
    @IBOutlet weak var btn_delete: UIButton!
    @IBOutlet weak var lblNumber: UILabel!
    @IBOutlet weak var tf_Title: UITextField!
    @IBOutlet weak var lblNo: UILabel!
    @IBOutlet weak var lblYes: UILabel!
    @IBOutlet weak var stack_status: UIStackView!
    @IBOutlet weak var btn_checkYes: UIButton!
    @IBOutlet weak var btn_checkNo: UIButton!
    @IBOutlet weak var btn_SelectFile: UIButton!
    @IBOutlet weak var viewBack: UIView!
    
    var btnDeleteAction : (()->())?
    var btnYesAction : (()->())?
    var btnNoAction : (()->())?
    var btnEndEditingAction : (()->())?
    
    @IBAction func didEndEditingButtonPressd(_ sender: Any) {
        btnEndEditingAction?()
    }
    
    @IBAction func didReCancelButtonPressd(_ sender: Any) {
        btnDeleteAction!()
    }
   
    
    
    @IBAction func didReNoButtonPressd(_ sender: Any) {
        btnNoAction?()
    }
    
    @IBAction func didReYesButtonPressd(_ sender: Any) {
        btnYesAction?()
    }
    
    
  
    
    override func awakeFromNib() {
        super.awakeFromNib()
       
        selectionStyle = .none
        
        self.btn_checkYes.setImage(UIImage(named: "uncheck"), for: .normal)
        self.btn_checkNo.setImage(UIImage(named: "uncheck"), for: .normal)
         
        lblNumber.font = .kufiRegularFont(ofSize: 15)
        tf_Title.font = .kufiRegularFont(ofSize: 15)
       
        lblNo.font = .kufiRegularFont(ofSize: 15)
        lblYes.font = .kufiRegularFont(ofSize: 15)
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
