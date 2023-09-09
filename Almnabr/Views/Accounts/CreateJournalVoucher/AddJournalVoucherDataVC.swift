//
//  AddJournalVoucherDataVC.swift
//  Almnabr
//
//  Created by Hany Alkahlout on 16/02/2023.
//  Copyright © 2023 Samar Akkila. All rights reserved.
//

import UIKit
import DropDown
class AddJournalVoucherDataVC: UIViewController {

    
    @IBOutlet weak var accountCodeTextField: UITextField!
    @IBOutlet weak var accountCodeArrow: UIImageView!
    @IBOutlet weak var debitAmountTextField: UITextField!
    @IBOutlet weak var creditAmountTextField: UITextField!
    @IBOutlet weak var descriptionTextField: UITextField!
    @IBOutlet weak var referenceNoTextField: UITextField!
    @IBOutlet weak var notesTextField: UITextField!
    
    private var dropDown = DropDown()
    private var accounts = [SearchBranchRecords]()
    private var selectedAccountCode:SearchBranchRecords?
    var data:JournalVoucherData?
    var branchId = ""
    var finance_id = ""
    var index:Int?
    var addAction : ((_ data:JournalVoucherData,_ index:Int?)->Void)?
    override func viewDidLoad() {
        super.viewDidLoad()
        initialization()
        // Do any additional setup after loading the view.
    }
    
    private func initialization(){
        setUpDropDwonlist()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(false, animated: true)
        let cancelButton = UIButton(type: .system)
        cancelButton.setTitle("Cancel", for: .normal)
        cancelButton.setTitleColor(.white, for: .normal)
        cancelButton.addTarget(self, action: #selector(cancelAction), for: .touchUpInside)
        navigationItem.leftBarButtonItem = .init(customView:cancelButton)
        addNavigationBarTitle(navigationTitle: "Add Journal Voucher Data")
        accountCodeTextField.addTarget(self, action: #selector(searchAccountCode), for: .editingChanged)
        
        if let data = data{
            accountCodeTextField.placeholder = data.accountCode?.label ?? ""
            selectedAccountCode = data.accountCode
            debitAmountTextField.text = data.debitAmount ?? ""
            creditAmountTextField.text = data.creditAmount ?? ""
            descriptionTextField.text = data.description ?? ""
            referenceNoTextField.text = data.referenceNo ?? ""
            notesTextField.text = data.notes ?? ""
        }
    }
    
    private func setUpDropDwonlist(){
        dropDown.anchorView = accountCodeTextField
        dropDown.bottomOffset = CGPoint(x: 0, y:(dropDown.anchorView?.plainView.bounds.height)!)
        
        dropDown.selectionAction = { [unowned self] (index: Int, item: String) in
            accountCodeArrow.transform = .init(rotationAngle: 0)
            selectedAccountCode = accounts[index]
            accountCodeTextField.placeholder = item
            accountCodeTextField.text = ""
        }
        
        dropDown.cancelAction = { [unowned self] in
            accountCodeArrow.transform = .init(rotationAngle: 0)
            accountCodeTextField.text = ""
        }
        
        debitAmountTextField.delegate = self
        creditAmountTextField.delegate = self
    }
    
    
    @objc private func cancelAction(){
        navigationController?.dismiss(animated: true)
    }

    
    
    @IBAction func costCenterAction(_ sender: Any) {
        let vc = SubmitCostCenteAlertVC()
        vc.data = data?.costCenter ?? []
        vc.branchId = branchId
        vc.total = debitAmountTextField.text! == "0.0" ? creditAmountTextField.text! : debitAmountTextField.text!
        vc.submitDataAction = { [weak self] data in
            if self?.data != nil{
                self?.data!.costCenter = data
            }else{
                self?.data = .init(costCenter:data)
            }
        }
        let nav = UINavigationController(rootViewController: vc)
        nav.modalPresentationStyle = .overCurrentContext
        navigationController?.present(nav, animated: true)
    }
    
    
    @IBAction func addAction(_ sender: Any) {
        let data = JournalVoucherData(accountCode: selectedAccountCode,debitAmount: debitAmountTextField.text,creditAmount: creditAmountTextField.text,description: descriptionTextField.text, costCenter: data?.costCenter ?? [],referenceNo: referenceNoTextField.text, notes: notesTextField.text)
        addAction?(data,index)
        navigationController?.dismiss(animated: true)
    }
    
}

// MARK: - API Handling
extension AddJournalVoucherDataVC{
    @objc private func searchAccountCode(){
        APIController.shard.searchForCardAccount(branch_id: branchId , finance_id: finance_id, search_text: accountCodeTextField.text!) { data in
            DispatchQueue.main.async { [weak self] in
                if data.status ?? false{
                    let records = data.records ?? []
                    self?.accounts = records
                    self?.dropDown.dataSource = records.map{$0.label ?? ""}
                    self?.dropDown.show()
                    self?.accountCodeArrow.transform = .init(rotationAngle: .pi)
                }
            }
        }
    }
}


extension AddJournalVoucherDataVC:UITextFieldDelegate{
    func textFieldDidBeginEditing(_ textField: UITextField) {
        if textField == debitAmountTextField {
            creditAmountTextField.text = "0.0"
        }else{
            debitAmountTextField.text = "0.0"
        }
    }
}






