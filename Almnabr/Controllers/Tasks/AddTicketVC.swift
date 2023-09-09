//
//  AddTicketVC.swift
//  Almnabr
//
//  Created by MacBook on 19/04/2022.
//  Copyright © 2022 Samar Akkila. All rights reserved.
//

import UIKit
import DropDown
import ObjectMapper
import FAPanels

class AddTicketVC: UIViewController, UINavigationControllerDelegate {
    
    
    @IBOutlet weak var lblTicketDetails: UILabel!
    @IBOutlet weak var tfSubject: UITextField!
    @IBOutlet weak var lblPriority: UILabel!
    @IBOutlet weak var imgPriority: UIImageView!
    @IBOutlet weak var lblType: UILabel!
    @IBOutlet weak var imgType: UIImageView!
    @IBOutlet weak var lblSignature: UILabel!
    @IBOutlet weak var imgSignature: UIImageView!
    @IBOutlet weak var txtDesc: UITextView!
    @IBOutlet weak var lblAttachments: UILabel!
    @IBOutlet weak var tableAttachments: UITableView!
    @IBOutlet weak var tfUsers: UITextField!
    @IBOutlet weak var lblUsers: UILabel!
    @IBOutlet weak var imgUsers: UIImageView!
    @IBOutlet weak var tfTotalDays: UITextField!
    @IBOutlet weak var lblStartDate: UILabel!
    @IBOutlet weak var lblEndDate: UILabel!
    @IBOutlet weak var tfStartDate: UITextField!
    @IBOutlet weak var tfEndDate: UITextField!
    @IBOutlet weak var switchNeedReply: UISwitch!
    @IBOutlet weak var lblNeedReply: UILabel!
    @IBOutlet weak var lblReplyDate: UILabel!
    @IBOutlet weak var tfReplyDate: UITextField!
    @IBOutlet weak var tfIssueLink: UITextField!
    @IBOutlet weak var viewNeedReply: UIView!
    @IBOutlet weak var txtNote: UITextView!
    @IBOutlet weak var btnSubmit: UIButton!
    @IBOutlet weak var Switch: UISwitch!
    @IBOutlet weak var table: UITableView!
    @IBOutlet var tableHeight: NSLayoutConstraint!
    @IBOutlet var view_users: UIView!
    @IBOutlet var Viewcollection_user: UIView!
    @IBOutlet var collection_user: UICollectionView!
    
    
    let dropUpmage =  UIImage.fontAwesomeIcon(name: .chevronUp , style: .solid, textColor:  .gray, size: CGSize(width: 40, height: 40))
    let dropDownmage =  UIImage.fontAwesomeIcon(name: .chevronDown , style: .solid, textColor:  .gray, size: CGSize(width: 40, height: 40))
    
    var arr_important:[importantObj] = []
    var arr_ticket_type:[importantObj] = []
    var arr_modules:[modulesObj] = []
    var arr_sig_id:[importantObj] = []
    var arr_ticket_status:[importantObj] = []
    var arr_Attachments:[attachment] = []
    var arr_NoData:[String] = ["No items found".localized()]
    var arr_user :[SupplierObj] = []
    var arr_selected_user :[SupplierObj] = []
    var arr_lbluser :[String] = []
    
    var Selected_index:Int = 0
    
    var delegate : (() -> Void)?
    
    var param = [:] as [String : String]
    var Attachments_index:Int = 0
    var isCheckList:Bool = false
    
    
    var object:TicketObj?
    var users:[HistoryObj] = []
    var isEdit:Bool = false
    
    var ticket_type:String = ""
    var ticket_id:String = ""
    
    var important_id:String = ""
    var sig_id:String = ""
    var need_reply:String = ""
    var strTitle:String = ""
    var task_id:String = ""
    let imagePickerController = UIImagePickerController()
    var documentInteractionController: UIDocumentPickerViewController? = nil
    
    let datePicker = UIDatePicker()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configNavigation()
        configGUI()
        createDatePicker()
        createReplyDatePicker()
        
        if isEdit {
            self.setData()
        }
    }
    
    override func viewWillLayoutSubviews() {
        super.updateViewConstraints()
        self.tableHeight?.constant = self.table.contentSize.height
        
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        // Hide the Navigation Bar
        self.navigationController?.setNavigationBarHidden(false, animated: true)
    }
    
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        // Show the Navigation Bar
        self.navigationController?.setNavigationBarHidden(false, animated: true)
    }
    
    // MARK: - Config Navigation
    func configNavigation() {
        
        _ = self.navigationController?.preferredStatusBarStyle
        self.view.backgroundColor = maincolor //F0F4F8
        //navigationController?.navigationBar.barTintColor = .buttonBackgroundColor()
        navigationController?.navigationBar.barTintColor = maincolor
        addNavigationBarTitle(navigationTitle: strTitle)
        UINavigationBar.appearance().backgroundColor = maincolor
    }
    
    
    
    //MARK: - Config GUI
    //------------------------------------------------------
    
    func setData() {
        self.lblPriority.text = object?.important_name
        self.lblType.text = object?.ticket_type_name
        self.lblSignature.text =  object?.sig_name
        txtDesc.text =  object?.ticket_detalis
        txtNote.text = object?.notes
        self.tfTotalDays.text = object?.time_work
        self.tfStartDate.text =  object?.start_date
        self.tfEndDate.text =  object?.end_date_nearly
        self.tfSubject.text = object?.ticket_titel
        
        self.ticket_type = object?.ticket_type ?? "0"
        self.important_id = object?.important_id ?? "0"
        self.sig_id = object?.sig_id ?? "0"
        self.need_reply = object?.need_reply ?? "0"
        
        
        txtDesc.textColor = .darkGray
        txtNote.textColor = .darkGray
        
        if users.count > 0 {
            self.Viewcollection_user.isHidden = false
        }
        for i in users {
            //            let dict = i as? [String:Any]
            //            let obj = SupplierObj.init(dict!)
            
            let dict = ["value" : i.emp_id,
                        "label" : i.emp_name]
            let item = SupplierObj(dict as? [String:Any] ?? [:])
            //            item.value = i.emp_id
            //            item.label = i.emp_name
            self.arr_selected_user.append(item)
        }
        self.collection_user.reloadData()
        
        if object?.need_reply == "1" {
            switchNeedReply.isOn = true
            self.viewNeedReply.isHidden = false
            self.tfReplyDate.text = object?.date_reply
        }
    }
    func configGUI() {
        
        self.lblTicketDetails.font = .kufiRegularFont(ofSize: 15)
        self.lblTicketDetails.text = "Ticket Details".localized()
        
        
        self.imgPriority.image = dropDownmage
        self.lblPriority.font = .kufiRegularFont(ofSize: 15)
        self.lblPriority.text = "Priority".localized()
        
        self.imgType.image = dropDownmage
        self.lblType.font = .kufiRegularFont(ofSize: 15)
        self.lblType.text = "Type".localized()
        
        self.imgSignature.image = dropDownmage
        self.lblSignature.font = .kufiRegularFont(ofSize: 15)
        self.lblSignature.text = "Signature".localized()
        
        self.txtDesc.text = ""
        self.txtNote.text = ""
        txtDesc.delegate = self
        txtNote.delegate = self
        
        txtDesc.text = "Description".localized()
        txtDesc.font = .kufiRegularFont(ofSize: 14)
        txtDesc.textColor = .lightGray
        
        txtNote.text = "Note".localized()
        txtNote.font = .kufiRegularFont(ofSize: 14)
        txtNote.textColor = .lightGray
        
        
        self.lblAttachments.font = .kufiRegularFont(ofSize: 15)
        self.lblAttachments.text = "Attachments".localized()
        
        self.imgUsers.image = dropDownmage
        self.lblUsers.font = .kufiRegularFont(ofSize: 15)
        self.lblUsers.text = "Users".localized()
        self.tfUsers.placeholder = "Users".localized()
        
        self.tfTotalDays.placeholder = "Total Days".localized()
        
        self.tfStartDate.font = .kufiRegularFont(ofSize: 15)
        self.tfStartDate.placeholder = "Start Date".localized()
        
        self.tfEndDate.font = .kufiRegularFont(ofSize: 15)
        self.tfEndDate.placeholder = "End Date".localized()
        
        self.lblNeedReply.font = .kufiRegularFont(ofSize: 15)
        self.lblNeedReply.text = "Need Reply".localized()
        
        self.tfReplyDate.font = .kufiRegularFont(ofSize: 15)
        self.tfReplyDate.placeholder = "Reply Date".localized()
        
        self.get_data()
        
        table.delegate = self
        table.dataSource = self
        
        self.tfUsers.delegate = self
        self.tfTotalDays.delegate = self
        self.imagePickerController.delegate = self
        
        table.register(UINib(nibName: "AttachmentsCell", bundle: nil), forCellReuseIdentifier: "AttachmentsCell")
        
        table.isHidden = true
    }
    
    func createDatePicker(){
        
        let toolbar = UIToolbar()
        toolbar.sizeToFit()
        
        datePicker.datePickerMode = .date
        let doneBtn = UIBarButtonItem(barButtonSystemItem: .done, target: nil, action: #selector(donePressed))
        toolbar.setItems([doneBtn], animated: true)
        toolbar.backgroundColor = .white
        tfStartDate.inputAccessoryView = toolbar
        tfStartDate.inputView = datePicker
    }
    
    
    @objc func donePressed(){
        
        tfStartDate.text = "\(datePicker.date.asStringyyyMMdd())"
        self.view.endEditing(true)
        if tfTotalDays.text != ""{
            let value = Int(tfTotalDays.text ?? "0") ?? 0
            let DayFromNow = Calendar.current.date(byAdding: .day, value: value , to: datePicker.date)
            print(DayFromNow)
            self.tfEndDate.text = DayFromNow?.asStringyyyMMdd()
        }
        
        
        
    }
    
    func createReplyDatePicker(){
        
        let toolbar = UIToolbar()
        toolbar.sizeToFit()
        datePicker.datePickerMode = .date
        
        let doneBtn = UIBarButtonItem(barButtonSystemItem: .done, target: nil, action: #selector(doneReplyDatePressed))
        toolbar.setItems([doneBtn], animated: true)
        toolbar.backgroundColor = .white
        tfReplyDate.inputAccessoryView = toolbar
        tfReplyDate.inputView = datePicker
    }
    
    
    @objc func doneReplyDatePressed(){
        
        tfReplyDate.text = "\(datePicker.date.asStringyyyMMdd())"
        self.view.endEditing(true)
    }
    
    
    
    func get_data(){
        
        self.showLoadingActivity()
        
        
        APIController.shard.sendRequestPostAuth(urlString: "tasks/get_add", parameters: [:] ) { (response) in
            self.hideLoadingActivity()
            
            
            let status = response["status"] as? Bool
            
            if status == true{
                
                if let data = response["data"] as? [String:Any] {
                    
                    
                    if  let important = data["important"] as? NSArray{
                        for i in important {
                            let dict = i as? [String:Any]
                            let obj = importantObj.init(dict!)
                            self.arr_important.append(obj)
                        } }
                    
                    if  let modules = data["modules"] as? NSArray{
                        for i in modules {
                            let dict = i as? [String:Any]
                            let obj = modulesObj.init(dict!)
                            self.arr_modules.append(obj)
                        } }
                    
                    if  let sig_id = data["sig_id"] as? NSArray{
                        for i in sig_id {
                            let dict = i as? [String:Any]
                            let obj = importantObj.init(dict!)
                            self.arr_sig_id.append(obj)
                        } }
                    
                    if  let ticket_status = data["ticket_status"] as? NSArray{
                        for i in ticket_status {
                            let dict = i as? [String:Any]
                            let obj = importantObj.init(dict!)
                            self.arr_ticket_status.append(obj)
                        } }
                    
                    if  let ticket_type = data["ticket_type"] as? NSArray{
                        for i in ticket_type {
                            let dict = i as? [String:Any]
                            let obj = importantObj.init(dict!)
                            self.arr_ticket_type.append(obj)
                        } }
                }
            }else{
                self.hideLoadingActivity()
            }
            
            
        }
    }
    
    @IBAction func btnAddNote_Click(_ sender: Any) {
        table.isHidden = false
        var is_nil = false
        for i in arr_Attachments {
            let urlStr = i.url
            let img = i.img
            
            if (urlStr == nil && img == nil) {
                is_nil = true
                break
            }
        }
        
        if is_nil {
            self.showAMessage(withTitle: "error".localized(), message: "Attach file to the last entry at First")
        }else{
            
            let new_index = arr_Attachments.count + 1
            self.arr_Attachments.append(attachment(title: "", Required: "No", img: nil, url: nil,type: "file", index: new_index ,IsNew: true))
            
            self.table.beginUpdates()
            self.table.insertRows(at: [IndexPath.init(row: self.arr_Attachments.count-1, section: 0)], with: .automatic)
            self.table.endUpdates()
        }
        
    }
    
    
    func get_user(search_key:String){
        
        var param :[String:Any] = [:]
        self.showLoadingActivity()
        APIController.shard.sendRequestGetAuth(urlString: "tc/getformuserslist?search=\(search_key)&lang_key=en&user_type_id=\(Auth_User.user_type_id)" ) { (response) in
            
            let status = response["status"] as? Bool
            if status == true{
                self.arr_user = []
                self.arr_lbluser = []
                if  let list = response["list"] as? NSArray{
                    for i in list {
                        let dict = i as? [String:Any]
                        let obj = SupplierObj.init(dict!)
                        self.arr_user.append(obj)
                        self.arr_lbluser.append(obj.label)
                        self.drop_userList()
                        
                    }
                    self.hideLoadingActivity()
                }
            }else {
                self.hideLoadingActivity()
            } 
            
        }
    }
    
    
    func drop_userList(){
        let dropDown = DropDown()
        
        if self.arr_user.count == 0 {
            dropDown.dataSource = self.arr_NoData
            dropDown.selectionAction = { [unowned self] (index: Int, item: String) in
                // self.imgDropMaterial.image = dropDownmage
            }
            dropDown.textColor = #colorLiteral(red: 0.8039215803, green: 0.8039215803, blue: 0.8039215803, alpha: 1)
        }else{
            
            dropDown.textColor = #colorLiteral(red: 0.1878142953, green: 0.1878142953, blue: 0.1878142953, alpha: 1)
            dropDown.dataSource = self.arr_lbluser
            dropDown.selectionAction = { [unowned self] (index: Int, item: String) in
                
                if item == self.arr_lbluser[index] {
                    let object =  self.arr_user[index]
                    let has_object = arr_selected_user.contains(where: { $0.label == item })
                    if has_object == false{
                        self.arr_selected_user.append(object)
                        self.Viewcollection_user.isHidden = false
                        self.collection_user.reloadData()
                    }
                }
                
            }
            
        }
        dropDown.direction = .bottom
        dropDown.anchorView = view_users
        dropDown.bottomOffset = CGPoint(x: 0, y: view_users.bounds.height)
        dropDown.width = view_users.bounds.width
        dropDown.show()
        
    }
    
    
    
    
    
    @IBAction func btnNeedReply_Changed(_ sender: UISwitch) {
        
        if (sender.isOn == true){
            print("UISwitch state is now ON")
            self.viewNeedReply.isHidden = false
            self.need_reply = "1"
        }
        else{
            print("UISwitch state is now Off")
            self.viewNeedReply.isHidden = true
            self.need_reply = "0"
        }
        
    }
    @IBAction func btnPriority_Click(_ sender: Any) {
        let vc :PickerVC = AppDelegate.mainSB.instanceVC()
        vc.arr_data =  arr_important.map({"\($0.name)"})
        vc.isModalInPresentation = true
        vc.modalPresentationStyle = .overFullScreen
        vc.definesPresentationContext = true
        vc.delegate = {name , index in
            self.lblPriority.text = name
            self.important_id = self.arr_important[index].id
        }
        self.present(vc, animated: true, completion: nil)
    }
    
    
    @IBAction func btnType_Click(_ sender: Any) {
        let vc :PickerVC = AppDelegate.mainSB.instanceVC()
        vc.arr_data =  arr_ticket_type.map({"\($0.name)"})
        vc.isModalInPresentation = true
        vc.modalPresentationStyle = .overFullScreen
        vc.definesPresentationContext = true
        vc.delegate = {name , index in
            self.lblType.text = name
            self.ticket_type = self.arr_ticket_type[index].id
        }
        self.present(vc, animated: true, completion: nil)
    }
    
    @IBAction func btnSignature_Click(_ sender: Any) {
        let vc :PickerVC = AppDelegate.mainSB.instanceVC()
        vc.arr_data =  arr_sig_id.map({"\($0.name)"})
        vc.isModalInPresentation = true
        vc.modalPresentationStyle = .overFullScreen
        vc.definesPresentationContext = true
        vc.delegate = {name , index in
            self.lblSignature.text = name
            self.sig_id = self.arr_sig_id[index].id
        }
        self.present(vc, animated: true, completion: nil)
    }
    
    func Submit_request(){
        
        
        for i in arr_Attachments {
            
            let urlStr = i.url
            let img = i.img
            
            if (urlStr == nil && img == nil) {
                showAMessage(withTitle: "error".localized(), message: "Please enter your file".localized())
                return
            }else{
                for i in arr_Attachments {
                    self.param["attachments[\(i.index - 1)][attach_title]"] = i.title
                }
            }
        }
        showLoadingActivity()
        
        var  Url = "tasks/add_tickets"
        if isEdit {
            Url = "tasks/update_ticket"
            self.param["ticket_id"] = self.ticket_id
        }
        
        APIController.shard.func_Upload(queryString: Url, arr_Attachments, param: self.param ) { (respnse ) in
            
            let status = respnse["status"] as? Bool
            let errors = respnse["error"] as? String
            
            
            if status == true{
                if let message = respnse["message"] as? String {
                    self.showAMessage(withTitle: "", message: message,  completion: {
                        if self.isEdit {
                            self.delegate!()
                        }
                        self.navigationController?.popViewController(animated: true)
                    })
                }
            }else{
                
                self.hideLoadingActivity()
                self.showAMessage(withTitle: "error".localized(), message: errors ?? "something went wrong")
            }
            self.hideLoadingActivity()
            
            
        }    }
    
    @IBAction func btnSubmit_Click(_ sender: Any) {
        
        guard tfSubject.text != "" else {
            return self.showAMessage(withTitle: "", message: "Ticket subject Field Required!")
        }
        
        guard tfTotalDays.text != "" else {
            return self.showAMessage(withTitle: "", message: "Total Days Field Required!")
        }
        
        guard tfStartDate.text != "" else {
            return self.showAMessage(withTitle: "", message: "Start Date Field Required!")
        }
        
        guard txtDesc.text != "Description" else {
            return self.showAMessage(withTitle: "", message: "Ticket detalis Field Required!")
        }
        guard txtNote.text != "Note" else {
            return self.showAMessage(withTitle: "", message: "Ticket detalis Field Required!")
        }
        
        if self.need_reply  == "1" {
            guard tfReplyDate.text != "" else {
                return self.showAMessage(withTitle: "", message: "Reply Date Field Required!")
            }
        }
        
        
        self.param["ticket_titel"] = tfSubject.text!
        self.param["ticket_detalis"] = txtDesc.text!
        self.param["ticket_type"] = self.ticket_type
        self.param["important_id"] =  self.important_id
        self.param["sig_id"] = self.sig_id
        self.param["need_reply"] = self.need_reply
        self.param["date_reply"] = tfReplyDate.text!
        self.param["notes"] = txtNote.text!
        self.param["time_work"] = tfTotalDays.text ?? "0"
        self.param["start_date"] = tfStartDate.text!
        self.param["end_date"] = tfEndDate.text
        self.param["issue_link"] = ""
        //tfIssueLink.text ?? ""
        self.param["ref_model"] = "tasks"
        
        var index = 0
        for i in arr_selected_user{
            
            self.param["users[\(index)]"] = i.value
            index += 1
        }
        
//        self.param["users[0]"] = "266"
//        self.param["users[1]"] = "265"
//        self.param["users[2]"] = "263"
        
        Submit_request()
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
    
}


extension AddTicketVC: UITextViewDelegate {
    
    
    func textViewDidBeginEditing(_ textView: UITextView) {
        if txtDesc.textColor == .lightGray {
            txtDesc.text = ""
            txtDesc.textColor = .darkGray
            txtDesc.font = .kufiRegularFont(ofSize: 15)
            
        }else if txtNote.textColor == .lightGray {
            txtNote.text = ""
            txtNote.textColor = .darkGray
            txtNote.font = .kufiRegularFont(ofSize: 15)
        }
    }
    
    func textViewDidEndEditing(_ textView: UITextView) {
        
        if txtDesc.text == "" {
            
            txtDesc.text = "Description".localized()
            txtDesc.font = .kufiRegularFont(ofSize: 15)
            txtDesc.textColor = .lightGray
        }else if txtNote.text == "" {
            
            txtNote.text = "Note".localized()
            txtNote.font = .kufiRegularFont(ofSize: 15)
            txtNote.textColor = .lightGray
        }
        
    }
    
    
}



extension AddTicketVC: UITableViewDelegate , UITableViewDataSource{
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return arr_Attachments.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "AttachmentsCell", for: indexPath) as! AttachmentsCell
        
        cell.backgroundColor = .clear
        let obj = arr_Attachments[indexPath.item]
        
        
        if (obj.img != nil || obj.url != nil) {
            cell.btn_Select.tintColor = "#3ea832".getUIColor()
        }else{
            cell.btn_Select.tintColor = HelperClassSwift.acolor.getUIColor()
        }
        cell.lblNo.font = .kufiRegularFont(ofSize: 13)
        cell.tfTitle.placeholder = "Description".localized()
        cell.lblNo.text = "# \(indexPath.item + 1)"
        
        cell.btn_delete.isHidden = false
        
        
        cell.tfTitle.isUserInteractionEnabled = true
        
        self.Attachments_index = obj.index
        cell.tfTitle.delegate = self
        
        
        cell.btnDeleteAction = {
            self.arr_Attachments.remove(at: indexPath.item)
            self.table.reloadData()
            if self.arr_Attachments.count == 0 {
                self.table.isHidden = true
            }
            
        }
        
        cell.btnUploadAction = {
            
            self.Selected_index = obj.index
            self.Upload_file()
        }
        cell.btnEndEditingAction = {
            self.arr_Attachments[indexPath.item].title = cell.tfTitle.text ?? ""
        }
        
        return cell
        
        
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        self.viewWillLayoutSubviews()
    }
}



extension AddTicketVC : UITextFieldDelegate{
    
    
    func textFieldShouldBeginEditing(_ textField: UITextField) -> Bool {
        if textField == tfUsers {
            self.view_users.setBorderWithColor("2D7FC1".getUIColor())
            //self.drop_material_list()
        }
        return true
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        
        if #available(iOS 15, *) {
            if textField == tfUsers {
                if tfUsers.text == "" {
                    self.view_users.setBorderWithColor(.clear)
                    
                }else{
                    self.view_users.setBorderWithColor(.clear)
                    get_user(search_key: tfUsers.text!)
                }
                
            }else if  textField == tfTotalDays {
                
                if tfStartDate.text != "" {
                    
                    let value = Int(tfTotalDays.text ?? "0") ?? 0
                    let DayFromNow = Calendar.current.date(byAdding: .day, value: value , to: (tfStartDate.text?.convertToDate)!)
                    print(DayFromNow)
                    self.tfEndDate.text = DayFromNow?.asStringyyyMMdd()
                }
                
                
                
            }
        } else {
            // Fallback on earlier versions
        }
        
        
    }
}



extension AddTicketVC: UICollectionViewDataSource ,UICollectionViewDelegate , UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        return arr_selected_user.count
        
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "unitCVCell", for: indexPath) as! unitCVCell
        
        let arr = arr_selected_user.map({"\($0.label)"})
        cell.lblTitle.text = arr[indexPath.row]
        cell.viewBack.setBorderWithColor("458FB8".getUIColor())
        cell.lblTitle.font = .kufiRegularFont(ofSize: 13)
        
        cell.btnDeleteAction = {
            
            self.arr_selected_user.remove(at: indexPath.item)
            self.collection_user.reloadData()
            if self.arr_user.count == 0 {
                self.Viewcollection_user.isHidden = true
            }
        }
        
        return cell
        
    }
    
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        // cell.view_img.backgroundColor = HelperClassSwift.acolor.getUIColor()
        
    }
}


extension AddTicketVC : UIImagePickerControllerDelegate  {
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]){
        
        if let image = (info[.originalImage] as? UIImage){
            
            if let row = self.arr_Attachments.firstIndex(where: {$0.index == self.Selected_index}) {
                
                arr_Attachments[row].type = "img"
                arr_Attachments[row].img = image
                arr_Attachments[row].url = nil
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


extension AddTicketVC: UIDocumentPickerDelegate {
    
    
    
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
                    
                    if let row = self.arr_Attachments.firstIndex(where: {$0.index == self.Selected_index}) {
                        
                        arr_Attachments[row].type = "file"
                        arr_Attachments[row].img = nil
                        arr_Attachments[row].url = url
                        self.table.reloadData()
                    }
                    
                    
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

