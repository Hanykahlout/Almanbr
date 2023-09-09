//
//  ViewEmpPassportDetailsVC.swift
//  Almnabr
//
//  Created by Hany Alkahlout on 12/06/2022.
//  Copyright © 2022 Samar Akkila. All rights reserved.
//

import UIKit

class ViewEmpPassportDetailsVC: UIViewController {

    @IBOutlet weak var passportNumberLabel: UILabel!
    @IBOutlet weak var issueDateLabel: UILabel!
    @IBOutlet weak var expiryDateLabel: UILabel!
    @IBOutlet weak var issuePlaceLabel: UILabel!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        intlization()
        // Do any additional setup after loading the view.
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        addNavigationBarTitle(navigationTitle: "Passport Details")
        navigationController?.setNavigationBarHidden(false, animated: true)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        navigationController?.setNavigationBarHidden(true, animated: true)
    }

    private func intlization(){
        passportNumberLabel.text = ViewEmployeeDetailsVC.empData.data?.passport_number ?? ""
        issueDateLabel.text = "\(ViewEmployeeDetailsVC.empData.data?.passport_issue_date_english ?? "") - \(ViewEmployeeDetailsVC.empData.data?.passport_issue_date_arabic ?? "")"
        expiryDateLabel.text = "\(ViewEmployeeDetailsVC.empData.data?.iqama_expiry_date_english ?? "") - \(ViewEmployeeDetailsVC.empData.data?.iqama_expiry_date_arabic ?? "")"
        issuePlaceLabel.text = "\(ViewEmployeeDetailsVC.empData.data?.passport_issue_date_english ?? "") - \(ViewEmployeeDetailsVC.empData.data?.passport_issue_date_arabic ?? "")"
    }

    

}
