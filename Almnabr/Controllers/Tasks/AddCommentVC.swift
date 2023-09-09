//
//  AddCommentVC.swift
//  Almnabr
//
//  Created by MacBook on 01/07/2022.
//  Copyright © 2022 Samar Akkila. All rights reserved.
//

import UIKit

class AddCommentVC: UIViewController {

    @IBOutlet weak var lblEdit_comment: UILabel!
    @IBOutlet weak var lblTitle: UILabel!
    @IBOutlet weak var tfTitle: UITextField!
    @IBOutlet weak var view_title: UIView!
    @IBOutlet weak var btnSubmit: UIButton!
    @IBOutlet weak var btnCancel: UIButton!
    
    var delegate : (() -> Void)?
    var comment_id:String = ""
    var comment:String = ""
    var header:String = "Edit comment".localized()
    var title_str :String = "comment".localized()
    var type :String = "comment"
    var task_id:String = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()

        configGUI()
        // Do any additional setup after loading the view.
    }
    
    
    //MARK: - Config GUI
    //------------------------------------------------------
    func configGUI() {
        
        self.lblEdit_comment.font = .kufiRegularFont(ofSize: 14)
        self.lblEdit_comment.text = self.header
        
        self.lblTitle.font = .kufiRegularFont(ofSize: 14)
        self.lblTitle.text = title_str
        
        self.tfTitle.text = self.comment
        self.tfTitle.placeholder = title_str
        self.view_title.setBorderGray()
        
//        self.tfUser.placeholder = "Add Users".localized()
        self.tfTitle.font = .kufiRegularFont(ofSize: 15)
        
//        self.tfUser.delegate = self
        
        self.btnSubmit.setTitle("Submit".localized(), for: .normal)
        self.btnSubmit.backgroundColor =  maincolor
        self.btnSubmit.setTitleColor(.white, for: .normal)
        self.btnSubmit.setRounded(10)
        self.btnSubmit.titleLabel?.font = .kufiRegularFont(ofSize: 14)
        
        self.btnCancel.setTitle("Cancel".localized(), for: .normal)
        self.btnCancel.backgroundColor =  maincolor
        self.btnCancel.setTitleColor(.white, for: .normal)
        self.btnCancel.setRounded(10)
        self.btnCancel.titleLabel?.font = .kufiRegularFont(ofSize: 14)
    }

    
    func Add_title(title:String , strUrl:String , param : [String:Any]){
        
        self.showLoadingActivity()
//
       
        APIController.shard.sendRequestPostAuth(urlString: "tasks/\(strUrl)", parameters: param ) { (response) in
            self.hideLoadingActivity()
           
            let status = response["status"] as? Bool
            let message = response["message"] as? [String:Any]
            
            if status == true{
                if self.type == "comment" {
                    if let message = message?["msg"] as? String {
                        self.showAMessage(withTitle: "", message: message,  completion: {
                            self.delegate!()
                            self.dismiss(animated: true)
                        })
                    }
                }else{
                    if let message = response["message"] as? String {
                        self.showAMessage(withTitle: "", message: message,  completion: {
                            self.delegate!()
                            self.dismiss(animated: true)
                        })
                    }
                }
               
            }else{
                if let message = response["message"] as? String {
                    self.showAMessage(withTitle: "error".localized(), message:  message)
                }else{
                    self.showAMessage(withTitle: "error".localized(), message:  "something went wrong")
                }
            }
            self.hideLoadingActivity()
            
        }
    }
    
    @IBAction func btnCancel_Click(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func btnSubmit_Click(_ sender: Any) {
        
        guard tfTitle.text != "" else {
            return self.showAMessage(withTitle: "", message: "Title Field Required!")
        }
        
        if type == "comment" {
            let param : [String:Any] = ["comment_id" : self.comment_id,
                                        "notes" : tfTitle.text!]
            
            self.Add_title(title: tfTitle.text! , strUrl: "update_comment_reply",param : param)
        }else{
            
            let param : [String:Any] = ["comment_id" : self.comment_id,
                                        "notes" : tfTitle.text!,
                                        "task_id" : self.task_id]
            self.Add_title(title: tfTitle.text!, strUrl: "add_reply_task", param : param)
        }
        
    }
}
