//
//  TechinicalAssistantVC.swift
//  Almnabr
//
//  Created by MacBook on 07/12/2021.
//  Copyright © 2021 Samar Akkila. All rights reserved.
//

import UIKit
import DropDown
import AVFoundation
import SwiftUI

var once:Int = 0
var DidReply:Bool = true

class TechinicalAssistantVC: UIViewController, UINavigationControllerDelegate {
    
    @IBOutlet weak var icon_noPermission: UIImageView!
    @IBOutlet weak var view_noPermission: UIView!
    @IBOutlet weak var lbl_noPermission: UILabel!
    @IBOutlet weak var table_checkList: UITableView!
    @IBOutlet weak var table_saudiCode: UITableView!
    @IBOutlet weak var table_note: UITableView!
    @IBOutlet weak var table_supplier_notes: UITableView!
    
    
    @IBOutlet weak var lbl_title: UILabel!
    @IBOutlet weak var lbl_CheckList: UILabel!
    @IBOutlet weak var lbl_SaudiBuldingCode : UILabel!
    @IBOutlet weak var lbl_SpecialApprovals: UILabel!
    @IBOutlet weak var lbl_addusers: UILabel!
    @IBOutlet weak var lbl_addusersSelected: UILabel!
    @IBOutlet weak var stack_addusers: UIStackView!
    @IBOutlet weak var view_addusers: UIView!
    @IBOutlet weak var imgDropaddusers: UIImageView!
    
    @IBOutlet weak var btnSpecialApprovals: UIButton!
    @IBOutlet weak var btn_cancel_AddUsers: UIButton!
    @IBOutlet weak var btn_submit: UIButton!
    @IBOutlet weak var view_main: UIView!
    
    @IBOutlet weak var btn_check: UIButton!
    @IBOutlet weak var btn_saudi: UIButton!
    @IBOutlet var tablecheckHeight: NSLayoutConstraint!
    @IBOutlet var tableSaudiHeight: NSLayoutConstraint!
    @IBOutlet var tableNoteHeight: NSLayoutConstraint!
    @IBOutlet var tableNoteSupplierHeight: NSLayoutConstraint!
    @IBOutlet var Collection: UICollectionView!
    
    @IBOutlet var lbl_status: UILabel!
    @IBOutlet var lbl_titleStr: UILabel!
    
    @IBOutlet var tf_sample_confoms: UITextField!
    @IBOutlet var tf_Warranty_Period: UITextField!
    @IBOutlet var tf_supplying_period: UITextField!
    @IBOutlet var tf_Spare_Parts_Availability: UITextField!
    
    @IBOutlet var view_sample_confoms: UIView!
    @IBOutlet var view_Warranty_Period: UIView!
    @IBOutlet var view_supplying_period: UIView!
    @IBOutlet var view_Spare_Parts_Availability: UIView!
    
    @IBOutlet var view_note: UIView!
    @IBOutlet var view_suplierNote: UIView!
    
    @IBOutlet var Submit_height: NSLayoutConstraint!
    
    @IBOutlet var view_daily_production_needs: UIView!
    @IBOutlet var view_production_amount: UIView!
    @IBOutlet var view_production_lines: UIView!
    
    @IBOutlet var lbl_daily_production_needs: UILabel!
    @IBOutlet var lbl_production_amount: UILabel!
    @IBOutlet var lbl_production_lines: UILabel!
    
    @IBOutlet var tf_daily_production_needs: UITextField!
    @IBOutlet var tf_production_amount: UITextField!
    @IBOutlet var tf_production_lines: UITextField!
   
    var production_needs:Int = 0
    var production_amount:Int = 0
    var production_lines:Int = 0
    
    
    
    var arr_Users:[ModuleObj] = []
    var arr_UsersLabel:[String] = []
    var arr_file:[SaudiBuillding] = []
    var arr_note:[NoteObj] = []
    var arr_supplier_notes:[NoteObj] = []
    var arr_special_approvers:[special_approvers] = []
    var arr_special_id:[String] = []
    var arr_special_title:[String] = []
    
    var arr_Technical_Assistants:[Technical_Assistants] = []
    var SpecialApprovals_status:Bool = false
    var SpecialApprovals:String = ""
    
    var params : [String:String] = [:]
    
    let dropUpmage =  UIImage.fontAwesomeIcon(name: .chevronUp , style: .solid, textColor:  .gray, size: CGSize(width: 40, height: 40))
    
    let dropDownmage =  UIImage.fontAwesomeIcon(name: .chevronDown , style: .solid, textColor:  .gray, size: CGSize(width: 40, height: 40))
    
    let imagePickerController = UIImagePickerController()
    var documentInteractionController: UIDocumentPickerViewController? = nil
    
    var Selected_index:Int = 0
    var BulidingSelected_index:Int = 0
    var note_index:Int = 0
    var supplier_note_index:Int = 0
    var isCheckList:Bool = false
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
//        if DidReply {
////            self.showLoadingActivity()
//            DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
//                self.configGUI()
////                self.hideLoadingActivity()
//                DidReply = false
//            }
//        }else{
            configGUI()
//            DidReply = true
//        }
//
//        if once == 0 {
//            configGUI()
//            once = 1
//        }else{
//            self.showLoadingActivity()
//
//        }
        
    }
    
    
    override func viewWillLayoutSubviews() {
        super.updateViewConstraints()
        self.tablecheckHeight?.constant = self.table_checkList.contentSize.height
        self.tableSaudiHeight?.constant = self.table_saudiCode.contentSize.height
        
        self.tableNoteHeight?.constant = self.table_note.contentSize.height
        self.tableNoteSupplierHeight?.constant = self.table_supplier_notes.contentSize.height
        
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        if StatusObject?.Techinical_Assistant == false {
            view_noPermission.isHidden = false
            self.view_main.isHidden = true
            
        }else{
            
            view_noPermission.isHidden = true
            self.view_main.isHidden = false
        }
    }
    
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
      
    }
    
    
    
    //MARK: - Config GUI
    //------------------------------------------------------
    func configGUI() {
        
        print("\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\technical")
        icon_noPermission.no_permission()
        
        self.lbl_noPermission.text =  "You not have permission to access this step".localized()
        self.lbl_noPermission.font = .kufiRegularFont(ofSize: 15)
        self.lbl_noPermission.textColor =  "#333".getUIColor()
        
        tf_sample_confoms.placeholder = "sample confoms"
        tf_Warranty_Period.placeholder = "Warranty Period"
        tf_supplying_period.placeholder = "supplying period"
        tf_Spare_Parts_Availability.placeholder = "Spare Parts Availability"
        
        if obj_transaction?.transaction_request_last_step == "completed"{
            self.stack_addusers.isHidden = true
            self.btn_check.isHidden = true
            self.btn_saudi.isHidden = true
            
            view_noPermission.isHidden = true
        }
        
        if StatusObject?.Techinical_Assistant == false {
            view_noPermission.isHidden = false
            self.view_main.isHidden = true
            append_inArrTech()
        }else{
            get_special_approver_users()
            get_Technical_Assistants_Evaluation()
            view_noPermission.isHidden = true
            self.view_main.isHidden = false
        }
        
        if obj_transaction?.transaction_key == "FORM_MIR" {
            
            view_sample_confoms.isHidden =  false
            view_Warranty_Period.isHidden =  false
            view_supplying_period.isHidden =  false
            view_Spare_Parts_Availability.isHidden =  false
            view_note.isHidden = false
            view_suplierNote.isHidden = false
            table_note.isHidden = false
            table_supplier_notes.isHidden = false
            Submit_height.constant = 40
            
        }else if obj_transaction?.transaction_key == "FORM_SQR" {
            
            view_daily_production_needs.isHidden = false
            view_production_amount.isHidden = false
            view_production_lines.isHidden = false
            view_note.isHidden = false
            table_note.isHidden = false
        }
//        else{
//            Submit_height.constant = 50
//        }
            
            
        self.imgDropaddusers.image = dropDownmage
        
        table_checkList.dataSource = self
        table_checkList.delegate = self
        let nib = UINib(nibName: "TechnicalAssistantCell", bundle: nil)
        table_checkList.register(nib, forCellReuseIdentifier: "TechnicalAssistantCell")
        
        
        table_saudiCode.dataSource = self
        table_saudiCode.delegate = self
        let nib1 = UINib(nibName: "SaudiTVCell", bundle: nil)
        table_saudiCode.register(nib1, forCellReuseIdentifier: "SaudiTVCell")
        
         
        table_note.register(UINib(nibName: "SimpleNoteCell", bundle: nil), forCellReuseIdentifier: "SimpleNoteCell")
        table_supplier_notes.register(UINib(nibName: "SimpleNoteCell", bundle: nil), forCellReuseIdentifier: "SimpleNoteCell")
        
        
        self.lbl_status.text = "Status".localized()
        self.lbl_status.font = .kufiRegularFont(ofSize: 13)
        self.lbl_status.textColor =  maincolor
        
        self.lbl_titleStr.text = "Title".localized()
        self.lbl_titleStr.font =  .kufiRegularFont(ofSize: 13)
        self.lbl_titleStr.textColor =  maincolor
        
        
        self.lbl_title.text = "Technical Assistant".localized()
        self.lbl_title.font = .kufiRegularFont(ofSize: 14)
        self.lbl_title.textColor =  maincolor
        
        
        self.lbl_CheckList.text = "Check List".localized()
        self.lbl_CheckList.font = .kufiRegularFont(ofSize: 13)
        self.lbl_CheckList.textColor =  maincolor
        
        self.lbl_SaudiBuldingCode.text = "Saudi Bulding Code :".localized()
        self.lbl_SaudiBuldingCode.font = .kufiRegularFont(ofSize: 13)
        self.lbl_SaudiBuldingCode.textColor =  maincolor
        
        self.lbl_SpecialApprovals.text = "Special Approvals !?".localized()
        self.lbl_SpecialApprovals.font = .kufiRegularFont(ofSize: 13)
        self.lbl_SpecialApprovals.textColor =  maincolor
        
        self.lbl_addusers.text = "add users".localized()
        self.lbl_addusers.font = .kufiRegularFont(ofSize: 13)
        self.lbl_addusers.textColor =  maincolor
        
        
        self.lbl_addusersSelected.text = "add users".localized()
        self.lbl_addusersSelected.font = .kufiRegularFont(ofSize: 13)
        self.lbl_addusersSelected.textColor =  maincolor
        
        
        self.stack_addusers.isHidden = true
        self.view_main.setRounded(20)
        
        self.view_addusers.setBorderGrayWidthCorner(1, 20)
        
        self.btn_submit.setTitle("Submit".localized(), for: .normal)
        self.btn_submit.backgroundColor =  "#1A3665".getUIColor()
        self.btn_submit.setTitleColor(.white, for: .normal)
        
        self.btnSpecialApprovals.setImage(UIImage(systemName:"square" ), for: .normal)
        
        self.table_checkList.reloadData()
        
        imagePickerController.delegate = self
        
        
        
        self.table_checkList.reloadData()
        
//        self.hideLoadingActivity()
    }
    
    func append_inArrTech(){
        
        var index:Int = 0
        var code:String = ""
        
        arr_Technical_Assistants = []
        for i in arr_Technical_Assistants_Evaluation{
            
            if i.extra1_result == ""{
                code = i.no_code_result
            }else{
                code = i.extra1_result
            }
            
            let value = Technical_Assistants(title: i.extra1_title, status: "", projects_from_consultant_id: "1" , result: code, img: nil, url: nil, type: nil, index: index, IsNew: false, yes_code_result: i.yes_code_result, no_code_result: i.no_code_result)
            
            index = index + 1
            self.arr_Technical_Assistants.append(value)
            
        }
        
        self.table_checkList.reloadData()
        self.viewWillLayoutSubviews()
        
    }
    
    
    
    func get_Technical_Assistants_Evaluation(){
        
        
        self.showLoadingActivity()
        
        let params = ["transaction_request_id" : obj_transaction?.transaction_request_id ?? "0"]
        
        APIController.shard.sendRequestPostAuth(urlString: "form/\(obj_transaction?.transaction_key ?? " ")/Techinical_Assistant/0", parameters: params ) { (response) in
            self.hideLoadingActivity()
            
            
            let status = response["status"] as? Bool
            let msg = response["msg"] as? String
            let error = response["error"] as? String
            
            if status == true{
                self.hideLoadingActivity()
                
                arr_Technical_Assistants_Evaluation =  []
                
                if  let records = response["Technical_Assistants_Evaluation"] as? NSArray{
                    for i in records {
                        let dict = i as? [String:Any]
                        let obj = Technical_Assistants_EvaluationObj.init(dict!)
                        arr_Technical_Assistants_Evaluation.append(obj)
                    }
                    
                    self.append_inArrTech()
                }
            }else{
                self.hideLoadingActivity()
                self.showAMessage(withTitle: "Error", message: error ?? "Some thing went wrong")
                
            }
        }
        
        
    }
    
    
    func get_special_approver_users(){
        
        self.showLoadingActivity()
        APIController.shard.sendRequestGetAuth(urlString: "form/\(obj_transaction?.transaction_key ?? " ")/special_approver_users?search_key=&lang_key=en&projects_work_area_id=\(obj_FormWir?.projects_work_area_id ?? "1")&method=list" ) { (response) in
            
            
            let status = response["status"] as? Bool
            if status == true{
                if  let list = response["records"] as? NSArray{
                    for i in list {
                        let dict = i as? [String:Any]
                        let obj = ModuleObj.init(dict!)
                        self.arr_Users.append(obj)
                        self.arr_UsersLabel.append(obj.label)
                        
                    }
                    self.hideLoadingActivity()
                }
            }
            self.hideLoadingActivity()
            
        }
    }
    
    
    func Submit_request(){
        
        for i in arr_Technical_Assistants{
            guard i.status != "" else {
                showAMessage(withTitle: "error".localized(), message: "missing data ".localized())
                return
            }
        }
        
        
        params["transaction_request_id"] = obj_transaction?.transaction_request_id ?? "0"
        var value = ""
        for i in arr_special_id{
            value = i
            if arr_special_id.count == 1 {
                print("return")
            }else if arr_special_id.count > 1 {
                value = value + ","
            }
        }
        params["special_approvers"] = value
        
        for i in arr_file {
            
            params["Saudi_Building_Codes[\(i.index)][title]"] = i.Title
            params["Saudi_Building_Codes[\(i.index)][status]"] = i.Status
            
            
        }
        for i in arr_Technical_Assistants {
            if i.img != nil{
                params["Technical_Assistants_Evaluation[\(i.index)][attachments][1][attach_title]"] = " "
                params["Technical_Assistants_Evaluation[\(i.index)][attachments][1][required]"] = "null"
                
            }
            if i.url != nil {
                params["Technical_Assistants_Evaluation[\(i.index)][attachments][1][attach_title]"] = " "
                params["Technical_Assistants_Evaluation[\(i.index)][attachments][1][required]"] = "null"
                
            }
            params["Technical_Assistants_Evaluation[\(i.index)][title]"] = i.title
            params["Technical_Assistants_Evaluation[\(i.index)][projects_from_consultant_id]"] = i.projects_from_consultant_id
            params["Technical_Assistants_Evaluation[\(i.index)][status]"] = i.status
            params["Technical_Assistants_Evaluation[\(i.index)][result]"] = i.result
            
            params["Technical_Assistants_Evaluation[\(i.index)][result]"] = i.result
            
        }
        
        showLoadingActivity()
        
        APIController.shard.func_UploadTechnical(queryString: "form/\(obj_transaction?.transaction_key ?? " ")/Techinical_Assistant/1", arr_Technical_Assistants, param: params ) { (respnse ) in
            
            let status = respnse["status"] as? Bool
            let errors = respnse["error"] as? String
            let msg = respnse["msg"] as? String
            
            if status == true{
                self.hideLoadingActivity()
                self.showAMessage(withTitle: "Success".localized(), message: msg ?? "Thank you. The operation was completed successfully.", completion: {
                    
                    self.update_Config()
                })
                
                
            }else{
                
                self.hideLoadingActivity()
                self.showAMessage(withTitle: "error".localized(), message: errors ?? "something went wrong")
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
    
    
    
    
    @IBAction func btnSpecialApprovals_Click(_ sender: Any) {
        
        
        if SpecialApprovals_status == false {
            self.btnSpecialApprovals.setImage(UIImage(systemName:"checkmark.square.fill" ), for: .normal)
            self.stack_addusers.isHidden = false
            SpecialApprovals_status = true
        }else{
            self.btnSpecialApprovals.setImage(UIImage(systemName:"square" ), for: .normal)
            SpecialApprovals_status = false
            self.stack_addusers.isHidden = true
        }
        
        
        
    }
    
    
    
    @IBAction func btnSubmit_Click(_ sender: Any) {
        
        
        if obj_transaction?.transaction_key == "FORM_MIR" {
            
            guard tf_sample_confoms.text != "" else {
                return self.showAMessage(withTitle: "", message: "sample confoms Field Required!")
            }
            guard tf_Warranty_Period.text != "" else {
                return self.showAMessage(withTitle: "", message: "Warranty Period Field Required!")
            }
            
            guard tf_supplying_period.text != "" else {
                return self.showAMessage(withTitle: "", message: "supplying period Field Required!")
            }
            guard tf_Spare_Parts_Availability.text != "" else {
                return self.showAMessage(withTitle: "", message: "Spare Parts Availability Field Required!")
            }
            
            
            for i in arr_note{
                guard i.Title != "" else {
                    showAMessage(withTitle: "error".localized(), message: "missing data ".localized())
                    return
                }
            }
            
            for i in arr_supplier_notes{
                guard i.Title != "" else {
                    showAMessage(withTitle: "error".localized(), message: "missing data ".localized())
                    return
                }
            }
            
            for i in arr_note {
                self.params["notes[\(i.index)][description]"] = i.Title
            }
            
            for i in arr_supplier_notes {
                self.params["supplier_notes[\(i.index)][description]"] = i.Title
            }
            
            self.params["sample_confoms"] = tf_sample_confoms.text
            self.params["warenty_period"] = tf_Warranty_Period.text
            self.params["supplying_period"] = tf_supplying_period.text
            self.params["spare_parts_availability"] = tf_Spare_Parts_Availability.text
            
            
            
        }else if obj_transaction?.transaction_key == "FORM_SQR" {
            
            
            guard tf_production_lines.text != "" else {
                return self.showAMessage(withTitle: "", message: "production lines Field Required!")
            }
            guard tf_daily_production_needs.text != "" else {
                return self.showAMessage(withTitle: "", message: "daily production needs Field Required!")
            }
            guard tf_production_amount.text != "" else {
                return self.showAMessage(withTitle: "", message: "production amoun Field Required!")
            }
            
            self.params["production_lines"] = "\(production_lines)"
            self.params["production_amount"] = "\(production_amount)"
            self.params["daily_production_needs"] = "\(production_needs)"
            
            for i in arr_note {
                self.params["notes[\(i.index)][description]"] = i.Title
            }
               
            for i in arr_note{
                guard i.Title != "" else {
                    showAMessage(withTitle: "error".localized(), message: "missing data ".localized())
                    return
                }
            }
            
            
        }
        
        Submit_request()
    }
    
    @IBAction func btnAddCkeckList_Click(_ sender: Any) {
        
        
        let index = arr_Technical_Assistants.count
        let value = Technical_Assistants(title: "", status: "", projects_from_consultant_id: "1", result: "", img: nil, url: nil, type: "", index: index, IsNew: true, yes_code_result: "", no_code_result: "", Required: "")
        
        self.arr_Technical_Assistants.append(value)
        
        self.table_checkList.beginUpdates()
        self.table_checkList.insertRows(at: [IndexPath.init(row: self.arr_Technical_Assistants.count-1, section: 0)], with: .automatic)
        self.table_checkList.endUpdates()
        let indexPath = NSIndexPath(row: arr_Technical_Assistants.count-1, section: 0)
        table_checkList.scrollToRow(at: indexPath as IndexPath, at: .bottom, animated: true)
        
        isCheckList = false
        
        
    }
    
    @IBAction func btnAddBulding_Click(_ sender: Any) {
        
        var is_nil = false
        
        for i in arr_file {
            let status = i.Status
            let title = i.Title
            
            if (status == "" || title == "") {
                is_nil = true
                break
            }
        }
        
        if is_nil {
            self.showAMessage(withTitle: "error".localized(), message: "Add Title and status to the last entry at First")
        }else{
            
            let new_index = (BulidingSelected_index + 1)
            self.arr_file.append(SaudiBuillding(Status: "", Title: "", index: new_index ))
            self.BulidingSelected_index = self.BulidingSelected_index + 1
            
            isCheckList = true
            self.table_saudiCode.reloadData()
        }
        
    }
    
    
    
    @IBAction func btnAddNote_Click(_ sender: Any) {
        
        var is_nil = false
        
        for i in arr_note {
            let title = i.Title
            
            if  title == "" {
                is_nil = true
                break
            }
        }
        
        if is_nil {
            self.showAMessage(withTitle: "error".localized(), message: "Add Title to the last entry at First")
        }else{
            
            let new_index = (note_index + 1)
            self.arr_note.append(NoteObj( Title: "", index: new_index ))
            self.note_index = self.note_index + 1
            
            isCheckList = true
            self.table_note.reloadData()
        }
     
        
    }
    
    @IBAction func btnAddSupplierNote_Click(_ sender: Any) {
      
        
        var is_nil = false
        
        for i in arr_supplier_notes {
            let title = i.Title
            
            if  title == "" {
                is_nil = true
                break
            }
        }
        
            if is_nil {
                self.showAMessage(withTitle: "error".localized(), message: "Add Title to the last entry at First")
            }else{
                
                let new_index = (supplier_note_index + 1)
                self.arr_supplier_notes.append(NoteObj( Title: "", index: new_index ))
                self.supplier_note_index = self.supplier_note_index + 1
                
                isCheckList = true
                self.table_supplier_notes.reloadData()
            }
      
        
  
    }
    
    @IBAction func btnAddUsers_Click(_ sender: Any) {
        
        let dropDown = DropDown()
        dropDown.anchorView = view
        dropDown.backgroundColor = .white
        dropDown.cornerRadius = 2.0
        
        dropDown.dataSource = self.arr_UsersLabel
        dropDown.selectionAction = { [unowned self] (index: Int, item: String) in
            
            if item == self.arr_UsersLabel[index] {
                // self.owner_users = arr_Users[index].value
                self.SpecialApprovals = arr_Users[index].user_type_id
                //self.lbl_addusersSelected.text = item
                
                let obj = special_approvers(Title: item, id: arr_Users[index].value)
                if arr_special_id.contains(arr_Users[index].value){
                    print("no")
                }else{
                    self.arr_special_id.append(arr_Users[index].value)
                    self.arr_special_approvers.append(obj)
                    self.Collection.reloadData()
                }
                
            }
            
        }
        dropDown.direction = .bottom
        dropDown.anchorView = view_addusers
        dropDown.bottomOffset = CGPoint(x: 0, y: view_addusers.bounds.height)
        dropDown.width = view_addusers.bounds.width
        dropDown.show()
        
    }
    
    
    @IBAction func btnUsersDelete_Click(_ sender: Any) {
        self.lbl_addusersSelected.text = "add users".localized()
        
        self.btn_cancel_AddUsers.isHidden = true
    }
    
    
    
    @IBAction func btn_production_needs_plus_Click(_ sender: Any) {
        
        
        if production_needs >= 0  {
            production_needs = production_needs + 1
            self.tf_daily_production_needs.text = "\(production_needs)"
        }
    }
    
    @IBAction func btn_production_needs_minus_Click(_ sender: Any) {
        if production_needs > 0  {
            production_needs = production_needs - 1
            self.tf_daily_production_needs.text = "\(production_needs)"
        }
    }
    
    @IBAction func btn_production_amount_plus_Click(_ sender: Any) {
        
        
        if production_amount >= 0  {
            production_amount = production_amount + 1
            self.tf_production_amount.text = "\(production_amount)"
        }
    }
    
    @IBAction func btn_production_amount_minus_Click(_ sender: Any) {
        if production_amount > 0  {
            production_amount = production_amount - 1
            self.tf_production_amount.text = "\(production_amount)"
        }
    }
    
    @IBAction func btn_production_lines_plus_Click(_ sender: Any) {
        
        
        if production_lines >= 0  {
            production_lines = production_lines + 1
            self.tf_production_lines.text = "\(production_lines)"
        }
    }
    
    @IBAction func btn_production_lines_minus_Click(_ sender: Any) {
        if production_lines > 0  {
            production_lines = production_lines - 1
            self.tf_production_lines.text = "\(production_lines)"
        }
    }
    
    
    
    private func update_Config() {
        NotificationCenter.default.post(name: NSNotification.Name("update_Config"),
                                        object: nil)
    }
    
    
}





extension TechinicalAssistantVC: UITableViewDelegate , UITableViewDataSource{
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        switch tableView {
        case table_checkList:
            return arr_Technical_Assistants.count
        case table_saudiCode:
            return arr_file.count
        case table_note:
            return arr_note.count
        case table_supplier_notes:
            return arr_supplier_notes.count
        default:
            return 0
        }
        
        
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        
        
        switch tableView {
        case table_checkList:
            
            let cell = tableView.dequeueReusableCell(withIdentifier: "TechnicalAssistantCell", for: indexPath) as! TechnicalAssistantCell
            
            var obj = arr_Technical_Assistants[indexPath.item]
            
            let title = "Title: ".localized() + obj.title!
            
            let Titleattribute: NSAttributedString = title.attributedStringWithColor(["Title: "], color: maincolor)
            cell.lbl_Title.attributedText = Titleattribute
            
            
            cell.lblNumber.text = "#\(indexPath.item + 1)"
            //"# \(indexPath.item + 1)"
            let result = "Evaluation Result: ".localized() + obj.result!
            
            let resultattribute: NSAttributedString = result.attributedStringWithColor(["Evaluation Result: "], color: maincolor)
            cell.lbl_EvaluationResult.attributedText = resultattribute
            
//            if (obj.img != nil || obj.url != nil) {
//                cell.btn_Select.tintColor = "#3ea832".getUIColor()
//            }
            
//            if obj.img != nil  {
//                if  obj.url != nil {
//                    cell.btn_Select.tintColor = "#3ea832".getUIColor()
//                }
//            }else{
//                cell.btn_Select.tintColor = "#3ea832".getUIColor()
//            }
            
            cell.lbl_Status.text = "Evaluation Status: ".localized()
            cell.lblNo.text =  "No".localized()
            cell.lblYes.text =  "Yes".localized()
            cell.lbl_Attachments.text = "Attachments".localized()
            
            if obj.IsNew == false{
                cell.btn_check.isHidden = true
                cell.tf_Title.isHidden = true
                cell.btn_delete.isHidden = true
                cell.viewSelectResult.isHidden = true
            }else{
                cell.lbl_Title.isHidden = true
                cell.tf_Title.placeholder = "Title"
                cell.btn_check.isHidden = true
                cell.tf_Title.isHidden = false
                cell.btn_delete.isHidden = false
                cell.viewSelectResult.isHidden = false
            }
            
            if obj_transaction?.transaction_request_last_step == "completed"{
                cell.btn_delete.isHidden = true
                cell.tf_Title.isHidden = true
                cell.stack_upload.isHidden = true
                cell.stack_status.isHidden = true
                
                if obj.status! == "1"{
                    cell.btn_check.setImage(UIImage(systemName: "checkmark"), for: .normal)
                    cell.btn_check.tintColor = "#4ca832".getUIColor()
                    
                }else{
                    cell.btn_check.tintColor = "#bf2a2a".getUIColor()
                    cell.btn_check.setImage(UIImage(systemName: "xmark"), for: .normal)
                }
                
            }else{
                
                if obj.status == "1" {
                    cell.btn_checkYes.setImage(UIImage(named: "check"), for: .normal)
                    cell.btn_checkNo.setImage(UIImage(named: "uncheck"), for: .normal)
                    self.arr_Technical_Assistants[indexPath.item].result = obj.yes_code_result
                }else if obj.status == "0" {
                    cell.btn_checkYes.setImage(UIImage(named: "uncheck"), for: .normal)
                    cell.btn_checkNo.setImage(UIImage(named: "check"), for: .normal)
                    self.arr_Technical_Assistants[indexPath.item].result = obj.no_code_result
                }else if obj.status == ""{
                    cell.btn_checkYes.setImage(UIImage(named: "uncheck"), for: .normal)
                    cell.btn_checkNo.setImage(UIImage(named: "uncheck"), for: .normal)
                    self.arr_Technical_Assistants[indexPath.item].result = ""
                }
            }
            
            var IsCheck:Bool = false
            var IsNo:Bool = false
       
            
            cell.btnNoAction = {
                
                cell.btn_checkYes.setImage(UIImage(named: "uncheck"), for: .normal)
                cell.btn_checkNo.setImage(UIImage(named: "check"), for: .normal)
                
                cell.lbl_EvaluationResult.text = "Evaluation Result: ".localized() + obj.no_code_result!
                IsCheck = true
                IsNo = true
                cell.lblSelectedResult.text = ""
                self.arr_Technical_Assistants[indexPath.item].status = "0"
                self.arr_Technical_Assistants[indexPath.item].result = obj.no_code_result
                
            }
            
            cell.btnYesAction = {
                
                cell.btn_checkNo.setImage(UIImage(named: "uncheck"), for: .normal)
                cell.btn_checkYes.setImage(UIImage(named: "check"), for: .normal)
                IsCheck = true
                IsNo = false
                cell.lblSelectedResult.text = ""
                cell.lbl_EvaluationResult.text = "Evaluation Result: ".localized() + obj.yes_code_result!
                self.arr_Technical_Assistants[indexPath.item].status = "1"
                self.arr_Technical_Assistants[indexPath.item].result = obj.yes_code_result
                
                
            }
            
            cell.btnUploadAction  = {
                
                if obj.url != nil && obj.IsNew == false{
                    let url = obj.url!.absoluteString
                    let vc:PDFViewrVC  = AppDelegate.mainSB.instanceVC()
                    vc.isModalInPresentation = true
                    vc.definesPresentationContext = true
                    vc.Strurl = url
                    self.present(vc, animated: true, completion: nil)
                }else{
                    self.Selected_index = indexPath.item
                    self.Upload_file()
                }
                
            }
            cell.btnDeleteAction = {
                
                self.arr_Technical_Assistants.remove(at: indexPath.item)
                self.table_checkList.reloadData()
            }
            
            var arr_result:[String] = [""]
            
            
            cell.btnSelectResultAction = {
                
                if IsCheck == false {
                    arr_result = ["Choose Option"]
                }else{
                    if IsNo == true{
                        arr_result = ["C","D"]
                    }else{
                        arr_result = ["A","B"]
                    }
                    
                }
                
                
                let dropDown = DropDown()
                dropDown.anchorView = self.view
                dropDown.backgroundColor = .white
                dropDown.cornerRadius = 2.0
                
                dropDown.dataSource =  arr_result
                
                if arr_result.count == 0 {
                    dropDown.dataSource = ["Choose Option"]
                    dropDown.selectionAction = { [unowned self] (index: Int, item: String) in
                        print("nil")
                        // self.imgDropWorkLevel.image = dropDownmage
                    }
                    //                    dropDown.selectionAction = { [unowned self] (index: Int, item: String) in
                    //                        cell.lblSelectedResult.text = ""
                    //                      //  self.imgDropZone.image = dropDownmage
                    //                    }
                    dropDown.textColor = #colorLiteral(red: 0.8039215803, green: 0.8039215803, blue: 0.8039215803, alpha: 1)
                }else{
                    dropDown.selectionAction = { [unowned self] (index: Int, item: String) in
                        
                        if item == arr_result[index] {
                            if item == "Choose Option"{
                                cell.lblSelectedResult.text = ""
                            }else{
                                cell.lblSelectedResult.text = item
                                self.arr_Technical_Assistants[indexPath.item].result = item
                            }
                            
                        }
                        
                    }
                    dropDown.direction = .bottom
                    dropDown.anchorView = cell.viewSelectResult
                    dropDown.bottomOffset = CGPoint(x: 0, y: cell.viewSelectResult.bounds.height)
                    dropDown.width = cell.viewSelectResult.bounds.width
                    dropDown.show()
                }
            }
            
            
            cell.btnEndEditingAction = {
                
                self.arr_Technical_Assistants[indexPath.item].title = cell.tf_Title.text!
                self.table_checkList.reloadData()
                
            }
            
            
            return cell
        case table_saudiCode:
            
            let cell = tableView.dequeueReusableCell(withIdentifier: "SaudiTVCell", for: indexPath) as! SaudiTVCell
            
            let obj = arr_file[indexPath.item]
            cell.tf_Title.placeholder = "Description".localized()
            cell.lblNumber.text = "# \(indexPath.item + 1)"
            
            
            cell.lblNo.text =  "No".localized()
            cell.lblYes.text =  "Yes".localized()
            self.BulidingSelected_index = obj.index
            cell.tf_Title.delegate = self
            
         
            
            cell.btnNoAction = {
                let obj = self.arr_file[indexPath.item]
                self.arr_file[indexPath.item] = SaudiBuillding(Status: "0", Title: obj.Title,index: obj.index)
                
                cell.btn_checkYes.setImage(UIImage(named: "uncheck"), for: .normal)
                cell.btn_checkNo.setImage(UIImage(named: "check"), for: .normal)
                
            }
            
            cell.btnYesAction = {
                
                let obj = self.arr_file[indexPath.item]
                self.arr_file[indexPath.item] = SaudiBuillding(Status: "1", Title: obj.Title,index: obj.index)
                
                cell.btn_checkNo.setImage(UIImage(named: "uncheck"), for: .normal)
                cell.btn_checkYes.setImage(UIImage(named: "check"), for: .normal)
            }
            
            
            cell.btnDeleteAction = {
                
                self.arr_file.remove(at: indexPath.item)
                self.table_saudiCode.reloadData()
                
            }
            cell.btnEndEditingAction = {
                
                self.arr_file[indexPath.item] = SaudiBuillding(Status: "1", Title: cell.tf_Title.text!,index: obj.index)
                
                self.table_saudiCode.reloadData()
                
            }
            
            return cell
            
        case table_note:
            
            let cell = tableView.dequeueReusableCell(withIdentifier: "SimpleNoteCell", for: indexPath) as! SimpleNoteCell
            
            let obj = arr_note[indexPath.item]
            cell.tf_Title.placeholder = "Description".localized()
            cell.lblNumber.text = "# \(indexPath.item + 1)"
            
            
            self.note_index = obj.index
            cell.tf_Title.delegate = self
      
            
            cell.btnDeleteAction = {
                self.arr_note.remove(at: indexPath.item)
                self.table_note.reloadData()
                
            }
            
            cell.btnEndEditingAction = {
                
                self.arr_note[indexPath.item] = NoteObj(Title: cell.tf_Title.text!,index: obj.index)
                self.table_note.reloadData()
                
            }
            
            return cell
            
        case table_supplier_notes:
            
            let cell = tableView.dequeueReusableCell(withIdentifier: "SimpleNoteCell", for: indexPath) as! SimpleNoteCell
            
            let obj = arr_supplier_notes[indexPath.item]
            cell.tf_Title.placeholder = "Description".localized()
            cell.lblNumber.text = "# \(indexPath.item + 1)"
            
            
            self.supplier_note_index = obj.index
            cell.tf_Title.delegate = self
      
            
            cell.btnDeleteAction = {
                self.arr_supplier_notes.remove(at: indexPath.item)
                self.table_supplier_notes.reloadData()
                
            }
            
            cell.btnEndEditingAction = {
                
                self.arr_supplier_notes[indexPath.item] = NoteObj(Title: cell.tf_Title.text!,index: obj.index)
                self.table_supplier_notes.reloadData()
                
            }
            
            return cell
            
            
        default:
            return UITableViewCell()
        }
        
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        self.viewWillLayoutSubviews()
    }
}


extension TechinicalAssistantVC : UICollectionViewDelegate , UICollectionViewDataSource  {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        return arr_special_approvers.count
        
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell:SpecialApproversCell = Collection.dequeueCVCell(indexPath: indexPath)
        let obj = self.arr_special_approvers[indexPath.item]
        
        
        cell.viewBack.backgroundColor = .white
        cell.viewBack.setBorderColorWidthCorner(0.5, 10, color: maincolor)
        cell.lblTitle.textColor = maincolor
        cell.lblTitle.text = obj.Title
        
        cell.btnDeleteAction = {
            
            self.arr_special_approvers.remove(at: indexPath.item)
            self.arr_special_id.remove(at: indexPath.item)
            self.Collection.reloadData()
            
        }
        return cell
        
        
    }
}

extension TechinicalAssistantVC : UIImagePickerControllerDelegate  {
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]){
        
        if let image = (info[.originalImage] as? UIImage){
            
            if let row = self.arr_Technical_Assistants.firstIndex(where: {$0.index == self.Selected_index}) {
                
                arr_Technical_Assistants[row].type = "img"
                arr_Technical_Assistants[row].img = image
                arr_Technical_Assistants[row].url = nil
                self.table_checkList.reloadData()
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
    
    
}





extension TechinicalAssistantVC: UIDocumentPickerDelegate {
    
    
    
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
                    
                    
                    if let row = self.arr_Technical_Assistants.firstIndex(where: {$0.index == self.Selected_index}) {
                        
                        arr_Technical_Assistants[row].type = "file"
                        arr_Technical_Assistants[row].img = nil
                        arr_Technical_Assistants[row].url = url
                        
                        self.table_checkList.reloadData()
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


extension TechinicalAssistantVC : UITextFieldDelegate {
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        
        print(textField.tag, " -> ", textField.text)
        
        
    }
    
}


extension UIView {
    func isInstalled() -> Bool{
        return (self.superview != nil) ? true : false
    }
}

