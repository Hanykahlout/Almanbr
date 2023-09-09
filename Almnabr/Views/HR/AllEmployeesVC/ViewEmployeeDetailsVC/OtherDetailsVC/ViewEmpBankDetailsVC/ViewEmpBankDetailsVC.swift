//
//  ViewEmpBankDetailsVC.swift
//  Almnabr
//
//  Created by Hany Alkahlout on 12/06/2022.
//  Copyright © 2022 Samar Akkila. All rights reserved.
//

import UIKit

class ViewEmpBankDetailsVC: UIViewController {

    @IBOutlet weak var accountNumberLabel: UILabel!
    @IBOutlet weak var bankNameLabel: UILabel!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        initlization()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        addNavigationBarTitle(navigationTitle: "Bank Details")
        navigationController?.setNavigationBarHidden(false, animated: true)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        navigationController?.setNavigationBarHidden(true, animated: true)
    }
    
    private func initlization(){
        accountNumberLabel.text = ViewEmployeeDetailsVC.empData.data?.account_number ?? ""
        bankNameLabel.text = ViewEmployeeDetailsVC.empData.data?.bankname ?? ""
        
    }
    
    
}
