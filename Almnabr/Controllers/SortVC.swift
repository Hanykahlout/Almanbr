//
//  FillterVC.swift
//  Almnabr
//
//  Created by MacBook on 15/01/2022.
//  Copyright © 2022 Samar Akkila. All rights reserved.
//

import UIKit
import DropDown

protocol filterDelegate {
    func pass(param: [String:Any])
}


class SortVC: UIViewController , UITextFieldDelegate {

    @IBOutlet weak var viewNavigation: UIView!
    @IBOutlet weak var lblTitle: UILabel!
    
    @IBOutlet weak var tfFilterName: UITextField!
    @IBOutlet weak var lblFilterName: UILabel!
    @IBOutlet weak var viewFilterName: UIView!
    
    
    @IBOutlet weak var viewRN: DropDownView!
    @IBOutlet weak var viewFilter: DropDownView!
    @IBOutlet weak var viewTempID: DropDownView!
    @IBOutlet weak var viewPlatformCodeSystem: DropDownView!
    @IBOutlet weak var viewzone: DropDownView!
    @IBOutlet weak var viewBlocks: DropDownView!
    @IBOutlet weak var viewClusters: DropDownView!
    @IBOutlet weak var viewBarCode: DropDownView!
    
    @IBOutlet weak var btnReset: UIButton!
    @IBOutlet weak var btnSubmit: UIButton!
    @IBOutlet weak var btnSave: UIButton!
    
    var arr_NoData:[String] = ["No items found".localized()]
    var arr_ASC:[String] = ["ASC".localized(),"DESC".localized()]
    
    var arr_filter_list:[FilterObj] = []
    var arr_filter:[FilterObj] = []
    var filter_id:String = ""
    var param:[String:Any] = [:]
    
    var delegate: filterDelegate!
    
    var IsChooseFilter:Bool = false
    
    let dropUpmage =  UIImage.fontAwesomeIcon(name: .chevronUp , style: .solid, textColor:  .gray, size: CGSize(width: 40, height: 40))
    
    let dropDownmage =  UIImage.fontAwesomeIcon(name: .chevronDown , style: .solid, textColor:  .gray, size: CGSize(width: 40, height: 40))
    
    override func viewDidLoad() {
        super.viewDidLoad()

        ConfigGUI()
        configNavigation()
        
        get_filter_list()
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
//        self.view.backgroundColor = .white
        
        self.view.backgroundColor = maincolor
        _ = self.navigationController?.preferredStatusBarStyle
//        self.view.backgroundColor = HelperClassSwift.acolor.getUIColor() //F0F4F8
        //navigationController?.navigationBar.barTintColor = .buttonBackgroundColor()
        navigationController?.navigationBar.barTintColor = maincolor
       addNavigationBarTitle(navigationTitle: "Sorting".localized())
        UINavigationBar.appearance().backgroundColor = maincolor
    }
    
    

    
    func ConfigGUI(){
       
        
        self.btnReset.setTitle("Reset".localized(), for: .normal)
        self.btnReset.backgroundColor =  maincolor
        self.btnReset.setTitleColor(.white, for: .normal)
        self.btnReset.setRounded(10)
        
        
        self.btnSubmit.setTitle("Submit".localized(), for: .normal)
        self.btnSubmit.backgroundColor =  maincolor
        self.btnSubmit.setTitleColor(.white, for: .normal)
        self.btnSubmit.setRounded(10)
        
        self.btnSave.setTitle("Save".localized(), for: .normal)
        self.btnSave.backgroundColor =  maincolor
        self.btnSave.setTitleColor(.white, for: .normal)
        self.btnSave.setRounded(10)
        
        viewFilterName.setBorderGray()
        
        tfFilterName.placeholder = "lang_filter_name".localized()
       
        lblFilterName.text = "lang_filter_name".localized()
        
        viewFilter.btnSearchAction = self.setupFilterName
        viewFilter.tf_searchTitle.placeholder =  "Filter".localized()
        viewFilter.lbl_searchTitle.text =  "Filter".localized()
        
        viewzone.tf_searchTitle.placeholder =  "Zone".localized()
        viewzone.lbl_searchTitle.text =  "Zone".localized()
        viewzone.btnSearchAction = self.setupzone
        
        viewRN.tf_searchTitle.placeholder =  "Request Number".localized()
        viewRN.lbl_searchTitle.text =  "Request Number".localized()
        viewRN.btnSearchAction = self.setupRN
        
        viewTempID.tf_searchTitle.placeholder =  "Template ID".localized()
        viewTempID.lbl_searchTitle.text =  "Template ID".localized()
        viewTempID.btnSearchAction = self.setupTempID
        
        viewPlatformCodeSystem.tf_searchTitle.placeholder =  "Platform Code System".localized()
        viewPlatformCodeSystem.lbl_searchTitle.text =  "Platform Code System".localized()
        viewPlatformCodeSystem.btnSearchAction = self.setupplatformCodeSystem
        
        viewBlocks.tf_searchTitle.placeholder =  "Blocks".localized()
        viewBlocks.lbl_searchTitle.text =  "Blocks".localized()
        viewBlocks.btnSearchAction = self.setupBlocks
        
        viewClusters.tf_searchTitle.placeholder =  "Clusters".localized()
        viewClusters.lbl_searchTitle.text =  "Clusters".localized()
        viewClusters.btnSearchAction = self.setupClusters
        
        viewBarCode.tf_searchTitle.placeholder =  "Barcode".localized()
        viewBarCode.lbl_searchTitle.text =  "Barcode".localized()
        viewBarCode.btnSearchAction = self.setupBarCode
        
        self.tfFilterName.delegate = self
    }
    
    
    
    func get_filter_details(filter_id:String,index:Int){
        
        self.showLoadingActivity()
        
        
        APIController.shard.sendRequestGetAuth(urlString: "pr/get_filter_details?filter_id=\(filter_id)") { (response) in
            self.hideLoadingActivity()
          
            let status = response["status"] as? Bool
            
            if status == true{
                
                if  let list = response["records"] as? NSArray{
                    
                    self.arr_filter = []
                    for i in list {
                        let dict = i as? [String:Any]
                        let obj = FilterObj.init(dict!)
                        self.arr_filter.append(obj)
                    }
                   
                    self.setupFilter(index: index)
                    self.hideLoadingActivity()
                }
            }
            
            
            
        }
    }
    
    func get_filter_list(){
        
        self.showLoadingActivity()
        //pr/get_filter_list?filter_key=FP1&projects_work_area_id=1
        APIController.shard.sendRequestGetAuth(urlString: "pr/get_filter_list?filter_key=FP1&projects_work_area_id=\(projects_work_area_id)") { (response) in
            self.hideLoadingActivity()
          
            let status = response["status"] as? Bool
            
            if status == true{
                
                if  let list = response["records"] as? NSArray{
                    
                    for i in list {
                        let dict = i as? [String:Any]
                        let obj = FilterObj.init(dict!)
                        self.arr_filter_list.append(obj)
                    }
                   
                    self.filter_id = self.arr_filter_list[0].filter_id
                    self.get_filter_details(filter_id: self.filter_id, index: 0)
                    self.hideLoadingActivity()
                }
            }
            
            
            
        }
    }
    
    func func_dropDown(arr_dataSource:[String],view_drop:UIView,tf_name:UITextField,img_Drop:UIImageView,btn_drop:UIButton,title:String) -> (String,Bool)  {
        //-> String
       var selected_item:String = ""
        var Iscanceled:Bool = false
        if arr_dataSource.count > 0 {
        
        let vc :PickerVC = AppDelegate.mainSB.instanceVC()
        vc.arr_data =  arr_dataSource
        vc.isModalInPresentation = true
        vc.modalPresentationStyle = .overFullScreen
        vc.definesPresentationContext = true
        vc.delegate = {name , index in
            if name == arr_dataSource[index] {
                Iscanceled = false
                if self.IsChooseFilter == true {
                    let i =  self.arr_filter_list[index].filter_id
                    selected_item = i
                    
                    self.get_filter_details(filter_id:  i,index:index)

                }else{
                    selected_item = name
                }
                btn_drop.isHidden = false
                img_Drop.image = self.dropDownmage
                tf_name.text =  name
            }
        }
        self.present(vc, animated: true, completion: nil)
    }
        
//        let dropDown = DropDown()
//        dropDown.anchorView = view
//        dropDown.backgroundColor = .white
//        dropDown.cornerRadius = 2.0
//
//        dropDown.cancelAction = {
//            btn_drop.isHidden = false
//            img_Drop.image = self.dropDownmage
//            Iscanceled = true
//        }
//        if arr_dataSource.count == 0 {
//            dropDown.dataSource = self.arr_NoData
//            dropDown.selectionAction = { [unowned self] (index: Int, item: String) in
//                img_Drop.image = dropDownmage
//            }
//            dropDown.textColor = #colorLiteral(red: 0.8039215803, green: 0.8039215803, blue: 0.8039215803, alpha: 1)
//        }else{
//            dropDown.dataSource = arr_dataSource
//            dropDown.selectionAction = { [unowned self] (index: Int, item: String) in
//
//                if item == arr_dataSource[index] {
//                    Iscanceled = false
//                    if IsChooseFilter == true {
//                        let i =  self.arr_filter_list[index].filter_id
//                        selected_item = i
//
//                        self.get_filter_details(filter_id:  i,index:index)
//
//                    }else{
//                        selected_item = item
//                    }
//
//                    btn_drop.isHidden = false
//                    img_Drop.image = self.dropDownmage
//                    tf_name.text =  item
//
//                }
//
//            }
//        }
//
//        dropDown.direction = .bottom
//        dropDown.anchorView = view_drop
//        dropDown.bottomOffset = CGPoint(x: 0, y: view_drop.bounds.height)
//        dropDown.width = view_drop.bounds.width
//        dropDown.show()
        return (selected_item ,Iscanceled )
    }
    
    
    

    func setupRN(){
        IsChooseFilter = false
        
        let item = self.func_dropDown(arr_dataSource: arr_ASC, view_drop: self.viewRN, tf_name: self.viewRN.tf_searchTitle, img_Drop: self.viewRN.img_Drop, btn_drop: self.viewRN.btn_search, title: "test")
        self.param["filter[transaction_request_id]"] = item.0
        
        
        if item.1 == true {
            self.param["filter[transaction_request_id]"] = ""
        }
        
    }
    
    func setupFilterName(){
        IsChooseFilter = true
        
        var arr_dataSource :[String] = []
        for i in arr_filter_list{
            arr_dataSource.append(i.filter_name)
        }
        
        let drop = self.func_dropDown(arr_dataSource: arr_dataSource, view_drop: self.viewFilter, tf_name: self.viewFilter.tf_searchTitle, img_Drop: self.viewFilter.img_Drop, btn_drop: self.viewFilter.btn_search, title: "test")
        
        if drop.1 == true {
            self.param["filter_name"] = ""
        }
        
    }
      
    
    func setupTempID(){
        
        IsChooseFilter = false
        
        let item = self.func_dropDown(arr_dataSource: arr_ASC, view_drop: self.viewTempID, tf_name: self.viewTempID.tf_searchTitle, img_Drop: self.viewTempID.img_Drop, btn_drop: self.viewTempID.btn_search, title: "test")
        self.param["sort_by[template_id]"] = item.0
        
        if item.1 == true {
            self.param["sort_by[template_id]"] = ""
        }
    }
    
    func setupplatformCodeSystem(){
        IsChooseFilter = false
        
        let item = self.func_dropDown(arr_dataSource: arr_ASC, view_drop: self.viewPlatformCodeSystem, tf_name: self.viewPlatformCodeSystem.tf_searchTitle, img_Drop: self.viewPlatformCodeSystem.img_Drop, btn_drop: self.viewPlatformCodeSystem.btn_search, title: "test")
        self.param["sort_by[platform_code_system]"] = item.0
        
        if item.1 == true {
            self.param["sort_by[platform_code_system]"] = ""
        }
    }
    
    func setupzone(){
        IsChooseFilter = false
        
        let item = self.func_dropDown(arr_dataSource: arr_ASC, view_drop: self.viewzone, tf_name: self.viewzone.tf_searchTitle, img_Drop: self.viewzone.img_Drop, btn_drop: self.viewzone.btn_search, title: "test")
        self.param["sort_by[zone]"] = item.0
        
        if item.1 == true {
            self.param["sort_by[zone]"] = ""
        }
    }
    
    func setupBlocks(){
        IsChooseFilter = false
        
        let item = self.func_dropDown(arr_dataSource: arr_ASC, view_drop: self.viewBlocks, tf_name: self.viewBlocks.tf_searchTitle, img_Drop: self.viewBlocks.img_Drop, btn_drop: self.viewBlocks.btn_search, title: "test")
        self.param["sort_by[block]"] = item.0
        
        if item.1 == true {
            self.param["sort_by[block]"]  = ""
        }
    }
    
    func setupClusters(){
        IsChooseFilter = false
        
        let item = self.func_dropDown(arr_dataSource: arr_ASC, view_drop: self.viewClusters, tf_name: self.viewClusters.tf_searchTitle, img_Drop: self.viewClusters.img_Drop, btn_drop: self.viewClusters.btn_search, title: "test")
        self.param["sort_by[cluster]"] = item.0
        
        if item.1 == true {
            self.param["sort_by[cluster]"]  = ""
        }
        
    }
    
    func setupBarCode(){
        
        IsChooseFilter = false
        
        let item = self.func_dropDown(arr_dataSource: arr_ASC, view_drop: self.viewBarCode, tf_name: self.viewBarCode.tf_searchTitle, img_Drop: self.viewBarCode.img_Drop, btn_drop: self.viewBarCode.btn_search, title: "test")
        self.param["sort_by[barcode]"] = item.0
        
        if item.1 == true {
            self.param["sort_by[barcode]"]  = ""
        }
    }
    
    func setupFilter(index:Int){
        
       let obj = arr_filter[0]
        //arr_filter_list[index]
        let sort_by = sort_byObj(obj.sort_by)
        let filter_by = filter_byObj(obj.filter_by)
        
        self.tfFilterName.text = obj.filter_name
        self.viewRN.tf_searchTitle.text = sort_by.transaction_request_id
        self.viewFilter.tf_searchTitle.text = obj.filter_name
        self.viewTempID.tf_searchTitle.text = sort_by.template_id
        self.viewPlatformCodeSystem.tf_searchTitle.text = sort_by.platform_code_system
        self.viewzone.tf_searchTitle.text = sort_by.zone
        self.viewBlocks.tf_searchTitle.text = sort_by.block
        self.viewClusters.tf_searchTitle.text = sort_by.cluster
        self.viewBarCode.tf_searchTitle.text = sort_by.barcode
        
        for i in filter_by.group1{
            var count = 0
            
            self.param["filter[group1][\(count)][label]"] = i.label
            self.param["filter[group1][\(count)][id]"] = i.id
            count = count + 1
        }
        
        for i in filter_by.group2{
            var count = 0
            self.param["filter[group2][\(count)][label]"] = i.label
            self.param["filter[group2][\(count)][id]"] = i.id
            count = count + 1
        }
        
        for i in filter_by.group_type{
            var count = 0
            self.param["filter[group_type][\(count)][label]"] = i.label
            self.param["filter[group_type][\(count)][id]"] = i.id
            count = count + 1
        }
        
        for i in filter_by.template{
            var count = 0
            self.param["filter[template][\(count)][label]"] = i.label
            self.param["filter[template][\(count)][id]"] = i.id
            count = count + 1
        }
        
        for i in filter_by.cluster{
            var count = 0
            self.param["filter[cluster][\(count)][label]"] = i.label
            self.param["filter[cluster][\(count)][id]"] = i.id
            count = count + 1
        }
        
        for i in filter_by.block{
            var count = 0
            self.param["filter[block][\(count)][label]"] = i.label
            self.param["filter[block][\(count)][id]"] = i.id
            count = count + 1
        }
        
        for i in filter_by.zone{
            var count = 0
            self.param["filter[zone][\(count)][label]"] = i.label
            self.param["filter[zone][\(count)][id]"] = i.id
            count = count + 1
        }
        
        self.param["filter[transaction_start_date]"] = filter_by.transaction_start_date
        self.param["filter[transaction_end_date]"] = filter_by.transaction_end_date
        self.param["filter[transaction_request_id]"] = filter_by.transaction_request_id
        self.param["filter[platform_code_system]"] = filter_by.platform_code_system
        self.param["filter[phase_short_code]"] = filter_by.phase_short_code
        self.param["filter[unit_id]"] = filter_by.unit_id
        self.param["filter[level_key]"] = filter_by.level_key
        self.param["filter[barcode]"] = filter_by.barcode
        self.param["filter[result_code]"] = filter_by.result_code
        self.param["filter[version]"] = filter_by.version
        
        self.param["sort_by[barcode]"] = sort_by.barcode
        self.param["sort_by[transaction_request_id]"] = sort_by.transaction_request_id
        self.param["sort_by[template_id]"] = sort_by.template_id
        self.param["sort_by[zone]"] = sort_by.zone
        self.param["sort_by[block]"] = sort_by.block
        self.param["sort_by[cluster]"] = sort_by.cluster
        self.param["sort_by[platform_code_system]"] = sort_by.platform_code_system
        
        self.param["projects_supervision_id"] = projects_supervision_id
    
        self.param["filter_name"] = tfFilterName.text
        self.param["filter[name]"] = tfFilterName.text
    }
    
    func update_filter(){
        self.param["filter_name"] = tfFilterName.text
        self.param["filter[name]"] = tfFilterName.text
        
        self.param["filter[result_code]"] = self.viewBarCode.tf_searchTitle.text
        self.param["sort_by[zone]"] = self.viewzone.tf_searchTitle.text
        self.param["sort_by[block]"] = self.viewBlocks.tf_searchTitle.text
        self.param["sort_by[cluster]"] = self.viewClusters.tf_searchTitle.text
        self.param["sort_by[platform_code_system]"] =  self.viewPlatformCodeSystem.tf_searchTitle.text
        self.param["sort_by[template_id]"] =  self.viewTempID.tf_searchTitle.text
        self.param["sort_by[transaction_request_id]"] = self.viewRN.tf_searchTitle.text
        
        self.craete_update_filter()
      
    }
    
    
    func craete_update_filter(){
      
        self.showLoadingActivity()
        
        self.param["filter_key"] = "FP1"
        self.param["projects_work_area_id"] = projects_work_area_id
       
        APIController.shard.sendRequestPostAuth(urlString: "pr/craete_update_filter", parameters: self.param ) { (response) in
            self.hideLoadingActivity()
            
            let status = response["status"] as? Bool
            let msg = response["error"] as? String
            
            if status == true{
                self.hideLoadingActivity()
         
            }else{
                
                self.showAMessage(withTitle: "error", message: msg ?? "some thing went wrong")
                self.hideLoadingActivity()
            }
            
            
            
        }
    }
    
    
    
    @IBAction func btnReset_Click(_ sender: Any) {
       // self.param = [:]
        
        self.tfFilterName.text = ""
        self.viewRN.tf_searchTitle.text = ""
        self.viewFilter.tf_searchTitle.text = ""
        self.viewTempID.tf_searchTitle.text = ""
        self.viewPlatformCodeSystem.tf_searchTitle.text = ""
        self.viewzone.tf_searchTitle.text = ""
        self.viewBlocks.tf_searchTitle.text = ""
        self.viewClusters.tf_searchTitle.text = ""
        self.viewBarCode.tf_searchTitle.text = ""
//
//        arr_filter = []
//        setupFilter(index:0)
//        self.ConfigGUI()
    }
    
    @IBAction func btnSubmit_Click(_ sender: Any) {
        delegate.pass(param: self.param)
        self.navigationController?.popViewController(animated: true)
        
    }
    
    @IBAction func btnSave_Click(_ sender: Any) {
        
        if tfFilterName.text == "" {
            self.showAMessage(withTitle: "", message: "")
        }else{
            update_filter()
           
        }
       
        
    }
}



extension SortVC : UITextViewDelegate{
    
    
    func textFieldShouldBeginEditing(_ textField: UITextField) -> Bool {
        if textField == tfFilterName {
            
            self.viewFilterName.layer.borderColor = #colorLiteral(red: 0.1764705926, green: 0.4980392158, blue: 0.7568627596, alpha: 1)
            self.viewFilterName.layer.borderWidth = 1
            self.viewFilterName.layer.cornerRadius = 4
            self.viewFilterName.layer.masksToBounds = true
            
        }
        return true
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        if textField == tfFilterName {
            if tfFilterName.text == "" {
                self.viewFilterName.layer.borderColor = #colorLiteral(red: 0.8078431487, green: 0.02745098062, blue: 0.3333333433, alpha: 1)
                self.viewFilterName.layer.borderWidth = 1
                self.viewFilterName.layer.cornerRadius = 4
                self.viewFilterName.layer.masksToBounds = true
            }else{
               
                self.viewFilterName.setBorderGray()
                self.param["filter_name"] = tfFilterName.text
                self.param["filter[name]"] = tfFilterName.text
                //get_Unit(searchTxt:tfUnit.text!)
            }
            
        }
        
        
    }
}
