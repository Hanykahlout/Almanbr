//
//  TechnicalAssitantCVCell.swift
//  Almnabr
//
//  Created by MacBook on 02/02/2022.
//  Copyright © 2022 Samar Akkila. All rights reserved.
//

import UIKit

class TechnicalAssitantCVCell: UITableViewCell {
    
    
    @IBOutlet weak var btn_Select: UIButton!
    @IBOutlet weak var btn_delete: UIButton!
    @IBOutlet weak var lblNumber: UILabel!
    @IBOutlet weak var tf_Title: UITextField!
    @IBOutlet weak var view_Title: UIView!
    @IBOutlet weak var lblTitle: UILabel!
    @IBOutlet weak var lblNo: UILabel!
    @IBOutlet weak var lblYes: UILabel!
    @IBOutlet weak var lblResult: UILabel!
    @IBOutlet weak var stack_status: UIStackView!
    @IBOutlet weak var stack_upload: UIStackView!
    @IBOutlet weak var btn_check: UIButton!
    @IBOutlet weak var btn_checkYes: UIButton!
    @IBOutlet weak var btn_checkNo: UIButton!
    
    @IBOutlet weak var viewBack: UIView!
    @IBOutlet weak var viewSelectResult: UIView!
    
    @IBOutlet weak var lblSelectedResult: UILabel!
    
    var btnDeleteAction : (()->())?
    var btnUploadAction : (()->())?
    var btnEndEditingAction : (()->())?
    var btnYesAction : (()->())?
    var btnNoAction : (()->())?
    var btnSelectResultAction : (()->())?
    
    var object: Technical_Assistants? { didSet{ set_info() } }
    
    
    private func set_info() {
        guard let obj = object else { return }
        
        self.tf_Title.text = obj.title!
        self.lblTitle.text = obj.title!
        self.lblNumber.text = "\(obj.index + 1)"

        if (obj.img != nil || obj.url != nil) {
            self.btn_Select.tintColor = "#3ea832".getUIColor()
        }
        
        self.lblNo.text =  "No".localized()
        self.lblYes.text =  "Yes".localized()
        
        if obj.IsNew == false{
            self.btn_check.isHidden = true
            self.view_Title.isHidden = true
            self.btn_delete.isHidden = true
            self.viewSelectResult.isHidden = true
            self.lblTitle.isHidden = false
        }else{
            self.btn_check.isHidden = true
            self.view_Title.isHidden = false
            self.lblTitle.isHidden = true
            self.btn_delete.isHidden = false
            self.viewSelectResult.isHidden = false
        }
        
        
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
       
         selectionStyle = .none
         
         self.btn_checkYes.setImage(UIImage(named: "uncheck"), for: .normal)
         self.btn_checkNo.setImage(UIImage(named: "uncheck"), for: .normal)
          
         lblNumber.font = .kufiRegularFont(ofSize: 15)
         tf_Title.font = .kufiRegularFont(ofSize: 15)
         lblResult.font = .kufiRegularFont(ofSize: 15)
//         lbl_EvaluationResult.font = .kufiRegularFont(ofSize: 15)
//         lbl_Attachments.font = .kufiRegularFont(ofSize: 15)
         lblNo.font = .kufiRegularFont(ofSize: 15)
         lblYes.font = .kufiRegularFont(ofSize: 15)
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
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
    
    
    @IBAction func didEndEditingButtonPressd(_ sender: Any) {
        btnEndEditingAction?()
    }
    
    @IBAction func diduploadButtonPressd(_ sender: Any) {
        btnUploadAction?()
    }
    
    @IBAction func didSelectResultPressd(_ sender: Any) {
        btnSelectResultAction?()
    }
    
}
