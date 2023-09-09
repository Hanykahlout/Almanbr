//
//  RecipientVerificationVC.swift
//  Almnabr
//
//  Created by MacBook on 07/12/2021.
//  Copyright © 2021 Samar Akkila. All rights reserved.
//

import UIKit

class RecipientVerificationVC: UIViewController {

    @IBOutlet weak var icon_noPermission: UIImageView!
    @IBOutlet weak var view_noPermission: UIView!
    @IBOutlet weak var lbl_noPermission: UILabel!
    
    @IBOutlet weak var lbl_Title: UILabel!
    @IBOutlet weak var lbl_ReserveRequestQ: UILabel!
    @IBOutlet weak var lbl_ReserveRequest: UILabel!
    @IBOutlet weak var lbl_Reject: UILabel!
    @IBOutlet weak var lbl_notes: UILabel!
    
    @IBOutlet weak var txt_notes: UITextView!
    @IBOutlet weak var btn_checkReject: UIButton!
    @IBOutlet weak var btn_checkReserve: UIButton!
    @IBOutlet weak var btn_submit: UIButton!
    
    @IBOutlet weak var view_main: UIView!
    
    @IBOutlet weak var view_txtView: UIView!
    
    
    var ReserveRequest:String = ""
    
    var params:[String:String] = [:]
    
    override func viewDidLoad() {
        super.viewDidLoad()

        configGUI()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
         configGUI()
    }
    
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
       // configGUI()
    }
    
    //MARK: - Config GUI
    //------------------------------------------------------
    func configGUI() {
        
        icon_noPermission.no_permission()
        
        self.lbl_noPermission.text =  "You not have permission to access this step".localized()
        self.lbl_noPermission.font = .kufiRegularFont(ofSize: 15)
        self.lbl_noPermission.textColor =  "#333".getUIColor()
        
        
        if StatusObject?.Recipient_Verification == false {
            view_noPermission.isHidden = false
            self.view_main.isHidden = true

        }else{
            view_noPermission.isHidden = true
            self.view_main.isHidden = false
        }

        
        self.txt_notes.text = ""
        self.btn_checkReserve.setImage(UIImage(named: "uncheck"), for: .normal)
        self.btn_checkReject.setImage(UIImage(named: "uncheck"), for: .normal)
        
        self.lbl_Title.text =  "Recipient Verification ".localized()
        self.lbl_Title.font = .kufiRegularFont(ofSize: 14)
        self.lbl_Title.textColor =  maincolor
        
        
        self.lbl_ReserveRequestQ.text =  "Reserve Request".localized() + "  ?!"
        self.lbl_ReserveRequestQ.font = .kufiRegularFont(ofSize: 13)
       // self.lbl_ReserveRequestQ.textColor =  HelperClassSwift.bcolor.getUIColor()
        
        
        self.lbl_Reject.text =  "Reject and return to update".localized()
        self.lbl_Reject.font = .kufiRegularFont(ofSize: 13)
        //self.lbl_Reject.textColor =  HelperClassSwift.bcolor.getUIColor()
        
        
        self.lbl_ReserveRequest.text =  "Reserve Request".localized()
        self.lbl_ReserveRequest.font = .kufiRegularFont(ofSize: 13)
       // self.lbl_ReserveRequest.textColor =  HelperClassSwift.bcolor.getUIColor()
        
        self.lbl_notes.text =  "Rejected Notes :".localized()
        self.lbl_notes.font = .kufiRegularFont(ofSize: 13)
       // self.lbl_notes.textColor =  HelperClassSwift.bcolor.getUIColor()
        
        
        self.view_txtView.setBorderColorWidthCorner(0.5, 10, color: maincolor)
        
       // self.view_main.setBorderGray()
        
        
        self.btn_submit.setTitle("Submit".localized(), for: .normal)
        self.btn_submit.backgroundColor =  "#1A3665".getUIColor()
        self.btn_submit.setTitleColor(.white, for: .normal)
        
        
    }

    
    
    func submit_Request(){
        
        
        if  self.ReserveRequest != "" {
            
            self.showLoadingActivity()
            
            if self.ReserveRequest == "0"  {
                self.params["notes"] = self.txt_notes.text ?? ""
            }
     
            APIController.shard.sendRequestPostAuth(urlString: "form/\(obj_transaction?.transaction_key ?? " ")/Recipient_Verification/0", parameters: params ) { (response) in
                self.hideLoadingActivity()
               
                
                let status = response["status"] as? Bool
                let msg = response["msg"] as? String
                let error = response["error"] as? String
                
                if status == true{
                    self.hideLoadingActivity()
                    self.showAMessage(withTitle: "Success".localized(), message: msg ?? "Thank you. The operation was completed successfully.", completion: {
                        self.configGUI()
                        self.update_Config()
//                        self.configGUI()
//                        self.change_page(SelectedIndex:5)
                    })
                    
                }else{
                    self.hideLoadingActivity()
                    self.showAMessage(withTitle: "Error", message: error ?? "Some thing went wrong")
                    
                }
                }
            
            
        }else {
            
            self.showAMessage(withTitle: "Error".lowercased(), message: "Some thing went wrong")
            return
        }
   

    }
    
    
    
    @IBAction func btnReserveRequest_Click(_ sender: Any) {
        
        self.params = [:]
        self.btn_checkReject.setImage(UIImage(named: "uncheck"), for: .normal)
          self.btn_checkReserve.setImage(UIImage(named: "check"), for: .normal)
     
        
          self.lbl_notes.isHidden = true
          self.view_txtView.isHidden = true
        
        self.ReserveRequest = "1"
        
        self.params["transaction_request_id"] = obj_transaction?.transaction_request_id ?? "0"
        //self.params["contractor_approval_status"] = "Approve"
        self.params["teserve_transaction"] = "1"
        self.params["rollback_to_configuration"] = "0"
        
        
    }
    
    @IBAction func btnReject_Click(_ sender: Any) {
        
        self.params = [:]
        self.btn_checkReserve.setImage(UIImage(named: "uncheck"), for: .normal)
        self.btn_checkReject.setImage(UIImage(named: "check"), for: .normal)
     
        
          self.lbl_notes.isHidden = false
          self.view_txtView.isHidden = false
        
        self.ReserveRequest = "0"
        
        self.params["transaction_request_id"] = obj_transaction?.transaction_request_id ?? "0"
        self.params["teserve_transaction"] = "0"
        self.params["rollback_to_configuration"] = "1"
        
        
        
    }
    
    
    @IBAction func btnSubmit_Click(_ sender: Any) {
        
        submit_Request()
    }
    
    
    
    private func change_page(SelectedIndex:Int) {
        NotificationCenter.default.post(name: NSNotification.Name("Change_Form_Step"),
                                        object: SelectedIndex)
    }
    
    private func update_Config() {
        NotificationCenter.default.post(name: NSNotification.Name("update_Config"),
                                        object: nil)
    }
    
}
