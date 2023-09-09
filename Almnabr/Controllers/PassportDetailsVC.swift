//
//  PassportDetailsVC.swift
//  Almnabr
//
//  Created by MacBook on 30/03/2022.
//  Copyright © 2022 Samar Akkila. All rights reserved.
//

import UIKit

class PassportDetailsVC: UIViewController {
    
    @IBOutlet weak var lblPassportNumber: UILabel!
    @IBOutlet weak var lblIssueDate: UILabel!
    @IBOutlet weak var lblExpiryDate: UILabel!
    @IBOutlet weak var lblIssuePlace: UILabel!
    
    var profile_obj:ProfileObj?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        configGUI() 
        configNavigation()
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
       addNavigationBarTitle(navigationTitle: "Passport Details".localized())
        UINavigationBar.appearance().backgroundColor = maincolor
    }


    
    //MARK: - Config GUI
    //------------------------------------------------------
    func configGUI() {
       
        let issue_date = "Issue Date".localized() +  ": \(profile_obj?.passport_issue_date_english ?? "---") - \(profile_obj?.passport_issue_date_arabic ?? "---")"
        let ExpiryDate =  "Expiry Date".localized() + ": \(profile_obj?.passport_expiry_date_english ?? "---") - \(profile_obj?.passport_expiry_date_arabic ?? "---")"
        let PassportNumber = "Passport Number".localized() + ": \(profile_obj?.passport_number ?? "---")"
        let IssuePlace = "Issue Place".localized() + ": \(profile_obj?.passport_issue_place ?? "---")"
        
        
        let PassportNumberattribute: NSAttributedString = PassportNumber.attributedStringWithColor(["Passport Number"], color: maincolor)
        self.lblPassportNumber.attributedText = PassportNumberattribute
        
        let IssueDateattribute: NSAttributedString = issue_date.attributedStringWithColor(["Issue Date"], color: maincolor)
        self.lblIssueDate.attributedText = IssueDateattribute
        
        let IssuePlaceattribute: NSAttributedString = IssuePlace.attributedStringWithColor(["Issue Place"], color: maincolor)
        self.lblIssuePlace.attributedText = IssuePlaceattribute
        
        let ExpiryDateattribute: NSAttributedString = ExpiryDate.attributedStringWithColor(["Expiry Date"], color: maincolor)
        self.lblExpiryDate.attributedText = ExpiryDateattribute
        
        
    }
    
}
