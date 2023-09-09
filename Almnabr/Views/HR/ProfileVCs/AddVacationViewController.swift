//
//  AddVacationViewController.swift
//  Almnabr
//
//  Created by Hany Alkahlout on 18/07/2022.
//  Copyright © 2022 Samar Akkila. All rights reserved.
//

import UIKit
import DropDown
import Fastis
import SCLAlertView
import FAPanels

class AddVacationViewController: UIViewController {
    //Hidden First
    @IBOutlet weak var afterSelectionStack: UIStackView!
    @IBOutlet weak var startDateTextField: UITextField!
    @IBOutlet weak var endTextField: UITextField!
    @IBOutlet weak var totalDaysTextField: UITextField!
    @IBOutlet weak var unpaidDaysTextField: UITextField!
    
    @IBOutlet weak var unSickStackView: UIStackView!
    @IBOutlet weak var paidDaysTextField: UITextField!
    @IBOutlet weak var totalPaidAmountTextField: UITextField!
    
    @IBOutlet weak var attachButton: UIButton!
    @IBOutlet weak var financeInfoButton: UIButton!
    
    @IBOutlet weak var otherVactionTextField: UITextField!
    
    @IBOutlet weak var sickStackView: UIStackView!
    @IBOutlet weak var paid75DaysAmountTextField: UITextField!
    @IBOutlet weak var paid100DaysAmountTextField: UITextField!
    @IBOutlet weak var paid75DaysTextField: UITextField!
    @IBOutlet weak var paid100DaysTextField: UITextField!
    @IBOutlet weak var sickBalanceTextField: UITextField!
    
    
    @IBOutlet weak var addNewAttachButton: UIView!
    
    //UnHidden
    @IBOutlet weak var typeTextField: UITextField!
    @IBOutlet weak var typeArrow: UIImageView!
    
    @IBOutlet weak var beforeDateTextField: UITextField!
    @IBOutlet weak var afterDateTextField: UITextField!
    @IBOutlet weak var directManagerTextField: UITextField!
    @IBOutlet weak var directManagerArrow: UIImageView!
    
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var tableHeight: NSLayoutConstraint!
    
    private var typeDropDown = DropDown()
    private var directManagerDropDown = DropDown()
    private let fastisController = FastisController(mode: .single)
    private var isAfter = false
    private var searchResult = [SearchBranchRecords]()
    private var vactionTypesData = [VactionTypesRecords]()
    private var selectedVactionType:VactionTypesRecords?
    private var selectedDirectManagerId:String = ""
    private var lastSearchStatus = false
    var empId = ""
    private var counter = 1
    private var currentIndex:Int?
    private var documentPickerController: UIDocumentPickerViewController!
    private var financeData = [Finance]()
    private var isFromFinaceInfo = false
    var contractInfo:Contract_vacation_info?
    
    
    private var selectedBeforeDateAr = ""
    private var selectedAfterDateAr = ""
    private var selectedStartDateAr = ""
    private var selectedEndDateAr = ""
    private var needAttach = "0"
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        initlization()
        setUpTableView()
        // Do any additional setup after loading the view.
    }
    
    
    private func initlization(){
        addNavigationBarTitle(navigationTitle: "Create New Vaction")
        navigationController?.navigationBar.barTintColor = maincolor
        setUpDropDown()
        setUpDatePicker()
    }
    
    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(false, animated: true)
        if !isFromFinaceInfo{
            //            financeInfoButton.isHidden = true
            //            attachButton.isHidden = true
            //            addNewAttachButton.isHidden = true
            //            tableView.isHidden = true
            getVactionTypes()
        }else{
            isFromFinaceInfo = false
        }
    }
    
    
    
    private func setUpDatePicker(){
        
        fastisController.title = "Choose Date".localized()
        fastisController.allowToChooseNilDate = true
        fastisController.shortcuts = [.today]
        fastisController.doneHandler = { result in
            if let result = result {
                let dateString = self.formatedDate(date: result)
                let hjriDateString = self.convertDateToHijri(date: result)
                if self.isAfter {
                    self.afterDateTextField.text = dateString
                    self.selectedAfterDateAr = hjriDateString
                    if !self.beforeDateTextField.text!.isEmpty && !self.typeTextField.text!.isEmpty{
                        self.selectionResult()
                    }else{
                        self.afterSelectionStack.isHidden = true
                    }
                }else{
                    self.beforeDateTextField.text = dateString
                    self.selectedBeforeDateAr = hjriDateString
                    if !self.afterDateTextField.text!.isEmpty && !self.typeTextField.text!.isEmpty{
                        self.selectionResult()
                    }else{
                        self.afterSelectionStack.isHidden = true
                    }
                }
            }
        }
        
        afterDateTextField.addGestureRecognizer(UITapGestureRecognizer.init(target: self, action: #selector(afterDateAction)))
        beforeDateTextField.addGestureRecognizer(UITapGestureRecognizer.init(target: self, action: #selector(beforeDateAction)))
    }
    
    
    private func setUpDropDown(){
        // typeDropDown
        typeTextField.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(typeDropDownAction)))
        typeDropDown.anchorView = typeTextField
        typeDropDown.bottomOffset = CGPoint(x: 0, y:(typeDropDown.anchorView?.plainView.bounds.height)!)
        
        typeDropDown.selectionAction = { [unowned self] (index: Int, item: String) in
            typeArrow.transform = .init(rotationAngle: 0)
            typeTextField.text = item
            selectedVactionType = vactionTypesData[index]
            tableView.isHidden = true
            addNewAttachButton.isHidden = true
            self.needAttach = selectedVactionType?.need_attachment ?? "0"
            attachButton.isHidden = selectedVactionType?.need_attachment == "0"
            
            if !afterDateTextField.text!.isEmpty && !beforeDateTextField.text!.isEmpty{
                self.selectionResult()
            }else{
                afterSelectionStack.isHidden = true
            }
            
        }
        
        typeDropDown.cancelAction = { [unowned self] in
            typeArrow.transform = .init(rotationAngle: 0)
        }
        
        // directManagerDropDown
        directManagerTextField.addTarget(self, action: #selector(directManagerDropDownAction), for: .editingChanged)
        directManagerDropDown.anchorView = directManagerTextField
        directManagerDropDown.bottomOffset = CGPoint(x: 0, y:(directManagerDropDown.anchorView?.plainView.bounds.height)!)
        
        directManagerDropDown.selectionAction = { [unowned self] (index: Int, item: String) in
            if !searchResult.isEmpty && self.lastSearchStatus{
                directManagerArrow.transform = .init(rotationAngle: 0)
                directManagerTextField.text = ""
                directManagerTextField.placeholder = item
                selectedDirectManagerId = searchResult[index].value ?? ""
            }else{
                directManagerTextField.text = ""
            }
        }
        
        directManagerDropDown.cancelAction = { [unowned self] in
            directManagerArrow.transform = .init(rotationAngle: 0)
            directManagerTextField.text = ""
        }
        
    }
    
    func validation() -> Bool{
        return !typeTextField.text!.isEmpty &&
        !beforeDateTextField.text!.isEmpty &&
        !afterDateTextField.text!.isEmpty &&
        !selectedDirectManagerId.isEmpty
    }
    
    @objc private func typeDropDownAction(){
        typeArrow.transform = .init(rotationAngle: .pi)
        typeDropDown.show()
    }
    
    @objc private func directManagerDropDownAction(){
        directManagerArrow.transform = .init(rotationAngle: .pi)
        searchForUser()
        directManagerDropDown.show()
    }
    
    @objc private func beforeDateAction(){
        isAfter = false
        fastisController.present(above: self)
    }
    
    
    @objc private func afterDateAction(){
        isAfter = true
        fastisController.present(above: self)
    }
    
    
    @IBAction func attachAction(_ sender: Any) {
        counter = 1
        tableView.isHidden = false
        tableHeight.constant = CGFloat(counter * 130)
        addNewAttachButton.isHidden = false
        attachButton.isHidden = true
    }
    
    
    @IBAction func submitAction(_ sender: Any) {
        if validation(){
            submitAction()
        }else{
            SCLAlertView().showError("error".localized(), subTitle: "Empty Fields!!".localized())
        }
    }
    
    @IBAction func addNewAttachAction(_ sender: Any) {
        counter += 1
        tableHeight.constant = CGFloat(counter * 130)
        tableView.reloadData()
    }
    
    @IBAction func financeInfoAction(_ sender: Any) {
        let vc = FinanceInfoViewController()
        self.isFromFinaceInfo = true
        vc.data = financeData
        navigationController?.pushViewController(vc, animated: true)
    }
    
    
}


// MARK: - Table View SetUp
extension AddVacationViewController: UITableViewDelegate,UITableViewDataSource{
    private func setUpTableView(){
        tableView.delegate = self
        tableView.dataSource = self
        
        tableView.register(.init(nibName: "OutgoingAttachmentTableViewCell", bundle: nil), forCellReuseIdentifier: "OutgoingAttachmentTableViewCell")
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return counter
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "OutgoingAttachmentTableViewCell", for: indexPath) as! OutgoingAttachmentTableViewCell
        cell.delegate = self
        cell.index = indexPath.row
        cell.attachwithPdfStackView.isHidden = true
        cell.officialPaperStackView.isHidden = true
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 130
    }
    
}


// MARK: - Handle Table View Cell Delegate
extension AddVacationViewController: OutgoingAttachmentCellDelegate{
    func deleteAction() {
        if counter > 1{
            counter -= 1
            tableHeight.constant = CGFloat(counter * 130)
            tableView.reloadData()
        }
    }
    
    func selectFileAction(index: Int) {
        currentIndex = index
        let alertVC = UIAlertController(title: "", message: "", preferredStyle: .actionSheet)
        alertVC.addAction(.init(title: "Choose Photo".localized(), style: .default, handler: { action in
            self.setImageBy(source: .photoLibrary)
        }))
        alertVC.addAction(.init(title: "Choose Pdf".localized(), style: .default, handler: { action in
            self.selectAttachment()
        }))
        present(alertVC, animated: true, completion: nil)
    }
    
    private func selectAttachment(){
        documentPickerController = UIDocumentPickerViewController(
            forOpeningContentTypes: [.pdf])
        documentPickerController.delegate = self
        self.present(documentPickerController, animated: true, completion: nil)
    }
}

// MARK: - UIDocumentPickerViewControllerDelegate

extension AddVacationViewController:UIDocumentPickerDelegate{
    public func documentPicker(_ controller: UIDocumentPickerViewController, didPickDocumentsAt urls: [URL]) {
        guard let myURL = urls.first else {
            return
        }
        if let currentIndexPath = currentIndex{
            let cell = tableView.cellForRow(at: IndexPath(row: currentIndexPath, section: 0)) as! OutgoingAttachmentTableViewCell
            cell.selectFileButton.setTitle(myURL.lastPathComponent , for: .normal)
            cell.fileUrl = myURL
        }
        
    }
    
    func documentPickerWasCancelled(_ controller: UIDocumentPickerViewController) {
        dismiss(animated: true, completion: nil)
    }
}

// MARK: - UIImagePickerControllerDelegate
extension AddVacationViewController : UIImagePickerControllerDelegate , UINavigationControllerDelegate{
    private func setImageBy(source:UIImagePickerController.SourceType){
        let imagePicker = UIImagePickerController()
        imagePicker.delegate = self
        imagePicker.allowsEditing = true
        imagePicker.sourceType = source
        present(imagePicker, animated: true, completion: nil)
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        if let imgUrl = info[UIImagePickerController.InfoKey.imageURL] as? URL , let currentIndex = currentIndex{
            let cell = tableView.cellForRow(at: IndexPath(row: currentIndex, section: 0)) as! OutgoingAttachmentTableViewCell
            cell.selectFileButton.setTitle(imgUrl.lastPathComponent, for: .normal)
            cell.fileUrl = imgUrl
        }
        dismiss(animated: true, completion: nil)
    }
    
}


// MARK: - API Handling

extension AddVacationViewController{
    private func searchForUser(){
        APIController.shard.searchForUser(searchText: directManagerTextField.text!, lang: L102Language.currentAppleLanguage(), id: Auth_User.user_type_id) { data in
            DispatchQueue.main.async {
                if let status = data.status,status{
                    
                    self.searchResult = data.list ?? []
                    self.directManagerDropDown.dataSource = self.searchResult.map{$0.label ?? ""}
                }else{
                    self.searchResult.removeAll()
                    self.directManagerDropDown.dataSource = [data.error ?? ""]
                }
            }
        }
    }
    
    private func getVactionTypes(){
        APIController.shard.getVactionTypes(empNum: empId) { data in
            DispatchQueue.main.async {
                if let status = data.status , status{
                    self.lastSearchStatus = true
                    self.vactionTypesData = data.records ?? []
                    let isAr = L102Language.currentAppleLanguage() == "ar"
                    self.typeDropDown.dataSource = self.vactionTypesData.map{ (isAr ? $0.text_ar : $0.text_en)!}
                }else{
                    self.lastSearchStatus = false
                    self.vactionTypesData.removeAll()
                    self.typeDropDown.dataSource.removeAll()
                }
            }
        }
    }
    
    
    private func selectionResult(){
        APIController.shard.showSelectionVactionResult(empNum: empId, vacation_type_id: selectedVactionType?.value ?? "", beforeDate: beforeDateTextField.text!, afterDate: afterDateTextField.text!) { data in
            DispatchQueue.main.async {
                if let status = data.status,status,let result = data.result{
                    self.startDateTextField.text = result.vacation_start_date ?? ""
                    self.endTextField.text = result.vacation_end_date ?? ""
                    self.totalDaysTextField.text = String(result.vacation_days ?? 0)
                    self.unpaidDaysTextField.text = String(result.unpaid_days ?? 0)
                    
                    self.paidDaysTextField.text = String(result.paid_days ?? 0)
                    self.totalPaidAmountTextField.text = String(result.paid_amount22 ?? 0)
                    
                    self.paid75DaysTextField.text = String(result.paid_days75 ?? 0)
                    self.paid100DaysTextField.text = String(result.paid_days100 ?? 0)
                    self.paid75DaysAmountTextField.text = String(result.paid_days75_amount ?? 0)
                    self.paid100DaysAmountTextField.text = String(result.paid_days100_amount ?? 0)
                    self.sickBalanceTextField.text = result.sick_balance ?? ""
                    
                    self.afterSelectionStack.isHidden = false
                    
                    let vactionTypeId = self.selectedVactionType?.value ?? ""
                    
                    self.sickStackView.isHidden = vactionTypeId != "3"
                    self.unSickStackView.isHidden = vactionTypeId == "3" || vactionTypeId == "9"
                    self.otherVactionTextField.isHidden = vactionTypeId != "9"
                    
                    if !(data.result?.finance?.isEmpty ?? true){
                        self.financeInfoButton.isHidden = false
                        self.financeData = data.result?.finance ?? []
                    }
                    self.selectedStartDateAr = self.convertDateToHijri(date: self.getDateFromString(str: self.startDateTextField.text!))
                    self.selectedEndDateAr = self.convertDateToHijri(date: self.getDateFromString(str: self.endTextField.text!))
                    
                    
                }else{
                    self.afterSelectionStack.isHidden = true
                    SCLAlertView().showError("error".localized(), subTitle: data.error ?? "")
                }
            }
        }
    }
    
    private func submitAction(){
        
        var param:[String:Any] = [String:Any]()
        param["employee_number"] = empId
        param["vacation_type_id"] = selectedVactionType?.value ?? ""
        param["vacation_other"] = otherVactionTextField.text!
        param["contract_id"] = contractInfo?.contract_id ?? ""
        param["before_vacation_working_date_english"] = beforeDateTextField.text!
        param["before_vacation_working_date_arabic"] = selectedBeforeDateAr
        param["vacation_start_date_english"] = startDateTextField.text!
        param["vacation_start_date_arabic"] = selectedStartDateAr
        param["vacation_end_date_english"] = endTextField.text!
        param["vacation_end_date_arabic"] = selectedEndDateAr
        param["after_vacation_working_date_english"] = afterDateTextField.text!
        param["after_vacation_working_date_arabic"] = selectedAfterDateAr
        param["vacation_total_days"] = totalDaysTextField.text!
        param["vacation_paid_days_from_contract"] = contractInfo?.vacation_paid_days_only ?? ""
        param["direct_manager"] = selectedDirectManagerId
        param["vacation_total_unpaid_days"] = unpaidDaysTextField.text!
        param["needAttach"] = needAttach
        param["vacation_total_paid_days"] = selectedVactionType?.value == "3" ? paid100DaysTextField.text! : paidDaysTextField.text!
        param["vacation_total_paid_amount"] = selectedVactionType?.value == "3" ? paid100DaysAmountTextField.text! : totalPaidAmountTextField.text!
        
        var fileUrl = [URL]()
        for index in 0..<counter{
            let cell = tableView.cellForRow(at: IndexPath(row: index, section: 0)) as! OutgoingAttachmentTableViewCell
            param["attachments[\(index)][attach_title]"] = cell.descriptionTextField.text!
            fileUrl.append(cell.fileUrl ?? URL(fileURLWithPath: ""))
        }
        showLoadingActivity()
        APIController.shard.submitVaction(fileUrl: fileUrl, body: param) { data in
            DispatchQueue.main.async {
                self.hideLoadingActivity()
                if let status = data.status,status{
                    SCLAlertView().showSuccess("Success".localized(), subTitle: data.msg ?? "")

                    let vc: TransactionsVC = AppDelegate.mainSB.instanceVC()
                    let nav = UINavigationController(rootViewController: vc)
                    let root = AppInstance.window?.rootViewController as? FAPanelController
                    if let root = root{
                        root.center(nav)
                    }else{
                        self.navigationController?.popViewController(animated: true)
                    }
                }else{
                    SCLAlertView().showError("error".localized(), subTitle: data.error ?? "")
                }
            }
        }
        
        
    }
    
    
}
