//
//  TrialBalanceViewController.swift
//  Almnabr
//
//  Created by Hany Alkahlout on 02/03/2023.
//  Copyright © 2023 Samar Akkila. All rights reserved.
//

import UIKit
import DropDown
import Fastis
class TrialBalanceViewController: UIViewController {
    
    
    @IBOutlet weak var headerTitleLabel: UILabel!
    @IBOutlet weak var headerView: HeaderView!
    @IBOutlet weak var branchSelectorStaclView: UIStackView!
    @IBOutlet weak var mainStackView: UIStackView!
    @IBOutlet weak var generalTrialBalanceStackView: UIStackView!
    @IBOutlet weak var generalTrialBalanceButton: UIButton!
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
    var isCostSummary = false
    
    
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
        headerTitleLabel.text = isCostSummary ? "Cost Summary" : "Trial Balance"
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
        branchSelectorStaclView.addArrangedSubview(branchSelector!)
    }
    
    private func setUpRaduoButtons(){
        generalTrialBalanceStackView.addTapGesture {
            self.accountTrailBalanceButton.isSelected = false
            self.accountCodeLevelButton.isSelected = false
            self.generalTrialBalanceButton.isSelected = true
            self.accountCodeLevelView.isHidden = !self.accountCodeLevelButton.isSelected
        }
        
        accountTrailBalanceStackView.addTapGesture {
            self.accountTrailBalanceButton.isSelected = true
            self.accountCodeLevelButton.isSelected = false
            self.generalTrialBalanceButton.isSelected = false
            self.accountCodeLevelView.isHidden = !self.accountCodeLevelButton.isSelected
        }
        accountCodeLevelStackView.addTapGesture {
            self.accountTrailBalanceButton.isSelected = false
            self.accountCodeLevelButton.isSelected = true
            self.generalTrialBalanceButton.isSelected = false
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
    
    
    @IBAction func accountTrailBalanceButtonAction(_ sender: Any) {
        accountTrailBalanceButton.isSelected = true
        accountCodeLevelButton.isSelected = false
        generalTrialBalanceButton.isSelected = false
        
        accountCodeLevelView.isHidden = !accountCodeLevelButton.isSelected
    }
    
    
    @IBAction func generalTrialBalanceButtonAction(_ sender: Any) {
        accountTrailBalanceButton.isSelected = false
        accountCodeLevelButton.isSelected = false
        generalTrialBalanceButton.isSelected = true
        
        
        
        accountCodeLevelView.isHidden = !accountCodeLevelButton.isSelected
    }
    
    
    @IBAction func accountCodeLevelButtonAction(_ sender: Any) {
        accountTrailBalanceButton.isSelected = false
        accountCodeLevelButton.isSelected = true
        generalTrialBalanceButton.isSelected = false
        accountCodeLevelView.isHidden = !accountCodeLevelButton.isSelected
    }
    
    
    @IBAction func submitAction(_ sender: Any) {
        let vc = AccountsTrialResultViewController()
        vc.url = isCostSummary ? "cost_summary" : "trial_balance"
        vc.body = [
            "branch_id": branch_id,
            "finance_id": finance_id,
            "report_type": accountCodeLevelButton.isSelected ? "ALEVEL" : generalTrialBalanceButton.isSelected ? "GTRAIL" : "ATRAIL",
            "account_level": accountCodeLevelButton.isSelected ? selectedLevel : "" ,
            "period_from": periodFromTextField.text!,
            "period_to": periodToTextField.text!
        ]
        let nav = UINavigationController(rootViewController: vc)
        navigationController?.present(nav, animated: true)
    }
    
    
}





