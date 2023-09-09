//
//  BankDetailsViewController.swift
//  Almnabr
//
//  Created by Hany Alkahlout on 08/06/2022.
//  Copyright © 2022 Samar Akkila. All rights reserved.
//

import UIKit
import DropDown
class BankDetailsViewController: UIViewController {

    @IBOutlet weak var addressNumberTextField: UITextField!
    
    @IBOutlet weak var bankNameTextField: UITextField!
    @IBOutlet weak var bankNameArrow: UIImageView!
    private var banksData = [SearchBranchRecords]()
    private var banksDropDown = DropDown()

    private var selectedBankCode = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        initlization()
    
    }

    private func initlization(){
        setEditBodyData()
        addSubmitObserver()
        setUpDropDown()
        getBanksData()
    }
    
    
    private func setEditBodyData(){
        self.addressNumberTextField.text! = EditEmployeeDetailsVC.editBody.account_number
        self.selectedBankCode = EditEmployeeDetailsVC.editBody.bank_short_code
        self.bankNameTextField.text = self.banksData.filter{$0.value == EditEmployeeDetailsVC.editBody.bank_short_code}.first?.label ?? ""
    }


    private func addSubmitObserver(){
        NotificationCenter.default.addObserver(forName: NSNotification.Name("Submit3"), object: nil, queue: .main) { notifi in
            print("Submit3")
            EditEmployeeDetailsVC.editBody.account_number = self.addressNumberTextField.text!
            EditEmployeeDetailsVC.editBody.bank_short_code = self.selectedBankCode
        }
    }
    
    
    private func setUpDropDown(){
        bankNameTextField.isUserInteractionEnabled = true
        bankNameTextField.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(bankNameTextFieldAction)))
        
        // banksDropDown
        banksDropDown.anchorView = bankNameTextField
        banksDropDown.bottomOffset = CGPoint(x: 0, y:(banksDropDown.anchorView?.plainView.bounds.height)!)
        
        banksDropDown.selectionAction = { [unowned self] (index: Int, item: String) in
            bankNameArrow.transform = .init(rotationAngle: 0)
            self.bankNameTextField.text = item
            self.selectedBankCode = self.banksData[index].value ?? ""
        }
        
        banksDropDown.cancelAction = { [unowned self] in
            bankNameArrow.transform = .init(rotationAngle: 0)
        }
    }
    
    
    @objc private func bankNameTextFieldAction(){
        banksDropDown.show()
    }
    
    
}


// MARK: - API Handling
extension BankDetailsViewController{
    private func getBanksData(){
        APIController.shard.getBankData { data in
            if let status = data.status , status{
                self.banksData = data.banks ?? []
                self.banksDropDown.dataSource = (data.banks ?? []).map{$0.label ?? ""}
            }
        }
    }
}
