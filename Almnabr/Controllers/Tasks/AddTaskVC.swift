//
//  AddTaskVC.swift
//  Almnabr
//
//  Created by MacBook on 07/05/2022.
//  Copyright © 2022 Samar Akkila. All rights reserved.
//

import UIKit
import DropDown
import ObjectMapper

class AddTaskVC: UIViewController, UINavigationControllerDelegate {


    @IBOutlet weak var lblAddTask: UILabel!
    @IBOutlet weak var tfSubject: UITextField!
    @IBOutlet weak var tfDesc: UITextField!
    @IBOutlet weak var lblPriority: UILabel!
    @IBOutlet weak var imgPriority: UIImageView!
    @IBOutlet weak var lblStatus: UILabel!
    @IBOutlet weak var imgStatus: UIImageView!
    @IBOutlet weak var lblRelatedTask: UILabel!
    @IBOutlet weak var imgRelatedTask: UIImageView!
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
    @IBOutlet weak var btnSubmit: UIButton!
    @IBOutlet var tableHeight: NSLayoutConstraint!
    
    @IBOutlet var view_users: UIView!
    @IBOutlet var Viewcollection_user: UIView!
    @IBOutlet var collection_user: UICollectionView!
    
    @IBOutlet var view_RelatedTask: UIView!
    @IBOutlet var Viewcollection_RelatedTask: UIView!
    @IBOutlet var collection_RelatedTask: UICollectionView!
    
    
    let dropUpmage =  UIImage.fontAwesomeIcon(name: .chevronUp , style: .solid, textColor:  .gray, size: CGSize(width: 40, height: 40))
    let dropDownmage =  UIImage.fontAwesomeIcon(name: .chevronDown , style: .solid, textColor:  .gray, size: CGSize(width: 40, height: 40))
     
    var arr_important:[importantObj] = []
    var arr_ticket_type:[importantObj] = []
    var arr_modules:[modulesObj] = []
    var arr_sig_id:[importantObj] = []
    var arr_task_status:[importantObj] = []
    var arr_Attachments:[attachment] = []
    var arr_NoData:[String] = ["No items found".localized()]
    var arr_user :[SupplierObj] = []
    var arr_selected_related :[TaskObj] = []
    var arr_selected_user :[SupplierObj] = []
    
    var arr_lbluser :[String] = []
    
    var Selected_index:Int = 0
    
    var delegate : (() -> Void)?
    
    var param = [:] as [String : String]
    var Attachments_index:Int = 0
    var isCheckList:Bool = false
    
    var task_id:String = ""
    var task_type:String = ""
    var important_id:String = ""
    var task_status:String = ""
    var status:String = ""
    var ticket_id:String = ""
    var strTitle:String = ""
    
    var object:TaskObj?
    var users:[HistoryObj] = []
    var isEdit:Bool = false
    
    
    var arr_related_task:[TaskObj] = []
    var arr_lbl_related_task:[String] = []
    
    let imagePickerController = UIImagePickerController()
    var documentInteractionController: UIDocumentPickerViewController? = nil
    
    let datePicker = UIDatePicker()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configNavigation()
        configGUI()
        createDatePicker()
        
        if isEdit {
            
            self.get_users()
            self.get_task()
        }
    }
    
    override func viewWillLayoutSubviews() {
        super.updateViewConstraints()
        self.tableHeight?.constant = self.tableAttachments.contentSize.height
        
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
        self.lblStatus.text = object?.status_name
        self.tfTotalDays.text = object?.task_time
        self.tfStartDate.text =  object?.start_date
        self.tfEndDate.text =  object?.end_date_task
        self.tfSubject.text = object?.task_detailes
        self.tfDesc.text = object?.task_detailes
        
        self.ticket_id = object?.ticket_id ?? "0"
        self.important_id = object?.important_id ?? "0"
//        self.status = object?.task_status_done ?? "0"
        self.task_status = object?.task_status_done ?? "0"
        
     
        
        if users.count > 0 {
            self.Viewcollection_user.isHidden = false
        }
        for i in users {
            let dict = ["value" : i.emp_id,
                        "label" : i.emp_name]
            let item = SupplierObj(dict as? [String:Any] ?? [:])
            self.arr_selected_user.append(item)
        }
        self.collection_user.reloadData()
        
        
        
        let arr_related =  object?.relateds_numbers
        var arr_related_id :[String] = []
        
        if arr_related!.count > 0 {
            self.Viewcollection_RelatedTask.isHidden = false
        }
        for i in arr_related! {
//            let dict = ["task_id" : i.task_id,
//                        "title" : i.sub_tasks_numbers]
//            let item = SupplierObj(dict as? [String:Any] ?? [:])
//            arr_related_id.append(i.task_id)
            for item in arr_related_task {
                if item.task_id == i.task_id {
                    self.arr_selected_related.append(item)
                }
            }
        }
        
        self.collection_RelatedTask.reloadData()
        
    }

    
    func configGUI() {
        
        self.lblAddTask.font = .kufiRegularFont(ofSize: 15)
        self.lblAddTask.text = strTitle
        
        
        self.imgPriority.image = dropDownmage
        self.lblPriority.font = .kufiRegularFont(ofSize: 15)
        self.lblPriority.text = "Priority".localized()
        
        self.imgStatus.image = dropDownmage
        self.lblStatus.font = .kufiRegularFont(ofSize: 15)
        self.lblStatus.text = "Status".localized()
        
        self.imgRelatedTask.image = dropDownmage
        self.lblRelatedTask.font = .kufiRegularFont(ofSize: 15)
        self.lblRelatedTask.text = "Related Task".localized()
        
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
        
      
        self.get_data()
        
        tableAttachments.delegate = self
        tableAttachments.dataSource = self
        
        self.tfUsers.delegate = self
        self.tfTotalDays.delegate = self
        self.imagePickerController.delegate = self
        
        tableAttachments.register(UINib(nibName: "AttachmentsCell", bundle: nil), forCellReuseIdentifier: "AttachmentsCell")
       
        tableAttachments.isHidden = true
    }
    
    
    func get_task(){
        
        self.showLoadingActivity()
        
        let param:[String:Any] = ["task_id" : self.task_id]
        APIController.shard.sendRequestPostAuth(urlString: "tasks/get_task_only", parameters: param ) { (response) in
            self.hideLoadingActivity()
            
            let status = response["status"] as? Bool
            
            if status == true{
                
                if  let data = response["data"] as? [String:Any]{
                    
                    let obj =  TaskObj(data)
                    self.object = obj
                }
                self.setData()
                self.hideLoadingActivity()
                
            }else{
                self.hideLoadingActivity()
            }
        }
    }
    
    
    func get_users(){
        
        self.showLoadingActivity()
        APIController.shard.sendRequestPostAuth(urlString: "tasks/get_emp_in_task", parameters: ["task_id":self.task_id] ) { (response) in
            self.hideLoadingActivity()
            
            let status = response["status"] as? Bool
           
            if status == true{
                
                if let data = response["data"] as? NSArray {
//                if  let status_done = data["task_status_done"] as? NSArray{
                    for i in data {
                        let dict = i as? [String:Any]
                        let obj = HistoryObj.init(dict!)
                        self.users.append(obj)
                    }
                   
            }
                self.hideLoadingActivity()
            }else{
                self.hideLoadingActivity()
            }
        }
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
                        self.arr_task_status.append(obj)
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
    
    @IBAction func btnAttachment_Click(_ sender: Any) {
        tableAttachments.isHidden = false
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
          
            self.tableAttachments.beginUpdates()
            self.tableAttachments.insertRows(at: [IndexPath.init(row: self.arr_Attachments.count-1, section: 0)], with: .automatic)
            self.tableAttachments.endUpdates()
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
                        } }  }}
            dropDown.direction = .bottom
            dropDown.anchorView = view_users
            dropDown.bottomOffset = CGPoint(x: 0, y: view_users.bounds.height)
            dropDown.width = view_users.bounds.width
            dropDown.show()
     
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
    
    
    @IBAction func btnRelatedTask_Click(_ sender: Any) {
        let vc :PickerVC = AppDelegate.mainSB.instanceVC()
        vc.arr_data =  arr_related_task.map({"\($0.title)"})
        vc.isModalInPresentation = true
        vc.modalPresentationStyle = .overFullScreen
        vc.definesPresentationContext = true
        vc.delegate = {name , index in
            
            if name == self.arr_related_task[index].title {
                let object =  self.arr_related_task[index]
                let has_object = self.arr_selected_related.contains(where: { $0.title == name })
                if has_object == false{
                    self.arr_selected_related.append(object)
                    self.Viewcollection_RelatedTask.isHidden = false
                    self.collection_RelatedTask.reloadData()
                } }
            
            //self.lblRelatedTask.text = name
            //self.related_task_id = self.arr_ticket_type[index].id
        }
        self.present(vc, animated: true, completion: nil)
    }
    
    
    @IBAction func btnStatus_Click(_ sender: Any) {
        let vc :PickerVC = AppDelegate.mainSB.instanceVC()
        vc.arr_data =  arr_task_status.map({"\($0.name)"})
        vc.isModalInPresentation = true
        vc.modalPresentationStyle = .overFullScreen
        vc.definesPresentationContext = true
        vc.delegate = {name , index in
            self.lblStatus.text = name
            self.task_status = self.arr_task_status[index].id
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
              
                var Url = "tasks/add_task"
             
        if isEdit {
            Url = "tasks/update_task"
            self.param["task_id"] = self.task_id
        }
        
        APIController.shard.func_Upload(queryString: Url, arr_Attachments, param: self.param ) { (respnse ) in
                    
                    let status = respnse["status"] as? Bool
                    let errors = respnse["error"] as? String

                    
                    if status == true{
                        if let message = respnse["message"] as? String {
                            self.showAMessage(withTitle: "", message: message,  completion: {
                                self.delegate!()
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
            
           
            
            self.param["task_detailes"] = tfDesc.text!
            self.param["status"] = self.status
            self.param["ticket_id"] = self.ticket_id
            self.param["title"] = tfSubject.text!
            self.param["task_time"] = tfTotalDays.text ?? "0"
            self.param["start_date"] = tfStartDate.text!
            self.param["end_date"] = tfEndDate.text
            self.param["important_id"] =  self.important_id
            self.param["task_status_done"] = self.task_status
            self.param["reminder_date"] = ""
            
            
            var related_task = ""
            for i in arr_selected_related{
                if arr_selected_related.count > 1 {
                    related_task = i.task_id  + "," + related_task
                }else{
                    related_task =  i.task_id
                }
            }
            self.param["related_id"] = related_task
            
            var selected_user = ""
            for i in arr_selected_user{
                if arr_selected_user.count > 1 {
                    selected_user = i.value  + "," + selected_user 
                }else{
                    selected_user =  i.value
                }
            }
            self.param["users"] = selected_user
            for i in arr_Attachments{
                self.param["attachments[\(i.index)][attach_title]"] = i.title
            }
            
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


extension AddTaskVC: UITableViewDelegate , UITableViewDataSource{
    
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
            self.tableAttachments.reloadData()
            if self.arr_Attachments.count == 0 {
                self.tableAttachments.isHidden = true
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



extension AddTaskVC : UITextFieldDelegate{
    
    
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



extension AddTaskVC: UICollectionViewDataSource ,UICollectionViewDelegate , UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        switch collectionView {
        case collection_user:
            return arr_selected_user.count
        case collection_RelatedTask:
            return arr_selected_related.count
        default:
            return 0
        }
       
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "unitCVCell", for: indexPath) as! unitCVCell
        switch collectionView {
        case collection_user:
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
        case collection_RelatedTask:
            let arr = arr_selected_related.map({"\($0.title)"})
            cell.lblTitle.text = arr[indexPath.row]
            cell.viewBack.setBorderWithColor("458FB8".getUIColor())
            cell.lblTitle.font = .kufiRegularFont(ofSize: 13)
            
            cell.btnDeleteAction = {
              
                self.arr_selected_related.remove(at: indexPath.item)
                self.collection_RelatedTask.reloadData()
                if self.arr_related_task.count == 0 {
                    self.Viewcollection_RelatedTask.isHidden = true
                }
                
            }
            
            return cell
        default:
            return UICollectionViewCell()
        }
        
         
      
    }
    
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
       // cell.view_img.backgroundColor = HelperClassSwift.acolor.getUIColor()
        
    }
}


extension AddTaskVC : UIImagePickerControllerDelegate  {
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]){
        
        if let image = (info[.originalImage] as? UIImage){
            
            if let row = self.arr_Attachments.firstIndex(where: {$0.index == self.Selected_index}) {
                 
                arr_Attachments[row].type = "img"
                arr_Attachments[row].img = image
                arr_Attachments[row].url = nil
                self.tableAttachments.reloadData()
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


extension AddTaskVC: UIDocumentPickerDelegate {
    
    
    
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
                        self.tableAttachments.reloadData()
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

