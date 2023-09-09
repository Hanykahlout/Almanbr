//
//  TechnicalAssistantCell.swift
//  Almnabr
//
//  Created by MacBook on 13/12/2021.
//  Copyright © 2021 Samar Akkila. All rights reserved.
//

import UIKit

class TechnicalAssistantCell: UITableViewCell {

    @IBOutlet weak var btn_Select: UIButton!
    @IBOutlet weak var btn_delete: UIButton!
    @IBOutlet weak var lblNumber: UILabel!
    @IBOutlet weak var lbl_Title: UILabel!
    @IBOutlet weak var tf_Title: UITextField!
    @IBOutlet weak var lbl_Status: UILabel!
    @IBOutlet weak var lbl_EvaluationResult: UILabel!
    @IBOutlet weak var lbl_Attachments: UILabel!
    @IBOutlet weak var lblNo: UILabel!
    @IBOutlet weak var lblYes: UILabel!
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
    var btnSelectResultAction : (()->())?
    var btnEndEditingAction : (()->())?
    var btnYesAction : (()->())?
    var btnNoAction : (()->())?
    
    
    @IBAction func didReCancelButtonPressd(_ sender: Any) {
        btnDeleteAction!()
    }
    
    @IBAction func didReUploadButtonPressd(_ sender: Any) {
        btnUploadAction!()
    }
    
    
    @IBAction func didReNoButtonPressd(_ sender: Any) {
        btnNoAction?()
    }
    
    @IBAction func didReYesButtonPressd(_ sender: Any) {
        btnYesAction?()
    }
    
    @IBAction func didSelectResultPressd(_ sender: Any) {
        btnSelectResultAction?()
    }
    
    
    @IBAction func didEndEditingButtonPressd(_ sender: Any) {
        btnEndEditingAction?()
    }
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
       
        selectionStyle = .none
        
        self.btn_checkYes.setImage(UIImage(named: "uncheck"), for: .normal)
        self.btn_checkNo.setImage(UIImage(named: "uncheck"), for: .normal)
         
        self.viewSelectResult.setBorderGray()
//        lblNumber.font = .kufiRegularFont(ofSize: 15)
//        lbl_Title.font = .kufiRegularFont(ofSize: 15)
//        tf_Title.font = .kufiRegularFont(ofSize: 15)
//        lbl_Status.font = .kufiRegularFont(ofSize: 15)
//        lbl_EvaluationResult.font = .kufiRegularFont(ofSize: 15)
//        lbl_Attachments.font = .kufiRegularFont(ofSize: 15)
//        lblNo.font = .kufiRegularFont(ofSize: 15)
//        lblYes.font = .kufiRegularFont(ofSize: 15)
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
