//
//  BalanceSheetsViewController.swift
//  Almnabr
//
//  Created by Hany Alkahlout on 04/03/2023.
//  Copyright © 2023 Samar Akkila. All rights reserved.
//

import UIKit
import Fastis
import DropDown
import FAPanels
class BalanceSheetsViewController: UIViewController {
    
    @IBOutlet weak var headerTitleLabel: UILabel!
    @IBOutlet weak var headerView: HeaderView!
    @IBOutlet weak var mainStackView: UIStackView!
    @IBOutlet weak var branchSelectorStackView: UIStackView!
    @IBOutlet weak var basedGeneralLedgerStackView: UIStackView!
    @IBOutlet weak var basedGeneralLedgerButtin: UIButton!
    @IBOutlet weak var basedAccountsStackView: UIStackView!
    @IBOutlet weak var basedAccountsButton: UIButton!
    @IBOutlet weak var accountCodeLevelStackView: UIStackView!
    @IBOutlet weak var accountCodeLevelButton: UIButton!
    @IBOutlet weak var previousYearSwitch: UISwitch!
    @IBOutlet weak var periodFromTextField: UITextField!
    @IBOutlet weak var periodToTextField: UITextField!
    @IBOutlet weak var accountCodeLevelView: UIView!
    @IBOutlet weak var accountCodeLevelTextField: UITextField!
    @IBOutlet weak var accountCodeLevelArrow: UIImageView!
    
    
    private var fastisController = FastisController(mode: .single)
    private var isFromDate = true
    private let levelsDropDown = DropDown()
    private var selectedLevel = ""
    var branch_id = ""
    var finance_id = ""
    var branchSelector:BranchSelection?
    var isBalanceSheets = true
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        handleHeaderView()
        setUpBranchSelector()
        setUpRaduoButtons()
        setUpFastisController()
        setUpDropDownList()
        
        periodFromTextField.addTapGesture {
            self.fastisController.present(above: self)
            self.isFromDate = true
        }
        
        periodToTextField.addTapGesture {
            self.fastisController.present(above: self)
            self.isFromDate = false
        }
        
        accountCodeLevelTextField.addTapGesture {
            self.accountCodeLevelArrow.transform = .init(rotationAngle: .pi)
            self.levelsDropDown.show()
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        headerTitleLabel.text = isBalanceSheets ? "Balance Sheets" : "Profit & Loss Statements"
        
    }
    
    
    private func setUpDropDownList(){
    //  levelsDropDown
        levelsDropDown.anchorView = accountCodeLevelTextField
        levelsDropDown.cornerRadius = 10
        levelsDropDown.bottomOffset = CGPoint(x: 0, y:(levelsDropDown.anchorView?.plainView.bounds.height)!)
        
        for i in 1...9{
            levelsDropDown.dataSource.append("Level \(i)")
        }
        levelsDropDown.selectionAction = { [unowned self] (index: Int, item: String) in
            accountCodeLevelArrow.transform = .init(rotationAngle: 0)
            accountCodeLevelTextField.text = item
            selectedLevel = String(index + 1)
        }
        
        levelsDropDown.cancelAction = { [unowned self] in
            accountCodeLevelArrow.transform = .init(rotationAngle: 0)
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
        }
        branchSelector?.financialYearSelectionAction = { [weak self] finance_id in
            self?.finance_id = finance_id
            self?.mainStackView.isHidden = self?.branch_id == ""
        }
        branchSelectorStackView.addArrangedSubview(branchSelector!)
    }
    
    private func setUpRaduoButtons(){
        basedGeneralLedgerStackView.addTapGesture {
            self.basedGeneralLedgerButtin.isSelected = true
            self.basedAccountsButton.isSelected = false
            self.accountCodeLevelButton.isSelected = false
            self.accountCodeLevelView.isHidden = !self.accountCodeLevelButton.isSelected
        }
        
        basedAccountsStackView.addTapGesture {
            self.basedGeneralLedgerButtin.isSelected = false
            self.basedAccountsButton.isSelected = true
            self.accountCodeLevelButton.isSelected = false
            self.accountCodeLevelView.isHidden = !self.accountCodeLevelButton.isSelected
        }
        accountCodeLevelStackView.addTapGesture {
            self.basedGeneralLedgerButtin.isSelected = false
            self.basedAccountsButton.isSelected = false
            self.accountCodeLevelButton.isSelected = true
            self.accountCodeLevelView.isHidden = !self.accountCodeLevelButton.isSelected
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
    
    private func transactionButtonAction(_ data:AssetsRecord){
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
    
    
    @IBAction func basedGeneralLedgerAction(_ sender: Any) {
        self.basedGeneralLedgerButtin.isSelected = true
        self.basedAccountsButton.isSelected = false
        self.accountCodeLevelButton.isSelected = false
        self.accountCodeLevelView.isHidden = !self.accountCodeLevelButton.isSelected
    }
    
    
    @IBAction func basedAccountsAction(_ sender: Any) {
        self.basedGeneralLedgerButtin.isSelected = false
        self.basedAccountsButton.isSelected = true
        self.accountCodeLevelButton.isSelected = false
        self.accountCodeLevelView.isHidden = !self.accountCodeLevelButton.isSelected
    }
    
    
    @IBAction func accountCodeLevelAction(_ sender: Any) {
        self.basedGeneralLedgerButtin.isSelected = false
        self.basedAccountsButton.isSelected = false
        self.accountCodeLevelButton.isSelected = true
        self.accountCodeLevelView.isHidden = !self.accountCodeLevelButton.isSelected
    }
    
    @IBAction func submitAction(_ sender: Any) {
        let vc = BalanceSheetsResultViewController()
        vc.transactionButtonAction = transactionButtonAction
        vc.branch_id = branch_id
        vc.finance_id = finance_id
        vc.url = isBalanceSheets ? "balance_sheets" : "profit_loss"
        vc.isBalanceSheets = isBalanceSheets
        vc.isComparePreviousYear = previousYearSwitch.isOn
        vc.body = [
            "branch_id": branch_id,
            "finance_id": finance_id,
            "report_type": basedGeneralLedgerButtin.isSelected ? "GLEDGER" : basedAccountsButton.isSelected ? "ALEDGER" : "ALEVEL",
            "account_level": accountCodeLevelButton.isSelected ? selectedLevel : "" ,
            "compare_previous_year": previousYearSwitch.isOn ? "1" : "0",
            "period_from": periodFromTextField.text!,
            "period_to": periodToTextField.text!
        ]
        let nav = UINavigationController(rootViewController: vc)
        nav.modalPresentationStyle = .fullScreen
        navigationController?.present(nav, animated: true)
    }
    
}
