//
//  LoanViewController.swift
//  Almnabr
//
//  Created by Hany Alkahlout on 20/11/2022.
//  Copyright © 2022 Samar Akkila. All rights reserved.
//

import UIKit
import SCLAlertView
class LoanViewController: UIViewController {

    
    @IBOutlet weak var noPermissionImageView: UIImageView!
    
    @IBOutlet weak var finalViewLabel: UILabel!
    @IBOutlet weak var mainView: UIView!
    @IBOutlet weak var submitFormView: UIView!
    
    @IBOutlet weak var approveStackView: UIStackView!
    @IBOutlet weak var rejectStackView: UIStackView!
    
    @IBOutlet weak var requestNoLabel: UILabel!
    @IBOutlet weak var barcodeNoLabel: UILabel!
    @IBOutlet weak var statusLabel: UILabel!
    @IBOutlet weak var createdByLabel: UILabel!
    @IBOutlet weak var createdDateLabel: UILabel!
    @IBOutlet weak var lastStepOpenedLabel: UILabel!
    @IBOutlet weak var selectedStepLabel: UILabel!
    @IBOutlet weak var selectedStepNoLabel: UILabel!
    @IBOutlet weak var emptyTextViewLabel: UILabel!
    @IBOutlet weak var previewLabel: UILabel!
    
    
    @IBOutlet weak var submitFormButton: UIButton!
    @IBOutlet weak var editUsersButton: UIButton!
    @IBOutlet weak var previewButton: UIButton!
    @IBOutlet weak var editButton: UIButton!
    @IBOutlet weak var approveButton: UIButton!
    @IBOutlet weak var rejectButton: UIButton!
    
    
    @IBOutlet weak var notesTextView: UITextView!
    
    @IBOutlet weak var verificationTextField: UITextField!
    
    @IBOutlet weak var stepsProgress: UIProgressView!
    
    @IBOutlet weak var finalResultView: UIView!
    
    var transactionId = ""
    
    private var presonalDetails:[TransactionsPersons] = []
    private var recordsData:[TransactionsContractRecord] = []
    private var pageController:LoanPageViewController!
    private var approvalStep:String? = nil
    private var previewFileData:GetImageResponse?
    private var progress:Float = 0 {
        didSet{
            stepsProgress.progress = self.progress/8
            changeCurrentStep()
        }
    }
    private var isWaitingThisUser = false
    private let steps:[Int:String] = [1:"CONFIGURATION",2:"EMPLOYEE",3:"DIRECT_MANAGER",4:"Executive_Manager",5:"HUMAN_RESOURCE_TEAM",6:"ACCOUNT_TEAM",7:"HUMAN_RESOURCE_MANAGER",8:"completed"]
    private var waitingUsers = ""
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        initialization()
        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        getLoanFormData()
        addNavigationBarTitle(navigationTitle: "Loan Form")
        navigationController?.setNavigationBarHidden(false, animated: true)
    }

    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        navigationController?.setNavigationBarHidden(true, animated: true)
    }
    
    private func initialization(){
        editButton.isHidden = !Auth_User.isAdmin
        setUpPageViewController()
        addNoPermissionImage()
        NotificationCenter.default.addObserver(forName: .init("ReloadLoanData"), object: nil, queue: .main) { notify in
            self.getLoanFormData()
        }
        notesTextView.delegate = self
        setUpRaduioButtonStackViews()
        self.verificationTextField.addTarget(self, action: #selector(verificationCodeAction), for: .editingChanged)

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
    
    private func getPrviewFile(base64:String?){
        var url = ""
        if let base64 = base64 {
            url = base64
        }else{
            url = "form/FORM_HRLN1/pr/\(transactionId)"
        }
        APIController.shard.getImage(url: url) { [weak self] data in
            
            if let status = data.status ,status , let self = self{
                self.previewButton.isHidden = false
                self.previewFileData = data
            }
        }
    }
    
    private func addNoPermissionImage(){
        if let image = UIImage.gif(name: "no-permission2"){
            noPermissionImageView.image = image
        }
    }
    
    private func changeCurrentStep(){
        switch progress{
        case 1:
            selectedStepLabel.text = "Configuration"
        case 2:
            selectedStepLabel.text = "Employee"
        case 3:
            selectedStepLabel.text = "Direct Manager"
        case 4:
            selectedStepLabel.text = "Executive Manager"
        case 5:
            selectedStepLabel.text = "HR Team"
        case 6:
            selectedStepLabel.text = "Account Team"
        case 7:
            selectedStepLabel.text = "HR Manager"
        case 8:
            selectedStepLabel.text = "last step"

        default:
            break
        }
        
        
        finalResultView.isHidden = (approvalStep != "last" && approvalStep != "completed") || progress != 8
        selectedStepNoLabel.text = "step \(Int(progress)) of 8"
        if isWaitingThisUser{
            submitFormView.isHidden = steps[Int(progress)] != approvalStep
        }else{
            submitFormView.isHidden = true
        }
        mainView.isHidden = !submitFormView.isHidden || !finalResultView.isHidden
    }
    
    private func setUpPageViewController(){
        pageController = LoanPageViewController()
        
        addChild(pageController)
        pageController.didMove(toParent: self)
        
        pageController.view.translatesAutoresizingMaskIntoConstraints = false
        
        mainView.addSubview(pageController.view)
        
        mainView.leadingAnchor.constraint(equalTo: pageController.view.leadingAnchor, constant: 0).isActive = true
        mainView.trailingAnchor.constraint(equalTo: pageController.view.trailingAnchor, constant: 0).isActive = true
        mainView.topAnchor.constraint(equalTo: pageController.view.topAnchor, constant: 0).isActive = true
        mainView.bottomAnchor.constraint(equalTo: pageController.view.bottomAnchor, constant: 0).isActive = true
    }
    
    private func setUpApprovalViewExistent(data:Transactions_persons?){
        waitingUsers.removeAll()
        if let data = data ,let records = data.records , let approvalStep = approvalStep{
            for record in records{
                if approvalStep == record.transactions_persons_last_step{
                    waitingUsers.append("\(waitingUsers.isEmpty ? "" : " - ")\(record.person_name ?? "")")
                }
                
                if record.user_id == Auth_User.user_id{
                    self.isWaitingThisUser = record.transactions_persons_last_step == approvalStep
                    submitFormView.isHidden = record.transactions_persons_last_step != approvalStep
                    mainView.isHidden = !submitFormView.isHidden || approvalStep == "completed" || approvalStep == "last"
                }
            }
        }
    }
    
    @objc private func verificationCodeAction(){
        submitFormButton.isHidden = verificationTextField.text!.isEmpty
    }
    
    @IBAction func previewFileAction(_ sender: Any) {
        if let data = previewFileData {
            let vc = WebViewViewController()
            vc.data = data
            let nav = UINavigationController(rootViewController: vc)
            self.navigationController?.present(nav, animated: true)
        }
    }
    
    
    @IBAction func editUserAction(_ sender: Any) {
        let vc = EditLastStepViewController()
        vc.formStr = "FORM_HRLN1"
        vc.transactionRequestId = transactionId
        let nav = UINavigationController(rootViewController: vc)
        nav.modalPresentationStyle = .overCurrentContext
        navigationController?.present(nav, animated: true)
        
    }
    
    
    @IBAction func infoAction(_ sender: Any) {
        let alertVC = UIAlertController(title: "Waited Users", message: waitingUsers, preferredStyle: .alert)
        alertVC.addAction(.init(title: "Cancel", style: .cancel))
        present(alertVC, animated: true)
    }
 
    
    @IBAction func reverseAction(_ sender: Any) {
        if progress > 1{
            progress -= 1
        }
        let index = pageController.currentIndex - 1
        guard index >= 0 else { return }
        pageController.currentIndex -= 1
        pageController.changeVC(direction: .reverse)
    }
    
    @IBAction func forwordAction(_ sender: Any) {
        if progress < 8{
            progress += 1
        }
        
        let index = pageController.currentIndex + 1
        guard index < pageController.containerVCs.count else { return }
        pageController.currentIndex += 1
        pageController.changeVC(direction: .forward)
        
    }
    
    @IBAction func sendCodeAction(_ sender: Any) {
        let vc = SendCodeWaysVC()
        vc.id = transactionId
        vc.approvalStep = approvalStep
        vc.type = "signature"
        let nav = UINavigationController(rootViewController: vc)
        nav.setNavigationBarHidden(true, animated: false)
        nav.modalPresentationStyle = .overCurrentContext
        navigationController?.present(nav, animated: true)
        
    }
    
    @IBAction func submitFormAction(_ sender: Any) {
        sendApproval()
    }
    
    
    @IBAction func personsDetailsAction(_ sender: Any) {
        let vc:HistoryVC = AppDelegate.TransactionSB.instanceVC()
        vc.recordsData = recordsData
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    @IBAction func historyAction(_ sender: Any) {
        let vc:PersonDetailsVC = AppDelegate.TransactionSB.instanceVC()
        vc.personalData = self.presonalDetails
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
}

// MARK: - API Controller
extension LoanViewController{
    private func getLoanFormData(){
        showLoadingActivity()
        APIController.shard.getLoanFormData(transactionId: transactionId) { data in
            DispatchQueue.main.async {
                self.hideLoadingActivity()
                if let status = data.status , status{
                    self.previewLabel.text = data.transactions_request?.transaction_request_last_step ?? "" == "completed" ? "View" : "Preview"
                    self.requestNoLabel.text = data.transactions_request?.transaction_request_id ?? "----"
                    self.barcodeNoLabel.text = data.transactions_request?.tbv_barcodeData ?? "----"
                    self.statusLabel.text = data.transactions_request?.transaction_request_status ?? "----"
                    self.createdByLabel.text = data.transactions_request?.created_name ?? ""
                    self.createdDateLabel.text = data.transactions_request?.created_date ?? ""
                    self.presonalDetails = data.transactions_persons?.records ?? []
                    self.recordsData = data.transactions_records?.records ?? []
                    
                    self.approvalStep = data.transactions_request?.transaction_request_last_step ?? ""
                    self.getPrviewFile(base64: self.approvalStep == "completed" ? data.transactions_request?.view_link : nil)
                    switch data.transactions_request?.transaction_request_last_step{
                    case "CONFIGURATION":
                        self.progress = 1
                        self.lastStepOpenedLabel.text = "Configuration"
                    case "EMPLOYEE":
                        self.progress = 2
                        self.lastStepOpenedLabel.text = "Employee"
                    case "DIRECT_MANAGER":
                        self.progress = 3
                        self.lastStepOpenedLabel.text = "Direct Manager"
                    case "Executive_Manager":
                        self.progress = 4
                        self.lastStepOpenedLabel.text = "Executive Manager"
                    case "HUMAN_RESOURCE_TEAM":
                        self.progress = 5
                        self.lastStepOpenedLabel.text = "Human Resource Team"
                    case "ACCOUNT_TEAM":
                        self.progress = 6
                        self.lastStepOpenedLabel.text = "Account Team"
                    case "HUMAN_RESOURCE_MANAGER":
                        self.progress = 7
                        self.lastStepOpenedLabel.text = "Human Resource Manager"
                    case "last":
                        self.progress = 8
                        self.lastStepOpenedLabel.text = "Processing"
                        self.finalViewLabel.text = "Thank you, we will review your request. wait the result soon."
                    case "completed":
                        self.progress = 8
                        self.lastStepOpenedLabel.text = "Completed"
                        self.finalViewLabel.text = "lang_completed_msg"
                        
                    default:
                        break
                    }
                    
                    self.setUpApprovalViewExistent(data: data.transactions_persons)
                }else{
                    
                }
            }
        }
    }
    
    private func sendApproval(){
        showLoadingActivity()
        APIController.shard.submitApproval(formType: "FORM_HRLN1", transaction_request_id: transactionId, approving_status: approveButton.isSelected ? "Approve" : "Reject", note: notesTextView.text!, transactions_persons_action_code: verificationTextField.text!) { data in
            DispatchQueue.main.async {
                self.hideLoadingActivity()
                if let status = data.status ,status{
                    self.getLoanFormData()
                }else{
                    SCLAlertView().showError("error".localized(), subTitle: data.error ?? "There is an unknown error")
                }
            }
        }
    }
    
}
extension LoanViewController: UITextViewDelegate{
    func textViewDidBeginEditing(_ textView: UITextView) {
        emptyTextViewLabel.isHidden = true
    }
}
