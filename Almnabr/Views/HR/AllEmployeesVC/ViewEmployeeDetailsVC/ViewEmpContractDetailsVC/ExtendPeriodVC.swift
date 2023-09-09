//
//  ExtendPeriodVC.swift
//  Almnabr
//
//  Created by Hany Alkahlout on 17/11/2022.
//  Copyright © 2022 Samar Akkila. All rights reserved.
//

import UIKit

class ExtendPeriodVC: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        addNavigationBarTitle(navigationTitle: "Extend Period")
        navigationController?.setNavigationBarHidden(false, animated: true)
    }
    
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        navigationController?.setNavigationBarHidden(true, animated: true)
    }
    
    
}
