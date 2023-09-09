//
//  AddPointVC.swift
//  Almnabr
//
//  Created by MacBook on 28/06/2022.
//  Copyright © 2022 Samar Akkila. All rights reserved.
//

import UIKit
import DropDown
import SCLAlertView

class AddPointVC: UIViewController, UINavigationControllerDelegate {
    
    @IBOutlet weak var lblCheckList: UILabel!
    
    @IBOutlet weak var lblTitle: UILabel!
    @IBOutlet weak var tfTitle: UITextField!
    @IBOutlet var view_title: UIView!
    
    @IBOutlet weak var lblProgress: UILabel!
    @IBOutlet weak var tfProgress: UITextField!
    @IBOutlet var view_Progress: UIView!
    
    @IBOutlet weak var lblHours: UILabel!
    @IBOutlet weak var tfHours: UITextField!
    @IBOutlet var view_Hours: UIView!
    
    @IBOutlet var viewDetails: UIView!
    @IBOutlet weak var txtDetails: UITextView!
    
    @IBOutlet weak var btnAdd: UIButton!
    @IBOutlet weak var btnCancel: UIButton!
    
    @IBOutlet weak var lblAttachments: UILabel!
    @IBOutlet weak var tfUsers: UITextField!
    @IBOutlet weak var lblUsers: UILabel!
    @IBOutlet weak var imgUsers: UIImageView!
    
    @IBOutlet weak var tfStartDate: UITextField!
    @IBOutlet weak var tfEndDate: UITextField!
    
    @IBOutlet weak var table: UITableView!
    @IBOutlet var tableHeight: NSLayoutConstraint!
    @IBOutlet var view_users: UIView!
    @IBOutlet var Viewcollection_user: UIView!
    @IBOutlet var collection_user: UICollectionView!
    @IBOutlet var usersTextFieldStackView: UIStackView!
    @IBOutlet weak var addAttachButton: UIButton!
    @IBOutlet weak var submitButton: UIButton!
    @IBOutlet weak var historyButton: UIButton!
    
    private var historyData:[ListItemHistoryData]?
    private var filesUrls:[URL] = []
    private let dropDown = DropDown()
    var isView = false
    var point_id:String = ""
    
    
    let dropUpmage =  UIImage.fontAwesomeIcon(name: .chevronUp , style: .solid, textColor:  .gray, size: CGSize(width: 40, height: 40))
    let dropDownmage =  UIImage.fontAwesomeIcon(name: .chevronDown , style: .solid, textColor:  .gray, size: CGSize(width: 40, height: 40))
    
    var arr_Attachments:[attachment] = []
    var arr_NoData:[String] = ["No items found".localized()]
    var arr_user :[SupplierObj] = []
    var arr_selected_user :[SupplierObj] = []
    
    var arr_lbluser :[String] = []
    
    var Selected_index:Int = 0
    
    var Attachments_index:Int = 0
    var isCheckList:Bool = false
    
    var strTitle:String = ""
    
    let imagePickerController = UIImagePickerController()
    var documentInteractionController: UIDocumentPickerViewController? = nil
    
    let datePicker = UIDatePicker()
    var data:SubCheckObj?
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configGUI()
        createDatePicker()
        createEndDatePicker()
        configNavigation()
        drop_userList()
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        // Hide the Navigation Bar
        self.navigationController?.setNavigationBarHidden(false, animated: true)
        
        if let data = data {
            tfTitle.isEnabled = !isView
            tfProgress.isEnabled = !isView
            tfHours.isEnabled = !isView
            tfStartDate.isEnabled = !isView
            tfEndDate.isEnabled = !isView
            txtDetails.isEditable = !isView
            submitButton.isHidden = isView
            usersTextFieldStackView.isHidden = isView
            
            tfTitle.text = data.notes
            tfProgress.text = data.prg_done
            tfHours.text = data.hours_by_manual
            tfStartDate.text = data.start_date
            tfEndDate.text = data.end_date
            if txtDetails.textColor == .lightGray {
                txtDetails.text = ""
                txtDetails.textColor = .darkGray
                txtDetails.font = .kufiRegularFont(ofSize: 15)
            }
            
            txtDetails.text = data.more_details
            addAttachButton.isHidden = isView
            
            if isView{
                getHistoryData()
                getFiles()
            }
            
            getUser()
            
        }
        
        historyButton.isHidden = !isView
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
        addNavigationBarTitle(navigationTitle: "Checklist Item".localized())
        UINavigationBar.appearance().backgroundColor = maincolor
    }
    
    
    override func viewWillLayoutSubviews() {
        super.updateViewConstraints()
        //        self.tableHeight?.constant = self.table.contentSize.height
        
    }
    
    
    //MARK: - Config GUI
    //------------------------------------------------------
    func configGUI() {
        
        self.lblTitle.font = .kufiRegularFont(ofSize: 14)
        self.lblTitle.text = "Point Title".localized()
        self.tfTitle.placeholder = "Point Title".localized()
        
        self.lblCheckList.font = .kufiBoldFont(ofSize: 15)
        self.lblCheckList.text = "Checklist Item".localized()
        
        self.lblProgress.font = .kufiRegularFont(ofSize: 14)
        self.lblProgress.text = "Point Progress".localized()
        self.tfProgress.placeholder = "Point Progress".localized()
        
        self.lblHours.font = .kufiRegularFont(ofSize: 14)
        self.lblHours.text = "Hours".localized()
        self.tfHours.placeholder = "Hours".localized()
        
        self.txtDetails.text = ""
        txtDetails.delegate = self
        
        txtDetails.text = "Details".localized()
        txtDetails.font = .kufiRegularFont(ofSize: 14)
        txtDetails.textColor = .lightGray
        
        self.viewDetails.setBorderGray()
        self.view_title.setBorderGray()
        self.view_Progress.setBorderGray()
        self.view_Hours.setBorderGray()
        
        self.tfTitle.font = .kufiRegularFont(ofSize: 15)
        self.lblAttachments.font = .kufiRegularFont(ofSize: 15)
        self.lblAttachments.text = "Attachments".localized()
        
        self.imgUsers.image = dropDownmage
        self.lblUsers.font = .kufiRegularFont(ofSize: 15)
        self.lblUsers.text = "Users".localized()
        self.tfUsers.placeholder = "Users".localized()
        
        self.tfStartDate.font = .kufiRegularFont(ofSize: 15)
        self.tfStartDate.placeholder = "Start Date".localized()
        
        self.tfEndDate.font = .kufiRegularFont(ofSize: 15)
        self.tfEndDate.placeholder = "End Date".localized()
        
        table.delegate = self
        table.dataSource = self
        
        self.tfUsers.delegate = self
        self.imagePickerController.delegate = self
        
        table.register(UINib(nibName: "AttachmentsCell", bundle: nil), forCellReuseIdentifier: "AttachmentsCell")
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
    }
    
    
    
    func createEndDatePicker(){
        
        let toolbar = UIToolbar()
        toolbar.sizeToFit()
        datePicker.datePickerMode = .date
        
        let doneBtn = UIBarButtonItem(barButtonSystemItem: .done, target: nil, action: #selector(doneEndDatePressed))
        toolbar.setItems([doneBtn], animated: true)
        toolbar.backgroundColor = .white
        tfEndDate.inputAccessoryView = toolbar
        tfEndDate.inputView = datePicker
    }
    
    
    @objc func doneEndDatePressed(){
        
        tfEndDate.text = "\(datePicker.date.asStringyyyMMdd())"
        self.view.endEditing(true)
    }
    
    
    
    func get_user(search_key:String){
        searchInUser(search_key:search_key)
    }
    
    
    
    func drop_userList(){
        
        dropDown.selectionAction = { [unowned self] (index: Int, item: String) in
            if item == self.arr_lbluser[index] {
                self.tfUsers.text = ""
                let object =  self.arr_user[index]
                let has_object = arr_selected_user.contains(where: { $0.label == item })
                if has_object == false{
                    self.arr_selected_user.append(object)
                    self.Viewcollection_user.isHidden = false
                    self.collection_user.reloadData()
                }
            }
            
        }
        
        dropDown.direction = .bottom
        dropDown.anchorView = view_users
        dropDown.bottomOffset = CGPoint(x: 0, y: view_users.bounds.height)
        dropDown.width = view_users.bounds.width
        
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
    
    
    @IBAction func historyAction(_ sender: Any) {
        if let historyData = historyData{
            let vc:TaskHistoryVC = AppDelegate.TicketSB.instanceVC()
            vc.data = historyData
            self.navigationController?.pushViewController(vc, animated: true)
        }
    }
    
    
    @IBAction func btnSubmit_Click(_ sender: Any) {
        let isAdd = data == nil
        var param = [
            "point_id": isAdd ? point_id : data!.check_id ,
            "\(isAdd ? "points[0][title]" : "title")": tfTitle.text!,
            "\(isAdd ? "points[0][prg_done]" : "prg_done")": tfProgress.text!,
            "\(isAdd ? "points[0][hour_no]" : "hour_no")": tfHours.text!,
            "\(isAdd ? "points[0][start_date]" : "start_date")": tfStartDate.text!,
            "\(isAdd ? "points[0][end_date]" : "end_date")": tfEndDate.text!,
            "\(isAdd ? "points[0][more_details]" : "more_details")": txtDetails.text!
        ]
        
        for i in 0..<arr_Attachments.count{
            param["attachments[\(i)][attach_title]"] = arr_Attachments[i].title ?? ""
        }
        
        var users = ""
        for i in 0..<arr_selected_user.count{
            users.append("\(i == 0 ? "" : ",")\(arr_selected_user[i].value)")
        }
        param["users"] = users
        
        addChecklListItem(param: param, url: isAdd ? "tasks/insert_task_points" : "tasks/update_task_points_all")
    }
    
    @IBAction func btnAddAttach_Click(_ sender: Any) {
        
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
            self.tableHeight?.constant = CGFloat(self.arr_Attachments.count * 60)
            self.table.insertRows(at: [IndexPath.init(row: self.arr_Attachments.count-1, section: 0)], with: .automatic)
            
        }
        
        
    }
}


extension AddPointVC: UITextViewDelegate {
    
    
    func textViewDidBeginEditing(_ textView: UITextView) {
        if txtDetails.textColor == .lightGray {
            txtDetails.text = ""
            txtDetails.textColor = .darkGray
            txtDetails.font = .kufiRegularFont(ofSize: 15)
            
        }
    }
    
    func textViewDidEndEditing(_ textView: UITextView) {
        
        if txtDetails.text == "" {
            
            txtDetails.text = "Details".localized()
            txtDetails.font = .kufiRegularFont(ofSize: 15)
            txtDetails.textColor = .lightGray
        }
        
    }
    
}

extension AddPointVC: UITableViewDelegate , UITableViewDataSource{
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return arr_Attachments.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "AttachmentsCell", for: indexPath) as! AttachmentsCell
        
        
        cell.backgroundColor = .clear
        let obj = arr_Attachments[indexPath.item]
        cell.btn_delete.isHidden = isView
        cell.tfTitle.text = obj.title ?? ""
        cell.tfTitle.isEnabled = !isView
        cell.btnUploadAction = {
            if self.isView {
                self.previewFile(filePath: obj.filePath )
            }else{
                self.Selected_index = obj.index
                self.Upload_file()
            }
        }
        
        
        if (obj.img != nil || obj.url != nil) {
            cell.btn_Select.tintColor = "#3ea832".getUIColor()
        }else{
            cell.btn_Select.tintColor = HelperClassSwift.acolor.getUIColor()
        }
        
        cell.lblNo.font = .kufiRegularFont(ofSize: 13)
        cell.tfTitle.placeholder = "Description".localized()
        cell.lblNo.text = "# \(indexPath.item + 1)"
        
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
        
        
        
        cell.btnEndEditingAction = {
            self.arr_Attachments[indexPath.item].title = cell.tfTitle.text ?? ""
        }
        
        
        
        return cell
    }
    
}



extension AddPointVC : UITextFieldDelegate{
    
    
    func textFieldShouldBeginEditing(_ textField: UITextField) -> Bool {
        if textField == tfUsers {
            self.view_users.setBorderWithColor("2D7FC1".getUIColor())
            //self.drop_material_list()
        }
        return true
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        if textField == tfUsers {
            
            if tfUsers.text == "" {
                self.view_users.setBorderWithColor(.clear)
            }else{
                self.view_users.setBorderWithColor(.clear)
                self.get_user(search_key: tfUsers.text!)
            }
        }
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.endEditing(true)
        return true
    }
    
}


extension AddPointVC: UICollectionViewDataSource ,UICollectionViewDelegate , UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        return arr_selected_user.count
        
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "unitCVCell", for: indexPath) as! unitCVCell
        
        let arr = arr_selected_user.map({"\($0.label)"})
        cell.deleteButton.isHidden = isView
        cell.lblTitle.text = arr[indexPath.row]
        cell.viewBack.setBorderWithColor("458FB8".getUIColor())
        cell.lblTitle.font = .kufiRegularFont(ofSize: 13)
        
        cell.btnDeleteAction = {
            
            self.arr_selected_user.remove(at: indexPath.row)
            self.collection_user.reloadData()
            self.Viewcollection_user.isHidden = self.arr_selected_user.isEmpty
            
        }
        
        return cell
    }
    
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        // cell.view_img.backgroundColor = HelperClassSwift.acolor.getUIColor()
        
    }
}


extension AddPointVC : UIImagePickerControllerDelegate  {
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]){
        if let row = self.arr_Attachments.firstIndex(where: {$0.index == self.Selected_index}) , let url = info[UIImagePickerController.InfoKey.imageURL] as? URL{
            let cell = table.cellForRow(at: IndexPath(row: row, section: 0)) as! AttachmentsCell
            arr_Attachments[row].title = cell.tfTitle.text!
            arr_Attachments[row].url = url
            self.table.reloadData()
            
        }
        
        picker.dismiss(animated: true,completion: nil)
    }
    
    
    
    
}


extension AddPointVC: UIDocumentPickerDelegate {
    
    func documentPicker(_ controller: UIDocumentPickerViewController, didPickDocumentsAt urls: [URL]) {
        if let url = urls.first {
            if let row = self.arr_Attachments.firstIndex(where: {$0.index == self.Selected_index}) {
                let cell = table.cellForRow(at: IndexPath(row: row, section: 0)) as! AttachmentsCell
                arr_Attachments[row].title = cell.tfTitle.text!
                arr_Attachments[row].url = url
                self.table.reloadData()
            }
        }
    }
    
}


// MARK: - API Handling
extension AddPointVC{
    private func getFiles(){
        showLoadingActivity()
        APIController.shard.getCheckListItemFiles(sub_point_id: data?.check_id ?? "") {
            data in
            DispatchQueue.main.async {
                self.hideLoadingActivity()
                self.arr_Attachments.removeAll()
                if let status = data.status,status{
                    self.table.isHidden = false
                    if let data = data.data{
                        for index in 0..<data.count{
                            var obj = attachment()
                            obj.filePath = data[index].file_path ?? ""
                            obj.title = data[index].file_name_en ?? ""
                            obj.index = index
                            self.arr_Attachments.append(obj)
                        }
                        self.tableHeight.constant = CGFloat(self.arr_Attachments.count * 60)
                        self.table.reloadData()
                    }
                }
            }
        }
    }
    
    private func previewFile(filePath:String){
        showLoadingActivity()
        APIController.shard.getImage(url: filePath) { data in
            DispatchQueue.main.async {
                self.hideLoadingActivity()
                if let status = data.status , status {
                    let vc = WebViewViewController()
                    vc.data = data
                    let nav = UINavigationController(rootViewController: vc)
                    nav.modalPresentationStyle = .automatic
                    self.navigationController?.present(nav, animated: true)
                }
            }
        }
    }
    
    
    private func getHistoryData(){
        showLoadingActivity()
        APIController.shard.getTimeLineForCheckListItem(sub_point_id: data?.check_id ?? "") { data in
            self.hideLoadingActivity()
            DispatchQueue.main.async {
                if let status = data.status, status {
                    self.historyData = data.data ?? []
                    self.historyButton.isHidden = false
                }else{
                    self.historyButton.isHidden = true
                }
            }
        }
    }
    
    private func getUser(){
        showLoadingActivity()
        APIController.shard.getUsersForCheckListItem(sub_point_id: data?.check_id ?? "") { data in
            self.hideLoadingActivity()
            if let status = data.status , status , let data = data.data{
                let isAr = L102Language.currentAppleLanguage() == "ar"
                for item in data {
                    let label = "\(isAr ? "\(item.firstname_arabic ?? "") \(item.lastname_arabic ?? "")" : "\(item.firstname_english ?? "") \(item.lastname_english ?? "")")"
                    let obj = [
                        "label" : label,
                        "value" : item.emp_id ?? "" ,
                    ]
                    self.arr_selected_user.append(.init(obj))
                }
                self.Viewcollection_user.isHidden = self.arr_selected_user.isEmpty
                self.lblUsers.isHidden = self.arr_selected_user.isEmpty
                self.collection_user.reloadData()
            }else{
                self.Viewcollection_user.isHidden = true
                self.lblUsers.isHidden = self.isView
            }
        }
    }
    
    
    
    private func searchInUser(search_key:String){
        self.showLoadingActivity()
        APIController.shard.searchForUser(search_Key: search_key ) { (response) in
            
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
                        
                        if self.arr_user.count == 0 {
                            self.dropDown.dataSource = self.arr_NoData
                            self.dropDown.textColor = #colorLiteral(red: 0.8039215803, green: 0.8039215803, blue: 0.8039215803, alpha: 1)
                        }else{
                            self.dropDown.textColor = #colorLiteral(red: 0.1878142953, green: 0.1878142953, blue: 0.1878142953, alpha: 1)
                            self.dropDown.dataSource = self.arr_lbluser
                        }
                        self.dropDown.show()
                    }
                    self.hideLoadingActivity()
                }
            }else {
                self.hideLoadingActivity()
            }
            
        }
    }
    
    
    private func addChecklListItem(param:[String:Any],url:String){
        showLoadingActivity()
        APIController.shard.addCheckListItem(url:url,filesUrl: arr_Attachments.map({$0.url}),parameters: param) { data in
            DispatchQueue.main.async {
                self.hideLoadingActivity()
                if let status = data.status , status{
                    SCLAlertView().showSuccess("Success".localized(), subTitle: data.message ?? "")
                    self.navigationController?.popViewController(animated: true)
                }else{
                    SCLAlertView().showError("error".localized(), subTitle: data.error ?? "There is an unknow error...")
                }
            }
        }
    }
    
    
}




