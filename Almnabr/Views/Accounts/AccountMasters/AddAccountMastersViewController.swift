//
//  AddAccountMastersViewController.swift
//  Almnabr
//
//  Created by Hany Alkahlout on 12/01/2023.
//  Copyright © 2023 Samar Akkila. All rights reserved.
//

import UIKit
import DropDown
import SCLAlertView
class AddAccountMastersViewController: UIViewController {
    
    @IBOutlet weak var headerLabel: UILabel!
    
    @IBOutlet weak var addAsRootView: UIView!
    @IBOutlet weak var addAsRootTextField: UITextField!
    @IBOutlet weak var addAsRootTextArrow: UIImageView!
    
    @IBOutlet weak var accountCreateTypeTextField: UITextField!
    @IBOutlet weak var accountCreateTypeArrow: UIImageView!
    @IBOutlet weak var accountCreateTypeView: UIView!
    
    
    @IBOutlet weak var titleEnTextField: UITextField!
    @IBOutlet weak var titleArTextField: UITextField!
    
    @IBOutlet weak var currenciesTextField: UITextField!
    @IBOutlet weak var currenciesArrow: UIImageView!
    
    @IBOutlet weak var accountTypeTextField: UITextField!
    @IBOutlet weak var accountTypeArrow: UIImageView!
    
    @IBOutlet weak var balanceSheetGroupTextField: UITextField!
    
    @IBOutlet weak var supportSubAccountTextField: UITextField!
    @IBOutlet weak var supportSubAccountArrow: UIImageView!
    
    @IBOutlet weak var VATNumberTextField: UITextField!
    
    
    @IBOutlet weak var costCenterSupportTextField: UITextField!
    @IBOutlet weak var costCenterSupportArrow: UIImageView!
    
    @IBOutlet weak var costCentersTextField: UITextField!
    @IBOutlet weak var costCentersArrow: UIImageView!
    @IBOutlet weak var costCentersView: UIView!
    @IBOutlet weak var costCentersCollectionView: UICollectionView!
    
    
    @IBOutlet weak var holdAccountSelectionStackView: UIStackView!
    @IBOutlet weak var holdAccountSelectionButton: UIButton!
    
    @IBOutlet weak var profitLossAccountSelectionStackView: UIStackView!
    @IBOutlet weak var profitLossAccountSelectionButton: UIButton!
    
    
    private let addAsRootDropDown = DropDown()
    private let accountCreateTypeDropDown = DropDown()
    private let currenciesDropDown = DropDown()
    private let accountTypeDropDown = DropDown()
    private let balanceSheetGroupDropDown = DropDown()
    private let supportSubAccountDropDown = DropDown()
    private let costCenterSupportDropDown = DropDown()
    private let costCentersDropDown = DropDown()
    
    private var currencies = [SearchBranchRecords]()
    private var accountTypes = [AccountTypesRecord]()
    private var balanceSheetGroups = [SearchBranchRecords]()
    private var costCenters = [SearchBranchRecords]()
    private var selectedCostCenters = [SearchBranchRecords]()
    
    private var selectedCurrencie:SearchBranchRecords?
    private var selectedAccountType:AccountTypesRecord?
    private var selectedBalanceSheetGroup:SearchBranchRecords?
    private var selectedAccountCreateType = ""
    
    var data: AccountMastersRecord?
    var index = -1
    var isEdit = false
    var dismissAction:(()->Void)?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        initialization()
        // Do any additional setup after loading the view.
    }
    
    
    private func initialization(){
        setUpDropDownLists()
        setUpCheckBoxs()
        setUpCollectionView()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        accountCreateTypeView.isHidden = isEdit ? true : data?.account_masters_support != "1"
        costCentersTextField.addTarget(self, action: #selector(costCentersAction), for: .editingChanged)
        getCurrencies()
        getAccountType()
       
    }
    
    
    private func setUpCheckBoxs(){
        holdAccountSelectionStackView.isUserInteractionEnabled = true
        profitLossAccountSelectionStackView.isUserInteractionEnabled = true
        holdAccountSelectionStackView.addTapGesture { [weak self] in
            self?.holdAccountSelectionButton.isSelected = !(self?.holdAccountSelectionButton.isSelected ?? true)
        }
        
        profitLossAccountSelectionStackView.addTapGesture { [weak self] in
            self?.profitLossAccountSelectionButton.isSelected = !(self?.profitLossAccountSelectionButton.isSelected ?? true)
        }
    }
    
    
    private func getEditData(){
        let account_masters_name_en = data?.account_masters_name_en ?? ""
        let account_masters_name_ar = data?.account_masters_name_ar ?? ""
        let currencyvalue = data?.currencyvalue ?? ""
        let accountvalue = data?.accountvalue ?? ""
        let account_masters_support = data?.account_masters_support ?? ""
        let hold_account_from_transaction = data?.hold_account_from_transaction ?? ""
        let set_profit_loss_account = data?.set_profit_loss_account ?? ""
        let account_vat_number = data?.account_vat_number ?? ""
        let cost_center_support = data?.cost_center_support ?? ""
        
        titleEnTextField.text = account_masters_name_en
        titleArTextField.text = account_masters_name_ar
        selectedCurrencie = currencies.first(where: {$0.value == currencyvalue})
        currenciesTextField.text = selectedCurrencie?.label ?? ""
        selectedAccountType = accountTypes.first(where: {$0.value == accountvalue})
        accountTypeTextField.text = selectedAccountType?.label ?? ""
        getBalanceSheetGroups(accountType: accountvalue)
        supportSubAccountTextField.text = account_masters_support == "1" ? "Yes" : "No"
        holdAccountSelectionButton.isSelected = hold_account_from_transaction == "1"
        profitLossAccountSelectionButton.isSelected = set_profit_loss_account == "1"
        VATNumberTextField.text = account_vat_number
        costCenterSupportTextField.text = cost_center_support == "1" ? "Yes" : "No"
        if cost_center_support == "1"{
            costCentersView.isHidden = false
            searchForCostCenter()
        }else{
            costCentersView.isHidden = true
        }
        
    }
    
    
    private func setUpDropDownLists(){
        //        addAsRootDropDown
        addAsRootDropDown.anchorView = addAsRootTextField
        addAsRootDropDown.bottomOffset = CGPoint(x: 0, y:(addAsRootDropDown.anchorView?.plainView.bounds.height)!)
        addAsRootDropDown.dataSource = ["Yes","No"]
        addAsRootDropDown.selectionAction = { [weak self] (index: Int, item: String) in
            self?.addAsRootTextArrow.transform = .init(rotationAngle: 0)
            self?.addAsRootTextField.text = item
        }
        
        addAsRootDropDown.cancelAction = { [unowned self] in
            addAsRootTextArrow.transform = .init(rotationAngle: .pi)
        }
        
        addAsRootTextField.addTapGesture {
            self.addAsRootTextArrow.transform = .init(rotationAngle: .pi)
            self.addAsRootDropDown.show()
        }
        
        
        
        //        accountCreateTypeDropDown
        accountCreateTypeDropDown.anchorView = accountCreateTypeTextField
        accountCreateTypeDropDown.bottomOffset = CGPoint(x: 0, y:(accountCreateTypeDropDown.anchorView?.plainView.bounds.height)!)
        accountCreateTypeDropDown.dataSource = ["Next Account","Child Account"]
        accountCreateTypeDropDown.selectionAction = { [weak self] (index: Int, item: String) in
            self?.accountCreateTypeArrow.transform = .init(rotationAngle: 0)
            self?.accountCreateTypeTextField.text = item
            self?.selectedAccountCreateType = index == 0 ? "next" : "child"
        }
        
        accountCreateTypeDropDown.cancelAction = { [unowned self] in
            accountCreateTypeArrow.transform = .init(rotationAngle: .pi)
        }
        
        accountCreateTypeTextField.addTapGesture {
            self.accountCreateTypeArrow.transform = .init(rotationAngle: .pi)
            self.accountCreateTypeDropDown.show()
        }
        
        
        //  currenciesDropDown
        
        currenciesDropDown.anchorView = currenciesTextField
        currenciesDropDown.bottomOffset = CGPoint(x: 0, y:(currenciesDropDown.anchorView?.plainView.bounds.height)!)
        currenciesDropDown.dataSource = ["Yes","No"]
        currenciesDropDown.selectionAction = { [weak self] (index: Int, item: String) in
            self?.currenciesArrow.transform = .init(rotationAngle: 0)
            if index != 0{
                self?.selectedCurrencie = self?.currencies[index - 1]
                self?.currenciesTextField.text = item
            }else{
                self?.selectedCurrencie = nil
                self?.currenciesTextField.text = ""
            }
        }
        
        currenciesDropDown.cancelAction = { [unowned self] in
            currenciesArrow.transform = .init(rotationAngle: .pi)
        }
        
        currenciesTextField.addTapGesture {
            self.currenciesArrow.transform = .init(rotationAngle: .pi)
            self.currenciesDropDown.show()
        }
        
        //  accountTypeDropDown
        
        accountTypeDropDown.anchorView = accountTypeTextField
        accountTypeDropDown.bottomOffset = CGPoint(x: 0, y:(accountTypeDropDown.anchorView?.plainView.bounds.height)!)
        accountTypeDropDown.selectionAction = { [weak self] (index: Int, item: String) in
            self?.accountTypeArrow.transform = .init(rotationAngle: 0)
            
            if index != 0{
                self?.selectedAccountType = self?.accountTypes[index - 1]
                self?.accountTypeTextField.text = item
                self?.getBalanceSheetGroups(accountType: self?.accountTypes[index - 1].value ?? "")
            }else{
                self?.selectedAccountType = nil
                self?.accountTypeTextField.text = ""
                self?.getBalanceSheetGroups(accountType: "")
            }
            
        }
        
        accountTypeDropDown.cancelAction = { [unowned self] in
            accountTypeArrow.transform = .init(rotationAngle: .pi)
        }
        
        accountTypeTextField.addTapGesture {
            self.accountTypeArrow.transform = .init(rotationAngle: .pi)
            self.accountTypeDropDown.show()
        }
        
        //  balanceSheetGroupDropDown
        
        balanceSheetGroupDropDown.anchorView = balanceSheetGroupTextField
        balanceSheetGroupDropDown.bottomOffset = CGPoint(x: 0, y:(balanceSheetGroupDropDown.anchorView?.plainView.bounds.height)!)
        
        balanceSheetGroupDropDown.selectionAction = { [weak self] (index: Int, item: String) in
            self?.accountTypeArrow.transform = .init(rotationAngle: 0)
            if index != 0{
                self?.selectedBalanceSheetGroup = self?.balanceSheetGroups[index - 1]
                self?.balanceSheetGroupTextField.text = item
            }else{
                self?.selectedBalanceSheetGroup = nil
                self?.balanceSheetGroupTextField.text = ""
            }
        }
        
        balanceSheetGroupDropDown.cancelAction = { [unowned self] in
            accountTypeArrow.transform = .init(rotationAngle: .pi)
        }
        
        balanceSheetGroupTextField.addTapGesture {
            self.accountTypeArrow.transform = .init(rotationAngle: .pi)
            self.balanceSheetGroupDropDown.show()
        }
        
        
        //  supportSubAccountDropDown
        
        supportSubAccountDropDown.anchorView = supportSubAccountTextField
        supportSubAccountDropDown.bottomOffset = CGPoint(x: 0, y:(supportSubAccountDropDown.anchorView?.plainView.bounds.height)!)
        supportSubAccountDropDown.dataSource = ["Yes","No"]
        supportSubAccountDropDown.selectionAction = { [unowned self] (index: Int, item: String) in
            supportSubAccountArrow.transform = .init(rotationAngle: 0)
            self.supportSubAccountTextField.text = item
        }
        
        supportSubAccountDropDown.cancelAction = { [unowned self] in
            supportSubAccountArrow.transform = .init(rotationAngle: .pi)
        }
        
        supportSubAccountTextField.addTapGesture {
            self.supportSubAccountArrow.transform = .init(rotationAngle: .pi)
            self.supportSubAccountDropDown.show()
        }
        
        
        //  costCenterSupportDropDown
        
        costCenterSupportDropDown.anchorView = costCenterSupportTextField
        costCenterSupportDropDown.bottomOffset = CGPoint(x: 0, y:(costCenterSupportDropDown.anchorView?.plainView.bounds.height)!)
        costCenterSupportDropDown.dataSource = ["Yes","No"]
        costCenterSupportDropDown.selectionAction = { [unowned self] (index: Int, item: String) in
            costCenterSupportArrow.transform = .init(rotationAngle: 0)
            self.costCenterSupportTextField.text = item
            costCentersView.isHidden = index == 1
        }
        
        costCenterSupportDropDown.cancelAction = { [unowned self] in
            costCenterSupportArrow.transform = .init(rotationAngle: .pi)
        }
        
        costCenterSupportTextField.addTapGesture {
            self.costCenterSupportArrow.transform = .init(rotationAngle: .pi)
            self.costCenterSupportDropDown.show()
        }
        
        
        //  costCentersDropDown
        
        costCentersDropDown.anchorView = costCentersTextField
        costCentersDropDown.bottomOffset = CGPoint(x: 0, y:(costCentersDropDown.anchorView?.plainView.bounds.height)!)
        costCentersDropDown.selectionAction = { [unowned self] (index: Int, item: String) in
            costCentersArrow.transform = .init(rotationAngle: 0)
            self.selectedCostCenters.append(costCenters[index])
            self.costCentersCollectionView.isHidden = false
            self.costCentersCollectionView.reloadData()
        }
        
        costCentersDropDown.cancelAction = { [unowned self] in
            costCentersArrow.transform = .init(rotationAngle: .pi)
        }
        
    }
    
    
    @objc private func costCentersAction(){
        searchForCostCenter()
    }

    
    @IBAction func holdAccountSelectionAction(_ sender: Any) {
        holdAccountSelectionButton.isSelected = !holdAccountSelectionButton.isSelected
    }
    
    
    @IBAction func profitLossAccountSelectionAction(_ sender: Any) {
        profitLossAccountSelectionButton.isSelected = !profitLossAccountSelectionButton.isSelected
    }
    
    
    @IBAction func submitAction(_ sender: Any) {
        submit()
    }
    
    
    @IBAction func closeAction(_ sender: Any) {
        navigationController?.dismiss(animated: true)
    }
    
}

extension AddAccountMastersViewController:UICollectionViewDelegate,UICollectionViewDataSource{
    private func setUpCollectionView(){
        costCentersCollectionView.delegate = self
        costCentersCollectionView.dataSource = self
        costCentersCollectionView.register(.init(nibName: "UsersCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "UsersCollectionViewCell")
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return selectedCostCenters.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "UsersCollectionViewCell", for: indexPath) as! UsersCollectionViewCell
        cell.delegate = self
        
        cell.setData(data: selectedCostCenters[indexPath.row], indexPath: indexPath)
        return cell
    }
}

extension AddAccountMastersViewController:UsersCollectionViewCellDelegate{
    func removeAction(indexPath:IndexPath){
        selectedCostCenters.remove(at: indexPath.row)
        costCentersCollectionView.isHidden = selectedCostCenters.isEmpty
        costCentersCollectionView.reloadData()
    }
}

// MARK: - API Handling
extension AddAccountMastersViewController{
    private func getCurrencies(){
        APIController.shard.getCurrencies(branch_id: data?.branch_id ?? "") { [weak self] data in
            DispatchQueue.main.async { [weak self] in
                if let status = data.status,status{
                    self?.currencies = data.records ?? []
                    self?.currenciesDropDown.dataSource = ["Choose Options"]
                    self?.currenciesDropDown.dataSource.append(contentsOf: (data.records ?? []).map{$0.label ?? ""})
                }
            }
        }
    }
    
    private func getAccountType(){
        APIController.shard.getAccountTypes(branch_id: data?.branch_id ?? "") { data in
            DispatchQueue.main.async { [weak self] in
                if let status = data.status,status{
                    self?.accountTypes = data.records ?? []
                    self?.accountTypeDropDown.dataSource = ["Choose Options"]
                    self?.accountTypeDropDown.dataSource.append(contentsOf: (data.records ?? []).map{$0.label ?? ""})
                    
                    
                }
                if self?.isEdit ?? false{
                    self?.addAsRootView.isHidden = true
                    self?.getEditData()
                }else{
                    self?.addAsRootView.isHidden = false
                }
            }
            
        }
    }
    
    private func getBalanceSheetGroups(accountType:String){
        APIController.shard.getBalanceSheetGroups(branch_id: data?.branch_id ?? "",account_type: accountType) { data in
            DispatchQueue.main.async { [weak self] in
                if let status = data.status,status{
                    self?.balanceSheetGroups = data.records ?? []
                    self?.balanceSheetGroupDropDown.dataSource = ["Choose Options"]
                    self?.balanceSheetGroupDropDown.dataSource.append(contentsOf: (data.records ?? []).map{$0.label ?? ""})
                    if self?.isEdit ?? false{
                        self?.selectedBalanceSheetGroup = self?.balanceSheetGroups.first(where: {$0.value == self?.data?.balancevalue})
                        self?.balanceSheetGroupTextField.text = self?.selectedBalanceSheetGroup?.label ?? ""
                    }
                }
            }
        }
    }
    
    private func submit(){
        var body:[String:Any] = [
            "account_masters_id": data?.account_masters_id ?? "",
            "branch_id": data?.branch_id ?? "",
            "account_master_root": addAsRootTextField.text! == "Yes" ? "1" : "0",
            "account_masters_code": data?.account_masters_code ?? "",
            "account_masters_name_en": titleEnTextField.text!,
            "account_masters_name_ar": titleArTextField.text!,
            "account_masters_currency_id[0][label]": selectedCurrencie?.label ?? "",
            "account_masters_currency_id[0][value]": selectedCurrencie?.value ?? "",
            "account_masters_type[0][label]": selectedAccountType?.label ?? "",
            "account_masters_type[0][value]": selectedAccountType?.value ?? "",
            "account_create_type": selectedAccountCreateType,
            "account_masters_balance_sheet_id[0][label]": selectedBalanceSheetGroup?.label ?? "",
            "account_masters_balance_sheet_id[0][value]": selectedBalanceSheetGroup?.value ?? "",
            "account_masters_support": supportSubAccountTextField.text! == "Yes" ? "1" : "0",
            "cost_center_support": costCenterSupportTextField.text! == "Yes" ? "1" : "0",
            "hold_account_from_transaction": holdAccountSelectionButton.isSelected ? "1" : "0",
            "set_profit_loss_account": profitLossAccountSelectionButton.isSelected ? "1" : "0",
            "account_vat_number": VATNumberTextField.text!
        ]
        
        
        for index in 0..<selectedCostCenters.count{
            body["account_masters_cost_center_id[\(index)][label]"] = selectedCostCenters[index].label ?? ""
            body["account_masters_cost_center_id[\(index)][value]"] = selectedCostCenters[index].value ?? ""
        }
        if isEdit{
            body["finance_id"] = data?.finance_id ?? ""
        }
        
        
//        data?.account_masters_parent = addAsRootTextField.text! == "Yes" ? "1" : "0"
//        data?.account_masters_name_en = titleEnTextField.text!
//        data?.account_masters_name_ar = titleArTextField.text!
//        data?.account_masters_currency_id = selectedCurrencie?.value ?? ""
//        data?.account_masters_type = selectedAccountType?.value ?? ""
//        data?.account_masters_balance_sheet_id = selectedBalanceSheetGroup?.value ?? ""
//        data?.account_masters_support = supportSubAccountTextField.text! == "Yes" ? "1" : "0"
//        data?.cost_center_support = costCenterSupportTextField.text! == "Yes" ? "1" : "0"
//        data?.hold_account_from_transaction = holdAccountSelectionButton.isSelected ? "1" : "0"
//        data?.set_profit_loss_account = profitLossAccountSelectionButton.isSelected ? "1" : "0"
//        data?.account_vat_number = VATNumberTextField.text!
        
        
        let url = isEdit ? "/amupdate/\(data?.account_masters_id ?? "")" : "/amcreate"
        APIController.shard.addAccountMaster(url:url,body: body) { [weak self] data in
            if let status = data.status,status{
                SCLAlertView().showSuccess("Success".localized(), subTitle: data.msg ?? "")
                NotificationCenter.default.post(name: .init("ReloadAccountManagerData"), object: nil)
                self?.dismissAction?()
            }else{
                SCLAlertView().showError("error".localized(), subTitle: data.error ?? "")
            }
        }
    }
    
    private func searchForCostCenter(){
        APIController.shard.searchForCostCenter(branch_id: data?.branch_id ?? "", search_text: costCentersTextField.text!) { [weak self] data in
            if let status = data.status,status{
                self?.costCenters = data.records ?? []
                self?.costCentersDropDown.dataSource = (data.records ?? []).map{$0.label ?? ""}
                self?.costCentersDropDown.show()
                if self?.isEdit ?? false{
                    let values = self?.data?.account_masters_cost_center_id?.components(separatedBy: ",") ?? []
                    self?.selectedCostCenters = self?.costCenters.filter{values.contains($0.value ?? "") } ?? []
                }
            }
        }
    }
    
}
