//
//  AddByPhasesVC.swift
//  Almnabr
//
//  Created by MacBook on 09/11/2021.
//  Copyright © 2021 Samar Akkila. All rights reserved.
//

import UIKit
import DPLocalization
import DropDown

class AddByPhasesVC: UIViewController , UITextFieldDelegate{

    
    @IBOutlet weak var lblZone: UILabel!
    @IBOutlet weak var lblBlocks: UILabel!
    @IBOutlet weak var lblClustre: UILabel!
    @IBOutlet weak var lblUnit: UILabel!
    @IBOutlet weak var lblWorkLevel: UILabel!
    
    
    @IBOutlet weak var viewZone: UIView!
    @IBOutlet weak var viewBlocks: UIView!
    @IBOutlet weak var viewClustre: UIView!
    @IBOutlet weak var viewUnit: UIView!
    @IBOutlet weak var viewWorkLevel: UIView!
    
    @IBOutlet weak var btnZone: UIButton!
    @IBOutlet weak var btnBlocks: UIButton!
    @IBOutlet weak var btnClustre: UIButton!
    @IBOutlet weak var btnWorkLevel: UIButton!
    @IBOutlet weak var btnUnit: UIButton!
    
    
    @IBOutlet weak var StackZone: UIStackView!
    @IBOutlet weak var StackBlocks: UIStackView!
    @IBOutlet weak var StackClustre: UIStackView!
    @IBOutlet weak var StackWorkLevel: UIStackView!
    @IBOutlet weak var StackUnit: UIStackView!
    
    
    @IBOutlet weak var imgDropZone: UIImageView!
    @IBOutlet weak var imgDropBlocks: UIImageView!
    @IBOutlet weak var imgDropClustre: UIImageView!
    @IBOutlet weak var imgDropWorkLevel: UIImageView!
    @IBOutlet weak var imgDropUnit: UIImageView!
    
    
    @IBOutlet weak var lblByPhase: UILabel!
    @IBOutlet weak var lblZoneTitle: UILabel!
    @IBOutlet weak var lblBlocksTitle: UILabel!
    @IBOutlet weak var lblClustreTitle: UILabel!
    @IBOutlet weak var lblUnitTitle: UILabel!
    @IBOutlet weak var lblWorkLevelTitle: UILabel!
    
    @IBOutlet weak var btnSubmit: UIButton!
    @IBOutlet weak var btnCancel: UIButton!
    
    var arr_zone:[ModuleObj] = []
    var arr_ZoneLabel:[String] = []
    
    var arr_Blocks:[ModuleObj] = []
    var arr_BlocksLabel:[String] = []
    
    var arr_clusters:[ModuleObj] = []
    var arr_clustersLabel:[String] = []
    
    var arr_Unit:[ModuleObj] = []
    var arr_UnitlLabel:[String] = []
    
    var arr_WorkLevels:[ModuleObj] = []
    var arr_WorkLevelsLabel:[String] = []
    
    var arr_unit:[uintObj] = []
    
    var arr_NoData:[String] = ["No items found".localized()]
    
    var ProjectObj:templateObj!
    
    
    var projects_work_area_id:String = ""
    var template_platform_code_system:String = ""
    var template_id:String = ""
    var phase_zone_block_cluster_g_nos:String = ""
    
    
    
    let dropUpmage =  UIImage.fontAwesomeIcon(name: .chevronUp , style: .solid, textColor:  .gray, size: CGSize(width: 40, height: 40))
    
    let dropDownmage =  UIImage.fontAwesomeIcon(name: .chevronDown , style: .solid, textColor:  .gray, size: CGSize(width: 40, height: 40))
    
    
    var StrZone:String = ""
    var StrBlocks:String = ""
    var StrCluster:String = ""
    var StrUnit:String = ""
    var StrWorkLevel:String = ""
    var transaction_separation:String = ""
    var StrLanguage:String = "en"
    var StrWL_label:String = ""
    
    var Phasesdelegate: ByPhasesDelegate!
    
    let maincolor = "#1A3665".getUIColor()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configGUI()
        get_Zone()
        get_WorkLevel()
    }
    
    
    
    
    //MARK: - Config GUI
    //------------------------------------------------------
    func configGUI() {
        
        
        self.btnSubmit.setTitle("Submit".localized(), for: .normal)
        self.btnSubmit.backgroundColor =  maincolor
        self.btnSubmit.setTitleColor(.white, for: .normal)
        self.btnSubmit.setRounded(10)
        
        
        self.btnCancel.setTitle("Cancel".localized(), for: .normal)
        self.btnCancel.backgroundColor =  maincolor
        self.btnCancel.setTitleColor(.white, for: .normal)
        self.btnCancel.setRounded(10)
        
        lblByPhase.textColor =  maincolor
        lblByPhase.font = .kufiBoldFont(ofSize: 15)
        lblByPhase.text = "txt_ByPhase".localized()
      
        self.lblZoneTitle.textColor =  maincolor
        self.lblZoneTitle.text =  "txt_Zone".localized()
        self.lblZoneTitle.font = .kufiRegularFont(ofSize: 15)
        
        
        self.lblBlocksTitle.textColor =  maincolor
        self.lblBlocksTitle.text =  "txt_Blocks".localized()
        self.lblBlocksTitle.font = .kufiRegularFont(ofSize: 15)
        
        
        
        self.lblClustreTitle.textColor =  maincolor
        self.lblClustreTitle.text =  "txt_Clustre".localized()
        self.lblClustreTitle.font = .kufiRegularFont(ofSize: 15)
        
        self.lblUnitTitle.textColor =  maincolor
        self.lblUnitTitle.text =  "txt_Unit".localized()
        self.lblUnitTitle.font = .kufiRegularFont(ofSize: 15)
        
        self.lblWorkLevelTitle.textColor =  maincolor
        self.lblWorkLevelTitle.text =  "txt_SearchGeneralNumbers".localized()
        self.lblWorkLevelTitle.font = .kufiRegularFont(ofSize: 15)
        
        
      
        self.viewZone.setBorderGrayWidthCorner(1, 20)
        self.viewBlocks.setBorderGrayWidthCorner(1, 20)
        self.viewUnit.setBorderGrayWidthCorner(1, 20)
        self.viewClustre.setBorderGrayWidthCorner(1, 20)
        self.viewWorkLevel.setBorderGrayWidthCorner(1, 20)
        
        
        self.StackZone.isHidden = false
        self.StackBlocks.isHidden = true
        self.StackClustre.isHidden = true
        self.StackWorkLevel.isHidden = true
        self.StackUnit.isHidden = true
        
        
        self.lblZone.text =  "txt_Zone".localized()
        self.lblZone.font = .kufiRegularFont(ofSize: 15)
        
        self.lblBlocks.text =  "txt_Blocks".localized()
        self.lblBlocks.font = .kufiRegularFont(ofSize: 15)
        
        self.lblClustre.text =  "txt_Clustre".localized()
        self.lblClustre.font = .kufiRegularFont(ofSize: 15)
        
        self.lblUnit.text =  "txt_Unit".localized()
        self.lblUnit.font = .kufiRegularFont(ofSize: 15)
        
        self.lblWorkLevel.text =  "txt_FillWorkLevels".localized()
        self.lblWorkLevel.font = .kufiRegularFont(ofSize: 15)
       
        btnZone.isHidden = true
        btnClustre.isHidden = true
        btnBlocks.isHidden = true
        btnWorkLevel.isHidden = true
        btnUnit.isHidden = true
        
        self.imgDropZone.image = dropDownmage
        self.imgDropClustre.image = dropDownmage
        self.imgDropBlocks.image = dropDownmage
        self.imgDropWorkLevel.image = dropDownmage
        self.imgDropUnit.image = dropDownmage
    
        self.btnCancel.backgroundColor = HelperClassSwift.acolor.getUIColor()
        self.btnSubmit.backgroundColor = HelperClassSwift.acolor.getUIColor()
        
    }
    
    
    func get_Zone(){
        
//        guard ProjectObj != nil else{
//            return
//        }
        
        self.showLoadingActivity()
        APIController.shard.sendRequestGetAuth(urlString: "form/FORM_WIR/search_units_by_phases_general_no?projects_work_area_id=\(self.projects_work_area_id)&platform_code_system=\(self.template_platform_code_system)&work_site=IM&transaction_separation=\(transaction_separation)&template_id=\(self.template_id)&work_site_type=Z&work_site_zones=&work_site_blocks=&work_site_clusters=&search_key=" ) { (response) in
            
            
            let status = response["status"] as? Bool
            if status == true{
                if  let list = response["records"] as? NSArray{
                    for i in list {
                        let dict = i as? [String:Any]
                        let obj = ModuleObj.init(dict!)
                        self.arr_zone.append(obj)
                        // for echitem in obj{
                        self.arr_ZoneLabel.append(obj.label)
                        // }
                        
                    }
                    self.hideLoadingActivity()
                }
            }
            self.hideLoadingActivity()
            
        }
    }
    
    
    func get_Blocks(zone:String){
        
//        guard ProjectObj != nil else{
//            return
//        }
        
        self.showLoadingActivity()
        APIController.shard.sendRequestGetAuth(urlString: "form/FORM_WIR/search_units_by_phases_general_no?projects_work_area_id=\(self.projects_work_area_id)&platform_code_system=\(self.template_platform_code_system)&work_site=IM&transaction_separation=\(transaction_separation)&template_id=\(self.template_id)&work_site_type=B&work_site_zones=\(zone)&work_site_blocks=&work_site_clusters=&search_key=" ) { (response) in
            
            
            let status = response["status"] as? Bool
            if status == true{
                if  let list = response["records"] as? NSArray{
                    for i in list {
                        let dict = i as? [String:Any]
                        let obj = ModuleObj.init(dict!)
                        self.arr_Blocks.append(obj)
                        // for echitem in obj{
                        self.arr_BlocksLabel.append(obj.label)
                        // }
                        
                    }
                    self.hideLoadingActivity()
                }
            }
            self.hideLoadingActivity()
            
        }
    }
    
    
    func get_Clusters(zone:String,Blocks:String){
        
//        guard ProjectObj != nil else{
//            return
//        }
        
        
        self.showLoadingActivity()
        APIController.shard.sendRequestGetAuth(urlString: "form/FORM_WIR/search_units_by_phases_general_no?projects_work_area_id=\(self.projects_work_area_id)&platform_code_system=\(self.template_platform_code_system)&work_site=IM&transaction_separation=\(transaction_separation)&template_id=\(self.template_id)&work_site_type=C&work_site_zones=\(zone)&work_site_blocks=\(Blocks)&work_site_clusters=&search_key=" ) { (response) in
            
            
            let status = response["status"] as? Bool
            if status == true{
                if  let list = response["records"] as? NSArray{
                    for i in list {
                        let dict = i as? [String:Any]
                        let obj = ModuleObj.init(dict!)
                        self.arr_clusters.append(obj)
                        // for echitem in obj{
                        self.arr_clustersLabel.append(obj.label)
                        // }
                        
                    }
                    self.hideLoadingActivity()
                }
            }
            self.hideLoadingActivity()
            
        }
    }
    
  
    
    

    
    
    
    func get_Unit(zone:String,Blocks:String,cluster:String){
        
        self.showLoadingActivity()
        APIController.shard.sendRequestGetAuth(urlString: "form/FORM_WIR/search_units_by_phases_general_no?projects_work_area_id=\(self.projects_work_area_id)&platform_code_system=\(self.template_platform_code_system)&work_site=IM&transaction_separation=\(transaction_separation)&template_id=\(self.template_id)&work_site_type=U&work_site_zones=\(zone)&work_site_blocks=\(Blocks)&work_site_clusters=\(cluster)&search_key="  ) { (response) in
           
            let status = response["status"] as? Bool
            if status == true{
                if  let list = response["records"] as? NSArray{
                    for i in list {
                        let dict = i as? [String:Any]
                        let obj = ModuleObj.init(dict!)
                        self.arr_Unit.append(obj)
                        // for echitem in obj{
                        self.arr_UnitlLabel.append(obj.label)
                        // }
                        
                    }
                    self.hideLoadingActivity()
                }
            }
            self.hideLoadingActivity()
            
        }
    }
    
    func get_WorkLevel(){
        
//        guard ProjectObj != nil else{
//            return
//        }
        
        self.showLoadingActivity()
        APIController.shard.sendRequestGetAuth(urlString: "form/FORM_WIR/get_work_levels_for_transaction?lang_key=en&projects_work_area_id=\(self.projects_work_area_id)&platform_code_system=\(self.template_platform_code_system)&work_site=IM&transaction_separation=\(transaction_separation)&template_id=\(self.template_id)&work_site_nos=324" ) { (response) in
            
            
            let status = response["status"] as? Bool
            if status == true{
                if  let list = response["records"] as? NSArray{
                    for i in list {
                        let dict = i as? [String:Any]
                        let obj = ModuleObj.init(dict!)
                        self.arr_WorkLevels.append(obj)
                        // for echitem in obj{
                        self.arr_WorkLevelsLabel.append(obj.label)
                        // }
                        
                    }
                    self.hideLoadingActivity()
                }
            }
            self.hideLoadingActivity()
            
        }
    }
    

    @IBAction func btnZone_Click(_ sender: Any) {
        
        self.imgDropZone.image = dropUpmage
        
        let dropDown = DropDown()
        dropDown.anchorView = view
        dropDown.backgroundColor = .white
        dropDown.cornerRadius = 2.0
        
        if self.arr_ZoneLabel.count == 0 {
            dropDown.dataSource = self.arr_NoData
            dropDown.selectionAction = { [unowned self] (index: Int, item: String) in
                self.imgDropZone.image = dropDownmage
            }
            dropDown.textColor = #colorLiteral(red: 0.8039215803, green: 0.8039215803, blue: 0.8039215803, alpha: 1)
        }else{
            dropDown.dataSource = self.arr_ZoneLabel
            dropDown.selectionAction = { [unowned self] (index: Int, item: String) in
                
                if item == self.arr_ZoneLabel[index] {
                    self.lblZone.text =  item
                    let i =  self.arr_zone[index]
                    self.imgDropZone.image = dropDownmage
                    self.viewZone.isHidden = false
                    self.btnZone.isHidden = false
                    self.StrZone = i.value
                    self.StackBlocks.isHidden = false
                    self.get_Blocks(zone: i.value)
                  
                }
                
            }

        }
        dropDown.direction = .bottom
        dropDown.anchorView = viewZone
        dropDown.bottomOffset = CGPoint(x: 0, y: viewZone.bounds.height)
        dropDown.width = viewZone.bounds.width
        dropDown.show()
    }
    
    
    @IBAction func btnBlocks_Click(_ sender: Any) {
        
        self.imgDropBlocks.image = dropUpmage
        let dropDown = DropDown()
        dropDown.anchorView = view
        dropDown.backgroundColor = .white
        dropDown.cornerRadius = 2.0
        
        if self.arr_BlocksLabel.count == 0 {
            dropDown.dataSource = self.arr_NoData
            dropDown.selectionAction = { [unowned self] (index: Int, item: String) in
                self.imgDropBlocks.image = dropDownmage
            }
            dropDown.textColor = #colorLiteral(red: 0.8039215803, green: 0.8039215803, blue: 0.8039215803, alpha: 1)
        }else{
            dropDown.dataSource = self.arr_BlocksLabel
            dropDown.selectionAction = { [unowned self] (index: Int, item: String) in
                
                if item == self.arr_BlocksLabel[index] {
                    self.lblBlocks.text =  item
                    let i =  self.arr_Blocks[index]
                    self.StrBlocks = i.value
                    self.imgDropBlocks.image = dropDownmage
                    self.btnBlocks.isHidden = false
                    
                    self.StackClustre.isHidden = false
                    self.get_Clusters(zone: StrZone, Blocks: i.value)
                   
                }
                
            }

        }
        dropDown.direction = .bottom
        dropDown.anchorView = viewBlocks
        dropDown.bottomOffset = CGPoint(x: 0, y: viewBlocks.bounds.height)
        dropDown.width = viewBlocks.bounds.width
        dropDown.show()
    }
    
    
    
    @IBAction func btnClusters_Click(_ sender: Any) {
        
        self.imgDropClustre.image = dropUpmage
        
        let dropDown = DropDown()
        dropDown.anchorView = view
        dropDown.backgroundColor = .white
        dropDown.cornerRadius = 2.0
        
        if self.arr_clustersLabel.count == 0 {
            dropDown.dataSource = self.arr_NoData
            dropDown.selectionAction = { [unowned self] (index: Int, item: String) in
                self.imgDropClustre.image = dropDownmage
            }
            dropDown.textColor = #colorLiteral(red: 0.8039215803, green: 0.8039215803, blue: 0.8039215803, alpha: 1)
        }else{
            dropDown.dataSource = self.arr_clustersLabel
            dropDown.selectionAction = { [unowned self] (index: Int, item: String) in
                
                if item == self.arr_clustersLabel[index] {
                    self.lblClustre.text =  item
                    let i =  self.arr_clusters[index]
                    self.StrCluster = i.value
                    self.imgDropClustre.image = dropDownmage
                    self.viewClustre.isHidden = false
                    self.btnClustre.isHidden = false
                    
                    self.StackUnit.isHidden = false
                    self.get_Unit(zone: StrZone, Blocks: StrBlocks, cluster: i.value)
                }
                
            }

        }
        dropDown.direction = .bottom
        dropDown.anchorView = viewClustre
        dropDown.bottomOffset = CGPoint(x: 0, y: viewClustre.bounds.height)
        dropDown.width = viewClustre.bounds.width
        dropDown.show()
    }
    
    
    @IBAction func btnUnits_Click(_ sender: Any) {
        
        self.imgDropUnit.image = dropUpmage
        let dropDown = DropDown()
        dropDown.anchorView = view
        dropDown.backgroundColor = .white
        dropDown.cornerRadius = 2.0
        
        if self.arr_UnitlLabel.count == 0 {
            dropDown.dataSource = self.arr_NoData
            dropDown.selectionAction = { [unowned self] (index: Int, item: String) in
                self.imgDropUnit.image = dropDownmage
            }
            dropDown.textColor = #colorLiteral(red: 0.8039215803, green: 0.8039215803, blue: 0.8039215803, alpha: 1)
        }else{
            dropDown.dataSource = self.arr_UnitlLabel
            dropDown.selectionAction = { [unowned self] (index: Int, item: String) in
                
                if item == self.arr_UnitlLabel[index] {
                    self.lblUnit.text =  item
                    let i =  self.arr_Unit[index]
                    self.StrUnit = i.value
                    self.imgDropUnit.image = dropDownmage
                    self.btnUnit.isHidden = false
                    
                    self.StackWorkLevel.isHidden = false
                   
                }
                
            }

        }
        dropDown.direction = .bottom
        dropDown.anchorView = viewUnit
        dropDown.bottomOffset = CGPoint(x: 0, y: viewUnit.bounds.height)
        dropDown.width = viewUnit.bounds.width
        dropDown.show()
    }
    
    
    @IBAction func btnFillWorkLevels_Click(_ sender: Any) {
        
        self.imgDropUnit.image = dropUpmage
        
        let dropDown = DropDown()
        dropDown.anchorView = view
        dropDown.backgroundColor = .white
        dropDown.cornerRadius = 2.0
        
        if self.arr_UnitlLabel.count == 0 {
            dropDown.dataSource = self.arr_NoData
            dropDown.selectionAction = { [unowned self] (index: Int, item: String) in
                self.imgDropUnit.image = dropDownmage
            }
            dropDown.textColor = #colorLiteral(red: 0.8039215803, green: 0.8039215803, blue: 0.8039215803, alpha: 1)
        }else{
            dropDown.dataSource = self.arr_WorkLevelsLabel
            dropDown.selectionAction = { [unowned self] (index: Int, item: String) in
                
                if item == self.arr_WorkLevelsLabel[index] {
                    self.lblWorkLevel.text =  item
                    let i =  self.arr_WorkLevels[index]
                    //self.StrUnit = i.value
                    self.imgDropWorkLevel.image = dropDownmage
                    self.StrWorkLevel = i.value
                    self.StrWL_label = i.label
//                    let Str_unit = uintObj(unit: StrUnit, value: i.value , label: i.label)
                    //self.arr_unit.append(Str_unit)
                    
                    self.viewWorkLevel.isHidden = false
                    self.btnWorkLevel.isHidden = false
                  
                }
                
            }

        }
        dropDown.direction = .bottom
        dropDown.anchorView = viewWorkLevel
        dropDown.bottomOffset = CGPoint(x: 0, y: viewWorkLevel.bounds.height)
        dropDown.width = viewWorkLevel.bounds.width
        dropDown.show()
    }
    
  
    
    @IBAction func btnZoneDelete_Click(_ sender: Any) {
        self.lblZone.text = "txt_zone".localized()
        self.btnZone.isHidden = true
        
        self.StackZone.isHidden = false
        self.StackBlocks.isHidden = true
        self.StackClustre.isHidden = true
        self.StackWorkLevel.isHidden = true
        self.StackUnit.isHidden = true
        
    }
    

    @IBAction func btnBlocksDelete_Click(_ sender: Any) {
        self.lblBlocks.text = "txt_Blooks".localized()
        self.btnBlocks.isHidden = true
        
        
        self.StackZone.isHidden = false
        self.StackBlocks.isHidden = false
        self.StackClustre.isHidden = true
        self.StackWorkLevel.isHidden = true
        self.StackUnit.isHidden = true
    }
    
 
    
    @IBAction func btnClustersDelete_Click(_ sender: Any) {
        self.lblClustre.text = "txt_cluster".localized()
        self.btnClustre.isHidden = true
        
        self.StackZone.isHidden = false
        self.StackBlocks.isHidden = false
        self.StackClustre.isHidden = false
        self.StackWorkLevel.isHidden = true
        self.StackUnit.isHidden = true
        
    }
    
    @IBAction func btnUnitsDelete_Click(_ sender: Any) {
        self.lblUnit.text = "txt_unit".localized()
        self.btnUnit.isHidden = true
        
        self.StackZone.isHidden = false
        self.StackBlocks.isHidden = false
        self.StackClustre.isHidden = false
        self.StackWorkLevel.isHidden = true
        self.StackUnit.isHidden = false
    }
    
    
    @IBAction func btnLevelWorkDelete_Click(_ sender: Any) {
        self.lblWorkLevel.text = "txt_FillWorkLevels".localized()
        self.btnWorkLevel.isHidden = true
        
        self.StackZone.isHidden = false
        self.StackBlocks.isHidden = false
        self.StackClustre.isHidden = false
        self.StackWorkLevel.isHidden = false
        self.StackUnit.isHidden = false
    }
    
    @IBAction func btnCancel_Click(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func btnSubmit_Click(_ sender: Any) {
        
        if (StrWorkLevel == "" ){
            self.showAMessage(withTitle: "Error", message: "missed data")
        }else{
            let obj = ByPhaseObj(number: 1, zones: StrZone, Blocks: StrBlocks, Clusters: StrCluster, units: StrUnit, Worklevels: StrWorkLevel,lblWorklevels:self.StrWL_label)
            var arr:[ByPhaseObj] = []
            arr.append(obj)
            Phasesdelegate.passByPhasesArr(data: arr)

            
            self.dismiss(animated: true, completion: nil)
        }
       
    }
}

