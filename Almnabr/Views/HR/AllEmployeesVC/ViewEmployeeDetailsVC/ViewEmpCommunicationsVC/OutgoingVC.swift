//
//  OutgoingVC.swift
//  Almnabr
//
//  Created by Hany Alkahlout on 22/06/2022.
//  Copyright © 2022 Samar Akkila. All rights reserved.
//

import UIKit
import DropDown
import Fastis

class OutgoingVC: UIViewController {
    
    @IBOutlet weak var backButton: UIButton!
    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var subjectTextField: UITextField!
    @IBOutlet weak var attachmentsTextField: UITextField!
    @IBOutlet weak var languageTextField: UITextField!
    @IBOutlet weak var toOrganizationTextFiled: UITextField!
    @IBOutlet weak var fileVisiblityView: UIView!
    @IBOutlet weak var fileVisibiltyLabel: UILabel!
    @IBOutlet weak var fileVisiblityCollectionView: UICollectionView!
    @IBOutlet weak var descriptionTextField: UITextView!
    
    @IBOutlet weak var addMarkButton: UIButton!
    @IBOutlet weak var addReview: UIButton!
    @IBOutlet weak var addAttachmentButton: UIButton!
    
    @IBOutlet weak var jopTitleATextField: UITextField!
    @IBOutlet weak var jobTitleBTextField: UITextField!
    
    @IBOutlet weak var jopTitleCTextField: UITextField!
    
    @IBOutlet weak var employeeNameATextField: UITextField!
    @IBOutlet weak var employeeNameBTextField: UITextField!
    @IBOutlet weak var employeeNameCTextField: UITextField!
    
    @IBOutlet weak var markerUsersTextField: UITextField!
    @IBOutlet weak var markersCollectionView: UICollectionView!
    
    @IBOutlet weak var reviewersUsersTextField: UITextField!
    @IBOutlet weak var reviewCollectionView: UICollectionView!
    
    @IBOutlet weak var attachmentsTableView: UITableView!
    
    @IBOutlet weak var attachmentsTableViewHeight: NSLayoutConstraint!
    
    
    @IBOutlet weak var MarkersView: UIView!
    
    @IBOutlet weak var reviewersView: UIView!
    
    @IBOutlet weak var attachmentsView: UIView!
    
    @IBOutlet weak var signatureView: UIView!
    
    @IBOutlet weak var fromTextFiled: UITextField!
    @IBOutlet weak var issueDateEnglishTextField: UITextField!
    @IBOutlet weak var issuedNumberTextField: UITextField!
    @IBOutlet weak var receipientTextField: UITextField!
    
    @IBOutlet weak var languageArrow: UIImageView!
    @IBOutlet weak var fileVisibiltyArrow: UIImageView!
    @IBOutlet weak var employeeNameAArrow: UIImageView!
    @IBOutlet weak var employeeNameBArrow: UIImageView!
    @IBOutlet weak var employeeNameCArrow: UIImageView!
    @IBOutlet weak var markerUsersArrow: UIImageView!
    @IBOutlet weak var reviewerUsersArrow: UIImageView!
    
    @IBOutlet weak var ongoingAddtionalFormStackView: UIStackView!
    
    @IBOutlet weak var calenderButton: UIButton!
    @IBOutlet weak var receipientArrow: UIImageView!
    
    private let languageDropDown = DropDown()
    private let fileVisibiltyDropDown = DropDown()
    private let employeeNameADropDown = DropDown()
    private let employeeNameBDropDown = DropDown()
    private let employeeNameCDropDown = DropDown()
    private let markerUsersDropDown = DropDown()
    private let reviewerUsersDropDown = DropDown()
    private let receipientDropDown = DropDown()
    
    
    private var fileVisiblityData = [SearchBranchRecords]()
    private var selectedFileVisiblity = [SearchBranchRecords]()
    private var attachmentsCount = 1
    
    private var employeeNameASearchResult = [SearchBranchRecords]()
    private var employeeNameBSearchResult = [SearchBranchRecords]()
    private var employeeNameCSearchResult = [SearchBranchRecords]()
    private var markSearchResult = [SearchBranchRecords]()
    private var selectedMarkSearchResult = [SearchBranchRecords]()
    private var reviewSearchResult = [SearchBranchRecords]()
    private var selectedReviewSearchResult = [SearchBranchRecords]()
    
    private var selectedASearchResult:SearchBranchRecords?
    private var selectedBSearchResult:SearchBranchRecords?
    private var selectedCSearchResult:SearchBranchRecords?
    
    
    private var receipientSearchResult = [SearchBranchRecords]()
    private var selectedReceipientSearchResult:SearchBranchRecords?
    
    private var dateController = FastisController(mode: .single)
    
    private var documentPickerController: UIDocumentPickerViewController!
    private var currentIndex:Int?
    private var selectedLang = ""
    private var selectedDatainAr = ""
    private var cellHeight = 190
    var isIncoming = false

    var myTranstion:String?
    override func viewDidLoad() {
        super.viewDidLoad()
        initlziation()
        // Do any additional setup after loading the view.
    }
    
    
    private func initlziation(){
        if L102Language.currentAppleLanguage() == "ar"{
            backButton.transform = .init(rotationAngle: .pi)
        }
        setUpDropDownLists()
        setUpDateController()
        setUpTableView()
        setUpCollectionView()
        getFileVisibiltyData()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        cellHeight = isIncoming ? 130 : 190
        signatureView.isHidden = isIncoming
        employeeNameAArrow.isHidden = isIncoming
        employeeNameBArrow.isHidden = isIncoming
        employeeNameCArrow.isHidden = isIncoming
        
        reviewersView.isHidden = true
        MarkersView.isHidden = !isIncoming
        attachmentsView.isHidden = !isIncoming
        ongoingAddtionalFormStackView.isHidden = !isIncoming
        toOrganizationTextFiled.isHidden = isIncoming
        addMarkButton.isHidden = isIncoming
        addReview.isHidden = isIncoming
        addAttachmentButton.isHidden = isIncoming
        calenderButton.isHidden = !isIncoming
        receipientArrow.isHidden = !isIncoming
        
        titleLabel.text = isIncoming ? "Incoming".localized() : "Outgoing".localized()
        
    }
    
    
    private func setUpDateController(){
        
        dateController.title = "Choose Date".localized()
        dateController.allowToChooseNilDate = true
        dateController.shortcuts = [.today]
        dateController.doneHandler = { result in
            if let result = result{
                self.issueDateEnglishTextField.text = self.formatedDate(date: result)
                self.selectedDatainAr = self.convertDateToHijri(date: result)
            }else{
                self.issueDateEnglishTextField.text = ""
                self.selectedDatainAr = ""
            }
        }
    }
    
    
    private func setUpDropDownLists(){
        setUpReceipientDropDown()
        setUpLanguageDropDown()
        setUpFileVisibiltyDropDown()
        setUpEmployeeNameADropDown()
        setUpEmployeeNameBDropDown()
        setUpemployeeNameCDropDown()
        setUpMarkerUsersDropDown()
        setUpReviewerUsersDropDown()
    }
    
    
    
    
    private func setUpReceipientDropDown(){
        //        receipientDropDown
        receipientDropDown.anchorView = receipientTextField
        
        receipientDropDown.bottomOffset = CGPoint(x: 0, y:(receipientDropDown.anchorView?.plainView.bounds.height)!)
        receipientDropDown.selectionAction = { [unowned self] (index: Int, item: String) in
            self.receipientArrow.transform = .init(rotationAngle: 0)
            self.receipientTextField.text = item
            
            if !self.receipientSearchResult.isEmpty && item != "There are no Data's" {
                self.receipientTextField.text = item
                self.selectedReceipientSearchResult = receipientSearchResult[index]
            }
        }
        
        receipientDropDown.cancelAction = { [unowned self] in
            self.receipientArrow.transform = .init(rotationAngle: 0)
            let item = receipientSearchResult.filter{$0.label == self.receipientTextField.text}.first
            if let item = item{
                self.selectedReceipientSearchResult = item
            }else{
                self.receipientTextField.text = ""
            }
        }
        
        receipientTextField.addTarget(self, action: #selector(receipientAction), for: .editingChanged)
    }
    
    
    private func setUpLanguageDropDown(){
        // languageDropDown
        languageDropDown.anchorView = languageTextField
        
        languageDropDown.bottomOffset = CGPoint(x: 0, y:(languageDropDown.anchorView?.plainView.bounds.height)!)
        languageDropDown.dataSource = ["Arabic".localized(),"English".localized()]
        languageDropDown.selectionAction = { [unowned self] (index: Int, item: String) in
            self.languageArrow.transform = .init(rotationAngle: 0)
            self.languageTextField.text = item
            self.selectedLang = index == 1 ? "en" : "ar"
        }
        
        languageDropDown.cancelAction = { [unowned self] in
            self.languageArrow.transform = .init(rotationAngle: 0)
        }
        languageTextField.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(languageAction)))
    }
    
    
    private func setUpFileVisibiltyDropDown(){
        fileVisibiltyDropDown.anchorView = fileVisiblityView
        fileVisibiltyDropDown.bottomOffset = CGPoint(x: 0, y:(fileVisibiltyDropDown.anchorView?.plainView.bounds.height)!)
        fileVisibiltyDropDown.selectionAction = { [unowned self] (index: Int, item: String) in
            self.fileVisibiltyArrow.transform = .init(rotationAngle: 0)
            self.fileVisibiltyLabel.isHidden = true
            if !self.selectedFileVisiblity.contains(where: {$0.value == fileVisiblityData[index].value}){
                self.selectedFileVisiblity.append(self.fileVisiblityData[index])
                fileVisiblityCollectionView.reloadData()
            }
            
        }
        
        fileVisibiltyDropDown.cancelAction = { [unowned self] in
            self.fileVisibiltyArrow.transform = .init(rotationAngle: 0)
        }
        fileVisiblityView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(fileVisibiltyAction)))
        
    }
    
    
    private func setUpEmployeeNameADropDown(){
        // employeeNameADropDown
        employeeNameADropDown.anchorView = employeeNameATextField
        employeeNameADropDown.bottomOffset = CGPoint(x: 0, y:(employeeNameADropDown.anchorView?.plainView.bounds.height)!)
        employeeNameADropDown.selectionAction = { [unowned self] (index: Int, item: String) in
            self.employeeNameAArrow.transform = .init(rotationAngle: 0)
            if !employeeNameASearchResult.isEmpty{
                self.employeeNameATextField.text = item
                self.selectedASearchResult = employeeNameASearchResult[index]
            }
            
        }
        
        employeeNameADropDown.cancelAction = { [unowned self] in
            self.employeeNameAArrow.transform = .init(rotationAngle: 0)
            let item = employeeNameASearchResult.filter{$0.label == self.employeeNameATextField.text}.first
            if let item = item{
                self.selectedASearchResult = item
            }else{
                self.employeeNameATextField.text = ""
            }
        }
        employeeNameATextField.addTarget(self, action: #selector(employeeNameAAction), for: .editingChanged)
        
    }
    
    private func setUpEmployeeNameBDropDown (){
        // employeeNameBDropDown
        employeeNameBDropDown.anchorView = employeeNameBTextField
        employeeNameBDropDown.bottomOffset = CGPoint(x: 0, y:(employeeNameBDropDown.anchorView?.plainView.bounds.height)!)
        employeeNameBDropDown.selectionAction = { [unowned self] (index: Int, item: String) in
            self.employeeNameBArrow.transform = .init(rotationAngle: 0)
            if !employeeNameBSearchResult.isEmpty{
                self.employeeNameBTextField.text = item
                self.selectedBSearchResult = employeeNameBSearchResult[index]
            }
        }
        
        employeeNameBDropDown.cancelAction = { [unowned self] in
            self.employeeNameBArrow.transform = .init(rotationAngle: 0)
            let item = employeeNameBSearchResult.filter{$0.label == self.employeeNameBTextField.text}.first
            if let item = item{
                self.selectedBSearchResult = item
            }else{
                self.employeeNameBTextField.text = ""
            }
        }
        employeeNameBTextField.addTarget(self, action: #selector(employeeNameBAction), for: .editingChanged)
    }
    
    private func setUpemployeeNameCDropDown(){
        // employeeNameCDropDown
        employeeNameCDropDown.anchorView = employeeNameCTextField
        employeeNameCDropDown.bottomOffset = CGPoint(x: 0, y:(employeeNameCDropDown.anchorView?.plainView.bounds.height)!)
        employeeNameCDropDown.selectionAction = { [unowned self] (index: Int, item: String) in
            self.employeeNameCArrow.transform = .init(rotationAngle: 0)
            if !employeeNameCSearchResult.isEmpty{
                self.employeeNameCTextField.text = item
                self.selectedCSearchResult = employeeNameCSearchResult[index]
            }
        }
        
        employeeNameCDropDown.cancelAction = { [unowned self] in
            self.employeeNameCArrow.transform = .init(rotationAngle: 0)
            let item = employeeNameCSearchResult.filter{$0.label == self.employeeNameCTextField.text}.first
            if let item = item{
                self.selectedCSearchResult = item
            }else{
                self.employeeNameCTextField.text = ""
            }
        }
        employeeNameCTextField.addTarget(self, action: #selector(employeeNameCAction), for: .editingChanged)
    }
    
    
    private func setUpMarkerUsersDropDown(){
        // markerUsersDropDown
        markerUsersDropDown.anchorView = markerUsersTextField
        markerUsersDropDown.bottomOffset = CGPoint(x: 0, y:(markerUsersDropDown.anchorView?.plainView.bounds.height)!)
        markerUsersDropDown.selectionAction = { [unowned self] (index: Int, item: String) in
            self.markerUsersArrow.transform = .init(rotationAngle: 0)
            if !self.markSearchResult.isEmpty && !selectedMarkSearchResult.contains(where: {$0.value == self.markSearchResult[index].value}){
                selectedMarkSearchResult.append(self.markSearchResult[index])
                markersCollectionView.reloadData()
                self.markerUsersTextField.text = ""
            }
        }
        
        markerUsersDropDown.cancelAction = { [unowned self] in
            self.markerUsersArrow.transform = .init(rotationAngle: 0)
        }
        markerUsersTextField.addTarget(self, action: #selector(markerUsersAction), for: .editingChanged)
    }
    
    
    private func setUpReviewerUsersDropDown(){
        // reviewerUsersDropDown
        reviewerUsersDropDown.anchorView = reviewersUsersTextField
        reviewerUsersDropDown.bottomOffset = CGPoint(x: 0, y:(reviewerUsersDropDown.anchorView?.plainView.bounds.height)!)
        reviewerUsersDropDown.selectionAction = { [unowned self] (index: Int, item: String) in
            self.reviewerUsersArrow.transform = .init(rotationAngle: 0)
            if !self.reviewSearchResult.isEmpty && !selectedReviewSearchResult.contains(where: {$0.value == self.reviewSearchResult[index].value}){
                self.selectedReviewSearchResult.append(self.reviewSearchResult[index])
                reviewCollectionView.reloadData()
                self.reviewersUsersTextField.text = ""
            }
        }
        
        reviewerUsersDropDown.cancelAction = { [unowned self] in
            self.reviewerUsersArrow.transform = .init(rotationAngle: 0)
        }
        reviewersUsersTextField.addTarget(self, action: #selector(reviewerUsersAction), for: .editingChanged)
    }
    
    
    @objc private func receipientAction(){
        receipientSearchForUser()
        self.receipientArrow.transform = .init(rotationAngle: .pi)
        
    }
    
    
    @objc private func languageAction(){
        self.languageArrow.transform = .init(rotationAngle: .pi)
        languageDropDown.show()
    }
    
    
    @objc private func fileVisibiltyAction(){
        self.fileVisibiltyArrow.transform = .init(rotationAngle: .pi)
        fileVisibiltyDropDown.show()
    }
    
    
    
    @objc private func employeeNameAAction(){
        empNameASearchForUser()
        self.employeeNameAArrow.transform = .init(rotationAngle: .pi)
    }
    
    
    
    @objc private func employeeNameBAction(){
        empNameBSearchForUser()
        self.employeeNameBArrow.transform = .init(rotationAngle: .pi)
    }
    
    
    
    @objc private func employeeNameCAction(){
        empNameCSearchForUser()
        self.employeeNameCArrow.transform = .init(rotationAngle: .pi)
    }
    
    
    
    @objc private func markerUsersAction(){
        markSearchForUser()
        self.markerUsersArrow.transform = .init(rotationAngle: .pi)
        
    }
    
    
    
    @objc private func reviewerUsersAction(){
        reviewSearchForUser()
        self.reviewerUsersArrow.transform = .init(rotationAngle: .pi)
    }
    
    
    @IBAction func backAction(_ sender: Any) {
        navigationController?.dismiss(animated: true)
    }
    
    
    @IBAction func showMarkersViewAction(_ sender: Any) {
        MarkersView.isHidden = false
        markerUsersArrow.isHidden = false
        addMarkButton.isHidden = true
    }
    
    @IBAction func showReviewerViewAction(_ sender: Any) {
        reviewersView.isHidden = false
        reviewerUsersArrow.isHidden = false
        addReview.isHidden = true
    }
    
    @IBAction func showAttachmentViewAction(_ sender: Any) {
        attachmentsView.isHidden = false
        addAttachmentButton.isHidden = true
    }
    
    @IBAction func addAttachmentAction(_ sender: Any) {
        attachmentsCount += 1
        attachmentsTableViewHeight.constant = CGFloat(attachmentsCount * cellHeight)
        attachmentsTableView.reloadData()
    }
    
    @IBAction func submitAction(_ sender: Any) {
        
        var body:[String:Any] = [:]
        body["subject"] = subjectTextField.text!
        body["attachmentstitle"] = attachmentsTextField.text!
        body["lang_key"] = selectedLang
        
        body["content"] = descriptionTextField.text!
       
        
        if !isIncoming{
            body["transaction_from"] = "[object Object]"
            body["transaction_to"] = toOrganizationTextFiled.text!
            body["needReview"] = addReview.isHidden ? "1" : "0"
            var reviews = ""
            for index in 0..<selectedReviewSearchResult.count {
                reviews.append("\(index != 0 ? "," : "")\(selectedReviewSearchResult[index].value ?? "")")
            }
            body["reviews"] = reviews
            body["extra[transaction_key]"] = "FORM_C1"
            body["needMark"] = addMarkButton.isHidden ? "1" : "0"
            body["needAttach"] = addAttachmentButton.isHidden ? "1" : "0"
            
            body["signature[A][title]"] = jopTitleATextField.text!
            body["signature[A][user_id]"] = selectedASearchResult?.value ?? ""
            body["signature[B][title]"] = jobTitleBTextField.text!
            body["signature[B][user_id]"] = selectedBSearchResult?.value ?? ""
            body["signature[C][title]"] = jopTitleCTextField.text!
            body["signature[C][user_id]"] = selectedCSearchResult?.value ?? ""
            
        }else{
            body["transaction_from"] = fromTextFiled.text!
            body["transaction_to"] = "1"
            body["extra[transaction_key]"] = "FORM_C2"
            body["needMark"] = "1"
            body["signature[C][user_id]"] = selectedReceipientSearchResult?.value ?? ""
            body["issued_number"] = issuedNumberTextField.text!
            body["issued_date_m"] = issueDateEnglishTextField.text!
            body["issued_date_h"] = self.selectedDatainAr
        }
        
        
        
        
        var marks = ""
        for index in 0..<selectedMarkSearchResult.count {
            marks.append("\(index != 0 ? "," : "")\(selectedMarkSearchResult[index].value ?? "")")
        }
        body["marks"] = marks
        var files:[String:URL] = [:]
        
        if !isIncoming{
            for index in 0..<attachmentsCount{
                let cell = attachmentsTableView.cellForRow(at: IndexPath(row: index, section: 0)) as! OutgoingAttachmentTableViewCell
                if let fileUrl = cell.fileUrl{
                    files["attachments[\(index)][file]"] = fileUrl
                    body["attachments[\(index)][attach_title]"] = cell.descriptionTextField.text!
                    body["attachments[\(index)][attach_with_the_document]"] = cell.attachwithPdfButton.isSelected ? "1" : "0"
                    body["attachments[\(index)][print_official_paper]"] = cell.officialPaperButton.isSelected ? "1" : "0"
                }
            }
        }else{
            for index in 0..<attachmentsCount{
                let cell = attachmentsTableView.cellForRow(at: IndexPath(row: index, section: 0)) as! OutgoingAttachmentTableViewCell
                if let fileUrl = cell.fileUrl{
                    files["attachments[\(index)][file]"] = fileUrl
                    body["attachments[\(index)][attach_title]"] = cell.descriptionTextField.text!
                }
            }
        }
        
        body["extra[module_key]"] = "human_resources"
        body["extra[employee_number]"] = ViewEmployeeDetailsVC.empData.data?.employee_number ?? ""
        
        
        var levels = ""
        for index in 0..<selectedFileVisiblity.count {
            levels.append("\(index != 0 ? "," : "")\(selectedFileVisiblity[index].value ?? "")")
        }
        body["extra[file_level_keys]"] = levels
        submitCommunicationDetails(files:files,body: body)
    }
    
    @IBAction func calenderAction(_ sender: Any) {
        dateController.present(above: self)
    }
    
}
// MARK: - Set Up Table View
extension OutgoingVC:UITableViewDelegate,UITableViewDataSource{
    private func setUpTableView(){
        attachmentsTableView.delegate = self
        attachmentsTableView.dataSource = self
        attachmentsTableViewHeight.constant = CGFloat(attachmentsCount * cellHeight)
        attachmentsTableView.register(.init(nibName: "OutgoingAttachmentTableViewCell", bundle: nil), forCellReuseIdentifier: "OutgoingAttachmentTableViewCell")
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return attachmentsCount
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "OutgoingAttachmentTableViewCell", for: indexPath) as! OutgoingAttachmentTableViewCell
        cell.attachwithPdfStackView.isHidden = isIncoming
        cell.officialPaperStackView.isHidden = isIncoming
        cell.index = indexPath.row
        cell.delegate = self
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return CGFloat(cellHeight)
    }
    
}

extension OutgoingVC:OutgoingAttachmentCellDelegate{
    func selectFileAction(index:Int) {
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
    
    func deleteAction() {
        if attachmentsCount > 1{
            attachmentsCount -= 1
            attachmentsTableViewHeight.constant = CGFloat(attachmentsCount * cellHeight)
            attachmentsTableView.reloadData()
        }
    }
    
    
    private func selectAttachment(){
        documentPickerController = UIDocumentPickerViewController(
            forOpeningContentTypes: [.pdf])
        documentPickerController.delegate = self
        self.present(documentPickerController, animated: true, completion: nil)
    }
}
// MARK: - UIDocumentPickerViewControllerDelegate

extension OutgoingVC:UIDocumentPickerDelegate{
    public func documentPicker(_ controller: UIDocumentPickerViewController, didPickDocumentsAt urls: [URL]) {
        guard let myURL = urls.first else {
            return
        }
        if let currentIndex = currentIndex{
            let cell = attachmentsTableView.cellForRow(at: IndexPath(row: currentIndex, section: 0)) as! OutgoingAttachmentTableViewCell
            cell.selectFileButton.setTitle(myURL.lastPathComponent , for: .normal)
            cell.fileUrl = myURL
        }
        
    }
    
    func documentPickerWasCancelled(_ controller: UIDocumentPickerViewController) {
        dismiss(animated: true, completion: nil)
    }
}


// MARK: - UIImagePickerControllerDelegate
extension OutgoingVC : UIImagePickerControllerDelegate , UINavigationControllerDelegate{
    private func setImageBy(source:UIImagePickerController.SourceType){
        let imagePicker = UIImagePickerController()
        imagePicker.delegate = self
        imagePicker.allowsEditing = true
        imagePicker.sourceType = source
        present(imagePicker, animated: true, completion: nil)
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        if let imgUrl = info[UIImagePickerController.InfoKey.imageURL] as? URL , let currentIndex = currentIndex{
            let cell = attachmentsTableView.cellForRow(at: IndexPath(row: currentIndex, section: 0)) as! OutgoingAttachmentTableViewCell
            cell.selectFileButton.setTitle(imgUrl.lastPathComponent, for: .normal)
            cell.fileUrl = imgUrl
        }
        dismiss(animated: true, completion: nil)
    }
    
}


// MARK: - Set Up Collection View
extension OutgoingVC:UICollectionViewDelegate,UICollectionViewDataSource{
    private func setUpCollectionView(){
        fileVisiblityCollectionView.delegate = self
        fileVisiblityCollectionView.dataSource = self
        
        markersCollectionView.delegate = self
        markersCollectionView.dataSource = self
        
        reviewCollectionView.delegate = self
        reviewCollectionView.dataSource = self
        
        fileVisiblityCollectionView.register(.init(nibName: "UsersCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "UsersCollectionViewCell")
        
        markersCollectionView.register(.init(nibName: "UsersCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "UsersCollectionViewCell")
        
        reviewCollectionView.register(.init(nibName: "UsersCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "UsersCollectionViewCell")
        
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        switch collectionView{
        case fileVisiblityCollectionView:
            return selectedFileVisiblity.count
        case markersCollectionView:
            return selectedMarkSearchResult.count
        case reviewCollectionView:
            return selectedReviewSearchResult.count
        default:
            return 0
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "UsersCollectionViewCell", for: indexPath) as! UsersCollectionViewCell
        switch collectionView{
        case fileVisiblityCollectionView:
            cell.setData(index:0,data: selectedFileVisiblity[indexPath.row], indexPath: indexPath)
        case markersCollectionView:
            cell.setData(index:1,data: selectedMarkSearchResult[indexPath.row], indexPath: indexPath)
        case reviewCollectionView:
            cell.setData(index:2,data: selectedReviewSearchResult[indexPath.row], indexPath: indexPath)
        default:
            break
        }
        cell.delegate = self
        return cell
    }
}

// MARK: - Set Up Collection View Cell Delegate

extension OutgoingVC:UsersCollectionViewCellDelegate{
    func removeAction(index: Int, indexPath: IndexPath) {
        switch index {
        case 0:
            selectedFileVisiblity.remove(at: indexPath.row)
            fileVisiblityCollectionView.reloadData()
            fileVisibiltyLabel.isHidden = !selectedFileVisiblity.isEmpty
        case 1:
            selectedMarkSearchResult.remove(at: indexPath.row)
            markersCollectionView.reloadData()
        case 2:
            selectedReviewSearchResult.remove(at: indexPath.row)
            reviewCollectionView.reloadData()
        default:
            break
        }
    }
}



// MARK: - API Handling

extension OutgoingVC{
    
    private func submitCommunicationDetails(files:[String:URL],body:[String:Any]){
        showLoadingActivity()
        APIController.shard.submitCommunicationDetails(isIncoming:isIncoming,files:files,body: body) { data in
            DispatchQueue.main.async {
                self.hideLoadingActivity()
                var alertVC: UIAlertController!
                if let status = data.status,status{
                    alertVC = UIAlertController(title: "Success".localized(), message: "Action has been completed successfully !!!".localized(), preferredStyle: .alert)
                    alertVC.addAction(.init(title: "Cancel".localized(), style: .cancel, handler: { action in
                        let vc:ViewOutgoingViewController = AppDelegate.HRSB.instanceVC()
                        vc.id = "\(data.transaction_request_id ?? -1)"
                        vc.isIncoming = self.isIncoming
                        self.navigationController?.pushViewController(vc, animated: true)
                    }))
                }else{
                    alertVC = UIAlertController(title: "error".localized(), message: data.error, preferredStyle: .alert)
                    alertVC.addAction(.init(title: "Cancel".localized(), style: .cancel, handler: nil))
                }
                self.present(alertVC, animated: true)
            }
        }
    }
    
    private func getFileVisibiltyData(){
        APIController.shard.getVisibiltyData { data in
            if let status = data.status,status{
                self.fileVisiblityData = data.records ?? []
                self.fileVisibiltyDropDown.dataSource = self.fileVisiblityData.map{$0.label ?? ""}
            }
        }
    }
    
    private func empNameASearchForUser(){
        let lang = L102Language.currentAppleLanguage()
        APIController.shard.searchForUser(searchText: employeeNameATextField.text!, lang: lang , id: "1") { data in
            if let status = data.status,status{
                if let list = data.list{
                    self.employeeNameASearchResult = list
                    self.employeeNameADropDown.dataSource = list.map{$0.label ?? ""}
                    
                }
            }else{
                self.employeeNameASearchResult.removeAll()
                self.employeeNameADropDown.dataSource = [data.error ?? ""]
            }
            self.employeeNameADropDown.show()
        }
    }
    
    private func empNameBSearchForUser(){
        let lang = L102Language.currentAppleLanguage()
        APIController.shard.searchForUser(searchText: employeeNameBTextField.text!, lang: lang , id: "1") { data in
            if let status = data.status,status{
                if let list = data.list{
                    self.employeeNameBSearchResult = list
                    self.employeeNameBDropDown.dataSource = list.map{$0.label ?? ""}
                    
                }
            }else{
                self.employeeNameBSearchResult.removeAll()
                self.employeeNameBDropDown.dataSource = [data.error ?? ""]
            }
            self.employeeNameBDropDown.show()
        }
    }
    
    private func empNameCSearchForUser(){
        let lang = L102Language.currentAppleLanguage()
        APIController.shard.searchForUser(searchText: employeeNameCTextField.text!, lang: lang , id: "1") { data in
            if let status = data.status,status{
                if let list = data.list{
                    self.employeeNameCSearchResult = list
                    self.employeeNameCDropDown.dataSource = list.map{$0.label ?? ""}
                    
                }
            }else{
                self.employeeNameCSearchResult.removeAll()
                self.employeeNameCDropDown.dataSource = [data.error ?? ""]
            }
            self.employeeNameCDropDown.show()
        }
    }
    
    
    private func markSearchForUser(){
        let lang = L102Language.currentAppleLanguage()
        APIController.shard.searchForUser(searchText: markerUsersTextField.text!, lang: lang , id: "1") { data in
            if let status = data.status,status{
                if let list = data.list{
                    self.markSearchResult = list
                    self.markerUsersDropDown.dataSource = list.map{$0.label ?? ""}
                }
            }else{
                self.markSearchResult.removeAll()
                self.markerUsersDropDown.dataSource = [data.error ?? ""]
            }
            self.markerUsersDropDown.show()
        }
    }
    
    
    private func reviewSearchForUser(){
        let lang = L102Language.currentAppleLanguage()
        APIController.shard.searchForUser(searchText: reviewersUsersTextField.text!, lang: lang , id: "1") { data in
            if let status = data.status,status{
                if let list = data.list{
                    self.reviewSearchResult = list
                    self.reviewerUsersDropDown.dataSource = list.map{$0.label ?? ""}
                }
            }else{
                self.reviewSearchResult.removeAll()
                self.reviewerUsersDropDown.dataSource = [data.error ?? ""]
            }
            self.reviewerUsersDropDown.show()
        }
    }
    
    private func receipientSearchForUser(){
        let lang = L102Language.currentAppleLanguage()
        APIController.shard.searchForUser(searchText: receipientTextField.text!, lang: lang , id: "1") { data in
            if let status = data.status,status{
                if let list = data.list{
                    self.receipientSearchResult = list
                    self.receipientDropDown.dataSource = list.map{$0.label ?? ""}
                }
            }else{
                self.receipientSearchResult.removeAll()
                self.receipientDropDown.dataSource = [data.error ?? ""]
            }
            self.receipientDropDown.show()
        }
    }
}


