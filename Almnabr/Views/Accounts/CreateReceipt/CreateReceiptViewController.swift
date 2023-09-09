//
//  CreateReceiptViewController.swift
//  Almnabr
//
//  Created by Hany Alkahlout on 31/01/2023.
//  Copyright © 2023 Samar Akkila. All rights reserved.
//

import UIKit
import Fastis
import SCLAlertView
import DropDown
import FAPanels

class CreateReceiptViewController: UIViewController {
    
    @IBOutlet weak var headerTitleLabel: UILabel!
    
    @IBOutlet weak var headerView: HeaderView!
    @IBOutlet weak var branchSelectorStackView: UIStackView!
    @IBOutlet weak var receiptDateLabel: UILabel!
    @IBOutlet weak var receiptDateTextField: UITextField!
    @IBOutlet weak var descriptionTextView: UITextView!
    @IBOutlet weak var emptyDescriptionLabel: UILabel!
    @IBOutlet weak var receiptFromLabel: UILabel!
    @IBOutlet weak var receiptFromTextField: UITextField!
    @IBOutlet weak var receiptModeLabel: UILabel!
    
    @IBOutlet weak var cashButton: UIButton!
    @IBOutlet weak var cashStackView: UIStackView!
    
    @IBOutlet weak var chequeButton: UIButton!
    @IBOutlet weak var chequeStackView: UIStackView!
    
    @IBOutlet weak var depositeButton: UIButton!
    @IBOutlet weak var depositeStackView: UIStackView!
    
    @IBOutlet weak var transferStackView: UIStackView!
    @IBOutlet weak var transferButton: UIButton!
    
    @IBOutlet weak var debitAccountTextField: UITextField!
    @IBOutlet weak var debitAccountArrow: UIImageView!
    
    @IBOutlet weak var creditAccountTextField: UITextField!
    @IBOutlet weak var creditAccountArrow: UIImageView!
    
    @IBOutlet weak var documentNoTextField: UITextField!
    
    @IBOutlet weak var documentDateTextField: UITextField!
    
    @IBOutlet weak var bankNameTextField: UITextField!
    
    @IBOutlet weak var receiptAmountLabel: UILabel!
    @IBOutlet weak var receiptAmountTextField: UITextField!
    
    @IBOutlet weak var emptyNoteLabel: UILabel!
    @IBOutlet weak var notesTextView: UITextView!
    @IBOutlet weak var selectFileButton: UIButton!
    @IBOutlet weak var addtionalFieldsStackView: UIStackView!
    
    @IBOutlet weak var mainStackView: UIStackView!
    
    
    private var documentPickerController: UIDocumentPickerViewController!
    
    private var branchSelector:BranchSelection?
    private let fastisController = FastisController(mode: .single)
    private var depitAccountsDropDown = DropDown()
    private var creditAccountsDropDown = DropDown()
    private var depitAccounts = [SearchBranchRecords]()
    private var depitAccountSelected:SearchBranchRecords?
    private var creditAccounts = [SearchBranchRecords]()
    private var creditAccountSelected:SearchBranchRecords?
    var branch_id = ""
    var payment_receipt_id = ""
    private var finance_id = ""
    private var receiptMode = ""
    private var isReceiptDate = false
    private var selectedFileUrl:URL?
    private var debitCardCosts: AddCardCost?
    private var creditCardCosts: AddCardCost?
    var isEdit = false
    var isPayment = false
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        initialization()
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        headerTitleLabel.text = "\(isEdit ? "Update" : "Create") \(isPayment ? "Payment" : "Receipt")"
        if isEdit{
            getEditData()
        }
        
        if isPayment{
            receiptDateTextField.placeholder = "Payment Date"
            receiptDateLabel.text = "Payment Date: *"
            
            receiptFromLabel.text = "Payment To: *"
            receiptFromTextField.placeholder = "Payment To"
            
            receiptModeLabel.text = "Payment Mode: *"
            
            receiptAmountLabel.text = "Payment Amount: *"
            receiptAmountTextField.placeholder = "Payment Amount"
        }
    }
    
    
    private func initialization(){
        documentPickerController = UIDocumentPickerViewController(
            forOpeningContentTypes: [.pdf])
        documentPickerController.delegate = self
        descriptionTextView.delegate = self
        notesTextView.delegate = self
        handleHeaderView()
        setUpGesture()
        setUpFastisController()
        if !isEdit{
            setUpBranchSelector()
        }
        debitAccountTextField.addTarget(self, action: #selector(searchForCardAccount(_:)), for: .editingChanged)
        creditAccountTextField.addTarget(self, action: #selector(searchForCardAccount(_:)), for: .editingChanged)
        setUpDropDownLists()
        mainStackView.isHidden = true
        setUpCardCostsViews()
    }
    
    
    private func setUpCardCostsViews(){
        
        debitCardCosts = AddCardCost()
        debitCardCosts!.isDebit = true
        
        debitCardCosts!.titleLabel.text = "Debit Cost *"
        debitCardCosts!.debitCostTextField.placeholder = "Debit Cost"
        
        mainStackView.insertArrangedSubview(debitCardCosts!, at: mainStackView.subviews.count - 2)
        
        creditCardCosts = AddCardCost()
        creditCardCosts!.isDebit = false
        
        creditCardCosts!.titleLabel.text = "Credit Cost *"
        creditCardCosts!.debitCostTextField.placeholder = "Credit Cost"
        
        mainStackView.insertArrangedSubview(creditCardCosts!, at: mainStackView.subviews.count - 2)
    }
    
    
    private func setUpGesture(){
        cashStackView.isUserInteractionEnabled = true
        cashStackView.addTapGesture {
            self.cashButton.isSelected = true
            self.chequeButton.isSelected = false
            self.depositeButton.isSelected = false
            self.transferButton.isSelected = false
            self.addtionalFieldsStackView.isHidden = true
            self.receiptMode = "cash"
        }
        
        chequeStackView.isUserInteractionEnabled = true
        chequeStackView.addTapGesture {
            self.cashButton.isSelected = false
            self.chequeButton.isSelected = true
            self.depositeButton.isSelected = false
            self.transferButton.isSelected = false
            self.addtionalFieldsStackView.isHidden = false
            self.receiptMode = "cheque"
        }
        
        depositeStackView.isUserInteractionEnabled = true
        depositeStackView.addTapGesture {
            self.cashButton.isSelected = false
            self.chequeButton.isSelected = false
            self.depositeButton.isSelected = true
            self.transferButton.isSelected = false
            self.addtionalFieldsStackView.isHidden = false
            self.receiptMode = "deposite"
        }
        
        transferStackView.isUserInteractionEnabled = true
        transferStackView.addTapGesture {
            self.cashButton.isSelected = false
            self.chequeButton.isSelected = false
            self.depositeButton.isSelected = false
            self.transferButton.isSelected = true
            self.addtionalFieldsStackView.isHidden = false
            self.receiptMode = "etransfer"
        }
        
        receiptDateTextField.addTapGesture {
            self.isReceiptDate = true
            self.fastisController.present(above: self)
        }
        
        documentDateTextField.addTapGesture {
            self.isReceiptDate = false
            self.fastisController.present(above: self)
        }
    }
    
    
    private func setUpDropDownLists(){
        
        // depitAccountsDropDown
        depitAccountsDropDown.anchorView = debitAccountTextField
        depitAccountsDropDown.bottomOffset = CGPoint(x: 0, y:(depitAccountsDropDown.anchorView?.plainView.bounds.height)!)
        depitAccountsDropDown.selectionAction = { [weak self] (index: Int, item: String) in
            self?.debitAccountArrow.transform = .init(rotationAngle: 0)
            self?.depitAccountSelected = self?.depitAccounts[index]
            self?.debitAccountTextField.placeholder = item
            self?.debitAccountTextField.text = ""
        }
        
        depitAccountsDropDown.cancelAction = { [weak self] in
            self?.debitAccountArrow.transform = .init(rotationAngle: .pi)
            self?.debitAccountTextField.text = ""
        }
        
        // creditAccountsDropDown
        creditAccountsDropDown.anchorView = creditAccountTextField
        creditAccountsDropDown.bottomOffset = CGPoint(x: 0, y:(creditAccountsDropDown.anchorView?.plainView.bounds.height)!)
        creditAccountsDropDown.selectionAction = { [weak self] (index: Int, item: String) in
            self?.creditAccountArrow.transform = .init(rotationAngle: 0)
            self?.creditAccountSelected = self?.creditAccounts[index]
            self?.creditAccountTextField.placeholder = item
            self?.creditAccountTextField.text = ""
            
        }
        
        creditAccountsDropDown.cancelAction = { [weak self] in
            self?.creditAccountArrow.transform = .init(rotationAngle: .pi)
            self?.creditAccountTextField.text = ""
        }

    }
    
    
    private func setUpFastisController(){
        fastisController.title = "Choose Date".localized()
        fastisController.allowToChooseNilDate = true
        fastisController.shortcuts = [.today]
        fastisController.doneHandler = { result in
            if let result = result {
                if self.isReceiptDate{
                    self.receiptDateTextField.text = self.formatedDate(date: result)
                }else{
                    self.documentDateTextField.text = self.formatedDate(date: result)
                }
            }
        }
    }
    
    
    private func setUpBranchSelector(){
        branchSelector = BranchSelection()
        branchSelector!.withFinancialYearSelection = true
        branchSelector!.branchSelectionAction = { [weak self] branch_id in
            self?.branch_id = branch_id
            self?.debitCardCosts?.branch_id = branch_id
            self?.creditCardCosts?.branch_id = branch_id
            self?.mainStackView.isHidden = branch_id == ""
            
        }
        branchSelector?.financialYearSelectionAction = { [weak self] finance_id in
            self?.finance_id = finance_id
        }
        branchSelectorStackView.addArrangedSubview(branchSelector!)
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
    
    
    @objc private func searchForCardAccount(_ textField:UITextField){
        searchCardAccount(search_text: textField.text!, isDebit: textField == debitAccountTextField)
    }
    
    
    @IBAction func cashAction(_ sender: Any) {
        self.cashButton.isSelected = true
        self.chequeButton.isSelected = false
        self.depositeButton.isSelected = false
        self.transferButton.isSelected = false
        self.addtionalFieldsStackView.isHidden = true
        self.receiptMode = "cash"
    }
    
    
    @IBAction func chequeAction(_ sender: Any) {
        self.cashButton.isSelected = false
        self.chequeButton.isSelected = true
        self.depositeButton.isSelected = false
        self.transferButton.isSelected = false
        self.addtionalFieldsStackView.isHidden = false
        self.receiptMode = "cheque"
    }
    
    
    @IBAction func depositeAction(_ sender: Any) {
        self.cashButton.isSelected = false
        self.chequeButton.isSelected = false
        self.depositeButton.isSelected = true
        self.transferButton.isSelected = false
        self.addtionalFieldsStackView.isHidden = false
        self.receiptMode = "deposite"
    }
    
    
    @IBAction func transferAction(_ sender: Any) {
        self.cashButton.isSelected = false
        self.chequeButton.isSelected = false
        self.depositeButton.isSelected = false
        self.transferButton.isSelected = true
        self.addtionalFieldsStackView.isHidden = false
        self.receiptMode = "etransfer"
    }
    
    
    @IBAction func selectFileAction(_ sender: Any) {
        self.present(documentPickerController, animated: true, completion: nil)
    }
    
    
    @IBAction func submitAction(_ sender: Any) {
        createReceipt()
    }
    
}


extension CreateReceiptViewController:UITextViewDelegate{
    func textViewDidBeginEditing(_ textView: UITextView) {
        if textView == descriptionTextView{
            emptyDescriptionLabel.isHidden = true
        }else{
            emptyNoteLabel.isHidden = true
        }
    }
}


extension CreateReceiptViewController:UIDocumentPickerDelegate{
    public func documentPicker(_ controller: UIDocumentPickerViewController, didPickDocumentsAt urls: [URL]) {
        guard let url = urls.first else {
            return
        }
        selectFileButton.setTitle(url.lastPathComponent, for: .normal)
        selectedFileUrl = url
    }
    
    func documentPickerWasCancelled(_ controller: UIDocumentPickerViewController) {
        dismiss(animated: true, completion: nil)
    }
}

// MARK: - API Handling
extension CreateReceiptViewController{
    
    private func searchCardAccount(search_text:String,isDebit:Bool){
        showLoadingActivity()
        APIController.shard.searchForCardAccount(branch_id: branch_id, finance_id: finance_id, search_text: search_text) { data in
            DispatchQueue.main.async { [weak self] in
                self?.hideLoadingActivity()
                if data.status ?? false{
                    if isDebit{
                        self?.depitAccounts = (data.records ?? [])
                        self?.depitAccountsDropDown.dataSource = (data.records ?? []).map{$0.label ?? ""}
                        self?.depitAccountsDropDown.show()
                    }else{
                        self?.creditAccounts = (data.records ?? [])
                        self?.creditAccountsDropDown.dataSource = (data.records ?? []).map{$0.label ?? ""}
                        self?.creditAccountsDropDown.show()
                    }
                }else{
                    if isDebit{
                        self?.depitAccounts.removeAll()
                        self?.depitAccountsDropDown.dataSource = []
                        self?.depitAccountsDropDown.show()
                    }else{
                        self?.creditAccounts.removeAll()
                        self?.creditAccountsDropDown.dataSource = []
                        self?.creditAccountsDropDown.show()
                    }
                }
            }
        }
    }
    
    private func createReceipt(){
        
        var body:[String:Any] = [
            "branch_id":branch_id,
            "finance_id":finance_id,
            "payment_receipt_date":receiptDateTextField.text!,
            "payment_receipt_to_from":receiptFromTextField.text!,
            "payment_receipt_mode":receiptMode,
            "payment_receipt_debit_account_id":depitAccountSelected?.value ?? "",
            "payment_receipt_credit_account_id":creditAccountSelected?.value ?? "",
            "payment_receipt_amount":receiptAmountTextField.text!,
            "payment_receipt_document_number":documentNoTextField.text!,
            "payment_receipt_document_date":documentDateTextField.text!,
            "payment_receipt_bank_name":bankNameTextField.text!,
            "payment_receipt_notes":notesTextView.text!,
            "payment_receipt_description":descriptionTextView.text!
        ]
        
        let debitCosts = debitCardCosts?.getSelectedCardCosts() ?? []
        for index in 0..<debitCosts.count{
            body["payment_receipt_debit_cost_id[\(index)][cid]"] = debitCosts[index].card?.value ?? ""
            body["payment_receipt_debit_cost_id[\(index)][amount]"] = debitCosts[index].amount
        }
        
        let creditCosts = creditCardCosts?.getSelectedCardCosts() ?? []
        for index in 0..<creditCosts.count{
            body["payment_receipt_credit_cost_id[\(index)][cid]"] = creditCosts[index].card?.value ?? ""
            body["payment_receipt_credit_cost_id[\(index)][amount]"] = creditCosts[index].amount
        }
        showLoadingActivity()
        let url = "/\(isPayment ? "pay": "rec")\(isEdit ? "update": "create")/\(payment_receipt_id)"
        
        APIController.shard.createReceipt(requestUrl: url ,fileUrl:selectedFileUrl,body: body) { data in
            DispatchQueue.main.async{ [weak self] in
                self?.hideLoadingActivity()
                if data.status ?? false{
                    SCLAlertView().showSuccess("Success".localized(), subTitle: data.msg ?? "")
                    let vc = AllReceiptsViewController()
                    vc.isPayment = self?.isPayment ?? false
                    let nav = UINavigationController(rootViewController: vc)
                    nav.isNavigationBarHidden = true
                    self?.panel?.center(nav)
                }else{
                    SCLAlertView().showError("error".localized(), subTitle: data.error ?? "")
                }
            }
        }
    }
    
    
    private func getEditData(){
        let url = "/\(isPayment ? "editpayment" : "editreceipt")/\(branch_id)/\(payment_receipt_id)"
        showLoadingActivity()
        APIController.shard.editReceipt(url:url) { data in
            DispatchQueue.main.async { [weak self] in
                self?.hideLoadingActivity()
                if data.status ?? false{
                    self?.setUpBranchSelector()
                    self?.branchSelector?.selecetdBranchId = self?.branch_id ?? ""
                    self?.branchSelector?.selecetdfinancialYear = data.financial_year?.finance_id ?? ""
                    self?.receiptDateTextField.text = data.records?.transaction_date ?? ""
                    self?.descriptionTextView.text = data.records?.payment_receipt_description ?? ""
                    self?.emptyDescriptionLabel.isHidden = !(self?.descriptionTextView.text.isEmpty ?? false)
                    self?.receiptFromTextField.text = data.records?.payment_receipt_to_from ?? ""
                    let receiptMode = data.records?.payment_receipt_mode ?? ""
                    self?.receiptMode = receiptMode
                    self?.cashButton.isSelected = receiptMode == "cash"
                    self?.chequeButton.isSelected = receiptMode == "cheque"
                    self?.depositeButton.isSelected = receiptMode == "deposite"
                    self?.transferButton.isSelected = receiptMode == "etransfer"
                    self?.addtionalFieldsStackView.isHidden = self?.cashButton.isSelected ?? false
                    self?.depitAccountSelected = .init(value: data.records?.payment_receipt_debit_account_id ?? "")
                    self?.creditAccountSelected = .init(value: data.records?.payment_receipt_credit_account_id ?? "")
                    self?.debitAccountTextField.placeholder = data.records?.debit_account ?? ""
                    self?.creditAccountTextField.placeholder = data.records?.credit_account ?? ""
                    self?.documentNoTextField.text = data.records?.payment_receipt_document_number ?? ""
                    self?.documentDateTextField.text = data.records?.payment_receipt_document_date ?? ""
                    self?.bankNameTextField.text = data.records?.payment_receipt_bank_name ?? ""
                    self?.receiptAmountTextField.text = data.records?.payment_receipt_amount ?? ""
                    self?.notesTextView.text = data.records?.payment_receipt_notes ?? ""
                    self?.emptyNoteLabel.isHidden = !(self?.notesTextView.text.isEmpty ?? false )
                    
                    var debitCosts = [(card:SearchBranchRecords?,amount:String)]()
                    for debitCost in data.records?.debit_costs ?? []{
                        debitCosts.append((card: .init(label:debitCost.label ?? "",value:debitCost.value ?? ""), amount: debitCost.amount ?? ""))
                    }
                    self?.debitCardCosts?.addCardCost(cost: debitCosts)
                    
                    var creditCosts = [(card:SearchBranchRecords?,amount:String)]()
                    for creditCost in data.records?.credit_costs ?? []{
                        creditCosts.append((card: .init(label:creditCost.label ?? "",value:creditCost.value ?? ""), amount: creditCost.amount ?? ""))
                    }
                    self?.creditCardCosts?.addCardCost(cost: creditCosts)
                }else{
                    SCLAlertView().showError("error".localized(), subTitle: data.error ?? "")
                }
            }
        }
    }
    
}



