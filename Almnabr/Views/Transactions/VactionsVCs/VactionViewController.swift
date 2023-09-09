//
//  VactionViewController.swift
//  Almnabr
//
//  Created by Hany Alkahlout on 24/07/2022.
//  Copyright © 2022 Samar Akkila. All rights reserved.
//

import UIKit
import SCLAlertView

class VactionViewController: UIViewController {

    @IBOutlet weak var previewPDFTitle: UILabel!
    @IBOutlet weak var requestNumLabel: UILabel!
    @IBOutlet weak var codeLabel: UILabel!
    @IBOutlet weak var statusLabel: UILabel!
    @IBOutlet weak var createdByLabel: UILabel!
    @IBOutlet weak var createdDateLabel: UILabel!
    @IBOutlet weak var lastStepOpendLabel: UILabel!
    @IBOutlet weak var selectedStepLabel: UILabel!
    @IBOutlet weak var stepsNumLabel: UILabel!
    @IBOutlet weak var stepsProgress: UIProgressView!
    @IBOutlet weak var noteTextView: UITextView!
    @IBOutlet weak var approveButton: UIButton!
    @IBOutlet weak var approveStackView: UIStackView!
    @IBOutlet weak var rejectButton: UIButton!
    @IBOutlet weak var rejectStackView: UIStackView!
    @IBOutlet weak var verficationCodeTextField: UITextField!
    @IBOutlet weak var nameOfRequestApprovalWritreLabel: UILabel!
    @IBOutlet weak var requestApprovalView: UIView!
    @IBOutlet weak var attachButton: UIButton!
    @IBOutlet weak var submitButton: UIButton!
    @IBOutlet weak var personalDetailsButton: UIButton!
    @IBOutlet weak var historyButton: UIButton!
    
    @IBOutlet weak var finalStepView: UIView!
    
    @IBOutlet weak var empNameLabel: UILabel!
    
    @IBOutlet weak var mobileNumberLabel: UILabel!
    
    @IBOutlet weak var jobTitleLabel: UILabel!
    
    @IBOutlet weak var branchLabel: UILabel!
    @IBOutlet weak var joiningDateLabel: UILabel!
    @IBOutlet weak var emailabel: UILabel!
    @IBOutlet weak var typeLabel: UILabel!
    @IBOutlet weak var daysLabel: UILabel!
    @IBOutlet weak var startDateLabel: UILabel!
    @IBOutlet weak var endDateLabel: UILabel!
    @IBOutlet weak var afterVactionLabel: UILabel!
    @IBOutlet weak var paidAmountLabel: UILabel!
    @IBOutlet weak var directManagerLabel: UILabel!
    @IBOutlet weak var financialButton: UIButton!
    @IBOutlet weak var notePlacolderLabel: UILabel!
    @IBOutlet weak var editButton: UIButton!
    
    
    private var presonalDetails:[TransactionsPersons]?
    private var persons: [TransactionsPersons]?
    private var attachData: [FormHrv1AttachmentsRecords]?
    private var recordsData: [TransactionsContractRecord]?
    private var financialData:[Finance]?
    private var waitedProgressNumber:Float = -1.0
    private var progress:Float = 1.0 {
        didSet{
            

                self.requestApprovalView.isHidden = progress != waitedProgressNumber || !isWaitiedPerson
            
            stepsNumLabel.text = "step \(Int(progress)) of 7"
            stepsProgress.progress = progress/7.0
            switch progress{
            case 1:
                selectedStepLabel.text = "Configurations"
            case 2:
                selectedStepLabel.text = "Employee"
            case 3:
                selectedStepLabel.text = "Direct Manager"
            case 4:
                selectedStepLabel.text = "HR Team"
            case 5:
                selectedStepLabel.text = "Account team"
            case 6:
                selectedStepLabel.text = "HR Manager"
            default:
                selectedStepLabel.text = "Last Vacation Step"
            }
        }
    }
    private var waitiedPersons = ""
    private var isWaitiedPerson = false
    private var finalStepPreivewLink:String?
    
    var transaction_request_id = ""
    override func viewDidLoad() {
        super.viewDidLoad()
        initlization()
        // Do any additional setup after loading the view.
    }
    
    private func initlization(){
        
        noteTextView.delegate = self
        addObserver()
        setUpSelectionRequestApproval()
        verficationCodeTextField.addTarget(self, action: #selector(verficationCodeTextFieldAction), for: .editingChanged)
        getVactionData()
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        addNavigationBarTitle(navigationTitle: "Vaction Form".localized())
        navigationController?.setNavigationBarHidden(false, animated: true)
    
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        navigationController?.setNavigationBarHidden(true, animated: true)
        
    }
    
    
    @objc private func verficationCodeTextFieldAction(){
        submitButton.isHidden = verficationCodeTextField.text!.isEmpty
    }
    
    
    private func addObserver(){
        NotificationCenter.default.addObserver(forName: .init("ReloadVactionData"), object: nil, queue: .main) { notify in
            self.getVactionData()
        }
    }
    
    
    private func setUpSelectionRequestApproval(){
        approveStackView.isUserInteractionEnabled = true
        approveStackView.addTapGesture {
            self.approveButtonAction()
        }
        
        self.approveButton.addTapGesture {
            self.approveButtonAction()
        }
        
        
        rejectStackView.isUserInteractionEnabled = true
        rejectStackView.addTapGesture {
            self.rejectButtonAction()
        }
        self.rejectButton.addTapGesture {
            self.rejectButtonAction()
        }
        
        
    }
    
    private func approveButtonAction(){
        self.approveButton.isSelected = !self.approveButton.isSelected
        self.rejectButton.isSelected = !self.approveButton.isSelected
    }
    
    
    private func rejectButtonAction(){
        self.rejectButton.isSelected = !self.rejectButton.isSelected
        self.approveButton.isSelected = !self.rejectButton.isSelected
    }
    
    
    
    @IBAction func beforeAction(_ sender: Any) {
        if progress > 1 {
            progress -= 1
        }
    }
    
    
    @IBAction func forwardAction(_ sender: Any) {
        if progress < 7 {
            progress += 1
        }
    }
    
    
    @IBAction func financialDetailsAction(_ sender: Any) {
        if let financialData = financialData {
            let vc = FinanceInfoViewController()
            vc.data = financialData
            navigationController?.pushViewController(vc, animated: true)
        }
    }
    
    
    @IBAction func presonalDetailsAction(_ sender: Any) {
        let vc:PersonDetailsVC = AppDelegate.TransactionSB.instanceVC()
        vc.personalData = self.presonalDetails
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    
    @IBAction func historyAction(_ sender: Any) {
        let vc:HistoryVC = AppDelegate.TransactionSB.instanceVC()
        vc.recordsData = recordsData
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    
    @IBAction func attachmentsAction(_ sender: Any) {
        
        let vc:FormsAttachmentsVC = AppDelegate.TransactionSB.instanceVC()
        vc.attachData = self.attachData
        self.navigationController?.pushViewController(vc, animated: true)
        
    }
    
    
    @IBAction func sendCodeAction(_ sender: Any) {
        let vc = SendCodeWaysVC()
        vc.id = transaction_request_id
        vc.approvalStep = self.lastStepOpendLabel.text!
        vc.type = "signature"
        let nav = UINavigationController(rootViewController: vc)
        nav.setNavigationBarHidden(true, animated: false)
        nav.modalPresentationStyle = .overCurrentContext
        navigationController?.present(nav, animated: true)
    }
    
    
    @IBAction func submitAction(_ sender: Any) {
        submitApprovalRequest()
    }
    
    
    @IBAction func previewPdfAction(_ sender: Any) {
        if let finalStepPreivewLink = finalStepPreivewLink{
            previewPDF(url: finalStepPreivewLink)
        }else{
            previewPDF(url:"form/FORM_HRV1/pr/\(transaction_request_id)")
        }
    }
    
    
    @IBAction func editLastStepOpenedAction(_ sender: Any) {
        let vc = EditLastStepViewController()
        vc.formStr = ""
        vc.transactionRequestId = transaction_request_id
        let nav = UINavigationController(rootViewController: vc)
        nav.modalPresentationStyle = .overCurrentContext
        navigationController?.present(nav, animated: true)
    }
    
    
    @IBAction func infoLastStepAction(_ sender: Any) {
        SCLAlertView().showInfo("Waiting for: \(waitiedPersons)", subTitle: "")
    }
    
}

// MARK: - API Handlign
extension VactionViewController{
    
    private func getVactionData(){
        self.isWaitiedPerson = false
        self.waitiedPersons = ""
        showLoadingActivity()
        APIController.shard.getVactionData(vactionId: transaction_request_id) { data in
            DispatchQueue.main.async {
                self.hideLoadingActivity()
                if let status = data.status,status{
                    self.editButton.isHidden = !Auth_User.isAdmin
                    let transctionDataFirstRecord = data.transactions_date?.records?.first
                    self.requestNumLabel.text = transctionDataFirstRecord?.transaction_request_id ?? "----"
                    self.statusLabel.text =  transctionDataFirstRecord?.transaction_request_status ?? "----"
                    self.createdByLabel.text = data.transactions_request?.created_name ?? "----"
                    self.createdDateLabel.text = data.transactions_request?.created_date ?? "----"
                    self.lastStepOpendLabel.text = data.last_request_step ?? ""
                    self.presonalDetails = data.transactions_persons?.records
                    self.setVactionDetailsData(data: data.form_hrv1_vacation_data?.records)
                    
                    self.persons = data.transactions_persons?.records
                    self.personalDetailsButton.isHidden = self.persons == nil
                    
                    if let persons = self.persons{
                        for person in persons{
                            if person.transactions_persons_last_step == self.lastStepOpendLabel.text! {
                                if person.user_id == Auth_User.user_id {
                                    self.isWaitiedPerson = true
                                }
                                    self.waitiedPersons += "\(person.person_name ?? "") -"
                            }
                        }
                    }
                    
                    self.previewPDFTitle.text = "Preview"
                    switch data.last_request_step ?? "" {
                    case "CONFIGURATION":
                        self.waitedProgressNumber = 1
                        self.nameOfRequestApprovalWritreLabel.text = "Configuration"
                        
                    case "EMPLOYEE":
                        self.waitedProgressNumber = 2
                        self.nameOfRequestApprovalWritreLabel.text = "Employee"
                        
                    case "DIRECT_MANAGER":
                        self.waitedProgressNumber = 3
                        self.nameOfRequestApprovalWritreLabel.text = "Direct Manager"
                        
                    case "HUMAN_RESOURCE_TEAM":
                        self.waitedProgressNumber = 4
                        self.nameOfRequestApprovalWritreLabel.text = "Human Resource Team"
                        
                    case "ACCOUNT_TEAM":
                        self.waitedProgressNumber = 5
                        self.nameOfRequestApprovalWritreLabel.text = "Account Team"
                    
                    case "HUMAN_RESOURCE_MANAGER":
                        self.waitedProgressNumber = 6
                        self.nameOfRequestApprovalWritreLabel.text = "Human Resource Manager"
                    
                    default:
                        self.previewPDFTitle.text = "View"
                        self.finalStepPreivewLink = data.transactions_request?.view_link
                        self.finalStepView.isHidden = false
                        self.waitedProgressNumber = 7
                        self.nameOfRequestApprovalWritreLabel.text = "last"
                        
                    }
                    self.progress = self.waitedProgressNumber
           
                    
                    self.attachData = data.form_hrv1_attachments?.records
                    self.attachButton.isHidden = self.attachData == nil
                    self.recordsData = data.transactions_records?.records
                    self.historyButton.isHidden = self.recordsData == nil

                    
                }else{
                    let alertVC = UIAlertController(title: "error".localized(), message: data.error ?? "", preferredStyle: .alert)
                    alertVC.addAction(.init(title: "Cancel".localized(), style: .cancel,handler: { action in
                        DispatchQueue.main.async {
                            self.navigationController?.popViewController(animated: true)
                        }
                    }))
                    self.present(alertVC, animated: true)
                }
            }
        }
    }
    
    
    private func getFinicalData(data:FormHrv1VacationData?){
        showLoadingActivity()
        APIController.shard.showSelectionVactionResult(empNum: data?.employee_number ?? "" , vacation_type_id: data?.vacation_type_id ?? "", beforeDate: data?.before_vacation_working_date_english ?? "", afterDate: data?.after_vacation_working_date_english ?? "") { data in
            DispatchQueue.main.async {
                self.hideLoadingActivity()
                if let status = data.status,status{
                    self.financialButton.isHidden = false
                    self.financialData = data.result?.finance ?? []
                }else{
                    self.financialButton.isHidden = true
                }
            }
        }
    }
    
    
    private func setVactionDetailsData(data:FormHrv1VacationData?){
        empNameLabel.text = data?.employee_name ?? ""
        mobileNumberLabel.text = data?.primary_mobile ?? ""
        jobTitleLabel.text = data?.job_title ?? ""
        branchLabel.text = data?.branch ?? ""
        joiningDateLabel.text = "\(data?.joining_start_date_english ?? "") - \(data?.joining_start_date_arabic ?? "")"
        emailabel.text = data?.primary_email ?? ""
        typeLabel.text = data?.vacation_type ?? ""
        daysLabel.text = data?.vacation_total_days ?? ""
        startDateLabel.text = "\(data?.vacation_start_date_english ?? "") - \(data?.vacation_start_date_arabic ?? "")"
        endDateLabel.text = "\(data?.vacation_end_date_english ?? "") - \(data?.vacation_end_date_arabic ?? "")"
        afterVactionLabel.text = "\(data?.after_vacation_working_date_english ?? "") - \(data?.after_vacation_working_date_arabic ?? "")"
        paidAmountLabel.text = data?.vacation_total_paid_amount ?? ""
        directManagerLabel.text = data?.direct_manager_name ?? ""
        getFinicalData(data: data)
    }
    
    
    private func previewPDF(url:String){
        
        showLoadingActivity()
        APIController.shard.getImage(url: url) { data in
            DispatchQueue.main.async {
                self.hideLoadingActivity()
                if let status = data.status,status{
                    let vc = WebViewViewController()
                    vc.data = data
                    self.navigationController?.present(UINavigationController(rootViewController: vc), animated: true)
                }else{
                    let alertVC = UIAlertController(title: "error".localized(), message: data.error ?? "", preferredStyle: .alert)
                    alertVC.addAction(.init(title: "Cancel".localized(), style: .cancel))
                    self.present(alertVC, animated: true)
                }
            }
        }
        
    }
    
    
    private func submitApprovalRequest(){
        
        let approving_status = approveButton.isSelected ? "Approve" : "Reject"
        let note = noteTextView.text!
        let transactions_persons_action_code = verficationCodeTextField.text!
        showLoadingActivity()
     
        APIController.shard.submitApproval(formType:"FORM_HRV1",transaction_request_id: transaction_request_id, approving_status: approving_status, note: note, transactions_persons_action_code: transactions_persons_action_code) { data in
            DispatchQueue.main.async {
                self.hideLoadingActivity()
                if let status = data.status,status{
                    SCLAlertView().showSuccess("Success".localized(), subTitle: data.msg ?? "")
                    self.getVactionData()
                    
                }else{
                    SCLAlertView().showError("error".localized(), subTitle: data.error ?? "")
                }
            }
        }
        
    }
    
    
}


extension VactionViewController: UITextViewDelegate {
    func textViewDidBeginEditing(_ textView: UITextView) {
        notePlacolderLabel.isHidden = true
    }
}
