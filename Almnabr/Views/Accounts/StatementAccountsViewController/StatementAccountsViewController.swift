//
//  StatementAccountsViewController.swift
//  Almnabr
//
//  Created by Hany Alkahlout on 26/02/2023.
//  Copyright © 2023 Samar Akkila. All rights reserved.
//

import UIKit
import DropDown
import Fastis
class StatementAccountsViewController: UIViewController {
    @IBOutlet weak var headerTitleLabel: UILabel!
    @IBOutlet weak var headerView: HeaderView!
    @IBOutlet weak var branchSelectorStackView: UIStackView!
    
    
    @IBOutlet weak var mainStackView: UIStackView!
    @IBOutlet weak var allRaduoButtonStackView: UIStackView!
    @IBOutlet weak var allRaduoButton: UIButton!
    @IBOutlet weak var particularRaduoButton: UIButton!
    @IBOutlet weak var particularRaduoButtonStackView: UIStackView!
    @IBOutlet weak var accountFromTextField: UITextField!
    @IBOutlet weak var accountFromView: UIView!
    @IBOutlet weak var accountFromArrow: UIImageView!
    @IBOutlet weak var accountToTextField: UITextField!
    @IBOutlet weak var accountToView: UIView!
    
    @IBOutlet weak var accountToArrow: UIImageView!
    @IBOutlet weak var periodFromTextField: UITextField!
    @IBOutlet weak var periodToTextField: UITextField!
    
    private var accountFromDropDown = DropDown()
    private var accountToDropDown = DropDown()
    private var accountFromResult = [SearchBranchRecords]()
    private var accountToResult = [SearchBranchRecords]()
    private var fastisController = FastisController(mode: .single)
    private var isFromDate = true
    
    var selectedAccountFrom: SearchBranchRecords?
    var selectedAccountTo: SearchBranchRecords?
    var branch_id = ""
    var finance_id = ""
    var branchSelector:BranchSelection?
    var isShowingDirectly = false
    var type:StatmentType = .account
    
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
        setUpRaduoButtons()
        setUpFastisController()
        let year = Calendar.current.component(.year, from: Date())
        periodFromTextField.text = "\(year)/1/1"
        periodToTextField.text = "\(year)/12/31"
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        setUpBranchSelector()
        if isShowingDirectly{
            allRaduoButton.isSelected = false
            particularRaduoButton.isSelected = true
            accountFromTextField.text = selectedAccountFrom?.label ?? ""
            accountToTextField.text = selectedAccountTo?.label ?? ""
            submitDataAction()
        }
        
        switch type {
        case .cost:
            accountFromTextField.addTapGesture {
                self.accountFromDropDown.show()
                self.accountFromArrow.transform = .init(rotationAngle: 0)
            }
            
            accountToTextField.addTapGesture {
                self.accountToDropDown.show()
                self.accountToArrow.transform = .init(rotationAngle: 0)
            }
            headerTitleLabel.text = "Statement Of Costs"
        case .account,.ledger:
            accountFromTextField.addTarget(self, action: #selector(accountFromAction), for: .editingChanged)
            accountToTextField.addTarget(self, action: #selector(accountToAction), for: .editingChanged)
            headerTitleLabel.text = type == .account ? "Statement Of Accounts" : "General Ledger"
            
        }
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
            if self?.type == .cost{
                self?.getAccounts()
            }
            
        }
        branchSelector?.financialYearSelectionAction = { [weak self] finance_id in
            self?.finance_id = finance_id
            self?.mainStackView.isHidden = self?.branch_id == ""
        }
        branchSelectorStackView.addArrangedSubview(branchSelector!)
    }
    
    private func setUpRaduoButtons(){
        allRaduoButtonStackView.addTapGesture {
            self.allRaduoButton.isSelected = !self.allRaduoButton.isSelected
            self.particularRaduoButton.isSelected = !self.allRaduoButton.isSelected
            self.accountFromView.isHidden = self.allRaduoButton.isSelected
            self.accountToView.isHidden = self.allRaduoButton.isSelected
        }
        particularRaduoButtonStackView.addTapGesture {
            self.particularRaduoButton.isSelected = !self.particularRaduoButton.isSelected
            self.allRaduoButton.isSelected = !self.particularRaduoButton.isSelected
            self.accountFromView.isHidden = self.allRaduoButton.isSelected
            self.accountToView.isHidden = self.allRaduoButton.isSelected
        }
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
        //        periodFromDropDown
        
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
    }
    
    private func submitDataAction(){
        let vc = StatementAccountsResultViewController()
        var body:[String:Any] = [
            "branch_id": branch_id,
            "finance_id": finance_id,
            "request_type": allRaduoButton.isSelected ? 1 : 0,
            "period_from": periodFromTextField.text!,
            "period_to": periodToTextField.text!
        ]
        
        if !allRaduoButton.isSelected{
            body["account_code_from"] = selectedAccountFrom?.value ?? ""
            body["account_code_to"] = selectedAccountTo?.value ?? ""
        }
        vc.type = type
        vc.requestBody = body
        let nav = UINavigationController(rootViewController: vc)
        navigationController?.present(nav, animated: true)
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
    
    
    @IBAction func particularRadioButtonAction(_ sender: Any) {
        self.particularRaduoButton.isSelected = !self.particularRaduoButton.isSelected
        self.allRaduoButton.isSelected = !self.particularRaduoButton.isSelected
        self.accountFromView.isHidden = self.allRaduoButton.isSelected
        self.accountToView.isHidden = self.allRaduoButton.isSelected
    }
    
    
    @IBAction func allRadioButtonAction(_ sender: Any) {
        self.allRaduoButton.isSelected = !self.allRaduoButton.isSelected
        self.particularRaduoButton.isSelected = !self.allRaduoButton.isSelected
        self.accountFromView.isHidden = self.allRaduoButton.isSelected
        self.accountToView.isHidden = self.allRaduoButton.isSelected
    }
    
    
}
// MARK: - API Handling
extension StatementAccountsViewController{
    private func searchForAccount(isAccountFrom:Bool){
        var body:[String:Any] = [
            "finance_id": finance_id,
            "search_text": isAccountFrom ? accountFromTextField.text! : accountToTextField.text!,
            "branch_id": branch_id
        ]
        
        body[type == .account ? "account_parent" : "status"] = "0"
        
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



enum StatmentType{
    case account, cost, ledger
}
