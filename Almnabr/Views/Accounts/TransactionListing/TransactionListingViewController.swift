//
//  TransactionListingViewController.swift
//  Almnabr
//
//  Created by Hany Alkahlout on 07/03/2023.
//  Copyright © 2023 Samar Akkila. All rights reserved.
//

import UIKit
import DropDown
import Fastis

class TransactionListingViewController: UIViewController {
    
    @IBOutlet weak var headerView: HeaderView!
    @IBOutlet weak var branchSelectorStackView: UIStackView!
    
    
    @IBOutlet weak var mainStackView: UIStackView!
    @IBOutlet weak var accountFromTextField: UITextField!
    @IBOutlet weak var accountFromArrow: UIImageView!
    @IBOutlet weak var accountToTextField: UITextField!
    
    @IBOutlet weak var accountToArrow: UIImageView!
    @IBOutlet weak var periodFromTextField: UITextField!
    @IBOutlet weak var periodToTextField: UITextField!
    
    @IBOutlet weak var transactionTypeTextField: UITextField!
    
    @IBOutlet weak var transactionTypeArrow: UIImageView!
    
    
    private var accountFromDropDown = DropDown()
    private var accountToDropDown = DropDown()
    private var transactionTypeDropDown = DropDown()
    private var accountFromResult = [SearchBranchRecords]()
    private var accountToResult = [SearchBranchRecords]()
    private var fastisController = FastisController(mode: .single)
    private var isFromDate = true
    private var selectedTransactionType = ""
    
    var selectedAccountFrom: SearchBranchRecords?
    var selectedAccountTo: SearchBranchRecords?
    var branch_id = ""
    var finance_id = ""
    var branchSelector:BranchSelection?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        handleHeaderView()
        periodFromTextField.addTapGesture {
            self.fastisController.present(above: self)
            self.isFromDate = true
        }
        periodToTextField.addTapGesture {
            self.fastisController.present(above: self)
            self.isFromDate = false
        }
        
        setUpDropDown()
        setUpFastisController()
        let year = Calendar.current.component(.year, from: Date())
        periodFromTextField.text = "\(year)/1/1"
        periodToTextField.text = "\(year)/12/31"
        
        accountFromTextField.addTarget(self, action: #selector(accountFromAction), for: .editingChanged)
        accountToTextField.addTarget(self, action: #selector(accountToAction), for: .editingChanged)
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        setUpBranchSelector()
    }
    
    
    private func handleHeaderView(){
        headerView.btnAction = {
            let language =  L102Language.currentAppleLanguage()
            if language == "ar"{
                self.panel?.openRight(animated: true)
            }else{
                self.panel?.openLeft(animated: true)
            }
        }
    }
    
    private func setUpBranchSelector(){
        branchSelector = BranchSelection()
        branchSelector?.selecetdBranchId = branch_id
        branchSelector?.selecetdfinancialYear = finance_id
        branchSelector!.withFinancialYearSelection = true
        branchSelector!.branchSelectionAction = { [weak self] branch_id in
            self?.branch_id = branch_id
            self?.getAccounts()
        }
        branchSelector?.financialYearSelectionAction = { [weak self] finance_id in
            self?.finance_id = finance_id
            self?.mainStackView.isHidden = self?.branch_id == ""
        }
        branchSelectorStackView.addArrangedSubview(branchSelector!)
    }
    
    private func setUpFastisController(){
        fastisController.title = "Choose Date".localized()
        fastisController.allowToChooseNilDate = true
        fastisController.shortcuts = [.today]
        fastisController.doneHandler = { result in
            if self.isFromDate{
                self.periodFromTextField.text = self.formatedDate(date: result)
            }else{
                self.periodToTextField.text = self.formatedDate(date: result)
            }
        }
    }
    
    
    private func setUpDropDown(){
        //  accountFromDropDown
        
        accountFromDropDown.anchorView = accountFromTextField
        accountFromDropDown.bottomOffset = CGPoint(x: 0, y:(accountFromDropDown.anchorView?.plainView.bounds.height)!)
        
        accountFromDropDown.selectionAction = { [unowned self] (index: Int, item: String) in
            accountFromArrow.transform = .init(rotationAngle: 0)
            selectedAccountFrom = accountFromResult[index]
            accountFromTextField.placeholder = item
            accountFromTextField.text = ""
        }
        
        accountFromDropDown.cancelAction = { [unowned self] in
            accountFromArrow.transform = .init(rotationAngle: 0)
            accountFromTextField.text = ""
        }
        
        //  accountToDropDown
        accountToDropDown.anchorView = accountToTextField
        accountToDropDown.bottomOffset = CGPoint(x: 0, y:(accountToDropDown.anchorView?.plainView.bounds.height)!)
        
        accountToDropDown.selectionAction = { [unowned self] (index: Int, item: String) in
            accountToArrow.transform = .init(rotationAngle: 0)
            selectedAccountTo = accountToResult[index]
            accountToTextField.placeholder = item
            accountToTextField.text = ""
        }
        
        accountToDropDown.cancelAction = { [unowned self] in
            accountToArrow.transform = .init(rotationAngle: 0)
            accountToTextField.text = ""
        }
        
        //        transactionTypeDropDown
        transactionTypeDropDown.anchorView = transactionTypeTextField
        transactionTypeDropDown.bottomOffset = CGPoint(x: 0, y:(transactionTypeDropDown.anchorView?.plainView.bounds.height)!)
        transactionTypeDropDown.dataSource = ["All","Receipts","Payments","Journal Voucher","Selling Invoices","Purchase Invoice"]
        transactionTypeDropDown.selectionAction = { [unowned self] (index: Int, item: String) in
            transactionTypeArrow.transform = .init(rotationAngle: 0)
            transactionTypeTextField.text = item
            
            switch index {
            case 0:
                self.selectedTransactionType = ""
            case 1:
                self.selectedTransactionType = "REC"
            case 2:
                self.selectedTransactionType = "PAY"
            case 3:
                self.selectedTransactionType = "JRN"
            case 4:
                self.selectedTransactionType = "SIV"
            case 5:
                self.selectedTransactionType = "PIV"
            default:
                break
            }
            
        }
        
        transactionTypeDropDown.cancelAction = { [unowned self] in
            transactionTypeArrow.transform = .init(rotationAngle: 0)
        }
        
        transactionTypeTextField.addTapGesture {
            self.transactionTypeArrow.transform = .init(rotationAngle: .pi)
            self.transactionTypeDropDown.show()
        }
    }
    
    
    private func submitDataAction(){
        let vc = TransactionListingResultViewController()
        vc.transactionButtonAction = transationAction
        var body:[String:Any] = [
            "branch_id": branch_id,
            "period_from": periodFromTextField.text!,
            "period_to": periodToTextField.text!,
            "transaction_listing":selectedTransactionType,
            "account_code_from": selectedAccountFrom?.value ?? "",
            "account_code_to": selectedAccountTo?.value ?? ""
        ]
        vc.body = body
        let nav = UINavigationController(rootViewController: vc)
        navigationController?.present(nav, animated: true)
    }
    
    private func transationAction(_ data:ReceiptTransaction){
        navigationController?.dismiss(animated: true)
        let vc = StatementAccountsViewController()
        vc.branch_id = branch_id
        vc.finance_id = finance_id
        vc.selectedAccountFrom = .init(label: data.account_name ?? "", value: data.account_cost_id ?? "")
        vc.selectedAccountTo = .init(label: data.account_name ?? "", value: data.account_cost_id ?? "")
        vc.isShowingDirectly = true
        let nav = UINavigationController(rootViewController: vc)
        nav.isNavigationBarHidden = true
        nav.modalPresentationStyle = .fullScreen
        panel?.center(nav)
    }
    
    @objc private func accountFromAction(){
        self.searchForAccount(isAccountFrom: true)
    }
    
    @objc private func accountToAction(){
        self.searchForAccount(isAccountFrom: false)
    }
    
    
    
    @IBAction func submitAction(_ sender: Any) {
        
        submitDataAction()
    }
}

// MARK: - API Handling
extension TransactionListingViewController{
    private func searchForAccount(isAccountFrom:Bool){
        let body:[String:Any] = [
            "finance_id": finance_id,
            "search_text": isAccountFrom ? accountFromTextField.text! : accountToTextField.text!,
            "branch_id": branch_id,
            "status": "0"
        ]
        
        showLoadingActivity()
        APIController.shard.searchForAccount(body:body) { data in
            DispatchQueue.main.async { [weak self] in
                self?.hideLoadingActivity()
                if data.status ?? false{
                    if isAccountFrom{
                        self?.accountFromResult = data.records ?? []
                    }else{
                        self?.accountToResult = data.records ?? []
                    }
                }else{
                    if isAccountFrom{
                        self?.accountFromResult.removeAll()
                    }else{
                        self?.accountToResult.removeAll()
                    }
                }
                if isAccountFrom{
                    self?.accountFromDropDown.dataSource = self?.accountFromResult.map{$0.label ?? ""} ?? []
                    self?.accountFromDropDown.show()
                    self?.accountFromArrow.transform = .init(rotationAngle: 0)
                }else{
                    self?.accountToDropDown.dataSource = self?.accountToResult.map{$0.label ?? ""} ?? []
                    self?.accountToDropDown.show()
                    self?.accountToArrow.transform = .init(rotationAngle: 0)
                }
                
            }
        }
    }
    
    private func getAccounts(){
        showLoadingActivity()
        APIController.shard.getAccounts(branch_id: branch_id, status: "0") { data in
            DispatchQueue.main.async { [weak self] in
                self?.hideLoadingActivity()
                if data.status ?? false{
                    self?.accountFromResult = data.records ?? []
                    self?.accountToResult = data.records ?? []
                }else{
                    self?.accountFromResult.removeAll()
                    self?.accountToResult.removeAll()
                }
                
                self?.accountFromDropDown.dataSource = self?.accountFromResult.map{$0.label ?? ""} ?? []
                self?.accountToDropDown.dataSource = self?.accountToResult.map{$0.label ?? ""} ?? []
                
            }
        }
    }
    
    
}
