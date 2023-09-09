//
//  AddChecklistVC.swift
//  Almnabr
//
//  Created by MacBook on 28/06/2022.
//  Copyright © 2022 Samar Akkila. All rights reserved.
//

import UIKit

class AddChecklistVC: UIViewController {
    
    @IBOutlet weak var lblAddCheckList: UILabel!
    @IBOutlet weak var lblTitle: UILabel!
    @IBOutlet weak var tfTitle: UITextField!
    @IBOutlet var view_title: UIView!
    @IBOutlet weak var btnAdd: UIButton!
    @IBOutlet weak var btnCancel: UIButton!
    
    var task_id:String = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configGUI()
        // Do any additional setup after loading the view.
    }
    
    
    //MARK: - Config GUI
    //------------------------------------------------------
    func configGUI() {
        
        self.lblTitle.font = .kufiRegularFont(ofSize: 14)
        self.lblTitle.text = "Title".localized()
        
        self.lblAddCheckList.font = .kufiBoldFont(ofSize: 15)
        self.lblAddCheckList.text = "Title".localized()
        
        self.view_title.setBorderGray()
        
        self.tfTitle.font = .kufiRegularFont(ofSize: 15)
        
        self.btnAdd.setTitle("Add".localized(), for: .normal)
        self.btnAdd.backgroundColor =  maincolor
        self.btnAdd.setTitleColor(.white, for: .normal)
        self.btnAdd.setRounded(10)
        self.btnAdd.titleLabel?.font = .kufiRegularFont(ofSize: 14)
        
        self.btnCancel.setTitle("Cancel".localized(), for: .normal)
        self.btnCancel.backgroundColor =  maincolor
        self.btnCancel.setTitleColor(.white, for: .normal)
        self.btnCancel.setRounded(10)
        self.btnCancel.titleLabel?.font = .kufiRegularFont(ofSize: 14)
        
    }
    
    
    func Add_title(title:String){
        
        self.showLoadingActivity()
        
        let param : [String:Any] = ["task_id" : self.task_id,
                                    "title" : title]
        APIController.shard.sendRequestPostAuth(urlString: "tasks/insert_task_points_main", parameters: param ) { (response) in
            self.hideLoadingActivity()
            print("RESPIIII",response)
            let status = response["status"] as? Bool
            if status == true{
                if let message = response["message"] as? String {
                    self.showAMessage(withTitle: "", message: message,  completion: {
                        self.dismiss(animated: true)
                    })
                }
            }else{
                if let message = response["message"] as? String {
                    self.showAMessage(withTitle: "error".localized(), message:  message)
                }else{
                    self.showAMessage(withTitle: "error".localized(), message:  "something went wrong")
                }
            }
        }
    }
    
    @IBAction func btnCancel_Click(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
    
    @IBAction func btnSubmit_Click(_ sender: Any) {
        
        guard tfTitle.text != "" else {
            return self.showAMessage(withTitle: "", message: "Titlet Field Required!")
        }
        
        self.Add_title(title: tfTitle.text!)
    }
}
