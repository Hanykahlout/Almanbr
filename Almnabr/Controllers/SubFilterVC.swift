//
//  SubFilterVC.swift
//  Almnabr
//
//  Created by MacBook on 22/01/2022.
//  Copyright © 2022 Samar Akkila. All rights reserved.
//

import UIKit
import DropDown

class SubFilterVC: UIViewController {

    
    @IBOutlet weak var viewTemplateID: DropDownView!
    @IBOutlet weak var viewDivision: DropDownView!
    @IBOutlet weak var viewGroupType: DropDownView!
    @IBOutlet weak var viewChapter: DropDownView!
    
    @IBOutlet weak var lblFilter: UILabel!
    @IBOutlet weak var btnSave: UIButton!
    @IBOutlet weak var btnCancel: UIButton!
    
    
    let dropUpmage =  UIImage.fontAwesomeIcon(name: .chevronUp , style: .solid, textColor:  .gray, size: CGSize(width: 40, height: 40))
    
    let dropDownmage =  UIImage.fontAwesomeIcon(name: .chevronDown , style: .solid, textColor:  .gray, size: CGSize(width: 40, height: 40))
    
    var arr_NoData:[String] = ["No items found".localized()]
    var arr_zone:[String] = []
    
    var arr_TempleteId :[ModuleObj] = []
    var arr_Division :[ModuleObj] = []
    var arr_GroupType :[ModuleObj] = []
    var arr_Chapter :[ModuleObj] = []
    
    var delegate:SubFilterDelegate!
    
    var IsTempleteId:Bool = false
    var IsDivision:Bool = false
    var IsGroupType:Bool = false
    var IsChapter:Bool = false
    
    var TempleteId:String = ""
    var Division:String = ""
    var GroupType:String = ""
    var Chapter:String = ""
    
    var Templete :String = ""
    var TempleteID :String = ""
    var DivisionId :String = ""
    var GroupTypeId :String = ""
    var ChapterId :String = ""
    var GroupTypeValue :String = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()

        ConfigGUI()
        get_TempleteId()
    }
    
    
    func ConfigGUI(){
       
        self.lblFilter.text = "Filter"
        self.btnSave.setTitle("Save".localized(), for: .normal)
        self.btnSave.backgroundColor =  HelperClassSwift.acolor.getUIColor()
        self.btnSave.setTitleColor(.white, for: .normal)
        self.btnSave.setRounded(10)
        
        self.btnCancel.setTitle("Cancel".localized(), for: .normal)
        self.btnCancel.backgroundColor =  HelperClassSwift.acolor.getUIColor()
        self.btnCancel.setTitleColor(.white, for: .normal)
        self.btnCancel.setRounded(10)
        
        viewTemplateID.tf_searchTitle.placeholder = "Template ID".localized()
        viewDivision.tf_searchTitle.placeholder = "Division".localized()
        viewGroupType.tf_searchTitle.placeholder = "Group Type".localized()
        viewChapter.tf_searchTitle.placeholder = "Chapter".localized()
        
        viewTemplateID.lbl_searchTitle.text = "Template ID".localized()
        viewDivision.lbl_searchTitle.text = "Division".localized()
        viewGroupType.lbl_searchTitle.text = "Group Type".localized()
        viewChapter.lbl_searchTitle.text = "Chapter".localized()
        
        viewTemplateID.btnSearchAction = self.setupTempleteId
        viewDivision.btnSearchAction = self.setupdivision
        viewGroupType.btnSearchAction = self.setupGroupType
        viewChapter.btnSearchAction = self.setupChapter
        
    }
    
    
    func func_dropDown(arr_dataSource:[String],view_drop:UIView,tf_name:UITextField,img_Drop:UIImageView,btn_drop:UIButton,title:String) -> (String,Bool)  {
        //-> String
       var selected_item:String = ""
        var Iscanceled:Bool = false
        //"title".localized()
       //self.img_Drop.image = dropUpmage
        let dropDown = DropDown()
        dropDown.anchorView = view
        dropDown.backgroundColor = .white
        dropDown.cornerRadius = 2.0
        
        dropDown.cancelAction = {
            btn_drop.isHidden = false
            img_Drop.image = self.dropDownmage
            Iscanceled = true
        }
        if arr_dataSource.count == 0 {
            dropDown.dataSource = self.arr_NoData
            dropDown.selectionAction = { [unowned self] (index: Int, item: String) in
                img_Drop.image = dropDownmage
            }
            dropDown.textColor = #colorLiteral(red: 0.8039215803, green: 0.8039215803, blue: 0.8039215803, alpha: 1)
        }else{
            dropDown.dataSource = arr_dataSource
            dropDown.selectionAction = { [unowned self] (index: Int, item: String) in
                
                if item == arr_dataSource[index] {
                    Iscanceled = false
                    if IsTempleteId == true {
                        let tempId = arr_TempleteId[index].value
                        self.get_division(tempId: tempId)
                        selected_item = item
                        self.TempleteId = item
                        self.Templete = item
                        self.TempleteID = tempId

                    }else if IsDivision == true{
                        let Id = arr_Division[index].value
                        get_groupType(divisionId:Id)
                        selected_item = item
                        self.Division = item
                        self.DivisionId = Id
                        
                    } else if IsGroupType == true{
                        
                        let Id = arr_GroupType[index].id
                       
                        get_chapter(Id:Id)
                        selected_item = item
                        self.GroupType = item
                        self.GroupTypeId = Id
                        self.GroupTypeValue = arr_GroupType[index].value
                        
                    }else if IsChapter == true{
                        let Id = arr_GroupType[index].id
                        get_chapter(Id:Id)
                        selected_item = item
                        self.Chapter = item
                        self.ChapterId = Id
                    }
                    
                    btn_drop.isHidden = false
                    img_Drop.image = self.dropDownmage
                    tf_name.text =  item
                    
                }
                
            }
        }
        
        dropDown.direction = .bottom
        dropDown.anchorView = view_drop
        dropDown.bottomOffset = CGPoint(x: 0, y: view_drop.bounds.height)
        dropDown.width = view_drop.bounds.width
        dropDown.show()
        return (selected_item ,Iscanceled )
    }
   
    
    func get_TempleteId(){
        
        self.showLoadingActivity()
        
        let language = L102Language.currentAppleLanguage()
        
        let url = "p/get_templates_for_transactions?lang_key=\(language)&projects_work_area_id=\(projects_work_area_id)"
        APIController.shard.sendRequestGetAuth(urlString: url) { (response) in
            self.hideLoadingActivity()
          
            let status = response["status"] as? Bool
            
            if status == true{
                
                if  let list = response["records"] as? NSArray{
                    self.arr_TempleteId = []
                    for i in list {
                        let dict = i as? [String:Any]
                        let obj = ModuleObj.init(dict!)
                        self.arr_TempleteId.append(obj)
                    }
                   
                  
                    self.hideLoadingActivity()
                }
            }
        }
    }
    
    
    func get_division(tempId:String){
        
        self.showLoadingActivity()
        
        let url = "pforms/get_group1_type_group2?projects_work_area_id=\(projects_work_area_id)&template_id=\(tempId)&required_type=group1&group1=&type="
        APIController.shard.sendRequestGetAuth(urlString: url) { (response) in
            self.hideLoadingActivity()
          
            let status = response["status"] as? Bool
            
            if status == true{
                
                if  let list = response["records"] as? NSArray{
                    self.arr_Division = []
                    for i in list {
                        let dict = i as? [String:Any]
                        let obj = ModuleObj.init(dict!)
                        self.arr_Division.append(obj)
                    }
                   
                  
                    self.hideLoadingActivity()
                }
            }
        }
    }
    
    func get_groupType(divisionId:String){
        
        self.showLoadingActivity()
        
        
        let url = "pforms/get_group1_type_group2?projects_work_area_id=\(projects_work_area_id)&template_id=\(TempleteID)&required_type=type&group1=\(divisionId)&type="
        APIController.shard.sendRequestGetAuth(urlString: url) { (response) in
            self.hideLoadingActivity()
          
            let status = response["status"] as? Bool
            
            if status == true{
                
                if  let list = response["records"] as? NSArray{
                    self.arr_GroupType = []
                    for i in list {
                        let dict = i as? [String:Any]
                        let obj = ModuleObj.init(dict!)
                        self.arr_GroupType.append(obj)
                    }
                   
                  
                    self.hideLoadingActivity()
                }
            }
        }
    }
    
    
    func get_chapter(Id:String){
        
        self.showLoadingActivity()
        
        let url = "pforms/get_group1_type_group2?projects_work_area_id=\(projects_work_area_id)&template_id=\(TempleteID)&required_type=group2&group1=\(DivisionId)&type=\(self.GroupTypeValue)"
        APIController.shard.sendRequestGetAuth(urlString: url) { (response) in
            self.hideLoadingActivity()
          
            let status = response["status"] as? Bool
            
            if status == true{
                self.arr_Chapter = []
                if  let list = response["records"] as? NSArray{
                   
                    for i in list {
                        let dict = i as? [String:Any]
                        let obj = ModuleObj.init(dict!)
                        self.arr_Chapter.append(obj)
                    }
                   
                  
                    self.hideLoadingActivity()
                }
            }else{
                self.hideLoadingActivity()
            }
        }
        
    }
    
    
    func setupTempleteId(){
        
        IsTempleteId = true
        IsDivision = false
        IsGroupType = false
        IsChapter = false
        
        var arr_dataSource :[String] = []
        for i in arr_TempleteId{
            arr_dataSource.append(i.label)
        }
        
        let drop = self.func_dropDown(arr_dataSource: arr_dataSource, view_drop: self.viewTemplateID, tf_name: self.viewTemplateID.tf_searchTitle, img_Drop: self.viewTemplateID.img_Drop, btn_drop: self.viewTemplateID.btn_search, title: "test")
   
        
    }
    
    func setupdivision(){
        
        IsTempleteId = false
        IsDivision = true
        IsGroupType = false
        IsChapter = false
        
        var arr_dataSource :[String] = []
        for i in arr_Division{
            arr_dataSource.append(i.label)
        }
        
        let drop = self.func_dropDown(arr_dataSource: arr_dataSource, view_drop: self.viewDivision, tf_name: self.viewDivision.tf_searchTitle, img_Drop: self.viewDivision.img_Drop, btn_drop: self.viewDivision.btn_search, title: "test")
      
    }
    
    func setupGroupType(){
        
        IsTempleteId = false
        IsDivision = false
        IsGroupType = true
        IsChapter = false
        
        var arr_dataSource :[String] = []
        for i in arr_GroupType{
            arr_dataSource.append(i.label)
        }
        
        let drop = self.func_dropDown(arr_dataSource: arr_dataSource, view_drop: self.viewGroupType, tf_name: self.viewGroupType.tf_searchTitle, img_Drop: self.viewGroupType.img_Drop, btn_drop: self.viewGroupType.btn_search, title: "test")
        
    }
    
    func setupChapter(){
        
        IsTempleteId = false
        IsDivision = false
        IsGroupType = false
        IsChapter = true
        
        var arr_dataSource :[String] = []
        for i in arr_Chapter{
            arr_dataSource.append(i.label)
        }
        
        let drop = self.func_dropDown(arr_dataSource: arr_dataSource, view_drop: self.viewChapter, tf_name: self.viewChapter.tf_searchTitle, img_Drop: self.viewChapter.img_Drop, btn_drop: self.viewChapter.btn_search, title: "test")
       
        
    }
    
    @IBAction func btnCancel_Click(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func btnSubmit_Click(_ sender: Any) {
        
        if (viewChapter.tf_searchTitle.text == "" ){
            self.showAMessage(withTitle: "Error", message: "missed data")
        }else{
            
            let TempleteObj = ["id":TempleteID,"label":self.Templete]
            let DivisionObj = ["id":DivisionId,"label":self.Division]
            let GroupTypObj = ["id":GroupTypeId,"label":self.GroupType]
            let ChapterObj = ["id":ChapterId,"label":self.Chapter]
            
            let obj1 = labelObj(TempleteObj)
            let obj2 = labelObj(DivisionObj)
            let obj3 = labelObj(GroupTypObj)
            let obj4 = labelObj(ChapterObj)
            
            delegate.passSubFilter(temp_arr: obj1, division_arr: obj2, Group_arr: obj3, Chapter_arr: obj4)
            self.dismiss(animated: true, completion: nil)
        }
       
    }
    
}
