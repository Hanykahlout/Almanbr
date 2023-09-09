//
//  AccountsTrialViewController.swift
//  Almnabr
//
//  Created by Hany Alkahlout on 27/02/2023.
//  Copyright © 2023 Samar Akkila. All rights reserved.
//

import UIKit
import Fastis
import DropDown
import FAPanels
class AccountsTrialViewController: UIViewController {

    @IBOutlet weak var headerView: HeaderView!
    @IBOutlet weak var branchSelectorStackView: UIStackView!
    @IBOutlet weak var mainStackView: UIStackView!
    @IBOutlet weak var accountTrailBalanceStackView: UIStackView!
    @IBOutlet weak var accountTrailBalanceButton: UIButton!
    @IBOutlet weak var accountCodeLevelStackView: UIStackView!
    @IBOutlet weak var accountCodeLevelButton: UIButton!
    @IBOutlet weak var periodFromTextField: UITextField!
    @IBOutlet weak var periodToTextField: UITextField!
    @IBOutlet weak var accountCodeLevelTextField: UITextField!
    @IBOutlet weak var accountCodeLevelArrow: UIImageView!
    @IBOutlet weak var accountCodeLevelView: UIView!
    
    private var fastisController = FastisController(mode: .single)
    private var isFromDate = true
    private let levelsDropDown = DropDown()
    private var selectedLevel = ""

    
    var branch_id = ""
    var finance_id = ""
    var branchSelector:BranchSelection?
    
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
            self?.mainStackView.isHidden = branch_id == ""
        }
        branchSelector?.financialYearSelectionAction = { [weak self] finance_id in
            self?.finance_id = finance_id
        }
        branchSelectorStackView.addArrangedSubview(branchSelector!)
    }
    
    private func setUpRaduoButtons(){
        accountTrailBalanceStackView.addTapGesture {
            self.accountTrailBalanceButton.isSelected = !self.accountTrailBalanceButton.isSelected
            self.accountCodeLevelButton.isSelected = !self.accountTrailBalanceButton.isSelected
            self.accountCodeLevelView.isHidden = !self.accountCodeLevelButton.isSelected
        }
        accountCodeLevelStackView.addTapGesture {
            self.accountCodeLevelButton.isSelected = !self.accountCodeLevelButton.isSelected
            self.accountTrailBalanceButton.isSelected = !self.accountCodeLevelButton.isSelected
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
    
    private func transationAction(_ data:GeneralLedgerRecord){
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
    
    
    @IBAction func accountTrailBalanceButtonAction(_ sender: Any) {
        accountTrailBalanceButton.isSelected = !accountTrailBalanceButton.isSelected
        accountCodeLevelButton.isSelected = !accountTrailBalanceButton.isSelected
        accountCodeLevelView.isHidden = !accountCodeLevelButton.isSelected
    }
    
    
    @IBAction func accountCodeLevelButtonAction(_ sender: Any) {
        accountCodeLevelButton.isSelected = !accountCodeLevelButton.isSelected
        accountTrailBalanceButton.isSelected = !accountCodeLevelButton.isSelected
        accountCodeLevelView.isHidden = !accountCodeLevelButton.isSelected
    }
    
    
    @IBAction func submitAction(_ sender: Any) {
        let vc = AccountsTrialResultViewController()
        vc.transactionButtonAction = transationAction
        vc.branch_id = branch_id
        vc.finance_id = finance_id
        vc.url = "account_trial"
        vc.body = [
            "branch_id": branch_id,
            "finance_id": finance_id,
            "report_type": accountCodeLevelButton.isSelected ? "ALEVEL" : "ATRAIL",
            "account_level": accountCodeLevelButton.isSelected ? selectedLevel : "" ,
            "period_from": periodFromTextField.text!,
            "period_to": periodToTextField.text!
        ]
        let nav = UINavigationController(rootViewController: vc)
        navigationController?.present(nav, animated: true)
    }
    
    
}


