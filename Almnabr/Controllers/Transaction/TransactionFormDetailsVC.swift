//
//  TransactionFormDetailsVC.swift
//  Almnabr
//
//  Created by MacBook on 04/12/2021.
//  Copyright © 2021 Samar Akkila. All rights reserved.
//

import UIKit
import DPLocalization
import FontAwesome_swift

import AMPopTip

var StatusObject:StepStatusObj?
var obj_transaction:Tcore?
var FormWirObject:form_wir_dataObj?
var obj_FormWir:WorkAreaInfoObj?
var data_FormWir:[String:Any] = [:]
var arr_Technical_Assistants_Evaluation:[Technical_Assistants_EvaluationObj] = []
var arr_form_unit_level:[project_supervision_form_unit_levelObj] = []

class TransactionFormDetailsVC: UIViewController {
    
    
    @IBOutlet weak var lblTitle: UILabel!
    @IBOutlet weak var lblRequestNumber: UILabel!
    @IBOutlet weak var lblProjectTitle: UILabel!
    @IBOutlet weak var lblServiceName: UILabel!
    @IBOutlet weak var lblFormCode: UILabel!
    @IBOutlet weak var lblDivision: UILabel!
    @IBOutlet weak var lblChapter: UILabel!
    @IBOutlet weak var lblItemName: UILabel!
    @IBOutlet weak var lblFormSpecifications: UILabel!
    @IBOutlet weak var lblLocation: UILabel!
    @IBOutlet weak var lblFormVersions: UILabel!
    @IBOutlet weak var lblPreview: UILabel!
    @IBOutlet weak var lblLang_drawing_file: UILabel!
    @IBOutlet weak var lblValRequestNumber: UILabel!
    @IBOutlet weak var lblValProjectTitle: UILabel!
    @IBOutlet weak var lblValServiceName: UILabel!
    @IBOutlet weak var lblValFormCode: UILabel!
    @IBOutlet weak var lblValDivision: UILabel!
    @IBOutlet weak var lblValChapter: UILabel!
    @IBOutlet weak var lblValItemName: UILabel!
    @IBOutlet weak var lblValFormSpecifications: UILabel!
  
    @IBOutlet weak var lblValLang_drawing_file: UILabel!
    
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var btnLocation: UIButton!
    @IBOutlet weak var btnFormVersions: UIButton!
    @IBOutlet weak var btnPreview: UIButton!
    
    @IBOutlet weak var lblSelectedStep: UILabel!
    @IBOutlet weak var lblValSelectedStep: UILabel!
    @IBOutlet weak var lblLastStepOpened: UILabel!
    @IBOutlet weak var lblLastValStepOpened: UILabel!
    @IBOutlet weak var btnLastValStepOpened: UIButton!
    @IBOutlet weak var btnWaitingFor: UIButton!
    @IBOutlet weak var lblStep: UILabel!
    @IBOutlet weak var lblWaitingFor: UILabel!
    
    @IBOutlet weak var mainView: UIView!
    @IBOutlet weak var slider: UIProgressView!
    
    @IBOutlet weak var header: HeaderView!
    
    @IBOutlet weak var btnNotes: UIButton!
    @IBOutlet weak var btnPersonDetails: UIButton!
    @IBOutlet weak var btnAttachments: UIButton!
    @IBOutlet weak var btnHistory: UIButton!
    @IBOutlet weak var btnAllProject: UIButton!
    @IBOutlet weak var btnSupervisionOperations: UIButton!
    
    @IBOutlet weak var btnEvalutionResult: UIButton!
    
    @IBOutlet weak var btnNext: UIButton!
    @IBOutlet weak var btnPrevious: UIButton!
    
    @IBOutlet weak var container_view: UIView!
    @IBOutlet weak var view_pager: UIView!
    
    @IBOutlet weak var pager_view: UIView!
    
    var pageViewController: UIPageViewController!
//    var index = 0
    
    private var vc_array : [UIViewController] = []
    
    var isFromHome: Bool = false
    var isFromFinish: Bool = false
    
    var StrTitle:String = ""

    var projectId:String = ""
    var CustomerName:String = ""
    
    var transaction_status:String = ""
    
    var SelectedIndex:Int = 1
    
    var str_url:String = ""
    var IsFromNotification:Bool = false
    let maincolor = "#1A3665".getUIColor()
    
    
    var Object:Tcore?
    var transactions_request:Tcore?
    var WorkAreaObj:WorkAreaInfoObj?
    var FormWirObj:form_wir_dataObj?
    var arr_transactionsNotes:[transactions_notesObj] = []
    var arr_transactions_persons:[transactions_personsObj] = []
    var arr_transactions_records:[transactions_recordsObj] = []
    var arr_Configurations_Attachments:[Configurations_AttachmentsObj] = []
    var arr_project_supervision_form_unit_level:[project_supervision_form_unit_levelObj] = []
    
    
    
    let arr_step:[String] = [ "Configurations".localized(),
                              "Contractor Team Approval".localized(),
                              "Contractor Manager Approval".localized(),
                              "Recipient Verification".localized(),
                              "Techinical Assistant".localized(),
                              "Special Approval".localized(),
                              "Evaluation Result".localized(),
                              "Authorized Positions Approval".localized(),
                              "Manager Approval".localized(),
                              "Owners Representative".localized(),
                              "Final Result".localized()]
    
    let arr_Valstep:[String] = [ "Configurations",
                                 "Contractor_Team_Approval",
                                 "Contractor_Manager_Approval",
                                 "Recipient_Verification",
                                 "Techinical_Assistant",
                                 "Special_Approval",
                                 "Evaluation_Result",
                                 "Authorized_Positions_Approval",
                                 "Manager_Approval",
                                 "Owners_Representative",
                                 "last"]
    
    var arr_waitingFor:[String] = []
    var parentPageVC: TransactionFormPageaVC!

    private let page_count = 11
    var request_id:String = "0"
    var Form:String = ""
    var IsComplete:Bool = false
    
    var filePath:String = ""
    private let refreshControl = UIRefreshControl()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.hideLoadingActivity()
        setupPageController()
        
        if IsFromNotification == true{
            let splitString = str_url.components(separatedBy: "/vr/")
            
            let Form = str_url.components(separatedBy: "/form/")
            print("Part before space: \(Form[1])")
            self.Form = str_url
            //Form[1]
           self.request_id = "\(splitString[1])"
        }else{
            if Object?.transaction_request_id != nil {
                self.request_id =  Object?.transaction_request_id ?? "0"
                self.Form = Object?.transaction_key ?? ""
            }
        }
        
        self.mainView.isHidden = true
        self.pager_view.isHidden = true
                
        get_Request()
       
        configNavigation()
       
        update_Config()
        
        refreshControl.addTarget(self, action: #selector(refresh), for: UIControl.Event.valueChanged)
        scrollView.refreshControl = refreshControl
        
        if L102Language.currentAppleLanguage() == "en" {
           
            lblRequestNumber.textAlignment = .right
            lblProjectTitle.textAlignment = .right
            lblServiceName.textAlignment = .right
            lblFormCode.textAlignment = .right
            lblDivision.textAlignment = .right
            lblChapter.textAlignment = .right
            lblItemName.textAlignment = .right
            lblFormSpecifications.textAlignment = .right
            lblLocation.textAlignment = .right
            lblFormVersions.textAlignment = .right
            lblPreview.textAlignment = .right
            lblLang_drawing_file.textAlignment = .right
            lblValRequestNumber.textAlignment = .right
            lblValProjectTitle.textAlignment = .right
            lblValServiceName.textAlignment = .right
            lblValFormCode.textAlignment = .right
            lblValDivision.textAlignment = .right
            lblValChapter.textAlignment = .right
            lblValItemName.textAlignment = .right
            lblValFormSpecifications.textAlignment = .right
            
        }
        

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
       addNavigationBarTitle(navigationTitle: "Form Details".localized())
        UINavigationBar.appearance().backgroundColor = maincolor
    }
    
    @objc func refresh(sender:AnyObject) {
        self.get_Request()
        self.refreshControl.endRefreshing()
    }
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "FormDetailsPager", let _ = segue.destination as? TransactionFormPageaVC {
            IsTransaction = true
            if let controller = self.parentPageVC {
                controller.displayPageForIndex(index: self.SelectedIndex)
            }
        }
    }
    
    //MARK: - Config GUI
    //------------------------------------------------------
    func configGUI() {
        
 
        mainView.layer.applySketchShadow(
          color: .black,
          alpha: 0.6,
          x: 0,
          y: 13,
          blur: 16,
          spread: 0)
        mainView.setRounded(20)
        
        pager_view.layer.applySketchShadow(
          color: .black,
          alpha: 0.6,
          x: 0,
          y: 13,
          blur: 16,
          spread: 0)
        pager_view.setRounded(20)
        
        if L102Language.currentAppleLanguage() == "ar" {
            self.btnNext.setImage(UIImage(systemName: "arrow.left"), for: .normal)
            self.btnPrevious.setImage(UIImage(systemName: "arrow.right"), for: .normal)
        }
        
        self.slider.progressTintColor = maincolor
        self.slider.progress = 0.1
       
        self.title = "Form Details".localized()
        
        self.lblStep.font = .kufiRegularFont(ofSize: 13)
        self.lblStep.textColor =  maincolor
        self.lblStep.text =  "step 1 of \(page_count)"
        
       
        self.lblRequestNumber.font = .kufiRegularFont(ofSize: 13)
        
        if Object?.transaction_request_id == nil {
            
            let RN = "Request Number".localized() + ":  \(self.request_id)"
            
            let RNattribute: NSAttributedString = RN.attributedStringWithColor(["Request Number"], color: maincolor)
            self.lblRequestNumber.attributedText = RNattribute
            
           // self.lblValRequestNumber.text =  self.request_id
        }else{
            
            let RN = "Request Number".localized() + ":  \(Object?.transaction_request_id ?? "--")"
            
            let RNattribute: NSAttributedString = RN.attributedStringWithColor(["Request Number"], color: maincolor)
            self.lblRequestNumber.attributedText = RNattribute
            
            //self.lblRequestNumber.text =
            //self.lblValRequestNumber.text =  Object?.transaction_request_id
        }
        
       // self.lblProjectTitle.text =  "Project Title".localized() + " :\(WorkAreaObj?.projects_profile_name)"
        self.lblProjectTitle.font = .kufiRegularFont(ofSize: 13)
        //self.lblProjectTitle.textColor =  HelperClassSwift.bcolor.getUIColor()
        
        let ProjectTitle = "Project Title".localized() + ":  \(WorkAreaObj?.projects_profile_name ?? "--")"
        let ProjectTitleattribute: NSAttributedString = ProjectTitle.attributedStringWithColor(["Project Title"], color: maincolor)
        self.lblProjectTitle.attributedText = ProjectTitleattribute
        
         
        let Service =  "Service Name".localized() + ":  \(WorkAreaObj?.projects_services_name ?? "--")"
        let Serviceattribute: NSAttributedString = Service.attributedStringWithColor(["Service Name"], color: maincolor)
        self.lblServiceName.attributedText = Serviceattribute
        self.lblServiceName.font = .kufiRegularFont(ofSize: 13)
        
        
        
        let FormCode =  "Form Code".localized() + ":  \(FormWirObj?.platform_code_system ?? "--")"
        let FormCodeattribute: NSAttributedString = FormCode.attributedStringWithColor(["Form Code"], color: maincolor)
        self.lblFormCode.attributedText = FormCodeattribute
        self.lblFormCode.font = .kufiRegularFont(ofSize: 13)
        
        
        let Division  =  "Division".localized() + ":  \(FormWirObj?.group1name ?? "--")"
        let Divisionattribute: NSAttributedString = Division.attributedStringWithColor(["Division"], color: maincolor)
        self.lblDivision.attributedText = Divisionattribute
        self.lblDivision.font = .kufiRegularFont(ofSize: 13)
        
        
        let Chapter =  "Chapter".localized() + ":  \(FormWirObj?.group2name ?? "--")"
        let Chapterattribute: NSAttributedString = Chapter.attributedStringWithColor(["Chapter"], color: maincolor)
        self.lblChapter.attributedText = Chapterattribute
        self.lblChapter.font = .kufiRegularFont(ofSize: 13)
        
        
        let FormSpec =  "Form Specifications".localized() + ":  \(FormWirObj?.specification ?? "---")"
        let FormSpecattribute: NSAttributedString = FormSpec.attributedStringWithColor(["Form Specifications"], color: maincolor)
        self.lblFormSpecifications.attributedText = FormSpecattribute
        self.lblFormSpecifications.font = .kufiRegularFont(ofSize: 13)
        
        
        let ItemName =  "Item Name".localized() + ":  \(FormWirObj?.platformname ?? "--")"
        let ItemNameattribute: NSAttributedString = ItemName.attributedStringWithColor(["Item Name"], color: maincolor)
        self.lblItemName.attributedText = ItemNameattribute
        self.lblItemName.font = .kufiRegularFont(ofSize: 13)
        
        
        
        self.lblFormVersions.text =  "Form Versions".localized()
        self.lblFormVersions.font = .kufiRegularFont(ofSize: 12)
        self.lblFormVersions.textColor =  maincolor
        
        
        self.lblLocation.text =  "txt_location".localized()
        self.lblLocation.font = .kufiRegularFont(ofSize: 13)
        self.lblLocation.textColor =  maincolor
        
        self.lblPreview.text =  "Preview".localized()
        self.lblPreview.font = .kufiRegularFont(ofSize: 13)
        self.lblPreview.textColor =  maincolor
        
        self.lblLang_drawing_file.text =  "Lang_drawing_file".localized() + ": ----"
        self.lblLang_drawing_file.font = .kufiRegularFont(ofSize: 13)
        self.lblLang_drawing_file.textColor =  maincolor
        
      
        
        
        self.lblSelectedStep.text =  "Selected Step".localized() + " :"
        self.lblSelectedStep.font = .kufiRegularFont(ofSize: 12)
        self.lblSelectedStep.textColor = maincolor
        
        self.lblValSelectedStep.text =  "Recipient Verification".localized()
        self.lblValSelectedStep.font = .kufiRegularFont(ofSize: 12)
        self.lblValSelectedStep.textColor =  .gray
        
//        self.lblLastStepOpened.text =  "Last Step Opened".localized() + " :"
        self.lblLastStepOpened.font = .kufiRegularFont(ofSize: 12)
        self.lblLastStepOpened.textColor =  HelperClassSwift.bcolor.getUIColor()
        
        let last_step = transactions_request?.transaction_request_last_step
        
        
        lblLastValStepOpened.isHidden = true
//        btnLastValStepOpened.isHidden = true
        
        if last_step == "last" {
            
            let text = "Last Step Opened".localized() + " : " + "Processing".localized()
           // lblLastStepOpened.attributedText  = attributedText(withString: text , boldString: "Processing".localized(), font: .kufiRegularFont(ofSize: 12))
            
            let attributed: NSAttributedString = text.attributedStringWithColor(["Processing".localized()], color: "#61b045".getUIColor())
            self.lblLastStepOpened.attributedText = attributed
           
            
//            self.lblLastValStepOpened.text = "Processing".localized()
        }else{
            let text = "Last Step Opened".localized() + " : " + (last_step ?? "--")
//            lblLastStepOpened.attributedText  = attributedText(withString: text , boldString: last_step!, font: .kufiRegularFont(ofSize: 12))
            let attributed: NSAttributedString = text.attributedStringWithColor([last_step ?? "--"], color: "#61b045".getUIColor())
            self.lblLastStepOpened.attributedText = attributed
            
//            self.lblLastValStepOpened.text = last_step
        }
        
        if last_step == "completed" {
            self.IsComplete = true
            self.lblPreview.text = "View".localized()
            self.btnPreview.setImage(UIImage(systemName: "eye"), for: .normal)
//            doc.text
            self.btnEvalutionResult.setBorderWithColor(maincolor)
            self.btnEvalutionResult.isHidden = false
            self.btnEvalutionResult.setTitleColor(maincolor, for: .normal)
            self.btnEvalutionResult.titleLabel?.font = .kufiRegularFont(ofSize: 13)
            self.btnEvalutionResult.backgroundColor =  .white
            self.btnEvalutionResult.setTitle("Evaluation Result:".localized() + " \(self.FormWirObj?.evaluation_result ?? "C")", for: .normal)
        }else{
            self.btnEvalutionResult.isHidden = true
        }
        
        self.lblLastValStepOpened.font = .kufiRegularFont(ofSize: 13)
        self.lblLastValStepOpened.textColor =  "#61b045".getUIColor()
        
        let i1 = arr_Valstep.firstIndex(where: {$0 == last_step})
        print(i1 ?? 10)
        let index = i1 ?? 10
        page_scroll(SelectedIndex: index + 1 )
        self.SelectedIndex = index + 1
        let index_ =  StatusObject?.to_array.firstIndex(where: {$0 == true})
        
       
//        let status = StatusObject?.to_array[ index_ ?? 0]
        self.btnLastValStepOpened.titleLabel?.font = .kufiRegularFont(ofSize: 13)
     
        if transaction_status != ""{
            self.btnLastValStepOpened.isHidden = false
            
            if transaction_status == "Accepted" {
                
                self.btnLastValStepOpened.setTitleColor("#3ea832".getUIColor(), for: .normal)
                self.btnLastValStepOpened.setTitle("(\(transaction_status))".localized(), for: .normal)
                
            }else{
                
                self.btnLastValStepOpened.setTitleColor(.red, for: .normal)
                self.btnLastValStepOpened.setTitle("(\(transaction_status))".localized(), for: .normal)
                
            }
        }else{
            self.btnLastValStepOpened.isHidden = true
            self.btnLastValStepOpened.setTitle("", for: .normal)
        }
       
        
        
        self.btnNotes.setTitleColor(maincolor, for: .normal)
        self.btnPersonDetails.setTitleColor(maincolor, for: .normal)
        self.btnAttachments.setTitleColor(maincolor, for: .normal)
        self.btnHistory.setTitleColor(maincolor, for: .normal)
        
        self.btnNotes.setTitle("Notes".localized(), for: .normal)
        self.btnPersonDetails.setTitle("Person Details".localized(), for: .normal)
        self.btnAttachments.setTitle("Attachments".localized(), for: .normal)
        self.btnHistory.setTitle("History".localized(), for: .normal)
        self.btnSupervisionOperations.setTitle("Supervision Operations".localized(), for: .normal)
        self.btnAllProject.setTitle("All Projects".localized(), for: .normal)
        
        self.btnSupervisionOperations.backgroundColor =  maincolor
        self.btnAllProject.backgroundColor =  maincolor
        
        self.btnSupervisionOperations.setTitleColor(.white, for: .normal)
        self.btnAllProject.setTitleColor(.white, for: .normal)
        
        
        //self.btnNext.backgroundColor =  HelperClassSwift.acolor.getUIColor()
        //self.btnPrevious.backgroundColor =  HelperClassSwift.acolor.getUIColor()
       
        if L102Language.currentAppleLanguage() == "ar" {
            self.btnPrevious.setImage(UIImage(systemName: "arrow.left"), for: .normal)
            self.btnNext.setImage(UIImage(systemName: "arrow.right"), for: .normal)
        }else{
            self.btnNext.setImage(UIImage(systemName: "arrow.right"), for: .normal)
            self.btnPrevious.setImage(UIImage(systemName: "arrow.left"), for: .normal)
        }
        self.lblValSelectedStep.text = "\(arr_step[SelectedIndex-1])"
        
//        self.arr_waitingFor = []
        var name = "Waiting for : ".localized()
        for i in arr_waitingFor{
            name = name + i + " "
        }
        
      
        let Waitingattribute: NSAttributedString = name.attributedStringWithColor(["Waiting for : "], color: maincolor)
        self.lblWaitingFor.attributedText = Waitingattribute
        self.lblWaitingFor.font = .kufiRegularFont(ofSize: 13)
        
        
        self.hideLoadingActivity()
    }
    
    func page_scroll(SelectedIndex:Int){
        
        self.SelectedIndex = SelectedIndex
//        change_page(SelectedIndex: SelectedIndex)
        setupPageController()
        self.slider.progress = Float(SelectedIndex)/Float(page_count)
        self.lblStep.text =  "step".localized() + " \(SelectedIndex) " + "of".localized() + " \(page_count)"
        self.lblValSelectedStep.text = "\(arr_step[SelectedIndex-1])"
        
    }
   
    
    func get_Request(){
        print("\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\1")
        self.showLoadingActivity()
        if IsFromNotification == false {
            self.str_url = "/form/\(Object?.transaction_key ?? "FORM_WIR")/vr/\(self.request_id)"
        }else{
            self.str_url = self.Form
        }
       
        APIController.shard.sendRequestGetAuth(urlString: self.str_url) { (response) in
             
//            let error = response["error"] as? String
             let status = response["status"] as? Bool
             if status == true{
                 
                 data_FormWir = response
                 
                 IsTransaction = true
                 if  let step_status = response["step_status"] as? [String:Any]{

                     //let view = step_status["view"] as! [String:Any]
                     let edit = step_status["edit"] as! [String:Any]
                     let obj = StepStatusObj(edit)
                     StatusObject = obj
                     self.update_langVC()
                     self.setupPageController()
                     
//                     self.change_page(SelectedIndex: SelectedIndex)
                 }
                 
                 if  let view_request = response["view_request"] as? [String:Any]{

                     if let transactions_request = view_request["transactions_request"] as? [String:Any]{
                         let transactions_status = transactions_request["status"] as? Bool
                         if transactions_status == true{
                             let records = transactions_request["records"] as! [String:Any]
                             let recordsObj = Tcore(records)
                             self.transactions_request = recordsObj
                             obj_transaction = recordsObj
                             
                         }
                     }
                    
                     if let work_area_info = view_request["work_area_info"] as? [String:Any]{
                         let transactions_status = work_area_info["status"] as? Bool
                         if transactions_status == true{
                             let records = work_area_info["records"] as! [String:Any]
                             let recordsObj = WorkAreaInfoObj(records)
                             self.WorkAreaObj = recordsObj
                             obj_FormWir = recordsObj
                         }
                     }

                     if let form_wir_data = view_request["form_wir_data"] as? [String:Any]{
                         let form_wir_data_status = form_wir_data["status"] as? Bool
                         if form_wir_data_status == true{
                             let records = form_wir_data["records"] as! NSArray
                             
                             let recordsObj = form_wir_dataObj(records.firstObject as! [String : Any])
                             self.FormWirObj = recordsObj
                             FormWirObject = self.FormWirObj
                         }
                        
                     }
                     
                     
                     if let form_msr_data = view_request["form_msr_data"] as? [String:Any]{
                         let form_wir_data_status = form_msr_data["status"] as? Bool
                         if form_wir_data_status == true{
                             let records = form_msr_data["records"] as! NSArray
                             
                             let recordsObj = form_wir_dataObj(records.firstObject as! [String : Any])
                             self.FormWirObj = recordsObj
                             FormWirObject = self.FormWirObj
                         }
                     }
                     
                     if let form_mir_data = view_request["form_mir_data"] as? [String:Any]{
                         let form_mir_data_status = form_mir_data["status"] as? Bool
                         if form_mir_data_status == true{
                             let records = form_mir_data["records"] as! NSArray
                             
                             let recordsObj = form_wir_dataObj(records.firstObject as! [String : Any])
                             self.FormWirObj = recordsObj
                             FormWirObject = self.FormWirObj
                         }
                     }
                     
                     
                     if let form_dsr_data = view_request["form_dsr_data"] as? [String:Any]{
                         let form_dsr_data_status = form_dsr_data["status"] as? Bool
                         if form_dsr_data_status == true{
                             let records = form_dsr_data["records"] as! NSArray
                             
                             let recordsObj = form_wir_dataObj(records.firstObject as! [String : Any])
                             self.FormWirObj = recordsObj
                             FormWirObject = self.FormWirObj
                         }
                     }
                     
                     
                     if let form_sqr_data = view_request["form_sqr_data"] as? [String:Any]{
                         let form_sqr_data_status = form_sqr_data["status"] as? Bool
                         if form_sqr_data_status == true{
                             let records = form_sqr_data["records"] as! NSArray
                             
                             let recordsObj = form_wir_dataObj(records.firstObject as! [String : Any])
                             self.FormWirObj = recordsObj
                             FormWirObject = self.FormWirObj
                         }
                     }
                     
                     
                     if let transactions_notes = view_request["transactions_notes"] as? [String:Any]{
                         let transactions_notes_status = transactions_notes["status"] as? Bool
                         if transactions_notes_status == true{
                            
                             if  let records = transactions_notes["records"] as? NSArray{
                                 for i in records {
                                     let dict = i as? [String:Any]
                                     let obj = transactions_notesObj.init(dict!)
                                     self.arr_transactionsNotes.append(obj)
                                   
                                 }
                             }

                         }
                     }
                     
                     if let transactions_persons = view_request["transactions_persons"] as? [String:Any]{
                         let transactions_persons_status = transactions_persons["status"] as? Bool
                         if transactions_persons_status == true{
                             self.arr_waitingFor = []
                             if  let records = transactions_persons["records"] as? NSArray{
                                 for i in records {
                                     let dict = i as? [String:Any]
                                     let obj = transactions_personsObj.init(dict!)
                                     self.arr_transactions_persons.append(obj)
                                     
                                   
                                     if obj.transactions_persons_action_status == "0" {
                                         let name = obj.first_name + " " + obj.last_name
                                         self.arr_waitingFor.append(name)
                                         self.transaction_status = obj.transactions_persons_key4
                                     }
                                 }
                             }

                         }
                     }

                     if let transactions_records = view_request["transactions_records"] as? [String:Any]{
                         let transactions_records_status = transactions_records["status"] as? Bool
                         if transactions_records_status == true {
                            
                             if  let records = transactions_records["records"] as? NSArray{
                                 for i in records {
                                     let dict = i as? [String:Any]
                                     let obj = transactions_recordsObj.init(dict!)
                                     self.arr_transactions_records.append(obj)
                                   
                                 }
                             }

                         }
                     }

                     
                     if let Configurations_Attachments = view_request["Configurations_Attachments"] as? [String:Any]{
                         let Configurations_Attachments_status = Configurations_Attachments["status"] as? Bool
                         if Configurations_Attachments_status == true{
                            
                             if  let records = Configurations_Attachments["records"] as? NSArray{
                                 for i in records {
                                     let dict = i as? [String:Any]
                                     let obj = Configurations_AttachmentsObj.init(dict!)
                                     self.arr_Configurations_Attachments.append(obj)
                                   
                                 }
                             }

                         }
                     }
                     
                     
                     if let project_supervision_form_unit_level = view_request["project_supervision_form_unit_level"] as? [String:Any]{
                         let project_status = project_supervision_form_unit_level["status"] as? Bool
                         if project_status == true{
                            
                             if  let records = project_supervision_form_unit_level["records"] as? NSArray{
                                 for i in records {
                                     let dict = i as? [String:Any]
                                     let obj = project_supervision_form_unit_levelObj.init(dict!)
                                     self.arr_project_supervision_form_unit_level.append(obj)
                                     arr_form_unit_level.append(obj)
                                 }
                             }

                         }
                     }

                     
                     if let Technical_Assistants_Evaluation = view_request["Technical_Assistants_Evaluation"] as? [String:Any]{
                         let Technical_Assistants_Evaluation_status = Technical_Assistants_Evaluation["status"] as? Bool
                         if Technical_Assistants_Evaluation_status == true{
                             arr_Technical_Assistants_Evaluation = []
                             if  let records = Technical_Assistants_Evaluation["records"] as? NSArray{
                                 for i in records {
                                     let dict = i as? [String:Any]
                                     let obj = Technical_Assistants_EvaluationObj.init(dict!)
                                    arr_Technical_Assistants_Evaluation.append(obj)
                                   
                                 }
                             }

                         }
                     }
                     
                 }

                 self.mainView.isHidden = false
                 self.pager_view.isHidden = false
                 
                 
                 self.configGUI()
                 self.update_Notification()
                 
             }else{
                 self.hideLoadingActivity()
                 self.navigationController?.popViewController(animated: true)
//                 self.showAMessage(withTitle: "Error", message: error ?? "Some thing went wrong", completion: {
//                 
//                 
//                 })
             }
             
        }
        
//        if FormWirObj == nil{
//            self.navigationController?.popViewController(animated: true)
//        }
     }
    
    
    
    
    
    @IBAction func btnWaitingFor_Click(_ sender: Any) {
        var name = "Waiting for : ".localized()
        for i in arr_waitingFor{
            name = name + i + " "
        } 
            let popTip = PopTip()
        popTip.bubbleColor = HelperClassSwift.acolor.getUIColor()
        popTip.backgroundColor = HelperClassSwift.acolor.getUIColor()
        popTip.show(text: name, direction: .up, maxWidth: 200, in: view, from:  CGRect(x: btnWaitingFor.center.x + 400, y: btnWaitingFor.center.y + 400, width: 150, height: 40))
    
        //self.scrollView.convert(self.lblLastStepOpened.frame, to: nil)
    }
    
    
    @IBAction func btnNotes_Click(_ sender: Any) {
        
        let vc:NotesVC = AppDelegate.TransactionSB.instanceVC()
        vc.arr_data = self.arr_transactionsNotes
        
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    @IBAction func btnFormVersions_Click(_ sender: Any) {
        
        let VC:SubFormVersionVC = AppDelegate.TransactionSB.instanceVC()
        VC.platform_code_system = FormWirObj?.platform_code_system ?? "w"
        self.navigationController?.pushViewController(VC, animated: true)
    }
    
    
    @IBAction func btnPersonDetails_Click(_ sender: Any) {
        
        let vc:PersonDetailsVC = AppDelegate.TransactionSB.instanceVC()
        vc.arr_data = self.arr_transactions_persons
        
        self.navigationController?.pushViewController(vc, animated: true)
        
    }
    
    @IBAction func btnAttachments_Click(_ sender: Any) {
       
        let vc:FormsAttachmentsVC = AppDelegate.TransactionSB.instanceVC()
        vc.arr_data = self.arr_Configurations_Attachments
        
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    
    
    @IBAction func btnHistory_Click(_ sender: Any) {
        
        let vc:HistoryVC = AppDelegate.TransactionSB.instanceVC()
        vc.arr_data = self.arr_transactions_records
        
        self.navigationController?.pushViewController(vc, animated: true)
        
    }
    @IBAction func btnSupervisionOperations_Click(_ sender: Any) {
        
        
        let vc:SupervisionOperationVC = AppDelegate.mainSB.instanceVC()
        _ =  panel?.center(vc)
        
    }
    
    @IBAction func btnAllProject_Click(_ sender: Any) {
        
        let vc:AllPrpjectsVC = AppDelegate.mainSB.instanceVC()
        _ =  panel?.center(vc)
        
    }
    
    @IBAction func btnNext_Click(_ sender: Any) {
        
//        DispatchQueue.main.async {
//            self.setViewControllers([self.pages[index - 1]], direction: .reverse, animated: true, completion: nil)
//        }
        
        print(SelectedIndex)
        if SelectedIndex < page_count {
            SelectedIndex = SelectedIndex + 1
            print(SelectedIndex)
            setupPageController()
//            change_page(SelectedIndex: SelectedIndex)
//            self.viewControllerAtIndex(SelectedIndex)
            self.slider.progress = Float(SelectedIndex)/Float(page_count)
            self.lblStep.text =  "step".localized() + " \(SelectedIndex) " + "of".localized() +  " \(page_count)"
            self.lblValSelectedStep.text = "\(arr_step[SelectedIndex-1])"
            
        }
        
        
        
    }
    
    @IBAction func btnPrevious_Click(_ sender: Any) {
        print(SelectedIndex)
        if SelectedIndex >  1 {
            
            SelectedIndex = SelectedIndex - 1
            print(SelectedIndex)
            setupPageController()
//            change_page(SelectedIndex: SelectedIndex)
            self.slider.progress = Float(SelectedIndex)/Float(page_count)
            self.lblStep.text =  "step".localized() + " \(SelectedIndex) " + "of".localized() +  " \(page_count)"
            self.lblValSelectedStep.text = "\(arr_step[SelectedIndex-1])"
       
            
        }
       
    }
    
    @IBAction func Preview_Click(_ sender: Any) {
   
    let vc:PDFViewrVC  = AppDelegate.mainSB.instanceVC()
    vc.isModalInPresentation = true
        
        
        var id = self.request_id
        if id == "0" {
            id = Object?.transaction_request_id ?? "0"
        }
//        obj.file_path != ""
    vc.Strurl = "form/FORM_WIR/pr/\(id)"
        if self.IsComplete {
            vc.Strurl =  self.transactions_request?.view_link ?? ""
            //self.filePath
        }
    self.present(vc, animated: true, completion: nil)
 
    }
    
    @IBAction func location_Click(_ sender: Any) {
        
        let vc:SelectesUnits_levelsVC = AppDelegate.TransactionSB.instanceVC()
        vc.arr_data = self.arr_project_supervision_form_unit_level
        
        self.navigationController?.pushViewController(vc, animated: true)
        
    }
    
    
//    private func change_page(SelectedIndex:Int) {
//        NotificationCenter.default.post(name: NSNotification.Name("Change_Form_Step"),
//                                        object: SelectedIndex)
//    }
    
    private func update_langVC() {
        NotificationCenter.default.post(name: NSNotification.Name("update_langVC"),
                                        object: nil)
        configGUI()
    }
    
    private func update_Notification() {
        NotificationCenter.default.post(name: NSNotification.Name("update_Notification"),
                                        object: nil)
    }
    
    
    private func update_Config(){
        NotificationCenter.default.addObserver(forName: NSNotification.Name("update_Config"), object: nil, queue: .main) { notifi in
            self.get_Request()
        }
    }
    
}
extension TransactionFormDetailsVC {
    private func setupPageController() {
        pageViewController = UIPageViewController(transitionStyle: .scroll, navigationOrientation: .horizontal, options: nil)
        
        self.vc_array = []
        // Append VCS
        // vc_array -> Your Array
        let vc: LanguageVC = AppDelegate.mainSB.instanceVC()
        let page1 = UINavigationController(rootViewController: vc)
        vc.IsFromTransaction = true
        IsTransaction = true
        let page2: ContractorTeamApprovalVC = AppDelegate.TransactionSB.instanceVC()
        let page3: ContractorManagerApprovalVC = AppDelegate.TransactionSB.instanceVC()
        let page4: RecipientVerificationVC = AppDelegate.TransactionSB.instanceVC()
        let page5: TechinicalAssistantVC = AppDelegate.TransactionSB.instanceVC()
        let page6: SpecialApprovalVC = AppDelegate.TransactionSB.instanceVC()
        let page7: EvaluationResultVC = AppDelegate.TransactionSB.instanceVC()
        let page8: AuthorizedPositionsApprovalVC = AppDelegate.TransactionSB.instanceVC()
        let page9: ManagerApprovalVC = AppDelegate.TransactionSB.instanceVC()
        let page10: OwnersRepresentativeVC = AppDelegate.TransactionSB.instanceVC()
        let page11: FinalResultVC = AppDelegate.TransactionSB.instanceVC()

        
        vc_array.append(page1)
        vc_array.append(page2)
        vc_array.append(page3)
        vc_array.append(page4)
        vc_array.append(page5)
        vc_array.append(page6)
        vc_array.append(page7)
        vc_array.append(page8)
        vc_array.append(page9)
        vc_array.append(page10)
        vc_array.append(page11)

        let viewController = viewControllerAtIndex(SelectedIndex - 1)
        guard let vc = viewController else { return }
        print(vc)
        pageViewController.setViewControllers([vc], direction: .forward, animated: true)
        pageViewController.dataSource = self
        
        addChild(pageViewController)
        pager_view.addSubview(pageViewController.view)
        
        pageViewController!.view.frame = pager_view.bounds
        pageViewController.didMove(toParent: self)
        
        // Add the page view controller's gesture recognizers to the view controller's view so that the gestures are started more easily.
        view.gestureRecognizers = pageViewController.gestureRecognizers
    }

}

extension TransactionFormDetailsVC: UIPageViewControllerDataSource, UIPageViewControllerDelegate {
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerBefore viewController: UIViewController) -> UIViewController? {
        guard let id = indexOfViewController(viewController) else {return nil}
        let prev = id - 1
        guard prev >= 0 else {return nil}
        guard vc_array.count > prev  else {return nil}
        return viewControllerAtIndex(prev)
    }
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerAfter viewController: UIViewController) -> UIViewController? {
        return nil
    }
    
    func pageViewController(_ pageViewController: UIPageViewController, didFinishAnimating finished: Bool, previousViewControllers: [UIViewController], transitionCompleted completed: Bool) {
        guard finished else {return}
        guard let current = self.pageViewController.viewControllers?.first else {return}
        guard let i = vc_array.firstIndex(of: current) else { return}
        debugPrint("i is \(i)")
        SelectedIndex = i
    }
    
    private func viewControllerAfter(_ viewController:UIViewController) -> UIViewController? {
        guard let id = indexOfViewController(viewController) else {return nil}
        let next = id + 1
        guard next < vc_array.count else { return nil }
        guard vc_array.count > next else { return nil }
        SelectedIndex += 1
        return viewControllerAtIndex(next)
    }
}

extension TransactionFormDetailsVC {
    fileprivate func viewControllerAtIndex(_ index: Int) -> UIViewController? {
        if vc_array.count == 0 || index >= vc_array.count {
            return nil
        }
        return vc_array[index]
    }
    
    fileprivate func indexOfViewController(_ viewController: UIViewController) -> Int? {
        return vc_array.firstIndex(of: viewController)
    }
    
    private func getCurrentIndex() -> Int? {
        guard let current = self.pageViewController.viewControllers?.first else {return nil }
        return vc_array.firstIndex(of: current)
    }
}

