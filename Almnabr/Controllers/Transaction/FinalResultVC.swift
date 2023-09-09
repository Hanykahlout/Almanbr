//
//  FinalResultVC.swift
//  Almnabr
//
//  Created by MacBook on 07/12/2021.
//  Copyright © 2021 Samar Akkila. All rights reserved.
//

import UIKit

class FinalResultVC: UIViewController {

    @IBOutlet weak var icon_noPermission: UIImageView!
    @IBOutlet weak var view_noPermission: UIView!
    @IBOutlet weak var lbl_noPermission: UILabel!
    
    @IBOutlet weak var lbl_Title: UILabel!
    @IBOutlet weak var lbl_Thanks: UILabel!
    
    @IBOutlet weak var view_main: UIView!
    
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
         
        
        self.lbl_Title.text =  "Final Result".localized()
        self.lbl_Title.font = .kufiRegularFont(ofSize: 14)
        self.lbl_Title.textColor =  maincolor
        
        
        self.lbl_Thanks.text =  "Thank you, we will review your request. wait the result soon.".localized()
        self.lbl_Thanks.font = .kufiRegularFont(ofSize: 13)
        self.lbl_Thanks.textColor =  "#555".getUIColor()
        
        
        
        icon_noPermission.no_permission()
        
        self.lbl_noPermission.text =  "You not have permission to access this step".localized()
        self.lbl_noPermission.font = .kufiRegularFont(ofSize: 15)
        self.lbl_noPermission.textColor =  "#333".getUIColor()
        
        let step = obj_transaction?.transaction_request_last_step ?? "last"
        if step == "completed" {
            view_noPermission.isHidden = true
            self.view_main.isHidden = false
            self.lbl_Title.isHidden = true
            self.lbl_Thanks.isHidden = true
        }else if step == "last" {
            view_noPermission.isHidden = true
            self.view_main.isHidden = false
            self.lbl_Title.isHidden = false
            self.lbl_Thanks.isHidden = false
        }else{
            if StatusObject?.Final_Result == false {
                view_noPermission.isHidden = false
                self.view_main.isHidden = true

            }else{
                view_noPermission.isHidden = true
                self.view_main.isHidden = false
//                self.lbl_Title.isHidden = false
//                self.lbl_Thanks.isHidden = false
            }
        }
        
      
    }


    
}
