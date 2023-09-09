//
//  NewContractVC.swift
//  Almnabr
//
//  Created by Hany Alkahlout on 23/08/2022.
//  Copyright © 2022 Samar Akkila. All rights reserved.
//

import UIKit
import SCLAlertView

class NewContractVC: UIViewController {
    @IBOutlet weak var previewLabel: UILabel!
    @IBOutlet weak var requestNoLabel: UILabel!
    @IBOutlet weak var requestNo2Label: UILabel!
    @IBOutlet weak var statusLabel: UILabel!
    @IBOutlet weak var createdByLabel: UILabel!
    @IBOutlet weak var createdDateLabel: UILabel!
    @IBOutlet weak var lastStepOpendLabel: UILabel!
    @IBOutlet weak var selectedStepLabel: UILabel!
    @IBOutlet weak var stepsNumberLabel: UILabel!
    @IBOutlet weak var previewButton: UIButton!
    
    @IBOutlet weak var rejectStackView: UIStackView!
    @IBOutlet weak var approveStackView: UIStackView!
    @IBOutlet weak var approveButton: UIButton!
    @IBOutlet weak var rejectButton: UIButton!
    @IBOutlet weak var noteTextView: UITextView!
    @IBOutlet weak var noteLabel: UILabel!
    @IBOutlet weak var verificationCodeTextField: UITextField!
    @IBOutlet weak var submitButton: UIButton!
    @IBOutlet weak var editButton: UIButton!
    @IBOutlet weak var stepsProgress: UIProgressView!
    @IBOutlet weak var mainView: UIView!
    @IBOutlet weak var finalResultView: UIView!
    @IBOutlet weak var gifView: UIView!
    @IBOutlet weak var mainViewHeight: NSLayoutConstraint!
    @IBOutlet weak var approvalView: UIView!
    
    private var previewFileData:GetImageResponse?
    private var pageController:ContractPageViewController!
    private var approvalStep:String? = nil
    private var isWaitingThisUser = false
    private let steps:[Int:String] = [1:"CONFIGURATION",2:"ACCOUNT_TEAM",3:"HUMAN_RESOURCE_MANAGER",4:"EMPLOYEE",5:"FIRST_PARTY",6:"last"]
    private var presonalDetails:[TransactionsPersons] = []
    private var progress:Float = 0 {
        didSet{
            stepsProgress.progress = self.progress/6
            changeCurrentStep()
        }
    }
    
    var transaction_request_id = ""
    private var recordsData: [TransactionsContractRecord]?
    private var waitingUsers = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        initlization()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        addNavigationBarTitle(navigationTitle: "New Contract Form")
        navigationController?.setNavigationBarHidden(false, animated: true)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        navigationController?.setNavigationBarHidden(true, animated: true)
    }
    private func initlization(){
        editButton.isHidden = !Auth_User.isAdmin
        approvalView.isHidden = true
        previewButton.isHidden = true
        setUpNav()
        setUpPageViewController()
        setUpRaduioButtonStackViews()
        self.noteTextView.delegate = self
        self.verificationCodeTextField.addTarget(self, action: #selector(verificationCodeAction), for: .editingChanged)
        getContractData()
        NotificationCenter.default.addObserver(forName: .init(rawValue: "UpdatePageControllerHeight"), object: nil, queue: .main) { _ in
            if let scrollView = self.pageController.containerVCs.first?.view.subviews.first as? UIScrollView{
                self.mainViewHeight.constant = scrollView.contentSize.height
            }
        }
        
        NotificationCenter.default.addObserver(forName: .init(rawValue: "ReloadNewContractData"), object: nil, queue: .main) { _ in
            self.getContractData()
        }
        
    }
    
    
    private func setUpRaduioButtonStackViews(){
        approveStackView.addTapGesture {
            self.approveButton.isSelected = !self.approveButton.isSelected
            self.rejectButton.isSelected = !self.approveButton.isSelected
        }
        
        rejectStackView.addTapGesture {
            
            self.rejectButton.isSelected = !self.rejectButton.isSelected
            self.approveButton.isSelected = !self.rejectButton.isSelected
        }
    }
    
    
    private func setUpNav(){
        navigationController?.setNavigationBarHidden(false, animated: true)
        addNavigationBarTitle(navigationTitle: "New Contract Form")
    }
    
    
    private func changeCurrentStep(){
        switch progress{
        case 1:
            selectedStepLabel.text = "Configurations"
        case 2:
            selectedStepLabel.text = "Account Team"
        case 3:
            selectedStepLabel.text = "HR Manager"
        case 4:
            selectedStepLabel.text = "Employee"
        case 5:
            selectedStepLabel.text = "First Party"
        case 6:
            selectedStepLabel.text = "Last Step"
        default:
            break
        }
        
        finalResultView.isHidden = approvalStep != "last" || progress != 6
        stepsNumberLabel.text = "step \(Int(progress)) of 6"
        if isWaitingThisUser{
            approvalView.isHidden = steps[Int(progress)] != approvalStep
        }else{
            approvalView.isHidden = true
        }
    }
    
    
    private func setUpPageViewController(){
        pageController = AppDelegate.TransactionSB.instanceVC()
        
        addChild(pageController)
        pageController.didMove(toParent: self)
        
        pageController.view.translatesAutoresizingMaskIntoConstraints = false
        
        mainView.addSubview(pageController.view)
        
        mainView.leadingAnchor.constraint(equalTo: pageController.view.leadingAnchor, constant: 0).isActive = true
        mainView.trailingAnchor.constraint(equalTo: pageController.view.trailingAnchor, constant: 0).isActive = true
        mainView.topAnchor.constraint(equalTo: pageController.view.topAnchor, constant: 0).isActive = true
        mainView.bottomAnchor.constraint(equalTo: pageController.view.bottomAnchor, constant: 0).isActive = true
    }
    
    
    @objc private func verificationCodeAction(){
        submitButton.isHidden = verificationCodeTextField.text!.isEmpty
    }
    
    
    @IBAction func pdfAction(_ sender: Any) {
        if let data = previewFileData {
            let vc = WebViewViewController()
            vc.data = data
            let nav = UINavigationController(rootViewController: vc)
            self.navigationController?.present(nav, animated: true)
        }
    }
    
    
    @IBAction func infoAction(_ sender: Any) {
        SCLAlertView().showInfo("Waiting for: \(waitingUsers)", subTitle: "")
    }
    
    
    @IBAction func editAction(_ sender: Any) {
        let vc = EditLastStepViewController()
        vc.formStr = "FORM_CT1"
        vc.transactionRequestId = transaction_request_id
        let nav = UINavigationController(rootViewController: vc)
        nav.modalPresentationStyle = .overCurrentContext
        navigationController?.present(nav, animated: true)
        
    }
    
    
    @IBAction func historyAction(_ sender: Any) {
        let vc:HistoryVC = AppDelegate.TransactionSB.instanceVC()
        vc.recordsData = recordsData
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    
    @IBAction func personalDetailsAction(_ sender: Any) {
        let vc:PersonDetailsVC = AppDelegate.TransactionSB.instanceVC()
        
        vc.personalData = self.presonalDetails
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    
    @IBAction func nextAction(_ sender: Any) {
        if progress < 6{
            progress += 1
        }
        
        let index = pageController.currentIndex + 1
        guard index < pageController.containerVCs.count else { return }
        pageController.currentIndex += 1
        pageController.changeVC(direction: .forward)
    }
    
    
    @IBAction func preAction(_ sender: Any) {
        if progress > 1{
            progress -= 1
        }
        let index = pageController.currentIndex - 1
        guard index >= 0 else { return }
        pageController.currentIndex -= 1
        pageController.changeVC(direction: .reverse)
    }
    
    
    @IBAction func sendCodeAction(_ sender: Any) {
        let vc = SendCodeWaysVC()
        vc.id = transaction_request_id
        vc.approvalStep = approvalStep
        vc.type = "signature"
        let nav = UINavigationController(rootViewController: vc)
        nav.setNavigationBarHidden(true, animated: false)
        nav.modalPresentationStyle = .overCurrentContext
        navigationController?.present(nav, animated: true)
    }
    
    
    @IBAction func submitAction(_ sender: Any) {
        sendApproval()
    }
    
}

// MARK: - API Handling

extension NewContractVC {
    
    private func getContractData(){
        waitingUsers = ""
        showLoadingActivity()
        APIController.shard.getContractDetails(transactionId: transaction_request_id ) { data in
            DispatchQueue.main.async {
                self.hideLoadingActivity()
                if let status =  data.status,status{
                    self.setRequestData(data: data)
                }else{
                    SCLAlertView().showError("error".localized(), subTitle: data.error ?? "")
                    self.navigationController?.popViewController(animated: true)
                }
            }
        }
    }
    
    
    private func setRequestData(data:NewContractDataResponse){
        let lastStep = data.transactions_request?.transaction_request_last_step ?? ""
        self.previewLabel.text = (lastStep == "completed" || lastStep == "last") ? "View" : "Preview"
        requestNoLabel.text = data.transactions_request?.transaction_request_id ?? "----"
        requestNo2Label.text = data.transactions_request?.tbv_barcodeData ?? "----"
        statusLabel.text = data.transactions_request?.transaction_request_status ?? "----"
        createdByLabel.text = data.transactions_request?.created_name ?? ""
        createdDateLabel.text = data.transactions_request?.created_date ?? ""
        presonalDetails = data.transactions_persons?.records ?? []
        recordsData = data.transactions_records?.records ?? []
        
        pageController.setContractData(data: data.form_ct1_data,addtionalAllowances:data.form_ct1_data_additional_terms)
        approvalStep = data.transactions_request?.transaction_request_last_step
        getPrviewFile(base64: approvalStep == "completed" ? data.transactions_request?.view_link ?? "" : nil)
        switch data.transactions_request?.transaction_request_last_step{
        case "CONFIGURATION":
            self.progress = 1
            lastStepOpendLabel.text = "Configuration"
        case "ACCOUNT_TEAM":
            self.progress = 2
            lastStepOpendLabel.text = "Account Team"
        case "HUMAN_RESOURCE_MANAGER":
            self.progress = 3
            lastStepOpendLabel.text = "Human Resource Manager"
        case "EMPLOYEE":
            self.progress = 4
            lastStepOpendLabel.text = "Employee"
        case "FIRST_PARTY":
            self.progress = 5
            lastStepOpendLabel.text = "First Party"
        case "last":
            self.progress = 6
            lastStepOpendLabel.text = "last step"
        case "completed":
            self.progress = 6
            lastStepOpendLabel.text = "Completed"
        default:
            
            break
        }
        
        self.setUpApprovalViewExistent(data: data.transactions_persons)
    }

    
    
    private func setUpApprovalViewExistent(data:Transactions_personsVD?){
        if let data = data ,let records = data.records , let approvalStep = approvalStep{
            for record in records{
                if approvalStep == record.transactions_persons_last_step{
                    waitingUsers.append("\(waitingUsers.isEmpty ? "" : " - ")\(record.person_name ?? "")")
                }
                
                if record.user_id == Auth_User.user_id{
                    self.isWaitingThisUser = record.transactions_persons_last_step == approvalStep
                    approvalView.isHidden = record.transactions_persons_last_step != approvalStep
                }
            }
        }
    }
    
    
    private func getPrviewFile(base64:String?){
        var url = ""
        if let base64 = base64 {
            url = base64
        }else{
            url = "form/FORM_CT1/pr1/\(transaction_request_id)"
        }
        APIController.shard.getImage(url: url) { [weak self] data in
            
            if let status = data.status ,status , let self = self{
                self.previewButton.isHidden = false
                self.previewFileData = data
            }
        }
    }
    
    
    private func sendApproval(){
        showLoadingActivity()
        APIController.shard.submitApproval(formType: "FORM_CT1", transaction_request_id: transaction_request_id, approving_status: approveButton.isSelected ? "Approve" : "Reject", note: noteTextView.text!, transactions_persons_action_code: verificationCodeTextField.text!) { data in
            DispatchQueue.main.async {
                self.hideLoadingActivity()
                if let status = data.status ,status{
                    self.getContractData()
                }else{
                    SCLAlertView().showError("error".localized(), subTitle: data.error ?? "There is an unknown error")
                }
            }
        }
    }
    
    
}


extension NewContractVC:UITextViewDelegate,UITextFieldDelegate{
    func textViewDidBeginEditing(_ textView: UITextView) {
        self.noteLabel.isHidden = true
    }
    
    func textViewDidEndEditing(_ textView: UITextView) {
        self.noteLabel.isHidden = !textView.text!.isEmpty
    }
    
}



