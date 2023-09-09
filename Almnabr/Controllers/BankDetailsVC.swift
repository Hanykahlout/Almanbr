//
//  BankDetailsVC.swift
//  Almnabr
//
//  Created by MacBook on 30/03/2022.
//  Copyright © 2022 Samar Akkila. All rights reserved.
//

import UIKit

class BankDetailsVC: UIViewController {

    @IBOutlet weak var lblBankName: UILabel!
    @IBOutlet weak var lblAccountNumber: UILabel!
    
    var profile_obj:ProfileObj?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        configNavigation()
        configGUI()
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        // Hide the Navigation Bar
        self.navigationController?.setNavigationBarHidden(false, animated: true)
    }
    
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        // Show the Navigation Bar
        self.navigationController?.setNavigationBarHidden(false, animated: true)
    }
    
    // MARK: - Config Navigation
    func configNavigation() {
        
        _ = self.navigationController?.preferredStatusBarStyle
        self.view.backgroundColor = maincolor //F0F4F8
        //navigationController?.navigationBar.barTintColor = .buttonBackgroundColor()
        navigationController?.navigationBar.barTintColor = maincolor
       addNavigationBarTitle(navigationTitle: "Bank Details".localized())
        UINavigationBar.appearance().backgroundColor = maincolor
    }

    
    
    //MARK: - Config GUI
    //------------------------------------------------------
    func configGUI() {
       
       
        let BankName = "Bank Name".localized() + " : \(profile_obj?.bankname ?? "---")"
        let AccountNumber = "Account Number".localized() + " : \(profile_obj?.account_number ?? "---")"
        
        let Bankattribute: NSAttributedString = BankName.attributedStringWithColor(["Bank Name"], color: maincolor)
        self.lblBankName.attributedText = Bankattribute
        
        let Accountattribute: NSAttributedString = AccountNumber.attributedStringWithColor(["Account Number"], color: maincolor)
        self.lblAccountNumber.attributedText = Accountattribute
    }
    
}
