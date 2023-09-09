//
//  AccountTaxViewController.swift
//  Almnabr
//
//  Created by Hany Alkahlout on 03/01/2023.
//  Copyright © 2023 Samar Akkila. All rights reserved.
//

import UIKit
import SCLAlertView
class AccountTaxViewController: UIViewController {
    
    @IBOutlet weak var itemTaxStackView: UIStackView!
    @IBOutlet weak var globalTaxStackView: UIStackView!
    @IBOutlet weak var itemDiscountStackView: UIStackView!
    @IBOutlet weak var globalItemDiscountStackView: UIStackView!
    
    
    @IBOutlet weak var itemTaxButton: UIButton!
    @IBOutlet weak var globalTaxButton: UIButton!
    @IBOutlet weak var itemDiscountButton: UIButton!
    @IBOutlet weak var globalItemDiscountButton: UIButton!
    private var observer:NSObjectProtocol?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        initialization()
    }
   
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        getData()
        observer = NotificationCenter.default.addObserver(forName: .init("ReloadAccountTax"), object: nil, queue: .main) { notify in
            self.getData()
        }
    }

    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        NotificationCenter.default.removeObserver(observer!)
    }
    
    
    private func initialization(){
        setUpRaduoButtons()
    }
    
    
    private func setUpRaduoButtons(){
        itemTaxStackView.addTapGesture {
            self.itemTaxButton.isSelected = !self.itemTaxButton.isSelected
        }
        globalTaxStackView.addTapGesture {
            self.globalTaxButton.isSelected = !self.globalTaxButton.isSelected
        }
        itemDiscountStackView.addTapGesture {
            self.itemDiscountButton.isSelected = !self.itemDiscountButton.isSelected
        }
        globalItemDiscountStackView.addTapGesture {
            self.globalItemDiscountButton.isSelected = !self.globalItemDiscountButton.isSelected
        }
    }

    
    @IBAction func updateAction(_ sender: Any) {
        updateAccountTaxSettings()
    }
    
}


// MARK: - API Handling
extension AccountTaxViewController{
    private func getData(){
        showLoadingActivity()
        APIController.shard.getAccountTaxsData(branch_id: AccountSettingsViewController.branch_id) { data in
            DispatchQueue.main.async {
                self.hideLoadingActivity()
                if let status = data.status,status{
                    self.itemTaxButton.isSelected = data.records?.item_tax ?? "" == "1"
                    self.globalTaxButton.isSelected = data.records?.global_tax ?? "" == "1"
                    self.itemDiscountButton.isSelected = data.records?.item_discount ?? "" == "1"
                    self.globalItemDiscountButton.isSelected = data.records?.global_discount ?? "" == "1"
                }else{
                    self.itemTaxButton.isSelected = false
                    self.globalTaxButton.isSelected = false
                    self.itemDiscountButton.isSelected = false
                    self.globalItemDiscountButton.isSelected = false
                }
            }
        }
    }
    
    
    private func updateAccountTaxSettings(){
        APIController.shard.updateAccountTaxSettings(branch_id: AccountSettingsViewController.branch_id,
                                                     item_tax: itemTaxButton.isSelected ? "1" : "0",
                                                     global_tax: globalTaxButton.isSelected ? "1" : "0",
                                                     item_discount: itemDiscountButton.isSelected ? "1" : "0",
                                                     global_discount: globalItemDiscountButton.isSelected ? "1" : "0") { data in
            if let status = data.status,status{
                SCLAlertView().showSuccess("Success".localized(), subTitle: data.msg ?? "")
            }else{
                SCLAlertView().showSuccess("error".localized(), subTitle: data.error ?? "There ")
            }
        }
        
    }
    
    
    
}
