//
//  SiteLevelVC.swift
//  Almnabr
//
//  Created by MacBook on 05/11/2021.
//  Copyright © 2021 Samar Akkila. All rights reserved.
//

import UIKit
import DropDown


protocol GeneralDelegate {
    func pass(data: [GeneralObj],unit_arr: [uintObj])
}

protocol ByPhasesDelegate {
    func passByPhasesArr(data: [ByPhaseObj])
}


class SiteLevelVC: UIViewController , ByPhasesDelegate ,GeneralDelegate{
    
    
    func pass(data: [GeneralObj],unit_arr: [uintObj]) { //conforms to protocol
        // implement your own implementation
        self.arr_unit = self.arr_unit + unit_arr
        self.arr_General = self.arr_General + data
        self.tableByGeneral.reloadData()
    }
    
    func passByPhasesArr(data: [ByPhaseObj]) { //conforms to protocol
        // implement your own implementation
        self.arr_ByPhase = self.arr_ByPhase + data
        self.tableByPhase.reloadData()
    }
    
    
    @IBOutlet weak var lblSeparateUnits: UILabel!
    @IBOutlet weak var lblUnitsYes: UILabel!
    @IBOutlet weak var lblUnitsNo: UILabel!
    
    @IBOutlet weak var lblWorkSite: UILabel!
    @IBOutlet weak var lblAllUnits: UILabel!
    @IBOutlet weak var lblGeneralNo: UILabel!
    @IBOutlet weak var lblPhases: UILabel!
    
    @IBOutlet weak var btnUnitsYes: UIImageView!
    @IBOutlet weak var btnUnitsNo: UIImageView!
    
    @IBOutlet weak var btnAllUnits: UIImageView!
    @IBOutlet weak var btnGeneralNo: UIImageView!
    @IBOutlet weak var btnPhases: UIImageView!
    
    @IBOutlet weak var ViewBtnAllUnits: UIView!
    @IBOutlet weak var ViewBtnGN: UIView!
    @IBOutlet weak var ViewBtnByPhase: UIView!
    
    @IBOutlet weak var ViewNo: UIView!
    @IBOutlet weak var ViewYes: UIView!
    
    
    @IBOutlet weak var ViewAllUnits: UIView!
    @IBOutlet weak var ViewGeneralNo: UIView!
    @IBOutlet weak var ViewPhases: UIView!
    
    @IBOutlet weak var imgStep: UIImageView!
    @IBOutlet weak var viewStep: UIView!
    @IBOutlet weak var lblStep: UILabel!
    
    
    @IBOutlet weak var tableByPhase: UITableView!
    @IBOutlet weak var tableByGeneral: UITableView!
    
    @IBOutlet weak var lblWorkLevel: UILabel!
    @IBOutlet weak var lblSelectWorkLevel: UILabel!
    @IBOutlet weak var viewsWorkLevel: UIView!
    
    @IBOutlet weak var btnWorkLevel: UIButton!
    
    @IBOutlet weak var imgDropWorkLevel: UIImageView!
    
    @IBOutlet weak var ViewAllUnitsSelect: UIView!
    
    @IBOutlet weak var btnNext: UIButton!
    @IBOutlet weak var btnPrevious: UIButton!
    
    @IBOutlet weak var lbl_workLevel: UILabel!
    @IBOutlet weak var lbl_units: UILabel!
    
    let checked =  UIImage.fontAwesomeIcon(name: .checkCircle, style: .solid, textColor: HelperClassSwift.bcolor.getUIColor(), size: CGSize(width: 40, height: 40))
    
    let Unchecked =  UIImage.fontAwesomeIcon(name: .circle, style: .solid, textColor: HelperClassSwift.bcolor.getUIColor(), size: CGSize(width: 40, height: 40))
    
    let dropUpmage =  UIImage.fontAwesomeIcon(name: .chevronUp , style: .solid, textColor:  .gray, size: CGSize(width: 40, height: 40))
    
    let dropDownmage =  UIImage.fontAwesomeIcon(name: .chevronDown , style: .solid, textColor:  .gray, size: CGSize(width: 40, height: 40))
    
    
    
    var arr_Work:[ModuleObj] = []
    var arr_workLevelLabel:[String] = []
    var arr_NoData:[String] = ["No items found".localized()]
    
    var arr_General:[GeneralObj] = []
    var arr_ByPhase:[ByPhaseObj] = []
    var arr_unit:[uintObj] = []
    
    var form_wir_data:templateObj?
    
    var transaction_id:String = "0"
    
    var StrWorkLevel:String = ""
    var level_Unit = ""
    var units :String = ""
    var StrLanguage:String = "en"
    var work_site:String = "ALL"
    var transaction_separation :String = "0"
    var GeneralTable:Bool = true
    var ProjectObj:templateObj!
    
    var FormWirObj:form_wir_dataObj?
    
    var wirObject:[String:Any] = [:]
    
    var params = [:] as [String : String]
    
    var projects_work_area_id:String = ""
    var template_platform_code_system:String = ""
    var template_id:String = ""
    var phase_zone_block_cluster_g_nos:String = ""
    var template_platform_group_type_code_system:String = ""
    
    var isGeneral:Bool = false
    var isAllUnits:Bool = true
    var isByPhases:Bool = false
    
    var IsFromTransaction:Bool = false
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configGUI()
        setupTable()
        get_WorkLevel()
        
        if IsFromTransaction  {
            
            self.SetConfigGUI()
            //            self.transaction_id = obj_transaction?.transaction_request_id ?? "0"
            //            self.projects_work_area_id = obj_FormWir?.projects_work_area_id ?? "0"
            //            self.template_platform_code_system = FormWirObject?.platform_code_system ?? "0"
            //            self.template_id = FormWirObject?.template_id ?? "0"
            //            self.template_platform_group_type_code_system = FormWirObject?.template_platform_group_type_code_system ?? "WIR"
        }else{
            
            self.transaction_id = "0"
            self.projects_work_area_id = ProjectObj.projects_work_area_id
            self.template_platform_code_system = ProjectObj.template_platform_code_system
            self.template_id = ProjectObj.template_id
            self.phase_zone_block_cluster_g_nos =  ProjectObj.phase_zone_block_cluster_g_nos
            self.template_platform_group_type_code_system = ProjectObj.template_platform_group_type_code_system
        }
        
        
        
        // print(obj_transaction?.transaction_request_id)
    }
    
    //    func config_wir_obj(){
    //
    //            let form_wir_data_status = wirObject["status"] as? Bool
    //            if form_wir_data_status == true{
    //                let records = wirObject["records"] as! NSArray
    //
    //                let recordsObj = form_wir_dataObj(records.firstObject as! [String : Any])
    //                self.FormWirObj = recordsObj
    //
    //
    //            }
    ////        }
    //    }
    
    
    
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
        
        self.arr_unit = []
        self.lbl_workLevel.text = "Work Level".localized()
        self.lbl_units.text = "Units".localized()
        
        self.lbl_units.font = .kufiRegularFont(ofSize: 13)
        //self.lbl_units.textColor =  HelperClassSwift.bcolor.getUIColor()
        
        self.lbl_workLevel.font = .kufiRegularFont(ofSize: 13)
        // self.lbl_workLevel.textColor =  HelperClassSwift.bcolor.getUIColor()
        
        // lblSeparateUnits.textColor =  HelperClassSwift.bcolor.getUIColor()
        lblSeparateUnits.font = .kufiRegularFont(ofSize: 13)
        lblSeparateUnits.text = "txt_SeparateUnits".localized()
        
        
        
        // lblUnitsYes.textColor =  HelperClassSwift.bcolor.getUIColor()
        lblUnitsYes.font = .kufiRegularFont(ofSize: 13)
        lblUnitsYes.text = "txt_Yes".localized()
        
        // lblUnitsNo.textColor =  HelperClassSwift.bcolor.getUIColor()
        lblUnitsNo.font = .kufiRegularFont(ofSize: 13)
        lblUnitsNo.text = "txt_No".localized()
        
        
        // lblWorkSite.textColor =  HelperClassSwift.bcolor.getUIColor()
        lblWorkSite.font = .kufiRegularFont(ofSize: 13)
        lblWorkSite.text = "txt_WorkSite".localized()
        
        
        //lblAllUnits.textColor =  HelperClassSwift.bcolor.getUIColor()
        lblAllUnits.font = .kufiRegularFont(ofSize: 11)
        lblAllUnits.text = "txt_AllUnits".localized()
        
        // lblGeneralNo.textColor =  HelperClassSwift.bcolor.getUIColor()
        lblGeneralNo.font = .kufiRegularFont(ofSize: 9)
        lblGeneralNo.text = "txt_GeneralNo".localized()
        
        // lblPhases.textColor =  HelperClassSwift.bcolor.getUIColor()
        lblPhases.font = .kufiRegularFont(ofSize: 11)
        lblPhases.text = "txt_Phases".localized()
        
        let maincolor = "#458FB8".getUIColor()
        
        //self.viewsWorkLevel.setBorderGray()
        self.viewsWorkLevel.setBorderGrayWidthCorner(1, 20)
        ViewNo.setBorderColorWidthCorner(1, 15, color: maincolor)
        ViewYes.setBorderColorWidthCorner(1, 15, color: maincolor)
        ViewBtnAllUnits.setBorderColorWidthCorner(1, 15, color: maincolor)
        ViewBtnGN.setBorderColorWidthCorner(1, 15, color: maincolor)
        ViewBtnByPhase.setBorderColorWidthCorner(1, 15, color: maincolor)
        
        // lblWorkLevel.textColor = HelperClassSwift.bcolor.getUIColor()
        lblWorkLevel.font = .kufiRegularFont(ofSize: 13)
        lblWorkLevel.text = "txt_FillWorkLevel".localized()
        
        self.btnWorkLevel.isHidden = true
        //  lblSelectWorkLevel.textColor = .gray
        lblSelectWorkLevel.font = .kufiRegularFont(ofSize: 13)
        lblSelectWorkLevel.text = "txt_FillWorkLevel".localized()
        
        self.btnPhases.image = UIImage(named: "uncheck")
        self.btnGeneralNo.image = UIImage(named: "uncheck")
        self.btnAllUnits.image = UIImage(named: "check")
        self.btnUnitsNo.image = UIImage(named: "check")
        self.btnUnitsYes.image = UIImage(named: "uncheck")
        
        self.ViewBtnAllUnits.isHidden = false
        
        self.viewStep.backgroundColor = HelperClassSwift.acolor.getUIColor()
        self.lblStep.text = "txt_SiteLevel".localized()
        self.lblStep.font = .kufiRegularFont(ofSize: 15)
        self.lblStep.textColor = "#616263".getUIColor()
        //HelperClassSwift.acolor.getUIColor()
        
        
        self.viewStep.setBorderGrayWidth(3)
        let Stepimage =  UIImage.fontAwesomeIcon(name: .building, style: .solid, textColor: HelperClassSwift.bcolor.getUIColor(), size: CGSize(width: 40, height: 40))
        self.imgStep.image = Stepimage
        
        
        self.btnNext.setTitle("Next".localized(), for: .normal)
        //        self.btnNext.backgroundColor =  HelperClassSwift.acolor.getUIColor()
        //        self.btnNext.setTitleColor(.white, for: .normal)
        //        self.btnNext.setRounded(10)
        
        
        self.btnPrevious.setTitle("Previous".localized(), for: .normal)
        //        self.btnPrevious.backgroundColor =  HelperClassSwift.acolor.getUIColor()
        //        self.btnPrevious.setTitleColor(.white, for: .normal)
        //        self.btnPrevious.setRounded(10)
        
        
        if L102Language.currentAppleLanguage() == "ar" {
            self.btnNext.setImage(UIImage(systemName: "arrow.left"), for: .normal)
            self.btnPrevious.setImage(UIImage(systemName: "arrow.right"), for: .normal)
        }
        
    }
    
    
    
    func setupTable(){
        
        self.tableByPhase.dataSource = self
        self.tableByPhase.delegate = self
        
        self.tableByGeneral.dataSource = self
        self.tableByGeneral.delegate = self
        
        let nib = UINib(nibName: "ByPhaseTVCell", bundle: nil)
        tableByPhase.register(nib, forCellReuseIdentifier: "ByPhaseTVCell")
        
        let nib2 = UINib(nibName: "GeneralNoCell", bundle: nil)
        tableByGeneral.register(nib2, forCellReuseIdentifier: "GeneralNoCell")
        
        self.tableByPhase.reloadData()
        self.tableByGeneral.reloadData()
    }
    
    
    func get_WorkLevel(){
        //        guard ProjectObj != nil else{
        //            return
        //        }
        
        // self.showLoadingActivity()
        APIController.shard.sendRequestGetAuth(urlString: "form/FORM_\(self.template_platform_group_type_code_system)/get_work_levels_for_transaction?projects_work_area_id=\( self.projects_work_area_id)&platform_code_system=\( self.template_platform_code_system)&transaction_separation=0&template_id=\(self.template_id)&lang_key=en&work_site=ALL" ) { (response) in
            
            
            let status = response["status"] as? Bool
            if status == true{
                if  let list = response["records"] as? NSArray{
                    for i in list {
                        let dict = i as? [String:Any]
                        let obj = ModuleObj.init(dict!)
                        self.arr_Work.append(obj)
                        // for echitem in obj{
                        self.level_Unit = obj.value
                        self.arr_workLevelLabel.append(obj.label)
                        // }
                        
                    }
                    self.hideLoadingActivity()
                }
            }else{
                self.hideLoadingActivity()
            }
            
            
        }
    }
    
    
    
    func validate_work_levels(value:String){
        
        self.showLoadingActivity()
        APIController.shard.sendRequestGetAuth(urlString: "form/FORM_\(self.template_platform_group_type_code_system)/validate_work_levels?projects_work_area_id=\( self.projects_work_area_id)&platform_code_system=\( self.template_platform_code_system)&work_site=ALL&transaction_separation=0&work_site_type=ALL&template_id=1&work_levels=\(value)" ) { (response) in
            
            
            let status = response["status"] as? Bool
            if status == true{
                if  let data = response["data"] as? [String:Any]{
                    if let unit = data["level_all_building"] as? String {
                        
                        self.units = unit
                    }
                    
                }
                self.hideLoadingActivity()
            }
        }
        
        
    }
    
    
    func Configuration_step1(){
        
        self.showLoadingActivity()
        
        self.setup_param()
        //        guard ProjectObj != nil else{
        //            return
        //        }
        
        
        self.params["projects_work_area_id"] =  self.projects_work_area_id
        self.params["platform_code_system"] = self.template_platform_code_system
        self.params["template_id"] = self.template_id
        self.params["lang_key"] = StrLanguage
        self.params["transaction_separation"] = transaction_separation
        self.params["page_no"] = "1"
        self.params["page_size"] = "10"
        self.params["work_site"] = self.work_site
        
        
        if arr_unit.count == 0 {
            self.params["units_and_level[\(self.level_Unit)]"] = String(self.units.dropLast())
            
        }else{
            
            var unit_str :String = ""
            var value_str :String = ""
            
            for i in arr_unit {
                
                if value_str == i.value! {
                    unit_str = unit_str + i.unit! + ","
                    self.params["units_and_level[\(i.value ?? "level_all_building")]"] = i.unit
                    value_str = i.value!
                }else{
                    self.params["units_and_level[\(i.value ?? "level_all_building")]"] = i.unit
                    value_str = i.value!
                }
                
            }
            
        }
        
        
        
        APIController.shard.sendRequestPostAuth(urlString: "form/FORM_\(self.template_platform_group_type_code_system)/cr/1/\(transaction_id)", parameters: params ) { (response) in
            self.hideLoadingActivity()
            
            
            let status = response["status"] as? Bool
            let error = response["error"] as? String
            let SkipPage = response["SkipPage"] as? Bool
            
            if status == true{
                
                
                if SkipPage == true{
                    self.next(SkipPage: true)
                    
                }else{
                    self.next(SkipPage: false)
                }
            }else{
                self.showAMessage(withTitle: "Error", message: error ?? "Some thing went wrong")
                
            }
            
            
            
        }
        
        
    }
    
    
    func SetConfigGUI(){
        
        if  let view_request = data_FormWir["view_request"] as? [String:Any]{
            
            if  let transaction_request = view_request["transactions_request"] as? [String:Any]{
                
                let records = transaction_request["records"] as! [String:Any]
                let obj = Tcore(records)
                
                self.StrLanguage = obj.lang_key
                self.transaction_id = obj.transaction_request_id
                //                self.template_platform_code_system =  obj.transactions_name
                //                self.template_id = obj.transaction_from
                self.transaction_separation = "0"
                self.work_site = "GN"
                
                self.btnPhases.image = UIImage(named: "uncheck")
                self.btnGeneralNo.image = UIImage(named: "check")
                self.btnAllUnits.image = UIImage(named: "uncheck")
                
                self.ViewAllUnits.isHidden = true
                self.ViewPhases.isHidden = true
                self.ViewGeneralNo.isHidden = false
                
                GeneralTable = true
                
                isAllUnits = false
                isGeneral = true
                isByPhases = false
                
            }
            
            if  let form_wir_data = view_request["form_wir_data"] as? [String:Any]{
                var arr_wir :[templateObj] = []
                if  let records = form_wir_data["records"] as? NSArray{
                    for i in records {
                        let dict = i as? [String:Any]
                        let obj =  templateObj.init(dict!)
                        arr_wir.append(obj)
                    }
                    
                    let obj = arr_wir[0]
                    self.form_wir_data = obj
                    
                    //                self.StrLanguage = obj.lang_key
                    self.template_platform_group_type_code_system = obj.platform_group_type_code_system
                    self.projects_work_area_id = obj.projects_work_area_id
                    self.template_platform_code_system =  obj.platform_code_system
                    self.template_id = obj.template_id
                    //                self.transaction_separation = "0"
                    //                self.work_site = "GN"
                }
            }
            var arr:[ByPhaseObj] = []
            if  let unit_level = view_request["project_supervision_form_unit_level"] as? [String:Any]{
                
                if  let records = unit_level["records"] as? NSArray{
                    for i in records {
                        let dict = i as? [String:Any]
                        let obj =  unitLevelObj.init(dict!)
                        let item = GeneralObj(number: 1, units: obj.unit_id, Worklevels: obj.work_level_key, label: obj.work_level_label)
                        //                        let item = ByPhaseObj(number: 1, zones: obj.Z, Blocks: obj.B, Clusters: obj.C, units: obj.unit_custom_title, Worklevels: obj.work_level_key,lblWorklevels: obj.work_level_label)
                        //                        arr.append(item)
                        self.arr_General.append(item)
                        
                    }
                    self.tableByGeneral.reloadData()
                    //                    self.tableByGeneral.reloadData()
                }
                
            }
        }
    }
    
    
    func setup_param(){
        if isGeneral == true {
            self.units = ""
            for i in arr_General {
                arr_unit.append(uintObj(unit: i.units, value: i.Worklevels))
                self.units = self.units + i.units! + ","
                
            }
        }else if isByPhases == true{
            self.units = ""
            for i in arr_ByPhase {
                
                units = units + i.units! + ","
                
            }
        }
    }
    
    
    func next(SkipPage:Bool){
        
        
        let VC:FormVersionVC = AppDelegate.mainSB.instanceVC()
        VC.Skipnext = SkipPage
        
        if isGeneral == true {
            self.units = ""
            for i in arr_General {
                arr_unit.append(uintObj(unit: i.units, value: i.Worklevels))
                self.units = self.units + i.units! + ","
            }
            if arr_General.count == 1 {
                VC.IsOneChar = true
            }
            VC.units_and_level = units
        }else if isAllUnits == true {
            VC.units_and_level = self.units
            //ProjectObj.phase_zone_block_cluster_g_nos
        }else if isByPhases == true{
            self.units = ""
            for i in arr_ByPhase {
                units = units + i.units! + ","
            }
            if arr_ByPhase.count == 1 {
                VC.IsOneChar = true
            }
            VC.units_and_level = units
        }
        
        VC.IsFromTransaction = self.IsFromTransaction
        VC.arr_unit = arr_unit
        VC.ProjectObj = self.ProjectObj
        VC.StrLanguage = self.StrLanguage
        VC.transaction_separation = transaction_separation
        VC.work_site = self.work_site
        VC.units = self.units
        VC.level_Unit = self.level_Unit
        VC.params = self.params
        VC.transaction_id = self.transaction_id
        VC.template_id = self.template_id
        VC.projects_work_area_id = self.projects_work_area_id
        VC.template_platform_code_system = self.template_platform_code_system
        VC.template_platform_group_type_code_system = self.template_platform_group_type_code_system
        VC.form_wir_data = self.form_wir_data
     
        self.navigationController?.pushViewController(VC, animated: true)
        
    }
    
    @IBAction func btnWorkLevel_Click(_ sender: Any) {
        
        self.imgDropWorkLevel.image = dropUpmage
        let dropDown = DropDown()
        dropDown.anchorView = view
        dropDown.backgroundColor = .white
        dropDown.cornerRadius = 2.0
        
        if self.arr_workLevelLabel.count == 0 {
            dropDown.dataSource = self.arr_NoData
            dropDown.selectionAction = { [unowned self] (index: Int, item: String) in
                self.imgDropWorkLevel.image = dropDownmage
            }
            dropDown.textColor = #colorLiteral(red: 0.8039215803, green: 0.8039215803, blue: 0.8039215803, alpha: 1)
        }else{
            dropDown.dataSource = self.arr_workLevelLabel
            dropDown.selectionAction = { [unowned self] (index: Int, item: String) in
                
                if item == self.arr_workLevelLabel[index] {
                    self.lblSelectWorkLevel.text =  item
                    let i =  self.arr_Work[index]
                    self.StrWorkLevel = i.value
                    self.validate_work_levels(value: i.value)
                    // self.units = i.value
                    // self.units = ProjectObj.phase_zone_block_cluster_g_nos
                    self.imgDropWorkLevel.image = dropDownmage
                    self.btnWorkLevel.isHidden = false
                    
                }
                
            }
            
        }
        dropDown.direction = .bottom
        dropDown.anchorView = viewsWorkLevel
        dropDown.bottomOffset = CGPoint(x: 0, y: viewsWorkLevel.bounds.height)
        dropDown.width = viewsWorkLevel.bounds.width
        dropDown.show()
        
    }
    
    
    
    @IBAction func btnWorkLevelDelete_Click(_ sender: Any) {
        self.lblSelectWorkLevel.text = "txt_FillWorkLevel".localized()
        self.btnWorkLevel.isHidden = true
    }
    
    
    
    
    @IBAction func btnNext_Click(_ sender: Any) {
        
        self.Configuration_step1()
        
    }
    
    @IBAction func btnBack_Click(_ sender: Any) {
        
        self.navigationController?.popViewController(animated: true)
    }
    
    
    @IBAction func btnGeneralNo_Click(_ sender: Any) {
        
        
        GeneralTable = true
        
        isAllUnits = false
        isGeneral = true
        isByPhases = false
        
        self.btnPhases.image = UIImage(named: "uncheck")
        self.btnGeneralNo.image = UIImage(named: "check")
        self.btnAllUnits.image = UIImage(named: "uncheck")
        
        self.ViewAllUnits.isHidden = true
        self.ViewPhases.isHidden = true
        self.ViewGeneralNo.isHidden = false
        
        self.work_site = "GN"
        
        
        
    }
    
    
    
    
    @IBAction func btnPhases_Click(_ sender: Any) {
        
        GeneralTable = false
        
        isAllUnits = false
        isGeneral = false
        isByPhases = true
        
        self.btnPhases.image = UIImage(named: "check")
        self.btnGeneralNo.image = UIImage(named: "uncheck")
        self.btnAllUnits.image = UIImage(named: "uncheck")
        
        self.ViewAllUnits.isHidden = true
        self.ViewPhases.isHidden = false
        self.ViewGeneralNo.isHidden = true
        
        self.work_site = "IM"
        self.tableByPhase.reloadData()
        //IM
        
    }
    
    
    @IBAction func btnUnits_Click(_ sender: Any) {
        
        
        isAllUnits = true
        isGeneral = false
        isByPhases = false
        
        self.btnPhases.image = UIImage(named: "uncheck")
        self.btnGeneralNo.image = UIImage(named: "uncheck")
        self.btnAllUnits.image = UIImage(named: "check")
        
        
        self.ViewAllUnits.isHidden = false
        self.ViewPhases.isHidden = true
        self.ViewGeneralNo.isHidden = true
        
        self.work_site = "ALL"
        
    }
    
    @IBAction func btnUnitslNo_Click(_ sender: Any) {
        
        self.transaction_separation = "0"
        
        self.ViewAllUnits.isHidden = false
        self.ViewBtnAllUnits.isHidden = false
        
        self.btnUnitsNo.image = UIImage(named: "check")
        self.btnUnitsYes.image = UIImage(named: "uncheck")
        self.ViewAllUnitsSelect.isHidden = false
    }
    
    @IBAction func btnUnitsYes_Click(_ sender: Any) {
        
        self.transaction_separation = "1"
        self.ViewAllUnits.isHidden = true
        self.ViewBtnAllUnits.isHidden = true
        
        self.btnUnitsNo.image = UIImage(named: "uncheck")
        self.btnUnitsYes.image = UIImage(named: "check")
        self.ViewAllUnitsSelect.isHidden = true
        
    }
    
    
    @IBAction func btnAddGeneral_Click(_ sender: Any) {
        
        let vc:AddGeneralNoVC  = AppDelegate.mainSB.instanceVC()
        
        vc.isModalInPresentation = true
        vc.modalPresentationStyle = .overFullScreen
        vc.definesPresentationContext = true
        vc.delegate = self
        vc.ProjectObj = self.ProjectObj
        vc.StrLanguage = self.StrLanguage
        vc.transaction_separation = transaction_separation
        vc.arr_unit = self.arr_unit
        vc.template_id = self.template_id
        vc.projects_work_area_id = self.projects_work_area_id
        vc.template_platform_code_system = self.template_platform_code_system
        
        self.present(vc, animated: true, completion: nil)
    }
    
    @IBAction func btnAddPhases_Click(_ sender: Any) {
        
        let vc:AddByPhasesVC  = AppDelegate.mainSB.instanceVC()
        
        vc.isModalInPresentation = true
        vc.modalPresentationStyle = .overFullScreen
        vc.definesPresentationContext = true
        vc.Phasesdelegate = self
        vc.ProjectObj = self.ProjectObj
        vc.StrLanguage = self.StrLanguage
        vc.transaction_separation = transaction_separation
        vc.template_id = self.template_id
        vc.projects_work_area_id = self.projects_work_area_id
        vc.template_platform_code_system = self.template_platform_code_system
        
        self.present(vc, animated: true, completion: nil)
    }
    
    
}



extension SiteLevelVC: UITableViewDelegate , UITableViewDataSource{
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        if GeneralTable == true{
            return arr_General.count
        }else{
            return arr_ByPhase.count
        }
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if GeneralTable == true{
            
            
            let cell = tableByGeneral.dequeueReusableCell(withIdentifier: "GeneralNoCell", for: indexPath) as! GeneralNoCell
            
            let obj = arr_General[indexPath.item]
            
            
            cell.lblNo.text = "\(indexPath.item + 1)"
            cell.lblUnit.text = obj.units!
            cell.lblWorklevels.text = obj.label!
            cell.lblNo.font = .kufiRegularFont(ofSize: 17)
            cell.lblUnit.font = .kufiRegularFont(ofSize: 17)
            cell.lblWorklevels.font = .kufiRegularFont(ofSize: 17)
            
            
            cell.btnDeleteAction = {
                
                self.arr_General.remove(at: indexPath.item)
                self.tableByGeneral.reloadData()
                
            }
            
            return cell
            
        }else{
            
            let cell = tableByPhase.dequeueReusableCell(withIdentifier: "ByPhaseTVCell", for: indexPath) as! ByPhaseTVCell
            
            let obj = arr_ByPhase[indexPath.item]
            
            //            let Number = "#" + "  \(obj.number ?? 0)"
            let zones = "\(obj.zones!)"
            let Blocks = "\(obj.Blocks!)"
            let Clusters =  "\(obj.Clusters!)"
            let Units = "\(obj.units!)"
            let WorkLevel =  "\(obj.lblWorklevels!)"
            
            cell.lblzones.text = zones
            cell.lblBlocks.text = Blocks
            cell.lblClusters.text = Clusters
            cell.lblWorklevels.text = WorkLevel
            cell.lblUnits.text = Units
            
            cell.btnDeleteAction = {
                self.arr_ByPhase.remove(at: indexPath.item)
                self.tableByPhase.reloadData()
                
            }
            
            return cell
            
        }
        
    }
    
    
}


