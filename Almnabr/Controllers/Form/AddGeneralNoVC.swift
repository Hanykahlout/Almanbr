//
//  AddGeneralNoVC.swift
//  Almnabr
//
//  Created by MacBook on 09/11/2021.
//  Copyright © 2021 Samar Akkila. All rights reserved.
//

import UIKit
import DPLocalization
import DropDown

struct uintObj{
    var unit:String?
    var value:String?
    var label:String?
    
}
class AddGeneralNoVC: UIViewController , UITextFieldDelegate{
    
    @IBOutlet weak var tfUnit: UITextField!
    @IBOutlet weak var lblWorkLevel: UILabel!
    
    @IBOutlet weak var viewUnit: UIView!
    @IBOutlet weak var viewWorkLevel: UIView!
    
    @IBOutlet weak var btnWorkLevel: UIButton!
    @IBOutlet weak var btnUnit: UIButton!
    
    @IBOutlet weak var imgDropWorkLevel: UIImageView!
    @IBOutlet weak var imgDropUnit: UIImageView!
    
    
    @IBOutlet weak var lblGeneralnumber: UILabel!
    @IBOutlet weak var lblSearchGeneralNumbers: UILabel!
    @IBOutlet weak var lblFillWorkLevels: UILabel!
    
    @IBOutlet weak var stkFillWorkLevels: UIStackView!
    
    @IBOutlet weak var btnSubmit: UIButton!
    @IBOutlet weak var btnCancel: UIButton!
    
    let maincolor = "#1A3665".getUIColor()
    
    var delegate: GeneralDelegate!
    let dropDown = DropDown()
    
    var arr_Unit:[ModuleObj] = []
    var arr_UnitlLabel:[String] = []
    
    var arr_unit:[uintObj] = []
    
    var arr_WorkLevels:[ModuleObj] = []
    var arr_WorkLevelsLabel:[String] = []
    
    var arr_NoData:[String] = ["No items found".localized()]
    
    let dropUpmage =  UIImage.fontAwesomeIcon(name: .chevronUp , style: .solid, textColor:  .gray, size: CGSize(width: 40, height: 40))
    
    let dropDownmage =  UIImage.fontAwesomeIcon(name: .chevronDown , style: .solid, textColor:  .gray, size: CGSize(width: 40, height: 40))
    
    var StrUnit:String = ""
    var StrWorkLevel:String = ""
    var StrWL_label:String = ""
    var ProjectObj:templateObj!
    var transaction_separation:String = ""
    
    var StrLanguage:String = "en"
    
    var projects_work_area_id:String = ""
    var template_platform_code_system:String = ""
    var template_id:String = ""
    var phase_zone_block_cluster_g_nos:String = ""
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configGUI()
        get_WorkLevel()
    }
    
    
    
    
    //MARK: - Config GUI
    //------------------------------------------------------
    func configGUI() {
        
        
        lblGeneralnumber.textColor =  maincolor
        lblGeneralnumber.font = .kufiBoldFont(ofSize: 15)
        lblGeneralnumber.text = "txt_Generalnumber".localized()
        
        self.lblSearchGeneralNumbers.text =  "txt_SearchGeneralNumbers".localized()
        self.lblSearchGeneralNumbers.font = .kufiRegularFont(ofSize: 15)
        
        self.lblFillWorkLevels.text =  "txt_FillWorkLevels".localized()
        self.lblFillWorkLevels.font = .kufiRegularFont(ofSize: 15)
        
        
        self.viewUnit.setBorderGrayWidthCorner(1, 20)
        self.tfUnit.placeholder =  "txt_SearchGeneralNumbers".localized()
        self.tfUnit.font = .kufiRegularFont(ofSize: 15)
        
        self.tfUnit.delegate = self
        
        self.viewWorkLevel.setBorderGrayWidthCorner(1, 20)
        self.lblWorkLevel.text =  "txt_FillWorkLevels".localized()
        self.lblWorkLevel.font = .kufiRegularFont(ofSize: 15)
        
        btnUnit.isHidden = true
        btnWorkLevel.isHidden = true
        
        self.imgDropUnit.image = dropDownmage
        self.imgDropWorkLevel.image = dropDownmage
        
        self.btnSubmit.setTitle("Submit".localized(), for: .normal)
        self.btnSubmit.backgroundColor =  maincolor
        self.btnSubmit.setTitleColor(.white, for: .normal)
        self.btnSubmit.setRounded(10)
        
        
        self.btnCancel.setTitle("Cancel".localized(), for: .normal)
        self.btnCancel.backgroundColor =  maincolor
        self.btnCancel.setTitleColor(.white, for: .normal)
        self.btnCancel.setRounded(10)
        
    }
    
    
    
    
    func get_WorkLevel(){
        
//        guard ProjectObj != nil else{
//            return
//        }
        //let language = MOLH.currentAppleLanguage()
       let lang =  L102Language.currentAppleLanguage()
        self.showLoadingActivity()
        APIController.shard.sendRequestGetAuth(urlString: "form/FORM_WIR/get_work_levels_for_transaction?lang_key=\(lang)&projects_work_area_id=\(self.projects_work_area_id)&platform_code_system=\(self.template_platform_code_system)&work_site=GN&transaction_separation=\(transaction_separation)&template_id=\(self.template_id)&work_site_nos=1" ) { (response) in
            
            
            let status = response["status"] as? Bool
            if status == true{
                self.arr_WorkLevels = []
                self.arr_WorkLevelsLabel = []
                
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
    
    
    
    
    func get_Unit(searchTxt:String){
        
//        guard ProjectObj != nil else{
//            return
//        }
        self.showLoadingActivity()
        APIController.shard.sendRequestGetAuth(urlString: "form/FORM_WIR/search_units_by_phases_general_no?projects_work_area_id=\(self.projects_work_area_id)&platform_code_system=\(self.template_platform_code_system)&work_site=GN&transaction_separation=\(transaction_separation)&template_id=\(self.template_id)&work_site_type=G&work_site_zones=&work_site_blocks=&work_site_clusters=&search_key=\(searchTxt)" ) { (response) in
            
            
            let status = response["status"] as? Bool
            if status == true{
                self.arr_Unit = []
                self.arr_UnitlLabel = []
                if  let list = response["records"] as? NSArray{
                    for i in list {
                        let dict = i as? [String:Any]
                        let obj = ModuleObj.init(dict!)
                        self.arr_Unit.append(obj)
                        // for echitem in obj{
                        self.arr_UnitlLabel.append(obj.label)
                        self.stkFillWorkLevels.isHidden = false
                        // }
                        
                    }
                    self.hideLoadingActivity()
                }
            }
            self.btnUnit_Click()
            self.hideLoadingActivity()
            
        }
    }
    
    
   func btnUnit_Click() {
        
        self.imgDropUnit.image = dropUpmage
        
        
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
                    self.tfUnit.text =  item
                    let i =  self.arr_Unit[index]
                    self.StrUnit = i.value
                    self.imgDropUnit.image = dropDownmage
                    self.viewWorkLevel.isHidden = false
                    self.btnUnit.isHidden = false
                    
                }
                
            }
            
        }
        dropDown.direction = .bottom
        dropDown.anchorView = viewUnit
        dropDown.bottomOffset = CGPoint(x: 0, y: viewUnit.bounds.height)
        dropDown.width = viewUnit.bounds.width
        dropDown.show()
    }
    
    
    
    @IBAction func btnLevelWorkAction_Click(_ sender: Any) {
        btnUnit_Click()
        
    }
    @IBAction func btnLevelWork_Click(_ sender: Any) {
        
        self.imgDropWorkLevel.image = dropUpmage
        let dropDown = DropDown()
        dropDown.anchorView = view
        dropDown.backgroundColor = .white
        dropDown.cornerRadius = 2.0
        
        if self.arr_WorkLevelsLabel.count == 0 {
            dropDown.dataSource = self.arr_NoData
            dropDown.selectionAction = { [unowned self] (index: Int, item: String) in
                self.imgDropWorkLevel.image = dropDownmage
            }
            dropDown.textColor = #colorLiteral(red: 0.8039215803, green: 0.8039215803, blue: 0.8039215803, alpha: 1)
        }else{
            dropDown.dataSource = self.arr_WorkLevelsLabel
            dropDown.selectionAction = { [unowned self] (index: Int, item: String) in
                
                if item == self.arr_WorkLevelsLabel[index] {
                    self.lblWorkLevel.text =  item
                    let i =  self.arr_WorkLevels[index]
                    self.StrWorkLevel = i.value
                    self.StrWL_label = i.label
                    let Str_unit = uintObj(unit: StrUnit, value: i.value , label: i.label)
                    self.arr_unit.append(Str_unit)
                    self.imgDropUnit.image = dropDownmage
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
    
    
    
    @IBAction func btnUnitDelete_Click(_ sender: Any) {
        self.tfUnit.placeholder = "txt_SearchGeneralNo".localized()
        self.btnUnit.isHidden = true
    }
    
    @IBAction func btnLevelWorkDelete_Click(_ sender: Any) {
        self.lblWorkLevel.text = "txt_FillWorkLevels".localized()
        
        self.btnWorkLevel.isHidden = true
    }
    
    @IBAction func btnCancel_Click(_ sender: Any) {
        self.dropDown.removeFromSuperview()
        self.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func btnSubmit_Click(_ sender: Any) {
        self.dropDown.removeFromSuperview()
       
        if (StrUnit == "" || StrWorkLevel == "" ){
            self.showAMessage(withTitle: "Error", message: "missed data")
        }else{
            let obj = GeneralObj(number: 1, units: StrUnit, Worklevels: StrWorkLevel,label:self.StrWL_label)
            var arr:[GeneralObj] = []
            arr.append(obj)
            delegate.pass(data: arr, unit_arr: arr_unit)
            self.hideLoadingActivity()
            self.dismiss(animated: true, completion: nil)
        }
      
    }
    
}


extension AddGeneralNoVC : UITextViewDelegate{
    
    
    func textFieldShouldBeginEditing(_ textField: UITextField) -> Bool {
        if textField == tfUnit {
            
            self.viewUnit.layer.borderColor = #colorLiteral(red: 0.1764705926, green: 0.4980392158, blue: 0.7568627596, alpha: 1)
            self.viewUnit.layer.borderWidth = 1
            self.viewUnit.layer.cornerRadius = 20
            self.viewUnit.layer.masksToBounds = true
            
        }
        return true
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        if textField == tfUnit {
            if tfUnit.text == "" {
                self.viewUnit.layer.borderColor = #colorLiteral(red: 0.8078431487, green: 0.02745098062, blue: 0.3333333433, alpha: 1)
                self.viewUnit.layer.borderWidth = 1
                self.viewUnit.layer.cornerRadius = 20
                self.viewUnit.layer.masksToBounds = true
            }else{
               
                self.viewUnit.setBorderGrayWidthCorner(1, 20)
                get_Unit(searchTxt:tfUnit.text!)
            }
            
        }
        
        
    }
}
