//
//  SortVC.swift
//  Almnabr
//
//  Created by MacBook on 16/01/2022.
//  Copyright © 2022 Samar Akkila. All rights reserved.
//

import UIKit
import DropDown

protocol FilterDelegate {
    func passFilter(zone_arr: labelObj,Block_arr: labelObj,Cluster_arr: labelObj)

}
protocol  SubFilterDelegate {
  func passSubFilter(temp_arr: labelObj,division_arr: labelObj,Group_arr: labelObj,Chapter_arr: labelObj)
}

class FilterVC: UIViewController , UITextFieldDelegate ,FilterDelegate , SubFilterDelegate {
    func passSubFilter(temp_arr: labelObj, division_arr: labelObj, Group_arr: labelObj, Chapter_arr: labelObj) {
        self.arr_TempId.append(temp_arr)
        self.arr_Division.append(division_arr)
        self.arr_GroupType.append(Group_arr)
        self.arr_Chapter.append(Chapter_arr)
        
        self.collectionTempId.reloadData()
        self.collectionDivision.reloadData()
        self.collectionGroupType.reloadData()
        self.collectionChapter.reloadData()
        
        collectionTempId.isHidden = false
        collectionDivision.isHidden = false
        collectionGroupType.isHidden = false
        collectionChapter.isHidden = false
        
        self.lblNoTempId.isHidden = true
        self.lblNoDivision.isHidden = true
        self.lblNoGroupType.isHidden = true
        self.lblNoChapter.isHidden = true
    }
    
    
    func passFilter(zone_arr: labelObj, Block_arr: labelObj, Cluster_arr: labelObj) {
        
        self.arr_Zone.append(zone_arr)
        self.arr_Blocks.append(Block_arr)
        self.arr_Clusters.append(Cluster_arr)
        
        self.collectionBlocks.reloadData()
        self.collectionZone.reloadData()
        self.collectionClusters.reloadData()
        
        collectionBlocks.isHidden = false
        collectionZone.isHidden = false
        collectionClusters.isHidden = false
        
        self.lblNoZone.isHidden = true
        self.lblNoBlocks.isHidden = true
        self.lblNoClusters.isHidden = true
        
    }
    
    @IBOutlet weak var viewFilter: DropDownView!
    @IBOutlet weak var lblFilterName: UILabel!
    @IBOutlet weak var viewFilterName: UIView!
    @IBOutlet weak var tfFilterName: UITextField!
    
    
    @IBOutlet weak var viewDate: UIView!
    @IBOutlet weak var lblDate: UILabel!
    
    @IBOutlet weak var tfRN: UITextField!
    @IBOutlet weak var lblRN: UILabel!
    @IBOutlet weak var viewRN: UIView!
   
    @IBOutlet weak var viewAllTempId: UIView!
    
    @IBOutlet weak var lblTempId: UILabel!
    @IBOutlet weak var lblNoTempId: UILabel!
    @IBOutlet weak var collectionTempId: UICollectionView!
    
    @IBOutlet weak var lblDivision: UILabel!
    @IBOutlet weak var lblNoDivision: UILabel!
    @IBOutlet weak var collectionDivision: UICollectionView!
    
    @IBOutlet weak var lblGroupType: UILabel!
    @IBOutlet weak var lblNoGroupType: UILabel!
    @IBOutlet weak var collectionGroupType: UICollectionView!
    
    @IBOutlet weak var lblChapter: UILabel!
    @IBOutlet weak var lblNoChapter: UILabel!
    @IBOutlet weak var collectionChapter: UICollectionView!
    
    @IBOutlet weak var tfPlatformCodeSystem: UITextField!
    @IBOutlet weak var lblPlatformCodeSystem: UILabel!
    @IBOutlet weak var viewPlatformCodeSystem: UIView!
    
    
    @IBOutlet weak var lblZone: UILabel!
    @IBOutlet weak var lblNoZone: UILabel!
    @IBOutlet weak var collectionZone: UICollectionView!
    
    
    @IBOutlet weak var lblBlocks: UILabel!
    @IBOutlet weak var lblNoBlocks: UILabel!
    @IBOutlet weak var collectionBlocks: UICollectionView!
    
    @IBOutlet weak var lblClusters: UILabel!
    @IBOutlet weak var lblNoClusters: UILabel!
    @IBOutlet weak var collectionClusters: UICollectionView!
    
    @IBOutlet weak var tfByPhases: UITextField!
    @IBOutlet weak var lblByPhases: UILabel!
    @IBOutlet weak var viewByPhases: UIView!
    
    @IBOutlet weak var tfGN: UITextField!
    @IBOutlet weak var lblGN: UILabel!
    @IBOutlet weak var viewGN: UIView!
    
    @IBOutlet weak var viewLevelKey: DropDownView!
    @IBOutlet weak var lblLevelKey: UILabel!
    
    @IBOutlet weak var viewAllByPhase: UIView!
    @IBOutlet weak var viewAllzone: UIView!
    
    @IBOutlet weak var lblResult: UILabel!
    @IBOutlet weak var lblNoResult: UILabel!
    @IBOutlet weak var collectionResult: UICollectionView!
    @IBOutlet weak var viewResult: DropDownView!
    
    
    @IBOutlet weak var viewStatus: DropDownView!
    
    @IBOutlet weak var tfBarcode: UITextField!
    @IBOutlet weak var lblBarcode: UILabel!
    @IBOutlet weak var viewBarcode: UIView!
    
    @IBOutlet weak var btnReset: UIButton!
    @IBOutlet weak var btnSubmit: UIButton!
    @IBOutlet weak var btnSave: UIButton!
    
    
    
    var arr_NoData:[String] = ["No items found".localized()]
    var arr_ASC:[String] = ["ASC".localized(),"DESC".localized()]
    
    let strNodata = "There are no data !!!".localized()
    var arr_filter_list:[FilterObj] = []
    var arr_filter:[FilterObj] = []
    var filter_id:String = ""
    var param:[String:Any] = [:]
    
    var arr_result:[String] = ["A","B","C","D","OPEN","CLOSE"]
    var arr_SelectedResult:[String] = []
    
    var arr_Unit:[ModuleObj] = []
    
    var arr_Clusters :[labelObj] = []
    var arr_Blocks :[labelObj] = []
    var arr_Zone :[labelObj] = []
    var arr_levelKey :[ModuleObj] = []
    var arr_Chapter :[labelObj] = []
    var arr_GroupType :[labelObj] = []
    var arr_Division :[labelObj] = []
    var arr_TempId :[labelObj] = []
    
    var arr_status:[String] = ["completed","completed versions","pending"]
    var arr_statusKey:[String] = ["final_completed_versions","all_completed_versions","all_pending_versions"]
    
    var delegate: filterDelegate!
    var IsChooseFilter:Bool = false
    var IslevelKey:Bool = false
    var IsResult:Bool = false
    var IsStatus:Bool = false
    
    var selected_levelKey :String  = ""
    var selected_status :String  = ""
    
    let dropUpmage =  UIImage.fontAwesomeIcon(name: .chevronUp , style: .solid, textColor:  .gray, size: CGSize(width: 40, height: 40))
    
    let dropDownmage =  UIImage.fontAwesomeIcon(name: .chevronDown , style: .solid, textColor:  .gray, size: CGSize(width: 40, height: 40))
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        ConfigGUI()
        configNavigation()
        get_level()
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
        
        self.view.backgroundColor = HelperClassSwift.acolor.getUIColor()
        _ = self.navigationController?.preferredStatusBarStyle
//        self.view.backgroundColor = HelperClassSwift.acolor.getUIColor() //F0F4F8
        //navigationController?.navigationBar.barTintColor = .buttonBackgroundColor()
        navigationController?.navigationBar.barTintColor = HelperClassSwift.acolor.getUIColor()
       addNavigationBarTitle(navigationTitle: "Sorting".localized())
        UINavigationBar.appearance().backgroundColor = HelperClassSwift.acolor.getUIColor()
    }
    
    
    
    // MARK: - Config GUI
    
    func ConfigGUI(){
       
        
        self.btnReset.setTitle("Reset".localized(), for: .normal)
        self.btnReset.backgroundColor =  HelperClassSwift.acolor.getUIColor()
        self.btnReset.setTitleColor(.white, for: .normal)
        self.btnReset.setRounded(10)
        
        
        self.btnSubmit.setTitle("Submit".localized(), for: .normal)
        self.btnSubmit.backgroundColor =  HelperClassSwift.acolor.getUIColor()
        self.btnSubmit.setTitleColor(.white, for: .normal)
        self.btnSubmit.setRounded(10)
        
        self.btnSave.setTitle("Save".localized(), for: .normal)
        self.btnSave.backgroundColor =  HelperClassSwift.acolor.getUIColor()
        self.btnSave.setTitleColor(.white, for: .normal)
        self.btnSave.setRounded(10)
        
        viewFilterName.setBorderGray()
        viewDate.setBorderGray()
        
        tfFilterName.placeholder = "lang_filter_name".localized()
        lblFilterName.text = "lang_filter_name".localized()
        
        viewFilter.btnSearchAction = self.setupFilterName
        viewFilter.tf_searchTitle.placeholder =  "Filter".localized()
        viewFilter.lbl_searchTitle.text =  "Filter".localized()
        
        self.lblDate.text = "Date".localized()
        
        self.viewFilterName.setBorderGray()
//        tfFilterName.placeholder = "filter_name".localized()
//        lblFilterName.text = "filter_name".localized()
        
        viewAllTempId.setBorderGray()
        
       
        self.lblTempId.text =  "Template ID".localized()
        self.lblNoTempId.text =  strNodata
        
        self.lblDivision.text =  "Division".localized()
        self.lblNoDivision.text =  strNodata
        
        self.lblGroupType.text =  "Group Type".localized()
        self.lblNoGroupType.text =  strNodata
        
        self.lblChapter.text =  "Chapter".localized()
        self.lblNoChapter.text =  strNodata
        
        
        self.viewPlatformCodeSystem.setBorderGray()
        tfPlatformCodeSystem.placeholder = "Platform Code System".localized()
        lblPlatformCodeSystem.text = "Platform Code System".localized()
        
        
        viewAllByPhase.setBorderGray()
        
        self.lblZone.text =  "Zone".localized()
        self.lblNoZone.text =  strNodata
        
        self.lblBlocks.text =  "Blocks".localized()
        self.lblNoBlocks.text =  strNodata
        
        self.lblClusters.text =  "Clusters".localized()
        self.lblNoClusters.text =  strNodata
        
        self.viewAllzone.setBorderGray()
        
        
        self.viewByPhases.setBorderGray()
        tfByPhases.placeholder = "By Phases".localized()
        lblByPhases.text = "By Phases".localized()
        
        self.viewGN.setBorderGray()
        tfGN.placeholder = "General number".localized()
        lblGN.text = "General number".localized()
        
        //viewLevelKey.setBorderGray()
        self.viewLevelKey.tf_searchTitle.placeholder = "Level Key".localized()
        self.viewLevelKey.lbl_searchTitle.text = "Level Key".localized()
        viewLevelKey.btnSearchAction = self.setupLevelKey
//        viewLevelKey.tf_searchTitle.placeholder =  "Result".localized()
//        viewLevelKey.lbl_searchTitle.text =  "Result".localized()
        //viewLevelKey.btnSearchAction = self.setupRN
        
        
        viewStatus.tf_searchTitle.placeholder =  "Status".localized()
        viewStatus.lbl_searchTitle.text =  "Status".localized()
        viewStatus.btnSearchAction = self.setupStatus
        
        self.viewBarcode.setBorderGray()
        tfBarcode.placeholder = "Barcode".localized()
        lblBarcode.text = "Barcode".localized()
        
        self.viewRN.setBorderGray()
        self.lblRN.text = "Request Number"
        self.tfRN.placeholder = "Request Number".localized()
        
        
        self.lblNoResult.text =  strNodata
        self.viewResult.lbl_searchTitle.text =  "Result".localized()
        self.viewResult.tf_searchTitle.placeholder =  "Result".localized()
        viewResult.btnSearchAction = self.setupResult
        
        self.tfFilterName.delegate = self
        self.tfRN.delegate = self
        self.tfPlatformCodeSystem.delegate = self
        self.tfByPhases.delegate = self
        self.tfGN.delegate = self
        self.tfBarcode.delegate = self
        
        setupCollection()
    }
    
   
    // MARK: - Config Navigation
    
    func setupCollection(){
        
        collectionResult.register(UINib(nibName: "ViewLabelCell", bundle: nil), forCellWithReuseIdentifier: "ViewLabelCell")
        
        collectionResult.delegate = self
        collectionResult.dataSource = self
        
        collectionClusters.register(UINib(nibName: "ViewLabelCell", bundle: nil), forCellWithReuseIdentifier: "ViewLabelCell")
        
        collectionClusters.delegate = self
        collectionClusters.dataSource = self
        
        collectionBlocks.register(UINib(nibName: "ViewLabelCell", bundle: nil), forCellWithReuseIdentifier: "ViewLabelCell")
        
        collectionBlocks.delegate = self
        collectionBlocks.dataSource = self
        
        collectionZone.register(UINib(nibName: "ViewLabelCell", bundle: nil), forCellWithReuseIdentifier: "ViewLabelCell")
        
        collectionZone.delegate = self
        collectionZone.dataSource = self
        
        collectionChapter.register(UINib(nibName: "ViewLabelCell", bundle: nil), forCellWithReuseIdentifier: "ViewLabelCell")
        
        collectionChapter.delegate = self
        collectionChapter.dataSource = self
        
        
        collectionGroupType.register(UINib(nibName: "ViewLabelCell", bundle: nil), forCellWithReuseIdentifier: "ViewLabelCell")
        
        collectionGroupType.delegate = self
        collectionGroupType.dataSource = self
        
        collectionDivision.register(UINib(nibName: "ViewLabelCell", bundle: nil), forCellWithReuseIdentifier: "ViewLabelCell")
        
        collectionDivision.delegate = self
        collectionDivision.dataSource = self
        
        collectionTempId.register(UINib(nibName: "ViewLabelCell", bundle: nil), forCellWithReuseIdentifier: "ViewLabelCell")
        
        collectionTempId.delegate = self
        collectionTempId.dataSource = self
        
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
    
    func get_level(){
        
        self.showLoadingActivity()
        
        let language = L102Language.currentAppleLanguage()
        
        APIController.shard.sendRequestGetAuth(urlString: "lpworklevel?lang_key=\(language)") { (response) in
            self.hideLoadingActivity()
          
            let status = response["status"] as? Bool
            
            if status == true{
                
                if  let list = response["records"] as? NSArray{
                    
                    for i in list {
                        let dict = i as? [String:Any]
                        let obj = ModuleObj.init(dict!)
                        self.arr_levelKey.append(obj)
                    }
                   
                  
                    self.hideLoadingActivity()
                }
            }
            
            
            
        }
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
                    if IsChooseFilter == true {
                        let i =  self.arr_filter_list[index].filter_id
                        selected_item = i
                        
                        self.get_filter_details(filter_id:  i,index:index)

                        btn_drop.isHidden = true
                    }else{
                        btn_drop.isHidden = false
                        if  IslevelKey == true{
                            selected_item = item
                            self.selected_levelKey = arr_levelKey[index].value
                        }else if IsResult == true {
                            if arr_SelectedResult.contains(item){
                              print("exist")
                            }else{
                                self.arr_SelectedResult.append(item)
                            }
                            selected_item = item
                            self.collectionResult.reloadData()
                        }else if IsStatus == true{
                            selected_item = item
                            selected_status = arr_statusKey[index]
                            
                        }else{
                            selected_item = item
                        }
                        
                        
                    }
                    
                    
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
    
    
//    func setupRN(){
//        IsChooseFilter = false
//
//        let item = self.func_dropDown(arr_dataSource: arr_ASC, view_drop: self.viewRN, tf_name: self.viewRN.tf_searchTitle, img_Drop: self.viewRN.img_Drop, btn_drop: self.viewRN.btn_search, title: "test")
//        self.param["filter[transaction_request_id]"] = item.0
//
//
//        if item.1 == true {
//            self.param["filter[transaction_request_id]"] = ""
//        }
//
//    }
    
    func setupFilterName(){
        
        IsChooseFilter = true
        IslevelKey = false
        IsResult = false
        IsStatus = false
        
        var arr_dataSource :[String] = []
        for i in arr_filter_list{
            arr_dataSource.append(i.filter_name)
        }
        
        let drop = self.func_dropDown(arr_dataSource: arr_dataSource, view_drop: self.viewFilter, tf_name: self.viewFilter.tf_searchTitle, img_Drop: self.viewFilter.img_Drop, btn_drop: self.viewFilter.btn_search, title: "test")
        
//        if drop.1 == true {
//            self.param["filter_name"] = ""
//        }
        
    }
     
    func setupStatus(){
        
        IsChooseFilter = false
        IslevelKey = false
        IsResult = false
        IsStatus = true
        
        
        let drop = self.func_dropDown(arr_dataSource: arr_status, view_drop: self.viewStatus, tf_name: self.viewStatus.tf_searchTitle, img_Drop: self.viewStatus.img_Drop, btn_drop: self.viewStatus.btn_search, title: "test")
        
//        if drop.1 == true {
//            self.param["filter_name"] = ""
//        }
        
    }
    
    
    func setupLevelKey(){

        IsChooseFilter = false
        IsResult = false
        IslevelKey = true
        IsStatus = false
        
        var arr_dataSource :[String] = []
        for i in arr_levelKey{
            arr_dataSource.append(i.label)
        }
        
        let item = self.func_dropDown(arr_dataSource: arr_dataSource, view_drop: self.viewLevelKey, tf_name: self.viewLevelKey.tf_searchTitle, img_Drop: self.viewLevelKey.img_Drop, btn_drop: self.viewLevelKey.btn_search, title: "test")
        //self.param["sort_by[template_id]"] = item.0

//        if item.1 == true {
//            self.param["sort_by[template_id]"] = ""
//        }
    }
    
    func setupResult(){

        IsChooseFilter = false
        IslevelKey = false
        IsResult = true
        IsStatus = false
        
        let item = self.func_dropDown(arr_dataSource: arr_result, view_drop: self.viewResult, tf_name: self.viewResult.tf_searchTitle, img_Drop: self.viewResult.img_Drop, btn_drop: self.viewResult.btn_search, title: "test")
      
      
        self.collectionResult.isHidden = false
        
        self.collectionResult.reloadData()
        
        //self.param["sort_by[template_id]"] = item.0

//        if item.1 == true {
//            self.param["sort_by[template_id]"] = ""
//        }
    }
    
//    func setupplatformCodeSystem(){
//        IsChooseFilter = false
//
//        let item = self.func_dropDown(arr_dataSource: arr_ASC, view_drop: self.viewPlatformCodeSystem, tf_name: self.viewPlatformCodeSystem.tf_searchTitle, img_Drop: self.viewPlatformCodeSystem.img_Drop, btn_drop: self.viewPlatformCodeSystem.btn_search, title: "test")
//        self.param["sort_by[platform_code_system]"] = item.0
//
//        if item.1 == true {
//            self.param["sort_by[platform_code_system]"] = ""
//        }
//    }
    
//    func setupzone(){
//        IsChooseFilter = false
//
//        let item = self.func_dropDown(arr_dataSource: arr_ASC, view_drop: self.viewzone, tf_name: self.viewzone.tf_searchTitle, img_Drop: self.viewzone.img_Drop, btn_drop: self.viewzone.btn_search, title: "test")
//        self.param["sort_by[zone]"] = item.0
//
//        if item.1 == true {
//            self.param["sort_by[zone]"] = ""
//        }
//    }
    
//    func setupBlocks(){
//        IsChooseFilter = false
//
//        let item = self.func_dropDown(arr_dataSource: arr_ASC, view_drop: self.viewBlocks, tf_name: self.viewBlocks.tf_searchTitle, img_Drop: self.viewBlocks.img_Drop, btn_drop: self.viewBlocks.btn_search, title: "test")
//        self.param["sort_by[block]"] = item.0
//
//        if item.1 == true {
//            self.param["sort_by[block]"]  = ""
//        }
//    }
    
//    func setupClusters(){
//        IsChooseFilter = false
//
//        let item = self.func_dropDown(arr_dataSource: arr_ASC, view_drop: self.viewClusters, tf_name: self.viewClusters.tf_searchTitle, img_Drop: self.viewClusters.img_Drop, btn_drop: self.viewClusters.btn_search, title: "test")
//        self.param["sort_by[cluster]"] = item.0
//
//        if item.1 == true {
//            self.param["sort_by[cluster]"]  = ""
//        }
//
//    }
    
//    func setupBarCode(){
//
//        IsChooseFilter = false
//
//        let item = self.func_dropDown(arr_dataSource: arr_ASC, view_drop: self.viewBarCode, tf_name: self.viewBarCode.tf_searchTitle, img_Drop: self.viewBarCode.img_Drop, btn_drop: self.viewBarCode.btn_search, title: "test")
//        self.param["sort_by[barcode]"] = item.0
//
//        if item.1 == true {
//            self.param["sort_by[barcode]"]  = ""
//        }
//    }
    
    func setupFilter(index:Int){
        
       let obj = arr_filter[0]
        //arr_filter_list[index]
        let sort_by = sort_byObj(obj.sort_by)
        let filter_by = filter_byObj(obj.filter_by)
        
        self.tfFilterName.text = obj.filter_name
        
        self.viewFilter.tf_searchTitle.text = obj.filter_name
        self.tfRN.text = filter_by.transaction_request_id
        self.tfPlatformCodeSystem.text = sort_by.platform_code_system
        self.tfBarcode.text = filter_by.barcode
        self.tfByPhases.text = filter_by.phase_short_code
        self.tfGN.text = filter_by.unit_id
         
        
       
        let index =  arr_statusKey.firstIndex(where: {$0 == filter_by.version})
        self.viewStatus.tf_searchTitle.text = arr_status[index ?? 0]
        
        self.viewLevelKey.tf_searchTitle.text = filter_by.level_key
        
        self.arr_Division = []
        for i in filter_by.group1{
//            var count = 0
//
//            self.param["filter[group1][\(count)][label]"] = i.label
//            self.param["filter[group1][\(count)][id]"] = i.id
//            count = count + 1
            self.arr_Division.append(i)
        }
        
        self.arr_Chapter = []
        for i in filter_by.group2{
//            var count = 0
//            self.param["filter[group2][\(count)][label]"] = i.label
//            self.param["filter[group2][\(count)][id]"] = i.id
//            count = count + 1
            self.arr_Chapter.append(i)
          
        }
        
        self.arr_GroupType = []
        for i in filter_by.group_type{
//            var count = 0
//            self.param["filter[group_type][\(count)][label]"] = i.label
//            self.param["filter[group_type][\(count)][id]"] = i.id
//            count = count + 1
            self.arr_GroupType.append(i)
        }
        
        self.arr_TempId = []
        for i in filter_by.template{
//            var count = 0
//            self.param["filter[template][\(count)][label]"] = i.label
//            self.param["filter[template][\(count)][id]"] = i.id
//            count = count + 1
            self.arr_TempId.append(i)
        }
        
        self.arr_Clusters = []
        for i in filter_by.cluster{
//            var count = 0
//            self.param["filter[cluster][\(count)][label]"] = i.label
//            self.param["filter[cluster][\(count)][id]"] = i.id
//            count = count + 1
            self.arr_Clusters.append(i)
        }
        
        self.arr_Blocks = []
        for i in filter_by.block{
//            var count = 0
//            self.param["filter[block][\(count)][label]"] = i.label
//            self.param["filter[block][\(count)][id]"] = i.id
//            count = count + 1
            self.arr_Blocks.append(i)
        }
        
        self.arr_Zone = []
        for i in filter_by.zone{
//            var count = 0
//            self.param["filter[zone][\(count)][label]"] = i.label
//            self.param["filter[zone][\(count)][id]"] = i.id
//            count = count + 1
            self.arr_Zone.append(i)
        }
         
        self.arr_SelectedResult = filter_by.result_code.components(separatedBy: ",")
         
        if arr_Zone.count == 0 {
            self.collectionZone.isHidden = true
            self.lblNoZone.isHidden = false
        }else{
            self.collectionZone.isHidden = false
            self.lblNoZone.isHidden = true
        }
        if arr_Blocks.count == 0 {
            self.collectionBlocks.isHidden = true
            self.lblNoBlocks.isHidden = false
        }else{
            self.collectionBlocks.isHidden = false
            self.lblNoBlocks.isHidden = true
        }
        
        if arr_Clusters.count == 0 {
            self.collectionClusters.isHidden = true
            self.lblNoClusters.isHidden = false
        }else{
            self.collectionClusters.isHidden = false
            self.lblNoClusters.isHidden = true
        }
        if arr_TempId.count == 0 {
            self.collectionTempId.isHidden = true
            self.lblNoTempId.isHidden = false
        }else{
            self.collectionTempId.isHidden = false
            self.lblNoTempId.isHidden = true
        }
        if arr_GroupType.count == 0 {
            self.collectionGroupType.isHidden = true
            self.lblNoGroupType.isHidden = false
        }else{
            self.collectionGroupType.isHidden = false
            self.lblNoGroupType.isHidden = true
        }
        if arr_Chapter.count == 0 {
            self.collectionChapter.isHidden = true
            self.lblNoChapter.isHidden = false
        }else{
            self.collectionChapter.isHidden = false
            self.lblNoChapter.isHidden = true
        }
        if arr_Division.count == 0 {
            self.collectionDivision.isHidden = true
            self.lblNoDivision.isHidden = false
        }else{
            self.collectionDivision.isHidden = false
            self.lblNoDivision.isHidden = true
        }
        if arr_SelectedResult.count == 0 {
            self.collectionResult.isHidden = true
            self.lblNoResult.isHidden = false
        }else{
            self.collectionResult.isHidden = false
            self.lblNoResult.isHidden = true
        }
        
        
        collectionResult.reloadData()
        collectionClusters.reloadData()
        collectionBlocks.reloadData()
        collectionZone.reloadData()
        collectionChapter.reloadData()
        collectionGroupType.reloadData()
        collectionDivision.reloadData()
        collectionTempId.reloadData()
        
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
    
        
    }
    
    func update_filter(){
        
        var count = 0
        
        for i in arr_Division{
            self.param["filter[group1][\(count)][label]"] = i.label
            self.param["filter[group1][\(count)][id]"] = i.id
            count = count + 1
        }
        
        var count1 = 0
        for i in arr_Chapter{
            self.param["filter[group2][\(count1)][label]"] = i.label
            self.param["filter[group2][\(count1)][id]"] = i.id
            count1 = count1 + 1
        }
        
        var count2 = 0
        for i in arr_GroupType{
            self.param["filter[group_type][\(count2)][label]"] = i.label
            self.param["filter[group_type][\(count2)][id]"] = i.id
            count2 = count2 + 1
        }
        
       
        var count3 = 0
        for i in arr_TempId{
            self.param["filter[template][\(count3)][label]"] = i.label
            self.param["filter[template][\(count3)][id]"] = i.id
            count3 = count3 + 1
        }
        
        var count4 = 0
        for i in arr_Clusters{
            self.param["filter[cluster][\(count4)][label]"] = i.label
            self.param["filter[cluster][\(count4)][id]"] = i.id
            count4 = count4 + 1
        }
        
        var count5 = 0
        for i in arr_Blocks{
            self.param["filter[block][\(count5)][label]"] = i.label
            self.param["filter[block][\(count5)][id]"] = i.id
            count5 = count5 + 1
        }
        
        var count6 = 0
        for i in arr_Zone{
            self.param["filter[zone][\(count6)][label]"] = i.label
            self.param["filter[zone][\(count6)][id]"] = i.id
            count6 = count6 + 1
        }
        
        var results = ""
        for i in arr_SelectedResult{
            results = results + i + ","
        }
        self.param["filter[result_code]"] = results.dropLast()
      
        //self.param["filter_name"] = viewFilter.tf_searchTitle.text
        self.param["filter[level_key]"] = self.viewLevelKey.tf_searchTitle.text
        
        self.param["filter[version]"] = selected_status
       
        self.craete_update_filter()
        
        //filter[version]: final_completed_versions
        //filter[version]: all_completed_versions
        //filter[version]: all_pending_versions
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
        self.param = [:]
        
        self.viewFilter.tf_searchTitle.text = ""
        self.tfFilterName.text = ""
        self.tfRN.text = ""
        self.tfPlatformCodeSystem.text = ""
        self.tfBarcode.text = ""
        self.tfByPhases.text = ""
        self.tfGN.text = ""
        self.viewStatus.tf_searchTitle.text = ""
        self.viewLevelKey.tf_searchTitle.text = ""
        
        self.arr_Clusters = []
        self.arr_Blocks = []
        self.arr_Zone = []
         
        self.arr_Chapter = []
        self.arr_GroupType = []
        self.arr_Division = []
        self.arr_TempId = []
        self.arr_SelectedResult = []
        
        collectionResult.reloadData()
        collectionClusters.reloadData()
        collectionBlocks.reloadData()
        collectionZone.reloadData()
        collectionChapter.reloadData()
        collectionGroupType.reloadData()
        collectionDivision.reloadData()
        collectionTempId.reloadData()
        
        collectionResult.isHidden = true
        collectionClusters.isHidden = true
        collectionBlocks.isHidden = true
        collectionZone.isHidden = true
        collectionChapter.isHidden = true
        collectionGroupType.isHidden = true
        collectionDivision.isHidden = true
        collectionTempId.isHidden = true
        
        self.lblNoResult.isHidden = false
        self.lblNoClusters.isHidden = false
        self.lblNoBlocks.isHidden = false
        self.lblNoZone.isHidden = false
        self.lblNoChapter.isHidden = false
        self.lblNoGroupType.isHidden = false
        self.lblNoDivision.isHidden = false
        self.lblNoTempId.isHidden = false
        
        
    }
    
    @IBAction func btnSubmit_Click(_ sender: Any) {
        update_filter()
        delegate.pass(param: self.param)
        self.navigationController?.popViewController(animated: true)
        
    }
    
    @IBAction func btnSave_Click(_ sender: Any) {
        
        if tfFilterName.text == "" {
            self.showAMessage(withTitle: "", message: "")
        }else{
            self.update_filter()
            
        }
       
        
    }
    
    
    @IBAction func btnAddTemplate_Click(_ sender: Any) {
        
        let vc:SubFilterVC  = AppDelegate.mainSB.instanceVC()
            
            vc.isModalInPresentation = true
            vc.modalPresentationStyle = .overFullScreen
            vc.definesPresentationContext = true
            vc.delegate = self
//            vc.ProjectObj = self.ProjectObj
//            vc.StrLanguage = self.StrLanguage
//            vc.transaction_separation = transaction_separation
//            vc.arr_unit = self.arr_unit
//            vc.template_id = self.template_id
//            vc.projects_work_area_id = self.projects_work_area_id
//            vc.template_platform_code_system = self.template_platform_code_system
       
            self.present(vc, animated: true, completion: nil)
        
    }
    
    @IBAction func btnAddZone_Click(_ sender: Any) {
        
        let vc:TemplateFilterVC  = AppDelegate.mainSB.instanceVC()
            
            vc.isModalInPresentation = true
            vc.modalPresentationStyle = .overFullScreen
            vc.definesPresentationContext = true
            vc.delegate = self
//            vc.ProjectObj = self.ProjectObj
//            vc.StrLanguage = self.StrLanguage
//            vc.transaction_separation = transaction_separation
//            vc.arr_unit = self.arr_unit
//            vc.template_id = self.template_id
//            vc.projects_work_area_id = self.projects_work_area_id
//            vc.template_platform_code_system = self.template_platform_code_system
            
            self.present(vc, animated: true, completion: nil)
    }
}






extension FilterVC : UICollectionViewDelegate , UICollectionViewDataSource  {
 
 func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
     
     switch collectionView {
     case collectionResult:
         return arr_SelectedResult.count
     case collectionClusters :
         return arr_Clusters.count
     case collectionBlocks :
         return arr_Blocks.count
     case collectionZone :
         return arr_Zone.count
     case collectionChapter :
         return arr_Chapter.count
     case collectionGroupType :
         return arr_GroupType.count
     case collectionDivision :
         return arr_Division.count
     case collectionTempId :
         return arr_TempId.count
         
     default:
         return 0
     }
     
 }
 
 func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
     
     

     switch collectionView {
     case collectionResult:
         let cell:ViewLabelCell = collectionResult.dequeueCVCell(indexPath: indexPath)
         let obj = arr_SelectedResult[indexPath.item]
         cell.lblTitle.text = obj
         cell.btnDeleteAction = {
             self.arr_SelectedResult.remove(at: indexPath.item)
             self.collectionResult.reloadData()
             
             if self.arr_SelectedResult.count == 0 {
                 self.collectionResult.isHidden = true
                 self.lblNoResult.isHidden = false
             }
         }
         return cell
     case collectionClusters :
         let cell:ViewLabelCell = collectionClusters.dequeueCVCell(indexPath: indexPath)
         let obj = arr_Clusters[indexPath.item]
         cell.lblTitle.text = obj.label
         cell.btnDeleteAction = {
             self.arr_Clusters.remove(at: indexPath.item)
             self.collectionClusters.reloadData()
             if self.arr_Clusters.count == 0 {
                 self.collectionClusters.isHidden = true
                 self.lblNoClusters.isHidden = false
             }
         }
         return cell
     case collectionBlocks :
         let cell:ViewLabelCell = collectionBlocks.dequeueCVCell(indexPath: indexPath)
         let obj = arr_Blocks[indexPath.item]
         cell.lblTitle.text = obj.label
         cell.btnDeleteAction = {
             self.arr_Blocks.remove(at: indexPath.item)
             self.collectionBlocks.reloadData()
             if self.arr_Blocks.count == 0 {
                 self.collectionBlocks.isHidden = true
                 self.lblNoBlocks.isHidden = false
             }
         }
         return cell
     case collectionZone :
         let cell:ViewLabelCell = collectionZone.dequeueCVCell(indexPath: indexPath)
         let obj = arr_Zone[indexPath.item]
         cell.lblTitle.text = obj.label
         cell.btnDeleteAction = {
             self.arr_Zone.remove(at: indexPath.item)
             self.collectionZone.reloadData()
             if self.arr_Zone.count == 0 {
                 self.collectionZone.isHidden = true
                 self.lblNoZone.isHidden = false
             }
         }
         return cell
     case collectionChapter :
         let cell:ViewLabelCell = collectionChapter.dequeueCVCell(indexPath: indexPath)
         let obj = arr_Chapter[indexPath.item]
         cell.lblTitle.text = obj.label
         cell.btnDeleteAction = {
             self.arr_Chapter.remove(at: indexPath.item)
             self.collectionChapter.reloadData()
             if self.arr_Chapter.count == 0 {
                 self.collectionChapter.isHidden = true
                 self.lblNoChapter.isHidden = false
             }
          
         }
         return cell
     case collectionGroupType :
         let cell:ViewLabelCell = collectionGroupType.dequeueCVCell(indexPath: indexPath)
         let obj = arr_GroupType[indexPath.item]
         cell.lblTitle.text = obj.label
         cell.btnDeleteAction = {
             self.arr_GroupType.remove(at: indexPath.item)
             self.collectionGroupType.reloadData()
             if self.arr_GroupType.count == 0 {
                 self.collectionGroupType.isHidden = true
                 self.lblNoGroupType.isHidden = false
             }
         }
         return cell
     case collectionDivision :
         let cell:ViewLabelCell = collectionDivision.dequeueCVCell(indexPath: indexPath)
         let obj = arr_Division[indexPath.item]
         cell.lblTitle.text = obj.label
         cell.btnDeleteAction = {
             self.arr_Division.remove(at: indexPath.item)
             self.collectionDivision.reloadData()
             if self.arr_Division.count == 0 {
                 self.collectionDivision.isHidden = true
                 self.lblNoDivision.isHidden = false
             }
         }
         return cell
     case collectionTempId :
         let cell:ViewLabelCell = collectionTempId.dequeueCVCell(indexPath: indexPath)
         let obj = arr_TempId[indexPath.item]
         cell.lblTitle.text = obj.label
         cell.btnDeleteAction = {
             self.arr_TempId.remove(at: indexPath.item)
             self.collectionTempId.reloadData()
             if self.arr_TempId.count == 0 {
                 self.collectionTempId.isHidden = true
                 self.lblNoTempId.isHidden = false
             }
         }
         return cell
         
     default:
         return UICollectionViewCell()
     }
     
     
     
 }
}


extension FilterVC : UITextViewDelegate{
    
    
    func textFieldShouldBeginEditing(_ textField: UITextField) -> Bool {
        if textField == tfFilterName {
            
            self.viewFilterName.layer.borderColor = #colorLiteral(red: 0.1764705926, green: 0.4980392158, blue: 0.7568627596, alpha: 1)
            self.viewFilterName.layer.borderWidth = 1
            self.viewFilterName.layer.cornerRadius = 4
            self.viewFilterName.layer.masksToBounds = true
            
        }else if textField == tfRN {
            
            self.viewRN.layer.borderColor = #colorLiteral(red: 0.1764705926, green: 0.4980392158, blue: 0.7568627596, alpha: 1)
            self.viewRN.layer.borderWidth = 1
            self.viewRN.layer.cornerRadius = 4
            self.viewRN.layer.masksToBounds = true
            
        }else if textField == tfPlatformCodeSystem {
            
            self.viewPlatformCodeSystem.layer.borderColor = #colorLiteral(red: 0.1764705926, green: 0.4980392158, blue: 0.7568627596, alpha: 1)
            self.viewPlatformCodeSystem.layer.borderWidth = 1
            self.viewPlatformCodeSystem.layer.cornerRadius = 4
            self.viewPlatformCodeSystem.layer.masksToBounds = true
            
        }else if textField == tfByPhases {
            
            self.viewByPhases.layer.borderColor = #colorLiteral(red: 0.1764705926, green: 0.4980392158, blue: 0.7568627596, alpha: 1)
            self.viewByPhases.layer.borderWidth = 1
            self.viewByPhases.layer.cornerRadius = 4
            self.viewByPhases.layer.masksToBounds = true
            
        }else if textField == tfGN {
            
            self.viewGN.layer.borderColor = #colorLiteral(red: 0.1764705926, green: 0.4980392158, blue: 0.7568627596, alpha: 1)
            self.viewGN.layer.borderWidth = 1
            self.viewGN.layer.cornerRadius = 4
            self.viewGN.layer.masksToBounds = true
            
        }else if textField == tfBarcode {
            
            self.viewBarcode.layer.borderColor = #colorLiteral(red: 0.1764705926, green: 0.4980392158, blue: 0.7568627596, alpha: 1)
            self.viewBarcode.layer.borderWidth = 1
            self.viewBarcode.layer.cornerRadius = 4
            self.viewBarcode.layer.masksToBounds = true
            
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
            }
            
        }else if textField == tfRN {
            if tfRN.text == "" {
                self.viewRN.setBorderGray()
                self.param["filter[transaction_request_id]"] = ""
            }else{
                self.viewRN.setBorderGray()
                self.param["filter[transaction_request_id]"] = tfRN.text
            }
          
            
        }else if textField == tfPlatformCodeSystem {
            if tfPlatformCodeSystem.text == "" {
                self.viewPlatformCodeSystem.setBorderGray()
                self.param["filter[platform_code_system]"] = ""
            }else{
                self.viewPlatformCodeSystem.setBorderGray()
                self.param["filter[platform_code_system]"] = tfPlatformCodeSystem.text
            }
          
            
        }else if textField == tfByPhases {
            if tfByPhases.text == "" {
                self.viewByPhases.setBorderGray()
                self.param["filter[phase_short_code]"] = ""
            }else{
                self.viewByPhases.setBorderGray()
                self.param["filter[phase_short_code]"] = tfByPhases.text
            }
          
            
        }else if textField == tfGN {
            if tfGN.text == "" {
                self.viewGN.setBorderGray()
                self.param["filter[unit_id]"] = ""
            }else{
                self.viewGN.setBorderGray()
                self.param["filter[unit_id]"] = tfGN.text
            }
          
            
        }else if textField == tfBarcode {
            if tfBarcode.text == "" {
                self.viewBarcode.setBorderGray()
                self.param["filter[barcode]"] = ""
            }else{
                self.viewBarcode.setBorderGray()
                self.param["filter[barcode]"] = tfBarcode.text
            }
          
            
        }

        
        
    }
}

   
