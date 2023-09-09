//
//  AddAttachmentViewController.swift
//  Almnabr
//
//  Created by Hany Alkahlout on 16/06/2022.
//  Copyright © 2022 Samar Akkila. All rights reserved.
//

import UIKit
import DropDown
import MobileCoreServices
import UniformTypeIdentifiers

class AddAttachmentViewController: UIViewController {
    
    @IBOutlet weak var attachmentTypeTextField: UITextField!
    @IBOutlet weak var attachTypeArrow: UIImageView!
    
    @IBOutlet weak var backButton: UIButton!
    
    @IBOutlet weak var descriptionTextField: UITextField!
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var visiblityView: UIView!
    @IBOutlet weak var visiblityArrow: UIImageView!
    @IBOutlet weak var visiblityLabel: UILabel!
    @IBOutlet weak var fileSelectionView: UIView!
    
    @IBOutlet weak var selectFileButton: UIButton!
    
    private var documentPickerController: UIDocumentPickerViewController!
    private var visibiltyData = [SearchBranchRecords]()
    private var selectedItems = [SearchBranchRecords]()
    private var dropDown = DropDown()
    private var attachTypeDropDown = DropDown()
    private var fileUrl:URL?
    private var attachmentTypes = [AttachmentTypeRecords]()
    var attachmentType = ""
    var attachmentData:AttachmentRecords?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        initlization()

    }
    
    private func initlization(){
        if L102Language.currentAppleLanguage() == "ar"{
            backButton.transform = .init(rotationAngle: .pi)
        }
        setUpCollectionView()
        getVisibiltyData()
        setUpDropDownList()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        if attachmentType.isEmpty{
            if let attachmentData = attachmentData {
                attachmentTypeTextField.isHidden = true
                attachTypeArrow.isHidden = true
                fileSelectionView.isHidden = true
                descriptionTextField.text = attachmentData.file_name ?? ""
                
            }else{
                attachmentTypeTextField.isHidden = false
                attachTypeArrow.isHidden = false
                getAttachmentTypes()
            }
        }else{
            attachmentTypeTextField.isHidden = true
            attachTypeArrow.isHidden = true
        }
    }
    
    
    private func setUpDropDownList(){
        // dropDown
        dropDown.anchorView = visiblityView
        dropDown.bottomOffset = CGPoint(x: 0, y:(dropDown.anchorView?.plainView.bounds.height)!)
        
        dropDown.selectionAction = { [unowned self] (index: Int, item: String) in
            visiblityArrow.transform = .init(rotationAngle: 0)
            let selectedItem = visibiltyData[index]
            if !self.selectedItems.contains(where: {$0.value == selectedItem.value}){
                self.selectedItems.append(selectedItem)
                self.collectionView.reloadData()
                self.visiblityLabel.isHidden = true
            }
        }
        
        dropDown.cancelAction = { [unowned self] in
            visiblityArrow.transform = .init(rotationAngle: 0)
        }
        visiblityView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(visiblityViewAction)))
        
        // attachTypeDropDown
        attachTypeDropDown.anchorView = attachmentTypeTextField
        attachTypeDropDown.bottomOffset = CGPoint(x: 0, y:(attachTypeDropDown.anchorView?.plainView.bounds.height)!)
        
        attachTypeDropDown.selectionAction = { [unowned self] (index: Int, item: String) in
            attachTypeArrow.transform = .init(rotationAngle: 0)
            attachmentTypeTextField.text = item
            self.attachmentType = attachmentTypes[index].key_code ?? ""
        }
        
        attachTypeDropDown.cancelAction = { [unowned self] in
            attachTypeArrow.transform = .init(rotationAngle: 0)
        }
        attachmentTypeTextField.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(attachmentTypeAction)))
        
    }
    
    
    private func selectAttachment(){
        documentPickerController = UIDocumentPickerViewController(
            forOpeningContentTypes: [.pdf])
        documentPickerController.delegate = self
        self.present(documentPickerController, animated: true, completion: nil)
    }
    
    
    @objc private func attachmentTypeAction(){
        attachTypeArrow.transform = .init(rotationAngle: .pi)
        attachTypeDropDown.show()
    }
    
    
    @objc private func visiblityViewAction(){
        visiblityArrow.transform = .init(rotationAngle: .pi)
        dropDown.show()
    }
    
    
    @IBAction func selectFileAction(_ sender: Any) {
        let alertVC = UIAlertController(title: "", message: "", preferredStyle: .actionSheet)
        alertVC.addAction(.init(title: "Choose Photo".localized(), style: .default, handler: { action in
            self.setImageBy(source: .photoLibrary)
        }))
        alertVC.addAction(.init(title: "Choose Pdf".localized(), style: .default, handler: { action in
            self.selectAttachment()
        }))
        present(alertVC, animated: true, completion: nil)
    }
    
    
    @IBAction func backAction(_ sender: Any) {
        navigationController?.popViewController(animated: true)
    }
    
    
    @IBAction func submitAction(_ sender: Any) {
        var param:[String:Any] = [:]
        if let attachmentData = attachmentData {
            param["file_records_id"] = attachmentData.file_records_id ?? ""
        }else{
            param["attachment_type"] = attachmentType
        }
        
        param["employee_number"] = ViewEmployeeDetailsVC.empData.data?.employee_number ?? ""
        param["attachment_descriptions"] = descriptionTextField.text!
        
        for index in 0..<selectedItems.count {
            param["level_keys[\(index)]"] = selectedItems[index].value ?? ""
        }
        
        uploadAttachmentData(isUpdate:attachmentData != nil,body: param)
        
    }
    
}

// MARK: - UIDocumentPickerViewControllerDelegate
extension AddAttachmentViewController:UIDocumentPickerDelegate{
    public func documentPicker(_ controller: UIDocumentPickerViewController, didPickDocumentsAt urls: [URL]) {
        guard let myURL = urls.first else {
            return
        }
        selectFileButton.setTitle(myURL.lastPathComponent, for: .normal)
        self.fileUrl = myURL
    }
    
    func documentPickerWasCancelled(_ controller: UIDocumentPickerViewController) {
        dismiss(animated: true, completion: nil)
    }
}


// MARK: - UIImagePickerControllerDelegate
extension AddAttachmentViewController : UIImagePickerControllerDelegate , UINavigationControllerDelegate{
    private func setImageBy(source:UIImagePickerController.SourceType){
        let imagePicker = UIImagePickerController()
        imagePicker.delegate = self
        imagePicker.allowsEditing = true
        imagePicker.sourceType = source
        present(imagePicker, animated: true, completion: nil)
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        let imgUrl = info[UIImagePickerController.InfoKey.imageURL] as? URL
        selectFileButton.setTitle(imgUrl?.lastPathComponent ?? "Select File".localized(), for: .normal)
        fileUrl = imgUrl
        dismiss(animated: true, completion: nil)
    }
}


// MARK: - Set Up Collection View

extension AddAttachmentViewController:UICollectionViewDelegate,UICollectionViewDataSource{
    private func setUpCollectionView(){
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.register(.init(nibName: "UsersCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "UsersCollectionViewCell")
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return selectedItems.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "UsersCollectionViewCell", for: indexPath) as! UsersCollectionViewCell
        cell.delegate = self
        cell.setData(data: selectedItems[indexPath.row], indexPath: indexPath)
        return cell
    }
    
}


// MARK: - Collection View Cell Delegate
extension AddAttachmentViewController: UsersCollectionViewCellDelegate{
 
    func removeAction(indexPath: IndexPath) {
        selectedItems.remove(at: indexPath.row)
        collectionView.reloadData()
        if selectedItems.isEmpty{
            visiblityLabel.isHidden = false
        }
    }
   
}


// MARK: - API Handling

extension AddAttachmentViewController{
    private func getVisibiltyData(){
        APIController.shard.getVisibiltyData { data in
            DispatchQueue.main.async{
                if let status = data.status, status{
                    self.visibiltyData = data.records ?? []
                    self.dropDown.dataSource = (data.records ?? []).map{$0.label ?? ""}
                    if let attachmentData = self.attachmentData{
                        let levelkey = attachmentData.level_keys?.components(separatedBy: ",")
                        for item in levelkey!{
                            if let newItem = self.visibiltyData.filter({$0.value == item}).first{
                                self.selectedItems.append(newItem)
                            }
                        }
                        self.collectionView.reloadData()
                        self.visiblityLabel.isHidden = !self.selectedItems.isEmpty
                    }
                }
            }
        }
    }
    
    private func uploadAttachmentData(isUpdate:Bool,body:[String:Any]){
        showLoadingActivity()
        if !isUpdate{
            APIController.shard.uploadAttachmentData(fileUrl: fileUrl, body: body) { data in
                self.handleResponseData(data: data)
                if self.attachmentType == "EN0001"{
                    ViewEmployeeDetailsVC.empData.attachments?.en0001 = data.attachments?.en0001
                    ViewEmployeeDetailsVC.empData.attachments?.en0001_d = data.attachments?.en0001_d
                    NotificationCenter.default.post(name: .init(rawValue: "SetUpAttachReviewEN"), object: nil)
                }else if self.attachmentType == "IR0001"{
                    ViewEmployeeDetailsVC.empData.attachments?.ir0001 = data.attachments?.ir0001
                    ViewEmployeeDetailsVC.empData.attachments?.ir0001_d = data.attachments?.ir0001_d
                    NotificationCenter.default.post(name: .init(rawValue: "SetUpAttachReviewIR"), object: nil)
                }
            }
        }else{
            APIController.shard.updateAttachmentData(body: body) { data in
                self.handleResponseData(data: data)
            }
        }
    }
    
    private func handleResponseData(data:UpdateSettingResponse){
        DispatchQueue.main.async{
            self.hideLoadingActivity()
            
            var alertVC:UIAlertController!
            if let status = data.status,status{
                alertVC = UIAlertController(title: "Success".localized(), message: data.msg, preferredStyle: .alert)
                alertVC.addAction(.init(title: "Cancel".localized(), style: .cancel, handler: { action in
                    self.navigationController?.popViewController(animated: true)
                }))
            }else{
                alertVC = UIAlertController(title: "error".localized(), message: data.error, preferredStyle: .alert)
                alertVC.addAction(.init(title: "Cancel".localized(), style: .cancel, handler:nil))
            }
            self.present(alertVC, animated: true)
        }
    }
    
    private func getAttachmentTypes(){
        APIController.shard.getAttachmentTypes { data in
            if let status = data.status,status{
                self.attachmentTypes = data.records ?? []
                self.attachTypeDropDown.dataSource = (data.records ?? []).map{$0.title ?? ""}
            }
        }
    }
}


extension URL {
    public func mimeType() -> String {
        if let mimeType = UTType(filenameExtension: self.pathExtension)?.preferredMIMEType {
            return mimeType
        }
        else {
            return "application/octet-stream"
        }
    }
}
