//
//  AppUpdateVC.swift
//  Almnabr
//
//  Created by Hany Alkahlout on 22/03/2023.
//  Copyright © 2023 Samar Akkila. All rights reserved.
//

import UIKit

class AppUpdateVC: UIViewController {
    var updateButtonAction:(()->Void)?
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
    }
    
    
    @IBAction func updateAction(_ sender: Any) {
        updateButtonAction?()
    }
    
    @IBAction func cancelAction(_ sender: Any) {
        navigationController?.popViewController(animated: true)
    }
    
}


