//
//  RequirementsVC.swift
//  Almnabr
//
//  Created by MacBook on 02/03/2022.
//  Copyright © 2022 Samar Akkila. All rights reserved.
//

import UIKit
import DropDown

class RequirementsVC: UIViewController {

    
    @IBOutlet weak var tf_material_list: UITextField!
    @IBOutlet weak var tf_supplier_list: UITextField!
    @IBOutlet weak var tf_SQRsupplier_list: UITextField!
    @IBOutlet weak var tf_supply_date_to_site: UITextField!
    @IBOutlet weak var tf_Storage_Area: UITextField!
    @IBOutlet weak var tf_Material_name: UITextField!
    @IBOutlet weak var tf_Item_in_bill_quantity: UITextField!
    
    @IBOutlet weak var view_supply_date_to_site: UIView!
    @IBOutlet weak var view_Storage_Area: UIView!
    @IBOutlet weak var view_Material_name: UIView!
    @IBOutlet weak var view_Item_in_bill_quantity: UIView!
    
    @IBOutlet weak var view_SQRsupplier_list: UIView!
    @IBOutlet weak var view_supplier_list: UIView!
    @IBOutlet weak var view_material_list: UIView!
    
    @IBOutlet weak var collection_supplier: UICollectionView!
    @IBOutlet weak var collection_material: UICollectionView!
    
    @IBOutlet weak var Viewcollection_supplier: UIView!
    @IBOutlet weak var Viewcollection_material: UIView!
    
    @IBOutlet weak var imgDropSupplier: UIImageView!
    @IBOutlet weak var imgDropMaterial: UIImageView!
  
    
    @IBOutlet weak var lbl_Material_Description: UILabel!
    @IBOutlet weak var txt_Material_Description: UITextView!
    
    @IBOutlet weak var imgStep: UIImageView!
    @IBOutlet weak var viewStep: UIView!
    @IBOutlet weak var lblStep: UILabel!
    
    @IBOutlet weak var btnNext: UIButton!
    @IBOutlet weak var btnPrevious: UIButton!
    
    let datePicker = UIDatePicker()
    
    var params = [:] as [String : String]
    
    var arr_supplier:[SupplierObj] = []
    var arr_SQRsupplier:[SupplierObj] = []
    var arr_material:[SupplierObj] = []
    var arr_Item_quantity:[SupplierObj] = []
    
    var arr_lblsupplier:[String] = []
    var arr_lblSQRsupplier:[String] = []
    var arr_lblmaterial:[String] = []
    var arr_lblItem_quantity:[String] = []
    
    
    var arr_Selectedsupplier:[String] = []
    var arr_Selectedmaterial:[String] = []
    
    var arr_ObjectSelectedsupplier:[SupplierObj] = []
    var arr_ObjectSelectedmaterial:[SupplierObj] = []
    
    var related_bill_quanties:String = ""
     
    
    let dropDown = DropDown()
    
    var arr_NoData:[String] = ["No items found".localized()]
    
    var ProjectObj:templateObj!
    var material_code:String = ""
    var supplier_id:String = ""
    var transaction_request_id:String = ""
    
    let dropUpmage =  UIImage.fontAwesomeIcon(name: .chevronUp , style: .solid, textColor:  .gray, size: CGSize(width: 40, height: 40))
    
    let dropDownmage =  UIImage.fontAwesomeIcon(name: .chevronDown , style: .solid, textColor:  .gray, size: CGSize(width: 40, height: 40))
    
    override func viewDidLoad() {
        super.viewDidLoad()

        createDatePicker()
        configGUI()
        get_material_list()
        get_supplier_list()
    }
    

    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        // Hide the Navigation Bar
        self.navigationController?.setNavigationBarHidden(true, animated: true)
    }
    
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        // Show the Navigation Bar
        self.navigationController?.setNavigationBarHidden(true, animated: false)
    }
    
    
    
    
    //MARK: - Config GUI
    //------------------------------------------------------
    func configGUI() {
        
        self.tf_SQRsupplier_list.delegate = self
        
        let code = ProjectObj.template_platform_group_type_code_system
        
        if code == "MSR" {
            view_Material_name.isHidden = false
            view_Item_in_bill_quantity.isHidden = false
            view_Storage_Area.isHidden  = true
            view_material_list.isHidden = true
            view_supplier_list.isHidden = true
            view_supply_date_to_site.isHidden = true
            view_SQRsupplier_list.isHidden = true
            get_Item_in_bill_quantity()
            self.lbl_Material_Description.text = "Material Description".localized()
        
        }else if code == "MIQ" {
            view_Material_name.isHidden = true
            view_Item_in_bill_quantity.isHidden = true
            view_Storage_Area.isHidden  = false
            view_material_list.isHidden = false
            view_supplier_list.isHidden = false
            view_supply_date_to_site.isHidden = false
            view_SQRsupplier_list.isHidden = true
            self.lbl_Material_Description.text = "Material Description".localized()
            
        }else if code == "SQR" {
            
            view_Item_in_bill_quantity.isHidden = false
            view_material_list.isHidden = false
            view_supplier_list.isHidden = true
            
            view_Material_name.isHidden = true
            view_Storage_Area.isHidden  = true
            view_supply_date_to_site.isHidden = true
            lbl_Material_Description.text = "Supplier Notes"
            view_SQRsupplier_list.isHidden = false
            get_bill_quantities()
            get_material_lists()
            
            
        }
        
        self.navigationController?.interactivePopGestureRecognizer?.delegate = nil
        self.navigationController?.interactivePopGestureRecognizer?.isEnabled = true
        
        txt_Material_Description.delegate = self
        
        
        self.tf_supplier_list.delegate = self
        self.tf_material_list.delegate = self
        
        self.tf_material_list.placeholder =  "txt_material_list".localized()
        self.tf_supplier_list.placeholder =  "txt_supplier_list".localized()
        self.tf_Storage_Area.placeholder = "txt_Storage_Area".localized()
        self.tf_supply_date_to_site.placeholder = "YYYY/MM/DD"
    
        
       
        tf_Material_name.placeholder = "Material name".localized()
        tf_Item_in_bill_quantity.placeholder = "Item in bill quantity".localized()
        
        
        tf_SQRsupplier_list.placeholder = "lang_supplier_list ".localized()
//        txt_Material_Description.text = "Material Description".localized()
        txt_Material_Description.textAlignment = .center
        txt_Material_Description.font = .kufiRegularFont(ofSize: 15)
        txt_Material_Description.textColor = "#585858".getUIColor()
        txt_Material_Description.setBorderGray()
        //self.tf_Storage_Area.setBorderGray()
        
        self.viewStep.backgroundColor = HelperClassSwift.acolor.getUIColor()
        self.lblStep.text = "txt_Requirements".localized()
        self.lblStep.font = .kufiRegularFont(ofSize: 15)
        self.lblStep.textColor = "#616263".getUIColor()
        
        self.viewStep.setBorderGrayWidth(3)
        self.Viewcollection_material.isHidden = true
        self.Viewcollection_supplier.isHidden = true
        
        let Stepimage =  UIImage.fontAwesomeIcon(name: .building, style: .solid, textColor: HelperClassSwift.bcolor.getUIColor(), size: CGSize(width: 40, height: 40))
        self.imgStep.image = Stepimage
        
        
        tf_material_list.attributedPlaceholder = NSAttributedString(string:  "txt_material_list".localized(), attributes: [
            .foregroundColor: "#AAAAAA".getUIColor(),
            .font: UIFont(name: "DroidArabicKufi", size: 14)!
        ])
        
        tf_supplier_list.attributedPlaceholder = NSAttributedString(string: "txt_supplier_list".localized(), attributes: [
            .foregroundColor: "#AAAAAA".getUIColor(),
            .font: UIFont(name: "DroidArabicKufi", size: 14)!
        ])
        
        tf_Storage_Area.attributedPlaceholder = NSAttributedString(string: "Storge Area".localized(), attributes: [
            .foregroundColor: "#AAAAAA".getUIColor(),
            .font: UIFont(name: "DroidArabicKufi", size: 14)!
        ])
        
        
        if L102Language.currentAppleLanguage() == "en" {
        
            self.tf_material_list.textAlignment = .left
            self.tf_supplier_list.textAlignment = .left
            self.tf_Storage_Area.textAlignment = .left
            self.tf_supply_date_to_site.textAlignment = .left
           
        }
        

        dropDown.anchorView = view
        dropDown.backgroundColor = .white
        dropDown.cornerRadius = 2.0
        
        self.btnNext.setTitle("Next".localized(), for: .normal)
        self.btnPrevious.setTitle("Previous".localized(), for: .normal)
        
        if L102Language.currentAppleLanguage() == "ar" {
            self.btnNext.setImage(UIImage(systemName: "arrow.left"), for: .normal)
            self.btnPrevious.setImage(UIImage(systemName: "arrow.right"), for: .normal)
        }
         
    }
    
    func createDatePicker(){
        
        let toolbar = UIToolbar()
        toolbar.sizeToFit()
        
        let doneBtn = UIBarButtonItem(barButtonSystemItem: .done, target: nil, action: #selector(donePressed))
        toolbar.setItems([doneBtn], animated: true)
        tf_supply_date_to_site.inputAccessoryView = toolbar
        
        tf_supply_date_to_site.inputView = datePicker
    }
    
   @objc func donePressed(){
        
       tf_supply_date_to_site.text = "\(datePicker.date)"
       self.view.endEditing(true)
    }
    
    
    func get_supplier_list(){

 //  material_suppliers?lang_key=en&projects_work_area_id=1&platform_code_system=1.MIR.1.1&page_no=1&page_size=10&template_id=2&request=SUPPLIER
        
        self.params["request"] = "SUPPLIER"
        
        self.showLoadingActivity()
        APIController.shard.sendRequestGetAuth(urlString: "form/FORM_\(ProjectObj.template_platform_group_type_code_system)/material_suppliers?lang_key=en&projects_work_area_id=\(ProjectObj.projects_work_area_id)&platform_code_system=1\(ProjectObj.template_platform_code_system)&page_no=1&page_size=10&template_id=\(ProjectObj.template_id)&request=SUPPLIER" ) { (response) in
            
            let status = response["status"] as? Bool
            if status == true{
                if  let list = response["records"] as? NSArray{
                    for i in list {
                        let dict = i as? [String:Any]
                        let obj = SupplierObj.init(dict!)
                        self.arr_supplier.append(obj)
                        self.arr_lblsupplier.append(obj.label)
                        
                    }
                    self.collection_supplier.reloadData()
                    self.hideLoadingActivity()
                }
            }else {
                self.hideLoadingActivity()
            }
            
            
        }
    }
    
    func get_material_list(){

     self.params["request"] = "MATERIAL"
        
        self.showLoadingActivity()
        APIController.shard.sendRequestGetAuth(urlString: "form/FORM_\(ProjectObj.template_platform_group_type_code_system)/material_suppliers?lang_key=en&projects_work_area_id=\(ProjectObj.projects_work_area_id)&platform_code_system=1\(ProjectObj.template_platform_code_system)&page_no=1&page_size=10&template_id=\(ProjectObj.template_id)&request=MATERIAL" ) { (response) in
            
            let status = response["status"] as? Bool
            if status == true{
                if  let list = response["records"] as? NSArray{
                    for i in list {
                        let dict = i as? [String:Any]
                        let obj = SupplierObj.init(dict!)
                        self.arr_material.append(obj)
                        self.arr_lblmaterial.append(obj.label)
                        
                    }
                    self.collection_material.reloadData()
                    self.hideLoadingActivity()
                }
            }else {
                self.hideLoadingActivity()
            }
            
            
        }
    }
    
    func get_bill_quantities(){

     self.params["list_type"] = "get_bill_quantites"
        
        self.showLoadingActivity()
        APIController.shard.sendRequestGetAuth(urlString: "form/FORM_\(ProjectObj.template_platform_group_type_code_system)/bill_quantities_material_suppliers?lang_key=en&projects_work_area_id=\(ProjectObj.projects_work_area_id)&platform_code_system=1\(ProjectObj.template_platform_code_system)&page_no=1&page_size=10&template_id=\(ProjectObj.template_id)&list_type=get_bill_quantites" ) { (response) in
            
            let status = response["status"] as? Bool
            if status == true{
                if  let list = response["records"] as? NSArray{
                    for i in list {
                        let dict = i as? [String:Any]
                        let obj = SupplierObj.init(dict!)
                        self.arr_Item_quantity.append(obj)
                        self.arr_lblItem_quantity.append(obj.label)
                        
                    }
                    self.collection_material.reloadData()
                    self.hideLoadingActivity()
                }
            }else {
                self.hideLoadingActivity()
            }
            
            
        }
    }
    
    func get_material_lists(){

     self.params["list_type"] = "material_lists"
        
        self.showLoadingActivity()
        APIController.shard.sendRequestGetAuth(urlString: "form/FORM_\(ProjectObj.template_platform_group_type_code_system)/bill_quantities_material_suppliers?lang_key=en&projects_work_area_id=\(ProjectObj.projects_work_area_id)&platform_code_system=1\(ProjectObj.template_platform_code_system)&page_no=1&page_size=10&template_id=\(ProjectObj.template_id)&list_type=material_lists" ) { (response) in
            
            let status = response["status"] as? Bool
            if status == true{
                if  let list = response["records"] as? NSArray{
                    for i in list {
                        let dict = i as? [String:Any]
                        let obj = SupplierObj.init(dict!)
                        self.arr_material.append(obj)
                        self.arr_lblmaterial.append(obj.label)
                        
                    }
                    self.hideLoadingActivity()
                }
            }else {
                self.hideLoadingActivity()
            }
            
            
        }
    }
    
    
    
    func get_bill__suppliers(search_key:String){

        var param :[String:Any] = [:]
        param["lang_key"] = "en"
        param["search_key"] = search_key
        param["list_type"] = "supplier_lists"
        
        self.showLoadingActivity()
        APIController.shard.sendRequestGetAuth(urlString: "form/FORM_\(ProjectObj.template_platform_group_type_code_system)/bill_quantities_material_suppliers?lang_key=en&list_type=supplier_lists&search_key=\(search_key)" ) { (response) in
            
            let status = response["status"] as? Bool
            if status == true{
                if  let list = response["records"] as? NSArray{
                    for i in list {
                        let dict = i as? [String:Any]
                        let obj = SupplierObj.init(dict!)
                        self.arr_SQRsupplier.append(obj)
                        self.arr_lblSQRsupplier.append(obj.label)
                        self.drop_SQR_SupplierList()
                        
                    }
                    self.hideLoadingActivity()
                }
            }else {
                self.hideLoadingActivity()
            }
            
            
        }
    }

    
    
    func get_Item_in_bill_quantity(){
  
        
        self.showLoadingActivity()
        APIController.shard.sendRequestGetAuth(urlString: "form/FORM_\(ProjectObj.template_platform_group_type_code_system)/bill_quantities?lang_key=en&projects_work_area_id=\(ProjectObj.projects_work_area_id)&platform_code_system=1\(ProjectObj.template_platform_code_system)&page_no=1&page_size=10&template_id=\(ProjectObj.template_id)&request=MATERIAL" ) { (response) in
            
            let status = response["status"] as? Bool
            if status == true{
                if  let list = response["records"] as? NSArray{
                    for i in list {
                        let dict = i as? [String:Any]
                        let obj = SupplierObj.init(dict!)
                        self.arr_Item_quantity.append(obj)
                        self.arr_lblItem_quantity.append(obj.label)
                        
                    }
                    self.hideLoadingActivity()
                }
            }else {
                self.hideLoadingActivity()
            }
            
            
        }
    }
    
    func drop_supplier_list(){
        
       // self.imgDropSupplier.image = dropUpmage
        
        
            if self.arr_supplier.count == 0 {
                dropDown.dataSource = self.arr_NoData
                dropDown.selectionAction = { [unowned self] (index: Int, item: String) in
                    //self.imgDropSupplier.image = dropDownmage
                }
                dropDown.textColor = #colorLiteral(red: 0.8039215803, green: 0.8039215803, blue: 0.8039215803, alpha: 1)
            }else{
                dropDown.dataSource = self.arr_lblsupplier
                dropDown.selectionAction = { [unowned self] (index: Int, item: String) in
                    
                    if item == self.arr_lblsupplier[index] {
                        let object =  self.arr_supplier[index]
                        if arr_Selectedsupplier.contains(item) == false{
                            self.arr_Selectedsupplier.append(item)
                            self.arr_ObjectSelectedsupplier.append(object)
                        }
                        self.Viewcollection_supplier.isHidden = false
                        self.collection_supplier.reloadData()
                        
                    }
                    
                }

            }
            dropDown.direction = .bottom
            dropDown.anchorView = view_supplier_list
            dropDown.bottomOffset = CGPoint(x: 0, y: view_supplier_list.bounds.height)
            dropDown.width = view_supplier_list.bounds.width
            dropDown.show()
     
    }
    
    
    
    func drop_material_list(){
        
        
        
            if self.arr_material.count == 0 {
                dropDown.dataSource = self.arr_NoData
                dropDown.selectionAction = { [unowned self] (index: Int, item: String) in
                   // self.imgDropMaterial.image = dropDownmage
                }
                dropDown.textColor = #colorLiteral(red: 0.8039215803, green: 0.8039215803, blue: 0.8039215803, alpha: 1)
            }else{
                dropDown.dataSource = self.arr_lblmaterial
                dropDown.selectionAction = { [unowned self] (index: Int, item: String) in
                    
                    if item == self.arr_lblmaterial[index] {
                        let object =  self.arr_material[index]
                        
                        let code = ProjectObj.template_platform_group_type_code_system
                        
                        if code == "SQR" {
                            self.tf_material_list.text = item
                            self.material_code = object.value
                            self.transaction_request_id = object.transaction_request_id
                        }else{
                            
                            if arr_Selectedmaterial.contains(item) == false{
                                self.arr_Selectedmaterial.append(item)
                                self.arr_ObjectSelectedmaterial.append(object)
                            }
                           
                           // self.imgDropMaterial.image = dropDownmage
                            self.Viewcollection_material.isHidden = false
                            self.collection_material.reloadData()
                            
                        }
                     
                    }
                    
                }

            }
            dropDown.direction = .bottom
            dropDown.anchorView = view_material_list
            dropDown.bottomOffset = CGPoint(x: 0, y: view_material_list.bounds.height)
            dropDown.width = view_material_list.bounds.width
            dropDown.show()
     
    }
    
    
    func drop_Item_in_bill_quantity(){
        
            if self.arr_Item_quantity.count == 0 {
                dropDown.dataSource = self.arr_NoData
                dropDown.selectionAction = { [unowned self] (index: Int, item: String) in
                   // self.imgDropMaterial.image = dropDownmage
                }
                dropDown.textColor = #colorLiteral(red: 0.8039215803, green: 0.8039215803, blue: 0.8039215803, alpha: 1)
            }else{
                
                dropDown.textColor = #colorLiteral(red: 0.1878142953, green: 0.1878142953, blue: 0.1878142953, alpha: 1)
                dropDown.dataSource = self.arr_lblItem_quantity
                dropDown.selectionAction = { [unowned self] (index: Int, item: String) in
                    
                    if item == self.arr_lblItem_quantity[index] {
                        self.tf_Item_in_bill_quantity.text =  item
                        let object =  self.arr_Item_quantity[index]
                      
                        self.related_bill_quanties = object.value
                    }
                    
                }

            }
            dropDown.direction = .bottom
            dropDown.anchorView = view_Item_in_bill_quantity
            dropDown.bottomOffset = CGPoint(x: 0, y: view_Item_in_bill_quantity.bounds.height)
            dropDown.width = view_Item_in_bill_quantity.bounds.width
            dropDown.show()
     
    }
    
    
    func drop_SQR_SupplierList(){
        
            if self.arr_SQRsupplier.count == 0 {
                dropDown.dataSource = self.arr_NoData
                dropDown.selectionAction = { [unowned self] (index: Int, item: String) in
                   // self.imgDropMaterial.image = dropDownmage
                }
                dropDown.textColor = #colorLiteral(red: 0.8039215803, green: 0.8039215803, blue: 0.8039215803, alpha: 1)
            }else{
                
                dropDown.textColor = #colorLiteral(red: 0.1878142953, green: 0.1878142953, blue: 0.1878142953, alpha: 1)
                dropDown.dataSource = self.arr_lblSQRsupplier
                dropDown.selectionAction = { [unowned self] (index: Int, item: String) in
                    
                    if item == self.arr_lblSQRsupplier[index] {
                        self.tf_SQRsupplier_list.text =  item
                        let object =  self.arr_Item_quantity[index]
                        self.supplier_id = object.value
                        self.related_bill_quanties = object.value
                    }
                    
                }

            }
            dropDown.direction = .bottom
            dropDown.anchorView = view_SQRsupplier_list
            dropDown.bottomOffset = CGPoint(x: 0, y: view_SQRsupplier_list.bounds.height)
            dropDown.width = view_SQRsupplier_list.bounds.width
            dropDown.show()
     
    }
    
    func Send_Request(){
        
        
            self.showLoadingActivity()
      
        APIController.shard.sendRequestPostAuth(urlString: "form/FORM_\(ProjectObj.template_platform_group_type_code_system)/cr/2/0", parameters: self.params ) { (response) in
            
            self.hideLoadingActivity()
           
      
            let status = response["status"] as? Bool
            let error = response["error"] as? String
            
            if status == true{
                
                self.hideLoadingActivity()
                
                let VC:AttachmentsVC = AppDelegate.mainSB.instanceVC()
                VC.ProjectObj = self.ProjectObj
                VC.parm = self.params
                self.navigationController?.pushViewController(VC, animated: true)
                

            }else{
                self.hideLoadingActivity()
                self.showAMessage(withTitle: "error", message: error ?? "sorry ,some thing went wrong")
            }

            
           
            }
        }

    
    
    @IBAction func btnMAterial_Click(_ sender: Any) {
 
        self.drop_material_list()
        
    }
    
    @IBAction func btnSupplier_Click(_ sender: Any) {
 
        self.drop_supplier_list()
        
    }
    
    @IBAction func btnSQRSupplier_Click(_ sender: Any) {
 
        self.drop_SQR_SupplierList()
        
    }
    
    @IBAction func btnDropItemQiantity_Click(_ sender: Any) {
 
        self.drop_Item_in_bill_quantity()
        
    }
    
    @IBAction func btnNext_Click(_ sender: Any) {
 
        let code = ProjectObj.template_platform_group_type_code_system
        
        if code == "MSR" {
            
            guard tf_Material_name.text != "" else {
                return self.showAMessage(withTitle: "", message: "Material Name Field Required!")
            }
            
            guard tf_Item_in_bill_quantity.text != "" else {
                return self.showAMessage(withTitle: "", message: "Item in bill quantity Field Required!")
            }
            guard txt_Material_Description.text != "" else {
                return self.showAMessage(withTitle: "", message: "Material Description Field Required!")
            }
            
            self.params["material_notes"] = self.txt_Material_Description.text
           
            self.params["related_bill_quanties"] = self.related_bill_quanties
            self.params["material_name"] = self.tf_Material_name.text
            
            
        }else if code == "SQR"{
            
            self.params["supplier_notes"] = self.txt_Material_Description.text
            self.params["related_bill_quanties"] = self.related_bill_quanties
            self.params["material_code"] = self.material_code
            
            self.params["supplier_id"] = self.supplier_id
           
            self.params["material_code_transaction_request_id"] = self.transaction_request_id
            
            
            guard tf_Item_in_bill_quantity.text != "" else {
                return self.showAMessage(withTitle: "", message: "Item in bill quantity Field Required!")
            }
            guard tf_material_list.text != "" else {
                return self.showAMessage(withTitle: "", message: "supply list Field Required!")
            }
            
            guard tf_SQRsupplier_list.text != "" else {
                return self.showAMessage(withTitle: "", message: "supply list Field Required!")
            }
            
            guard txt_Material_Description.text != "" else {
                return self.showAMessage(withTitle: "", message: "Material Description Field Required!")
            }
            
          
            
            
            
        }else{
         
            guard tf_Storage_Area.text != "" else {
                return self.showAMessage(withTitle: "", message: "Storge Area Field Required!")
            }
            guard tf_supply_date_to_site.text != "" else {
                return self.showAMessage(withTitle: "", message: "supply date Field Required!")
            }
            
            guard txt_Material_Description.text != "" else {
                return self.showAMessage(withTitle: "", message: "Material Description Field Required!")
            }
            
            guard self.arr_Selectedmaterial != [] else {
                return self.showAMessage(withTitle: "", message: "material list Field Required!")
            }
            
            guard self.arr_Selectedsupplier != [] else {
                return self.showAMessage(withTitle: "", message: "supplier list Field Required!")
            }
            
            for i in arr_ObjectSelectedmaterial{
                self.params["material_code"] = i.value
                self.params["material_code_transaction_request_id"] = i.transaction_request_id
            }
            
            for i in arr_ObjectSelectedsupplier{
                self.params["supplier_code"] = i.value
                self.params["supplier_code_transaction_request_id"] = i.transaction_request_id
            }
            
            self.params["material_notes"] = self.txt_Material_Description.text
           
            self.params["storage_area"] = self.tf_Storage_Area.text
            self.params["supply_date_to_site"] = self.tf_supply_date_to_site.text
            
        }
       
        
        let VC:AttachmentsVC = AppDelegate.mainSB.instanceVC()
        VC.ProjectObj = self.ProjectObj
        VC.parm = self.params
        self.navigationController?.pushViewController(VC, animated: true)
    
        
    }
    
    @IBAction func btnBack_Click(_ sender: Any) {
        
        self.navigationController?.popViewController(animated: true)
    }
    
    

}


extension RequirementsVC: UICollectionViewDataSource ,UICollectionViewDelegate , UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        switch collectionView {
        case collection_material:
            return arr_Selectedmaterial.count
        case collection_supplier:
            return arr_Selectedsupplier.count
        default:
            return 0
        }
       
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell1 = collectionView.dequeueReusableCell(withReuseIdentifier: "unitCVCell", for: indexPath) as! unitCVCell
        
        
        switch collectionView {
        case collection_material:
            cell1.lblTitle.text = arr_Selectedmaterial[indexPath.row]
            cell1.viewBack.setBorderWithColor("458FB8".getUIColor())
            cell1.lblTitle.font = .kufiRegularFont(ofSize: 13)
            
            cell1.btnDeleteAction = {
              
                self.arr_Selectedmaterial.remove(at: indexPath.item)
                self.collection_material.reloadData()
                if self.arr_Selectedmaterial.count == 0 {
                    self.Viewcollection_material.isHidden = true
                }
                
            }
            
            return cell1
        case collection_supplier:
            let object = arr_Selectedsupplier[indexPath.row]
            cell1.lblTitle.text = object
            cell1.lblTitle.font = .kufiRegularFont(ofSize: 13)
            cell1.viewBack.setBorderWithColor("458FB8".getUIColor())
            
            cell1.btnDeleteAction = {
              
                self.arr_Selectedsupplier.remove(at: indexPath.item)
                self.collection_supplier.reloadData()
                
                if self.arr_Selectedsupplier.count == 0 {
                    self.Viewcollection_supplier.isHidden = true
                }
            }
            
           
            
            return cell1
        default:
            return UICollectionViewCell()
        }
    }
    
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
       // cell.view_img.backgroundColor = HelperClassSwift.acolor.getUIColor()
        
    }
}




extension RequirementsVC: UITextViewDelegate {
    
    
    func textViewDidBeginEditing(_ textView: UITextView) {
       
        if txt_Material_Description.textColor == "585858".getUIColor() {
            txt_Material_Description.text = ""
            txt_Material_Description.textColor = "585858".getUIColor()
            txt_Material_Description.textAlignment = .center
            txt_Material_Description.font = UIFont(name: "DroidArabicKufi", size: 14)
        }
    }
    
    func textViewDidEndEditing(_ textView: UITextView) {
        
        if txt_Material_Description.text == "" {
            
            txt_Material_Description.text = "txt_Put_your_idea".localized()
            txt_Material_Description.textAlignment = .center
            txt_Material_Description.font = UIFont(name: "DroidArabicKufi", size: 14)
            txt_Material_Description.textColor = "#AAAAAA".getUIColor()
        }
    }
    
    
}



extension RequirementsVC : UITextFieldDelegate{
    
    
    func textFieldShouldBeginEditing(_ textField: UITextField) -> Bool {
        if textField == tf_material_list {
            self.view_material_list.setBorderWithColor("2D7FC1".getUIColor())
            self.drop_material_list()

        }else if  textField == tf_supplier_list {
            self.view_supplier_list.setBorderWithColor("2D7FC1".getUIColor())
            self.drop_supplier_list()
        }
        return true
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        
        if textField == tf_supplier_list {
            if tf_supplier_list.text == "" {
               // self.view_supplier_list.setBorderWithColor("CE0755".getUIColor())
                self.view_supplier_list.setBorderWithColor(.clear)
                
            }else{
                self.view_supplier_list.setBorderGrayWidthCorner(1, 20)
                get_supplier_list()
            }
            
        }else  if textField == tf_material_list  {
            
            if tf_material_list.text == "" {
                //self.view_material_list.setBorderWithColor("CE0755".getUIColor())
                self.view_material_list.setBorderWithColor(.clear)
                
            }else{
                self.view_material_list.setBorderGrayWidthCorner(1, 20)
                get_supplier_list()
            }
            
        }else if textField == tf_SQRsupplier_list{
            
            if tf_SQRsupplier_list.text == "" {
                self.view_SQRsupplier_list.setBorderWithColor(.clear)
                
            }else{
                //self.view_SQRsupplier_list.setBorderGrayWidthCorner(1, 20)
                self.get_bill__suppliers(search_key: tf_SQRsupplier_list.text!)
            }
            
        }
        
        
    }
}


