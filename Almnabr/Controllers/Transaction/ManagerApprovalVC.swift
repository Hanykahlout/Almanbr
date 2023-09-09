//
//  ManagerApprovalVC.swift
//  Almnabr
//
//  Created by MacBook on 07/12/2021.
//  Copyright © 2021 Samar Akkila. All rights reserved.
//

import UIKit
import DropDown
import MobileCoreServices

class ManagerApprovalVC: UIViewController, UINavigationControllerDelegate {
    
    
    @IBOutlet weak var icon_noPermission: UIImageView!
    @IBOutlet weak var view_noPermission: UIView!
    @IBOutlet weak var lbl_noPermission: UILabel!
    
    @IBOutlet weak var lbl_Title: UILabel!
    @IBOutlet weak var lbl_ManagerApprovalQ: UILabel!
    @IBOutlet weak var lbl_Return: UILabel!
    @IBOutlet weak var lbl_Approve: UILabel!
    @IBOutlet weak var lbl_notes: UILabel!
    
    @IBOutlet weak var lbl_CustomerRepresntativeQ: UILabel!
    @IBOutlet weak var stack_CustomerRepresntative: UIStackView!
    @IBOutlet weak var lbl_CustomerNote: UILabel!
    
    @IBOutlet weak var lbl_CustomerUploadQ: UILabel!
    @IBOutlet weak var stack_CustomerUpload: UIStackView!
    
    @IBOutlet weak var lbl_No: UILabel!
    @IBOutlet weak var lbl_Yes: UILabel!
    
    @IBOutlet weak var lbl_upload: UILabel!
    @IBOutlet weak var lbl_Assign: UILabel!
    
    @IBOutlet weak var txt_notes: UITextView!
    
    @IBOutlet weak var btn_checkYes: UIButton!
    @IBOutlet weak var btn_checkNo: UIButton!
    
    @IBOutlet weak var btn_checkApprove: UIButton!
    @IBOutlet weak var btn_checkReturn: UIButton!
    
    @IBOutlet weak var btn_checkUpload: UIButton!
    @IBOutlet weak var btn_checkAssign: UIButton!
    
    
    @IBOutlet weak var btn_submit: UIButton!
    
    @IBOutlet weak var view_main: UIView!
    
    @IBOutlet weak var view_txtView: UIView!
    @IBOutlet weak var lbl_ownerUsers: UILabel!
    @IBOutlet weak var btn_ownerUsers: UIButton!
    @IBOutlet weak var lbl_ownerUserSelect: UILabel!
    @IBOutlet weak var stack_ownerUser: UIStackView!
    @IBOutlet weak var view_ownerUser: UIView!
    @IBOutlet weak var imgDropOwner: UIImageView!
    @IBOutlet weak var btn_cancel_ownerUsers: UIButton!
    @IBOutlet weak var stack_uploadAttachment: UIView!
    @IBOutlet weak var lbl_uploadAttachments: UILabel!
    @IBOutlet weak var table: UITableView!
    
    var Selected_index:Int = 0
    var manager_approval_approval_status:String = ""
    var customr_representative_required:String = ""
    var customer_representative_type:String = ""
    
    var arr_data:[AttachmentsObj] = []
    var arr_file:[attachment] = []
    
    var param = [:] as [String : String]
    
    var arr_ownerUsers:[ModuleObj] = []
    var arr_ownerUsersLabel:[String] = []
    var arr_NoData:[String] = ["No items found".localized()]
    var owner_users:String = ""
    
    let imagePickerController = UIImagePickerController()
    var documentInteractionController: UIDocumentPickerViewController? = nil
    
    
    let dropUpmage =  UIImage.fontAwesomeIcon(name: .chevronUp , style: .solid, textColor:  .gray, size: CGSize(width: 40, height: 40))
    
    let dropDownmage =  UIImage.fontAwesomeIcon(name: .chevronDown , style: .solid, textColor:  .gray, size: CGSize(width: 40, height: 40))
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        configGUI()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
//        configGUI()
    }
    
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
      //  configGUI()
    }
    
    
    //MARK: - Config GUI
    //------------------------------------------------------
    func configGUI() {
        
        icon_noPermission.no_permission()
        
        self.lbl_noPermission.text =  "You not have permission to access this step".localized()
        self.lbl_noPermission.font = .kufiRegularFont(ofSize: 15)
        self.lbl_noPermission.textColor =  "#333".getUIColor()
        
        self.lbl_uploadAttachments.text = "Upload attachment".localized() + " *"
        self.lbl_uploadAttachments.font = .kufiRegularFont(ofSize: 13)
        
        if StatusObject?.Manager_Approval == false {
            view_noPermission.isHidden = false
            self.view_main.isHidden = true

        }else{
//            self.get_OwnerUser()
            view_noPermission.isHidden = true
            self.view_main.isHidden = false
        }

        imagePickerController.delegate = self
        
        self.txt_notes.text = ""
        self.btn_checkReturn.setImage("uncheck".to_image, for: .normal)
        self.btn_checkApprove.setImage("uncheck".to_image, for: .normal)
        
        self.btn_checkUpload.setImage(UIImage(named: "uncheck"), for: .normal)
        self.btn_checkAssign.setImage(UIImage(named: "uncheck"), for: .normal)
        
        
        self.lbl_CustomerNote.text =  "( Note : The consultant decision in this request will not be confirmed until reviewing owner representative response )".localized()
        self.lbl_CustomerNote.font = .kufiRegularFont(ofSize: 12)
        self.lbl_CustomerNote.textColor =  .red
        self.lbl_CustomerNote.isHidden = true
        
        self.lbl_Title.text =  "Manager Approval".localized()
        self.lbl_Title.font = .kufiRegularFont(ofSize: 13)
        self.lbl_Title.textColor =  maincolor
        
    
        self.lbl_ManagerApprovalQ.text =  "Manager Approval".localized() +  " !?. "
        self.lbl_ManagerApprovalQ.font = .kufiRegularFont(ofSize: 13)
        self.lbl_ManagerApprovalQ.textColor =  maincolor
        
        
        self.lbl_Return.text =  "Return to technical assistant to re-submit".localized()
        self.lbl_Return.font = .kufiRegularFont(ofSize: 13)
       // self.lbl_Return.textColor =  maincolor
        
        
        self.lbl_Approve.text =  "Approve".localized()
        self.lbl_Approve.font = .kufiRegularFont(ofSize: 13)
       // self.lbl_Approve.textColor = maincolor
        
        self.lbl_notes.text =  "Rejected Notes :".localized()
        self.lbl_notes.font = .kufiRegularFont(ofSize: 13)
        self.lbl_notes.textColor =  maincolor
        
        
        self.lbl_CustomerRepresntativeQ.text =  "Customer Representative Required !?.".localized()
        self.lbl_CustomerRepresntativeQ.font = .kufiRegularFont(ofSize: 13)
        self.lbl_CustomerRepresntativeQ.textColor =  maincolor
        
        
        self.btn_checkNo.setImage(UIImage(named: "uncheck"), for: .normal)
        self.btn_checkYes.setImage(UIImage(named: "uncheck"), for: .normal)
        
        
        self.lbl_No.text =  "No".localized()
        self.lbl_No.font = .kufiRegularFont(ofSize: 13)
       // self.lbl_No.textColor =  maincolor
        
        self.lbl_Yes.text =  "Yes".localized()
        self.lbl_Yes.font = .kufiRegularFont(ofSize: 13)
      //  self.lbl_Yes.textColor =  HelperClassSwift.bcolor.getUIColor()
        
        
        self.lbl_upload.text =  "Upload customer approved document".localized()
        self.lbl_upload.font = .kufiRegularFont(ofSize: 13)
// self.lbl_upload.textColor =  HelperClassSwift.bcolor.getUIColor()
        
        self.lbl_Assign.text =  "Assign owner user for confirmation".localized()
        self.lbl_Assign.font = .kufiRegularFont(ofSize: 13)
    //    self.lbl_Assign.textColor =  HelperClassSwift.bcolor.getUIColor()
        
        
        self.lbl_CustomerUploadQ.text =  "Customer Representative ? :".localized()
        self.lbl_CustomerUploadQ.font = .kufiRegularFont(ofSize: 13)
        self.lbl_CustomerUploadQ.textColor =  maincolor
        
        
        self.lbl_ownerUsers.text = "Owner users".localized()
        self.lbl_ownerUsers.font = .kufiRegularFont(ofSize: 13)
        self.lbl_ownerUsers.textColor =  maincolor
        
        
        self.lbl_ownerUserSelect.text = "Owner users".localized()
        self.lbl_ownerUserSelect.font = .kufiRegularFont(ofSize: 13)
      //  self.lbl_ownerUserSelect.textColor =  HelperClassSwift.bcolor.getUIColor()
        
        self.lbl_CustomerUploadQ.isHidden = true
        self.stack_CustomerUpload.isHidden = true
      
        self.stack_ownerUser.isHidden = true
        
        self.lbl_CustomerRepresntativeQ.isHidden = true
        self.stack_CustomerRepresntative.isHidden = true
        
        self.lbl_notes.isHidden = true
        self.view_txtView.isHidden = true
        
        self.view_ownerUser.setBorderGray()
        
        self.view_txtView.setBorderGray()
        
        
        self.btn_cancel_ownerUsers.isHidden = true
        
        self.btn_submit.setTitle("Submit".localized(), for: .normal)
        self.btn_submit.backgroundColor = "#1A3665".getUIColor()
        self.btn_submit.setTitleColor(.white, for: .normal)
        
       
        
        self.stack_uploadAttachment.isHidden = true
        
        table.dataSource = self
        table.delegate = self
        let nib = UINib(nibName: "AttachmentsCell", bundle: nil)
        table.register(nib, forCellReuseIdentifier: "AttachmentsCell")
    }

    
    
    func get_OwnerUser(){
     
        
        self.showLoadingActivity()
        APIController.shard.sendRequestGetAuth(urlString: "form/\(obj_transaction?.transaction_key ?? " ")/customer_users?lang_key=en&user_position=CST001,CSM001&projects_work_area_id=\(obj_FormWir?.projects_work_area_id ?? "1")" ) { (response) in
            
            
            let status = response["status"] as? Bool
            if status == true{
                if  let list = response["records"] as? NSArray{
                    for i in list {
                        let dict = i as? [String:Any]
                        let obj = ModuleObj.init(dict!)
                        self.arr_ownerUsers.append(obj)
                        self.arr_ownerUsersLabel.append(obj.label)
                       
                    }
                    self.hideLoadingActivity()
                }
            }
            self.hideLoadingActivity()
            
        }
    }
    
    
    
    func submit_Request(){
        
        
        if  self.manager_approval_approval_status != "" {
            
            self.showLoadingActivity()
            
            let params = ["transaction_request_id" : obj_transaction?.transaction_request_id ?? "0",
                          "manager_approval_approval_status":self.manager_approval_approval_status ,
                          "rejected_notes":self.txt_notes.text ?? "",
                          "customr_representative_required": self.customr_representative_required,
                          "customer_representative_type":self.customer_representative_type,
                          "owner_users" : owner_users,
                          "transactions_persons_action_code" : "501658"]
            APIController.shard.sendRequestPostAuth(urlString: "form/\(obj_transaction?.transaction_key ?? " ")/Manager_Approval/0", parameters: params ) { (response) in
                self.hideLoadingActivity()
               
                
                let status = response["status"] as? Bool
                let msg = response["msg"] as? String
                let error = response["error"] as? String
                
                if status == true{
                    self.hideLoadingActivity()
                    self.showAMessage(withTitle: "Success".localized(), message: msg ?? "Thank you. The operation was completed successfully.", completion: {
                        self.update_Config()
//                        self.configGUI()
//                        self.change_page(SelectedIndex:5)
                    })
                    
                }else{
                    self.hideLoadingActivity()
                    self.showAMessage(withTitle: "Error", message: error ?? "Some thing went wrong")
                    
                }
                }
            
            
        }else {
            
            self.showAMessage(withTitle: "Error".lowercased(), message: "Some thing went wrong")
            return
        }
   

    }
    
    
    
    func Submit_request(){
        
        
        if self.customer_representative_type == "upload_customer_approved_document" {
           
            guard arr_file.count != 0 else {
                showAMessage(withTitle: "error".localized(), message: "Please enter your file".localized())
                return
            }
        }
   
        if self.manager_approval_approval_status == "Return" {
            guard txt_notes.text != "" else {
                showAMessage(withTitle: "error".localized(), message: "Please enter your Notes".localized())
                return
            }
        }
        
      
        
        for i in arr_file {
            self.param["attachments[\(i.index)][attach_title]"] = i.title
        }
        
        param["customr_representative_required"] =  self.customr_representative_required
        param["customer_representative_type"] = self.customer_representative_type
        param["owner_users"] = owner_users
        
        
        param["transaction_request_id"] =  obj_transaction?.transaction_request_id ?? "0"
        param["manager_approval_approval_status"] = self.manager_approval_approval_status
        
        param["rejected_notes"] = self.txt_notes.text ?? ""
        
        showLoadingActivity()
        
        APIController.shard.func_Upload(queryString: "/form/\(obj_transaction?.transaction_key ?? " ")/Manager_Approval/0", arr_file, param: self.param ) { (respnse ) in
            
            let status = respnse["status"] as? Bool
            let msg = respnse["msg"] as? String
            let error = respnse["error"] as? String

            if status == true{
                self.hideLoadingActivity()
                self.showAMessage(withTitle: "Success".localized(), message: msg ?? "Thank you. The operation was completed successfully.", completion: {

                    self.update_Config()
                })
                
            }else{
                self.hideLoadingActivity()
                self.showAMessage(withTitle: "Error", message: error ?? "Some thing went wrong")
                
            }

            self.hideLoadingActivity()
            
            
        }
        
        
        
    }
    
    
    func Upload_file(){
        
        imagePickerController.allowsEditing = true
        let actionsheet = UIAlertController(title: nil, message: nil, preferredStyle: .actionSheet)
        actionsheet.addAction(UIAlertAction(title: "Choose photo".localized(), style: .default, handler: { (action:UIAlertAction)in
            self.imagePickerController.allowsEditing = true
            self.imagePickerController.mediaTypes = ["public.image"]
            
            self.present(self.imagePickerController, animated: true, completion: nil)
            self.imagePickerController.sourceType = .photoLibrary
            
        }))
        
                
        actionsheet.addAction(UIAlertAction(title: "Choose Pdf".localized(), style: .default, handler: { (action:UIAlertAction)in
            
            self.documentInteractionController = UIDocumentPickerViewController(documentTypes: ["public.pdf", "public.data"], in: .import)
            self.documentInteractionController?.delegate = self
            self.present(self.documentInteractionController!, animated: true, completion: nil)
            
            
        }))
        
        actionsheet.addAction(UIAlertAction(title: "Close".localized(), style: .cancel, handler: nil))
        self.present(actionsheet,animated: true, completion: nil)
        
    }

    
    
    
    @IBAction func btnApprove_Click(_ sender: Any) {
        
        self.btn_checkReturn.setImage(UIImage(named: "uncheck"), for: .normal)
        self.btn_checkApprove.setImage(UIImage(named: "check"), for: .normal)
     
        
          self.lbl_notes.isHidden = true
          self.view_txtView.isHidden = true
        
        self.lbl_CustomerRepresntativeQ.isHidden = false
        self.stack_CustomerRepresntative.isHidden = false
        
        self.manager_approval_approval_status = "Approve"
        
    }
    
    @IBAction func btnReturn_Click(_ sender: Any) {
        
        self.btn_checkApprove.setImage(UIImage(named: "uncheck"), for: .normal)
        self.btn_checkReturn.setImage(UIImage(named: "check"), for: .normal)
     
        
          self.lbl_notes.isHidden = false
          self.view_txtView.isHidden = false
        
        self.lbl_CustomerRepresntativeQ.isHidden = true
        self.stack_CustomerRepresntative.isHidden = true
        
        self.lbl_CustomerUploadQ.isHidden = true
        self.stack_CustomerUpload.isHidden = true
        
        stack_uploadAttachment.isHidden = true
        
        self.manager_approval_approval_status = "Return"
        
    }
    
    
    @IBAction func btnNo_Click(_ sender: Any) {
        
        self.btn_checkYes.setImage(UIImage(named: "uncheck"), for: .normal)
          self.btn_checkNo.setImage(UIImage(named: "check"), for: .normal)
     
        self.lbl_CustomerUploadQ.isHidden = true
        self.stack_CustomerUpload.isHidden = true
        self.customr_representative_required = "No"
        stack_uploadAttachment.isHidden = true
        self.lbl_CustomerNote.isHidden = true
    }
    
    @IBAction func btnYes_Click(_ sender: Any) {
        
        self.btn_checkNo.setImage(UIImage(named: "uncheck"), for: .normal)
        self.btn_checkYes.setImage(UIImage(named: "check"), for: .normal)
     
        self.lbl_CustomerUploadQ.isHidden = false
        self.stack_CustomerUpload.isHidden = false
        self.customr_representative_required = "Yes"
        
        self.lbl_CustomerNote.isHidden = false
        self.customer_representative_type = ""
    }
    
    
    @IBAction func btnUpload_Click(_ sender: Any) {
        
        self.btn_checkUpload.setImage(UIImage(named: "check"), for: .normal)
        self.btn_checkAssign.setImage(UIImage(named: "uncheck"), for: .normal)
        
        self.stack_ownerUser.isHidden = true
        self.stack_uploadAttachment.isHidden = false
        
        self.customer_representative_type = "upload_customer_approved_document"
    }
    
    @IBAction func btnAssign_Click(_ sender: Any) {
        
        self.btn_checkUpload.setImage(UIImage(named: "uncheck"), for: .normal)
        self.btn_checkAssign.setImage(UIImage(named: "check"), for: .normal)
        
        self.stack_ownerUser.isHidden = false
        self.stack_uploadAttachment.isHidden = true
        
        self.customer_representative_type = "assign_owner_for_confirmation"
    }
    
 
    
    @IBAction func btnSubmit_Click(_ sender: Any) {
        
        Submit_request()
        //submit_Request()
    }
    
    
    
    
    @IBAction func btnOwnerUsers_Click(_ sender: Any) {
        
        self.imgDropOwner.image = dropUpmage
        let vc :PickerVC = AppDelegate.mainSB.instanceVC()
        vc.arr_data =  self.arr_ownerUsersLabel
        vc.isModalInPresentation = true
        vc.modalPresentationStyle = .overFullScreen
        vc.definesPresentationContext = true
        vc.delegate = {name , index in
            if name == self.arr_ownerUsersLabel[index] {
                self.owner_users = self.arr_ownerUsers[index].value
                self.lbl_ownerUserSelect.text = name
                self.btn_cancel_ownerUsers.isHidden = false
            }
            
//            if name == self.arr_ServicesLabel[index] {
//                self.lblsearchByServices.text =  name
//                let i =  self.arr_Services[index].value
//                self.StrsearchByServices = i
//                self.imgDropServices.image = self.dropDownmage
//                self.get_Projects_data(showLoading: true, loadOnly: true)
//            }

        }
        self.present(vc, animated: true, completion: nil)
        
//        let dropDown = DropDown()
//        dropDown.anchorView = view
//        dropDown.backgroundColor = .white
//        dropDown.cornerRadius = 2.0
//  
//        dropDown.dataSource = self.arr_ownerUsersLabel
//        dropDown.selectionAction = { [unowned self] (index: Int, item: String) in
//            
//            if item == self.arr_ownerUsersLabel[index] {
//                self.owner_users = arr_ownerUsers[index].value
//                self.lbl_ownerUserSelect.text = item
//                self.btn_cancel_ownerUsers.isHidden = false
//            }
//            
//        }
//        dropDown.direction = .bottom
//        dropDown.anchorView = btn_ownerUsers
//        dropDown.bottomOffset = CGPoint(x: 0, y: btn_ownerUsers.bounds.height)
//        dropDown.width = btn_ownerUsers.bounds.width
//        dropDown.show()
        
    }
    
    
    @IBAction func btnUsersDelete_Click(_ sender: Any) {
        self.lbl_ownerUsers.text = "Owner users".localized()
        
        self.btn_cancel_ownerUsers.isHidden = true
    }
    
    
    
    @IBAction func btnAddFile_Click(_ sender: Any) {
        
        var is_nil = false
        
        for i in arr_file {
            
            let urlStr = i.url
            let img = i.img
                 
            let title = i.title
            
            if (urlStr == nil && img == nil || title == "" ) {
                is_nil = true
                break
            }
        }
       
        if is_nil{
            self.showAMessage(withTitle: "error".localized(), message: "Attach file and title to the last entry at First")
        }else{
            let new_index = (Selected_index)
            self.arr_file.append(attachment(title: "", Required: "No", img: nil, url: nil,type: "file", index: new_index))
            self.table.reloadData()
        }
        
     
    }

    
    private func change_page(SelectedIndex:Int) {
        NotificationCenter.default.post(name: NSNotification.Name("Change_Form_Step"),
                                        object: SelectedIndex)
    }
    private func update_Config() {
        NotificationCenter.default.post(name: NSNotification.Name("update_Config"),
                                        object: nil)
    }
    
}


extension ManagerApprovalVC: UITableViewDelegate , UITableViewDataSource{
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    
      
        return arr_file.count
    
       
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
     
            let cell = tableView.dequeueReusableCell(withIdentifier: "AttachmentsCell", for: indexPath) as! AttachmentsCell
            
            let obj = arr_file[indexPath.item]
 
        
        cell.btn_Select.setImage( UIImage(systemName: "plus.rectangle.fill.on.folder.fill"), for: .normal)
        
        cell.lblNo.text =  "#" + "\(indexPath.item + 1)"
        cell.lblNo.font = .kufiRegularFont(ofSize: 13)
        cell.tfTitle.text = obj.title
        cell.tfTitle.placeholder = "Description".localized()
        cell.btn_Select.tintColor = HelperClassSwift.acolor.getUIColor()
        cell.btn_delete.isHidden = false
        cell.tfTitle.isUserInteractionEnabled = true
           
     
        
        cell.btnDeleteAction = {
            () in
            self.arr_file.remove(at: indexPath.item)
            self.table.reloadData()
            
        }
        
        cell.btnUploadAction = {
           
            self.Selected_index = obj.index
                self.Upload_file()
          
            
        }
        
        cell.btnEndEditingAction = {
            
                self.arr_file[indexPath.item] = attachment(title: cell.tfTitle.text!, Required: obj.Required, img: obj.img, url: obj.url, type: obj.type, index: obj.index, IsNew: false)
                
//            self.arr_file[indexPath.item].title = cell.tfTitle.text!
            self.table.reloadData()
        
        }
        
        return cell
        
        
  
    }
    
  
}



extension ManagerApprovalVC : UIImagePickerControllerDelegate  {
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]){
        
        if let image = (info[.originalImage] as? UIImage){
            
            
            let value = attachment(img: image, url: nil, type: "img",index: Selected_index)
            //self.arr_file.append(value)
            //self.arr_file = self.arr_file.map { $0.img == nil ? image : nil }
            
            if let row = self.arr_file.firstIndex(where: {$0.index == self.Selected_index}) {
                
                arr_file[row] = attachment(title:arr_file[row].title, Required:  arr_file[row].Required , img: image, url: nil ,type: "img",index: Selected_index)
                self.table.reloadData()
            }
           
           
            
        }
        
        if let editedImage = info[UIImagePickerController.InfoKey.editedImage] as? UIImage{
            self.imagePickerController.allowsEditing = true
            
            let data =  editedImage.jpegData(compressionQuality:0.6)
            let imageSize: Int = data?.count ?? 0
            print(imageSize/1000000)
            let size  = imageSize/1000000
            
            if size > 10 {
                self.showAMessage(withTitle: "error".localized(), message: "image must be less than 10 MB".localized())
                return
            }
           // self.Collection.reloadData()
        }
        
        picker.dismiss(animated: true) {
            
        }
    }
    
    
    
    
}





extension ManagerApprovalVC: UIDocumentPickerDelegate {
    
    
    
    func documentPicker(_ controller: UIDocumentPickerViewController, didPickDocumentsAt urls: [URL]) {
        print(urls)
        for url in urls {
            let cico = url as URL
            
            
            print(cico)
            print(url)
            print(url.lastPathComponent)
            print(url.pathExtension)
            getDataFrom(url: url) { (data) in
                if let data = data {
                    
                    
                    let value = attachment(img: nil, url: url, type: "file",index: Selected_index)
                   
                    
                    if let row = self.arr_file.firstIndex(where: {$0.index == self.Selected_index}) {
                        arr_file[row] = value
                    }
                    
                    self.table.reloadData()
                    
                    let Size1: Int = data.count ?? 0
                    let size  = Size1/1000000
                    
                    if size > 10 {
                        self.showAMessage(withTitle: "error".localized(), message: "Pdf must be less than 10 MB".localized())
                        return
                    }
                    
                  //  self.Collection.reloadData()
                    
                }
                
                
            }
        }
    }
    

    func getDataFrom(url: URL, completion: (Data?)->()) {
        do {
            let data = try Data.init(contentsOf: url, options: .dataReadingMapped)
            print(data)
            completion(data)
        }catch {
            print(error)
            completion(nil)
        }
    }
    
    
    
    func json(from object: Any) -> String? {
        guard let data = try? JSONSerialization.data(withJSONObject: object, options: []) else {
            return nil
        }
        return String(data: data, encoding: String.Encoding.utf8)
    }

}


extension String {
    var to_image :  UIImage {
        return UIImage(named: self) ?? UIImage()
    }
}
