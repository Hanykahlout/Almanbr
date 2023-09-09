//
//  AttachmentsVC.swift
//  Almnabr
//
//  Created by MacBook on 16/11/2021.
//  Copyright © 2021 Samar Akkila. All rights reserved.
//

import UIKit
import MobileCoreServices
import DropDown

struct attachment {
    
    var title:String?
    var Required:String?
    var img:UIImage?
    var url:URL?
    var type:String?
    var index:Int = 0
    var IsNew:Bool = false
    var filePath = ""
}

struct notes {
    
    var id:String = ""
    var title:String = ""
    var result:String = ""
    var Required:String = ""
    var img:UIImage?
    var url:URL?
    var type:String = ""
    var index:Int = 0
    var IsNew:Bool = false
}

struct AttachNotes {
    
    var id:String?
    var title:String?
    var result:String?
    var Required:String?
    var img:UIImage?
    var url:URL?
    var type:String?
    var index:Int = 0
    var IsNew:Bool = false
    var arr:[notes] = []
}


struct SaudiBuillding {
    
    var Status:String?
    var Title:String?
    var index:Int = 0
}

struct NoteObj {
    
    var Title:String?
    var index:Int = 0
}


struct special_approvers {
    
    var Title:String?
    var id:String?
}

struct Technical_Assistants {
    
    var title:String?
    var status:String?
    var projects_from_consultant_id:String?
    var result:String?
    var img:UIImage?
    var url:URL?
    var type:String?
    var index:Int = 0
    var IsNew:Bool = false
    var yes_code_result:String?
    var no_code_result:String?
    var Required:String?
}

class AttachmentsVC: UIViewController ,UINavigationControllerDelegate{

    
    @IBOutlet weak var mainView: UIView!
    @IBOutlet weak var table: UITableView!
    
    @IBOutlet weak var imgStep: UIImageView!
    @IBOutlet weak var viewStep: UIView!
    @IBOutlet weak var lblStep: UILabel!
    @IBOutlet weak var lblAttachments: UILabel!
    
    @IBOutlet weak var btnNext: UIButton!
    @IBOutlet weak var btnPrevious: UIButton!
    
    @IBOutlet weak var lblContractorManager: UILabel!
    @IBOutlet weak var lblSelectContractor: UITextField!
    @IBOutlet weak var viewContractor: UIView!
    @IBOutlet weak var btnContractor: UIButton!
    @IBOutlet weak var imgDropContractor: UIImageView!
    @IBOutlet weak var btnDeleteContractor: UIButton!
    
    
    @IBOutlet weak var btnYes: UIImageView!
    @IBOutlet weak var btnNo: UIImageView!
    
    @IBOutlet weak var lblContractorTeamUsers: UILabel!
    @IBOutlet weak var lblYes: UILabel!
    @IBOutlet weak var lblNo: UILabel!
    
    @IBOutlet weak var Stack_contractor: UIView!
    
    @IBOutlet weak var img_nodata: UIImageView!
    
    @IBOutlet weak var collection_contractors: UICollectionView!
    
    @IBOutlet weak var Viewcollection_contractors: UIView!
    
    
    var IsFromTransaction:Bool = false
    
    var arr_default_attachment:[FileObj] = []
    var arr_data:[AttachmentsObj] = []
    var arr_file:[attachment] = []
    var ProjectObj:templateObj!
    var transaction_separation:String = ""
    
    var units_and_level :String = ""
    var StrLanguage:String = "en"
    var Selected_index:Int = 0
    var work_site:String = "ALL"
    var units :String = ""
    var user_position:String = "CTT01"
    
    var form_wir_data:templateObj?
    
    var transaction_id:String = "0"
    
    var projects_work_area_id:String = ""
    var template_platform_code_system:String = ""
    var template_id:String = ""
    
    var template_platform_group_type_code_system:String = ""
    
    var arr_NoData:[String] = ["No items found".localized()]
    
    var parm = [:] as [String : String]
    var level_Unit = ""
    
    var arr_contractor:[ContractorObj] = []
    var arr_contractor_label:[String] = []
    var arr_SelectedContractor:[String] = []
    var arr_ObjectSelectedcontractor:[ContractorObj] = []
    
    var arr_unit:[uintObj] = []
    
    let imagePickerController = UIImagePickerController()
    var documentInteractionController: UIDocumentPickerViewController? = nil
    
    
    let checked =  UIImage.fontAwesomeIcon(name: .checkCircle, style: .solid, textColor: HelperClassSwift.bcolor.getUIColor(), size: CGSize(width: 40, height: 40))
    
    let Unchecked =  UIImage.fontAwesomeIcon(name: .circle, style: .solid, textColor: HelperClassSwift.bcolor.getUIColor(), size: CGSize(width: 40, height: 40))
    
    let dropUpmage =  UIImage.fontAwesomeIcon(name: .chevronUp , style: .solid, textColor:  .gray, size: CGSize(width: 40, height: 40))
    
    let dropDownmage =  UIImage.fontAwesomeIcon(name: .chevronDown , style: .solid, textColor:  .gray, size: CGSize(width: 40, height: 40))
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configGUI()
        get_default_attachments()
        
        get_ContractorTeamUsers()
        
        self.img_nodata.isHidden = true
//        if self.arr_default_attachment.count == 0{
//            self.img_nodata.isHidden = false
//        }else{
//            self.img_nodata.isHidden = true
//        }
        
        
    }
    
    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        // Hide the Navigation Bar
        self.navigationController?.setNavigationBarHidden(true, animated: true)
    }
    
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        // Show the Navigation Bar
        self.navigationController?.setNavigationBarHidden(true, animated: true)
    }
    
    
    //MARK: - Config GUI
    //------------------------------------------------------
    func configGUI() {
 
        self.parm["contractor_manager_step_require"] = "0"
        
        self.btnNext.setTitle("Next".localized(), for: .normal)
        self.btnPrevious.setTitle("Previous".localized(), for: .normal)
        
        viewContractor.setBorderGray()
        imagePickerController.delegate = self
        
        self.viewStep.backgroundColor = HelperClassSwift.acolor.getUIColor()
        self.lblStep.text = "txt_Attachments".localized()
        self.lblStep.font = .kufiRegularFont(ofSize: 15)
        self.lblStep.textColor = "#616263".getUIColor()
        
        self.lblAttachments.text = "txt_Attachments".localized()
        self.lblAttachments.font = .kufiRegularFont(ofSize: 15)
        self.lblAttachments.textColor = .gray
        
        
        
        lblContractorManager.textColor = .gray
        lblContractorManager.font = .kufiRegularFont(ofSize: 15)
        lblContractorManager.text = "lbl_ContractorManager".localized()
       
        
        lblSelectContractor.textColor = .gray
        lblSelectContractor.font = .kufiRegularFont(ofSize: 15)
        lblSelectContractor.text = "lbl_ContractorTeamUsers".localized()
       
        
        
        lblContractorTeamUsers.textColor = .gray
        lblContractorTeamUsers.font = .kufiRegularFont(ofSize: 15)
        lblContractorTeamUsers.text = "lbl_ContractorTeamUsers".localized()
        
        
        lblYes.textColor = .gray
        lblYes.font = .kufiRegularFont(ofSize: 15)
        lblYes.text = "txt_Yes".localized()
        
        
        lblNo.textColor = .gray
        lblNo.font = .kufiRegularFont(ofSize: 15)
        lblNo.text = "txt_No".localized()
        
        
        
        self.btnYes.image = UIImage(named: "uncheck")
        self.btnNo.image = UIImage(named: "check")
        
        if L102Language.currentAppleLanguage() == "ar" {
            self.btnNext.setImage(UIImage(systemName: "arrow.left"), for: .normal)
            self.btnPrevious.setImage(UIImage(systemName: "arrow.right"), for: .normal)
        }
        
        self.viewStep.setBorderGrayWidth(3)
        let Stepimage =  UIImage.fontAwesomeIcon(name: .building, style: .solid, textColor: HelperClassSwift.bcolor.getUIColor(), size: CGSize(width: 40, height: 40))
        self.imgStep.image = Stepimage
        
       
        
        table.dataSource = self
        table.delegate = self
        let nib = UINib(nibName: "AttachmentsCell", bundle: nil)
        table.register(nib, forCellReuseIdentifier: "AttachmentsCell")
        
        if userObj?.user_type_id == "1" {
            switch self.template_platform_group_type_code_system {
            case "WIR":
                self.arr_file.append(attachment(title: "Signed Contractor Request PDF", Required: "Yes", img: nil, url: nil,type: "img" ,index: 0 , IsNew: true))
                
                self.Selected_index = self.Selected_index + 1
                
            case "DSR":
                self.arr_file.append(attachment(title: "Signed Contractor Request PDF", Required: "Yes", img: nil, url: nil,type: "img" ,index: 0 , IsNew: true))
                self.arr_file.append(attachment(title: "Stamped PDF drawings", Required: "Yes", img: nil, url: nil,type: "img" ,index: 1 , IsNew: true))
                self.arr_file.append(attachment(title: "Drawings Source in (ZIP) file", Required: "Yes", img: nil, url: nil,type: "img" ,index: 2 , IsNew: true))
                self.Selected_index = self.Selected_index + 1
                
            case "MIR":
                self.arr_file.append(attachment(title: "lang_sign_and_stamp_contractor_request", Required: "Yes", img: nil, url: nil,type: "img" ,index: 0 , IsNew: true))
                self.arr_file.append(attachment(title: "Material Specification", Required: "Yes", img: nil, url: nil,type: "img" ,index: 1 , IsNew: true))
                
                self.Selected_index = 2
                
            case "MSR":
                self.arr_file.append(attachment(title: "Signed Contractor Request PDF", Required: "Yes", img: nil, url: nil,type: "img" ,index: 0 , IsNew: true))
                self.arr_file.append(attachment(title: "Material Specification", Required: "Yes", img: nil, url: nil,type: "img" ,index: 1 , IsNew: true))
                
                self.arr_file.append(attachment(title: "Certificate of origin", Required: "No", img: nil, url: nil,type: "img" ,index: 2 , IsNew: true))
                self.arr_file.append(attachment(title: "SASO or SABR", Required: "No", img: nil, url: nil,type: "img" ,index: 3 , IsNew: true))
                self.arr_file.append(attachment(title: "Another specification", Required: "No", img: nil, url: nil,type: "img" ,index: 4 , IsNew: true))
                self.arr_file.append(attachment(title: "Authorities requirements", Required: "No", img: nil, url: nil,type: "img" ,index: 5 , IsNew: true))
                
                self.Selected_index = 6
                
            case "SQR":
                self.arr_file.append(attachment(title: "lang_sign_and_stamp_contractor_request", Required: "Yes", img: nil, url: nil,type: "img" ,index: 0 , IsNew: true))
                self.arr_file.append(attachment(title: "Material Specification", Required: "Yes", img: nil, url: nil,type: "img" ,index: 1 , IsNew: true))
                
                self.Selected_index = 2
            default:
                print("nil")
            }
            
        }else if userObj?.user_type_id == "4" {
            switch self.template_platform_group_type_code_system {
            case "WIR":
                print("no files for type id 4")
//                self.arr_file.append(attachment(title: "Signed Contractor Request PDF", Required: "No", img: nil, url: nil,type: "img" ,index: 0 , IsNew: true))
//
//                self.Selected_index = self.Selected_index + 1
                
            case "DSR":
              
                self.arr_file.append(attachment(title: "Stamped PDF drawings", Required: "Yes", img: nil, url: nil,type: "img" ,index: 0 , IsNew: true))
                self.arr_file.append(attachment(title: "Drawings Source in (ZIP) file", Required: "Yes", img: nil, url: nil,type: "img" ,index: 1 , IsNew: true))
                self.Selected_index = self.Selected_index + 1
                
            case "MIR":
                self.arr_file.append(attachment(title: "Material Specification", Required: "Yes", img: nil, url: nil,type: "img" ,index: 0 , IsNew: true))
                
                self.Selected_index = 1
                
            case "MSR":
                self.arr_file.append(attachment(title: "Signed Contractor Request PDF", Required: "Yes", img: nil, url: nil,type: "img" ,index: 0 , IsNew: true))
                self.arr_file.append(attachment(title: "Material Specification", Required: "Yes", img: nil, url: nil,type: "img" ,index: 1 , IsNew: true))
                
                self.arr_file.append(attachment(title: "Certificate of origin", Required: "No", img: nil, url: nil,type: "img" ,index: 2 , IsNew: true))
                self.arr_file.append(attachment(title: "SASO or SABR", Required: "No", img: nil, url: nil,type: "img" ,index: 3 , IsNew: true))
                self.arr_file.append(attachment(title: "Another specification", Required: "No", img: nil, url: nil,type: "img" ,index: 4 , IsNew: true))
                self.arr_file.append(attachment(title: "Authorities requirements", Required: "No", img: nil, url: nil,type: "img" ,index: 5 , IsNew: true))
                
                self.Selected_index = 6
                
            case "SQR":
                self.arr_file.append(attachment(title: "lang_sign_and_stamp_contractor_request", Required: "Yes", img: nil, url: nil,type: "img" ,index: 0 , IsNew: true))
                self.arr_file.append(attachment(title: "Material Specification", Required: "Yes", img: nil, url: nil,type: "img" ,index: 1 , IsNew: true))
                
                self.Selected_index = 2
            default:
                print("nil")
            }
        }
        
        let userType = userObj?.user_type_id
        
        if userType == "3" || userType == "4" {
            Stack_contractor.isHidden = false
        }else{
            Stack_contractor.isHidden = true
        }
        self.Viewcollection_contractors.isHidden = true
        
        if IsFromTransaction {
            if form_wir_data?.contractor_manager_step_require == "1" {
                self.user_position = "CTM01"
                self.parm["contractor_manager_step_require"] = "1"
                self.btnNo.image = UIImage(named: "uncheck")
                self.btnYes.image = UIImage(named: "check")
            }else{
                self.user_position = "CTT01"
                self.parm["contractor_manager_step_require"] = "0"
                self.btnNo.image = UIImage(named: "check")
                self.btnYes.image = UIImage(named: "uncheck")
            }
        }
       
        
    }
    
    
    
    
    
    
    func get_default_attachments(){
        
        self.showLoadingActivity()
        
//        guard ProjectObj != nil else{
//            return
//        }
       
        var params = [:] as [String : String]
        
       params["projects_work_area_id"] = self.projects_work_area_id
       params["platform_code_system"] = self.template_platform_code_system
       params["lang_key"] = StrLanguage
       params["work_site"] = self.work_site
        
        
        if arr_unit.count == 0 {
          params["units_and_level[\(self.level_Unit)]"] = self.units
        }else{
           
            var unit_str :String = ""
            var value_str :String = ""
            
            for i in arr_unit {
             
                if value_str == i.value! {
                    unit_str = unit_str + i.unit! + ","
                    params["units_and_level[\(i.value ?? "level_all_building")]"] = i.unit
                    value_str = i.value!
                }else{
                   params["units_and_level[\(i.value ?? "level_all_building")]"] = i.unit
                    value_str = i.value!
                }
               
            }
            
        }
        
     
        
        APIController.shard.sendRequestPostAuth(urlString: "form/FORM_\(self.template_platform_group_type_code_system)/get_default_attachments", parameters: params ) { (response) in
            self.hideLoadingActivity()
           
            
            let status = response["status"] as? Bool
            let error = response["error"] as? String
            
            
            if status == true{
                if  let list = response["records"] as? NSArray{
                    for i in list {
                        let dict = i as? [String:Any]
                        let obj = FileObj.init(dict!)
                        self.arr_default_attachment.append(obj)
                    }
                    
                    for i in self.arr_default_attachment{
                  
                        
                              
//                              let value = attachment(title:i.label, img: nil, url: URL(string: i.file_path), type: "file",index: self.Selected_index , IsNew: false , required : "No")
                        
                        let value = attachment(title:i.label, Required: "Yes", img: nil, url: URL(string: i.file_path) ,type: "file" , index: self.Selected_index , IsNew : false)
                        self.Selected_index = self.arr_file.count - 1
                        //self.Selected_index + 1
                        self.arr_file.append(value)
         
                    }
            
                    
                    self.table.reloadData()
                    
            }else{
                self.showAMessage(withTitle: "Error", message: error ?? "Some thing went wrong")
                
            }

            
           
            }

        
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
    
    
    
    func Submit_request(){
        
//        guard arr_file.count != 0 else {
//            showAMessage(withTitle: "error".localized(), message: "Please enter your file".localized())
//            return
//        }
  
        var Con_users = ""
        for item in arr_ObjectSelectedcontractor{
            if arr_ObjectSelectedcontractor.count > 1 {
                Con_users = item.user_id + "," + Con_users
               
            }else{
                Con_users = item.user_id
            }
        }
        if arr_ObjectSelectedcontractor.count > 1 { Con_users =  String(Con_users.dropLast())}
        
        self.parm["contractor_team_users"] = Con_users
        
        for i in arr_file {
            let urlStr = i.url
            let img = i.img
                 
            if (urlStr == nil && img == nil) {
                showAMessage(withTitle: "error".localized(), message: "Please enter your file".localized())
                return
            }else{
                for i in arr_file {
                    self.parm["attachments[\(i.index)][attach_title]"] = i.title
                    self.parm["attachments[\(i.index )][required]"] = i.Required
                }
            }}
                
                showLoadingActivity()
                let code = self.template_platform_group_type_code_system
                var formUrl = "/form/FORM_\(self.template_platform_group_type_code_system)/cr/2/\(transaction_id)"
                if code == "MIR" ||  code == "MSR" || code == "SQR"{
                    formUrl =  "/form/FORM_\(self.template_platform_group_type_code_system)/cr/3/\(transaction_id)"
                }
                
        APIController.shard.func_Upload(queryString: formUrl, arr_file, param: self.parm ) { (respnse ) in
                    
                    let status = respnse["status"] as? Bool
                    let errors = respnse["error"] as? String

                    
                    if status == true{
                        
                       
                        
                        let vc:AllTicketVC = AppDelegate.TicketSB.instanceVC()
                        vc.pushToTransactionS = true
                        let nav = UINavigationController.init(rootViewController: vc)
                        _ =  self.panel?.center(nav)
                        
                        
//                        let page = UINavigationController.init(rootViewController: vc)
//                        _ =  self.panel?.center(page)
               
                    }else{
                        
                        self.hideLoadingActivity()
                        self.showAMessage(withTitle: "error".localized(), message: errors ?? "something went wrong")
                    }
                    self.hideLoadingActivity()
                    
            }
        }
        
        
    
    
    
    func get_ContractorTeamUsers(){
      
       self.showLoadingActivity()
        APIController.shard.sendRequestGetAuth(urlString: "/form/FORM_\(self.template_platform_group_type_code_system)/contractor_users?lang_key=\(StrLanguage)&projects_work_area_id=\(self.projects_work_area_id))&user_position=\(self.user_position)" ) { (response) in
            
            
            let status = response["status"] as? Bool
            if status == true{
                if  let list = response["records"] as? NSArray{
                    for i in list {
                        let dict = i as? [String:Any]
                        let obj = ContractorObj.init(dict!)
                        self.arr_contractor.append(obj)
                        // for echitem in obj{
                        //self.level_Unit = obj.value
                        self.arr_contractor_label.append(obj.label)
                        // }
                        
                    }
                    self.hideLoadingActivity()
                }
            }
            
            
        }
    }
    
    
    
    @IBAction func btnBack_Click(_ sender: Any) {
        
        self.navigationController?.popViewController(animated: true)
    }
    
    
    @IBAction func btnSubmit_Click(_ sender: Any) {
        Submit_request()
    }
    
    @IBAction func btnAddFile_Click(_ sender: Any) {
        
        var is_nil = false
        
        for i in arr_file {
            
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
            
            let new_index = arr_file.count + 1
           // attachment(title: "", Required: "No", img: nil, url: nil, type: "file", index: new_index, IsNew: true)
            self.arr_file.append(attachment(title: "", Required: "No", img: nil, url: nil,type: "file", index: new_index ,IsNew: true))
          
            self.table.beginUpdates()
            self.table.insertRows(at: [IndexPath.init(row: self.arr_file.count-1, section: 0)], with: .automatic)
            self.table.endUpdates()
        }
        
     
    }
    

    
    @IBAction func btnContractorTeamUser_Click(_ sender: Any) {
        
        self.imgDropContractor.image = dropUpmage
        
        let vc :PickerVC = AppDelegate.mainSB.instanceVC()
        vc.arr_data =  arr_contractor_label
        vc.isModalInPresentation = true
        vc.modalPresentationStyle = .overFullScreen
        vc.definesPresentationContext = true
        vc.delegate = {name , index in
            if name == self.arr_contractor_label[index] {
                let object =  self.arr_contractor[index]
                
                if self.arr_SelectedContractor.contains(name) == false{
                    self.arr_SelectedContractor.append(name)
                    self.arr_ObjectSelectedcontractor.append(object)
                }
                self.Viewcollection_contractors.isHidden = false
                self.collection_contractors.reloadData()
                
                self.imgDropContractor.image = self.dropDownmage
            }
        }
        self.present(vc, animated: true, completion: nil)
        
        
//        self.imgDropContractor.image = dropUpmage
//        let dropDown = DropDown()
//        dropDown.anchorView = view
//        dropDown.backgroundColor = .white
//        dropDown.cornerRadius = 2.0
//
//        if self.arr_contractor_label.count == 0 {
//            dropDown.dataSource = self.arr_NoData
//            dropDown.selectionAction = { [unowned self] (index: Int, item: String) in
//                self.imgDropContractor.image = dropDownmage
//            }
//            dropDown.textColor = #colorLiteral(red: 0.8039215803, green: 0.8039215803, blue: 0.8039215803, alpha: 1)
//        }else{
//            dropDown.dataSource = self.arr_contractor_label
//            dropDown.selectionAction = { [unowned self] (index: Int, item: String) in
//
//                if item == self.arr_contractor_label[index] {
//                    self.lblSelectContractor.text =  item
//                    let i =  self.arr_contractor[index]
//                    //self.StrWorkLevel = i.value
//                    self.parm["contractor_team_users"] = i.value
//                    self.imgDropContractor.image = dropDownmage
//                    self.btnDeleteContractor.isHidden = false
//
//                }
//
//            }
//
//        }
//        dropDown.direction = .bottom
//        dropDown.anchorView = viewContractor
//        dropDown.bottomOffset = CGPoint(x: 0, y: viewContractor.bounds.height)
//        dropDown.width = viewContractor.bounds.width
//        dropDown.show()

    }
    
    
    @IBAction func btnNo_Click(_ sender: Any) {
        
        self.user_position = "CTT01"
        self.parm["contractor_manager_step_require"] = "0"
        self.btnNo.image = UIImage(named: "check")
        self.btnYes.image = UIImage(named: "uncheck")
    }
    
    @IBAction func btnYes_Click(_ sender: Any) {
        
        self.user_position = "CTM01"
        self.parm["contractor_manager_step_require"] = "1"
        self.btnNo.image = UIImage(named: "uncheck")
        self.btnYes.image = UIImage(named: "check")
    
    }
    
    
    @IBAction func btnDelete_Click(_ sender: Any) {
        self.lblContractorTeamUsers.text = "lbl_ContractorTeamUsers".localized()
        self.btnDeleteContractor.isHidden = true
       
    }
    
    
}


extension AttachmentsVC: UITableViewDelegate , UITableViewDataSource{
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    
      
        return arr_file.count
    
       
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
     
            let cell = tableView.dequeueReusableCell(withIdentifier: "AttachmentsCell", for: indexPath) as! AttachmentsCell
        
        let obj = arr_file[indexPath.item]
        
        if obj.title != ""{
            
            if obj.IsNew == true {
               
                cell.btn_Select.setImage( UIImage(systemName: "square.and.arrow.up"), for: .normal)
            }else{
                
                if obj.title != "Signed Contractor Request PDF" {
                    cell.btn_Select.setImage(UIImage(named: "icon-pdf"), for: .normal)
                }else if obj.title != "Stamped PDF drawings" {
                    cell.btn_Select.setImage(UIImage(named: "icon-pdf"), for: .normal)
                }else if obj.title != "Drawings Source in (ZIP) file" {
                    cell.btn_Select.setImage(UIImage(named: "icon-pdf"), for: .normal)
                }
                
            }
            
            if (obj.img != nil || obj.url != nil) {
                cell.btn_Select.tintColor = "#3ea832".getUIColor()
            }else{
                cell.btn_Select.tintColor = HelperClassSwift.acolor.getUIColor()
            }
            cell.lblNo.text =  "#" + "\(indexPath.item + 1)"
            cell.lblNo.font = .kufiRegularFont(ofSize: 13)
            cell.tfTitle.text = obj.title
            
//            if obj.IsNew == true {
//                cell.btn_delete.isHidden = false
//            }else{
//                cell.btn_delete.isHidden = true
//            }
            
            if obj.Required == "Yes" {
                cell.btn_delete.isHidden = true
            }else{
                cell.btn_delete.isHidden = false
            }
            
            cell.tfTitle.isUserInteractionEnabled = false
            
            
        }else{
            
            if (obj.img != nil || obj.url != nil) {
                cell.btn_Select.tintColor = "#3ea832".getUIColor()
            }else{
                cell.btn_Select.tintColor = HelperClassSwift.acolor.getUIColor()
            }
            
            //"plus.rectangle.fill.on.folder.fill"
            cell.btn_Select.setImage( UIImage(systemName: "square.and.arrow.up"), for: .normal)
            
            cell.lblNo.text =  "#" + "\(indexPath.item + 1)"
            cell.lblNo.font = .kufiRegularFont(ofSize: 13)
            cell.tfTitle.text = ""
            cell.tfTitle.placeholder = "Description".localized()
            //cell.btn_Select.tintColor = HelperClassSwift.acolor.getUIColor()
            if obj.IsNew == true {
                cell.btn_delete.isHidden = false
            }else{
                cell.btn_delete.isHidden = true
            }
            
            cell.tfTitle.isUserInteractionEnabled = true
        }
        
        
        cell.btnDeleteAction = {
          
            self.arr_file.remove(at: indexPath.item)
            self.table.reloadData()
            
        }
        
        cell.btnEndEditingAction = {
            self.arr_file[indexPath.item].title = cell.tfTitle.text ?? ""
        }
        cell.btnUploadAction = {
          
            if obj.url != nil && obj.IsNew == false{
                let url = obj.url!.absoluteString
                let vc:PDFViewrVC  = AppDelegate.mainSB.instanceVC()
                vc.isModalInPresentation = true
                //vc.modalPresentationStyle = .overFullScreen
                vc.definesPresentationContext = true
                vc.Strurl = url
                self.present(vc, animated: true, completion: nil)
            }else{
                self.Selected_index = obj.index
                self.Upload_file()
            }
        }
        
        return cell
        
        
        
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let obj = arr_file[indexPath.item]
        
    }
}




extension AttachmentsVC : UIImagePickerControllerDelegate  {
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]){
        
        if let image = (info[.originalImage] as? UIImage){
            
            if let row = self.arr_file.firstIndex(where: {$0.index == self.Selected_index}) {
                 
                arr_file[row].type = "img"
                arr_file[row].img = image
                arr_file[row].url = nil
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





extension AttachmentsVC: UIDocumentPickerDelegate {
    
    
    
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
                    
                    if let row = self.arr_file.firstIndex(where: {$0.index == self.Selected_index}) {
                        
                        arr_file[row].type = "file"
                        arr_file[row].img = nil
                        arr_file[row].url = url
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


//template_platform_group_type_code_system

extension AttachmentsVC: UICollectionViewDataSource ,UICollectionViewDelegate , UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
            return arr_SelectedContractor.count
       
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "unitCVCell", for: indexPath) as! unitCVCell
        
            cell.lblTitle.text = arr_SelectedContractor[indexPath.row]
            cell.viewBack.setBorderWithColor("458FB8".getUIColor())
            cell.lblTitle.font = .kufiRegularFont(ofSize: 11)
            
            cell.btnDeleteAction = {
              
                self.arr_SelectedContractor.remove(at: indexPath.item)
                self.collection_contractors.reloadData()
                if self.arr_SelectedContractor.count == 0 {
                    self.Viewcollection_contractors.isHidden = true
                }
                
            }
            
            return cell
        }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
       // cell.view_img.backgroundColor = HelperClassSwift.acolor.getUIColor()
        
    }
}
