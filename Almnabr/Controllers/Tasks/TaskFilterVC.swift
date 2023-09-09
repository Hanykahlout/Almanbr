//
//  TaskFilterVC.swift
//  Almnabr
//
//  Created by MacBook on 20/04/2022.
//  Copyright © 2022 Samar Akkila. All rights reserved.
//

import UIKit
import DropDown

class TaskFilterVC: UIViewController {

    @IBOutlet weak var lblAdvancedFilter: UILabel!
    @IBOutlet weak var tfTicketNumber: UITextField!
   
    @IBOutlet weak var lblUsers: UILabel!
    @IBOutlet weak var imgUsers: UIImageView!
    @IBOutlet weak var lblStatus: UILabel!
    @IBOutlet weak var imgStatus: UIImageView!
    @IBOutlet weak var lblPriority: UILabel!
    @IBOutlet weak var imgPriority: UIImageView!
    @IBOutlet weak var lblType: UILabel!
    @IBOutlet weak var imgType: UIImageView!
    @IBOutlet weak var lblSignature: UILabel!
    @IBOutlet weak var imgSignature: UIImageView!
    @IBOutlet weak var lblModule: UILabel!
    @IBOutlet weak var imgModule: UIImageView!
    @IBOutlet weak var lblStartDate: UILabel!
    @IBOutlet weak var lblEndDate: UILabel!
    @IBOutlet weak var tflinkIssue: UITextField!
    @IBOutlet weak var btnSubmit: UIButton!
    @IBOutlet weak var tfUser: UITextField!
    @IBOutlet var view_users: UIView!
    @IBOutlet var Viewcollection_user: UIView!
    @IBOutlet var collection_user: UICollectionView!
    @IBOutlet weak var tfStartDate: UITextField!
    @IBOutlet weak var tfEndDate: UITextField!
    
    var arr_important:[importantObj] = []
    var arr_ticket_type:[importantObj] = []
    var arr_modules:[modulesObj] = []
    var arr_sig_id:[importantObj] = []
    var arr_ticket_status:[importantObj] = []
    
    var arr_NoData:[String] = ["No items found".localized()]
    var arr_user :[SupplierObj] = []
    var arr_selected_user :[SupplierObj] = []
    var arr_lbluser :[String] = []
    var params = [:] as [String : Any]
    
    var delegate : ((_ param:[String:Any]) -> Void)?
    
    
    let dropUpmage =  UIImage.fontAwesomeIcon(name: .chevronUp , style: .solid, textColor:  .gray, size: CGSize(width: 40, height: 40))
    let dropDownmage =  UIImage.fontAwesomeIcon(name: .chevronDown , style: .solid, textColor:  .gray, size: CGSize(width: 40, height: 40))
    let datePicker = UIDatePicker()
    
    var ticket_type:String = ""
    var important_id:String = ""
    var sig_id:String = ""
    var need_reply:String = ""
    var ticket_status:String = ""
    var ref_model:String = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configNavigation()
        configGUI()
        get_data()
        createStartDatePicker()
        createEndDatePicker()
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
       addNavigationBarTitle(navigationTitle: "Advanced Filter".localized())
        UINavigationBar.appearance().backgroundColor = maincolor
    }
    
    
    
    //MARK: - Config GUI
    //------------------------------------------------------
    func configGUI() {
        
        self.lblAdvancedFilter.font = .kufiRegularFont(ofSize: 15)
        self.lblAdvancedFilter.text = "Advanced Filter".localized()
        
        self.tfTicketNumber.placeholder = "Ticket Number".localized()
        
        self.imgPriority.image = dropDownmage
        self.lblPriority.font = .kufiRegularFont(ofSize: 15)
        self.lblPriority.text = "Priority".localized()
        
        self.imgStatus.image = dropDownmage
        self.lblStatus.font = .kufiRegularFont(ofSize: 15)
        self.lblStatus.text = "Status".localized()
        
        self.imgType.image = dropDownmage
        self.lblType.font = .kufiRegularFont(ofSize: 15)
        self.lblType.text = "Type".localized()
        
        self.imgSignature.image = dropDownmage
        self.lblSignature.font = .kufiRegularFont(ofSize: 15)
        self.lblSignature.text = "Signature".localized()
        
        self.imgModule.image = dropDownmage
        self.lblModule.font = .kufiRegularFont(ofSize: 15)
        self.lblModule.text = "Module".localized()
        
        self.imgUsers.image = dropDownmage
//        self.lblUsers.font = .kufiRegularFont(ofSize: 15)
//        self.lblUsers.text = "Users".localized()
        
        self.tfUser.placeholder = "Users".localized()
        self.tfUser.font = .kufiRegularFont(ofSize: 15)
        
        self.tflinkIssue.placeholder = "link Issue".localized()
        
//        self.lblStartDate.font = .kufiRegularFont(ofSize: 15)
//        self.lblStartDate.text = "Start Date".localized()
//
//        self.lblEndDate.font = .kufiRegularFont(ofSize: 15)
//        self.lblEndDate.text = "End Date".localized()
        
        self.tfUser.delegate = self
        self.tfStartDate.font = .kufiRegularFont(ofSize: 15)
        self.tfEndDate.font = .kufiRegularFont(ofSize: 15)

    }

    func get_data(){
        
        self.showLoadingActivity()
        
        
        APIController.shard.sendRequestPostAuth(urlString: "tasks/get_add", parameters: [:] ) { (response) in
            self.hideLoadingActivity()
            
           
            let status = response["status"] as? Bool
           
            if status == true{
                
                if let data = response["data"] as? [String:Any] {
              
                
                if  let important = data["important"] as? NSArray{
                    for i in important {
                        let dict = i as? [String:Any]
                        let obj = importantObj.init(dict!)
                        self.arr_important.append(obj)
                    } }
                
                if  let modules = data["modules"] as? NSArray{
                    for i in modules {
                        let dict = i as? [String:Any]
                        let obj = modulesObj.init(dict!)
                        self.arr_modules.append(obj)
                    } }
                
                if  let sig_id = data["sig_id"] as? NSArray{
                    for i in sig_id {
                        let dict = i as? [String:Any]
                        let obj = importantObj.init(dict!)
                        self.arr_sig_id.append(obj)
                    } }
                
                if  let ticket_status = data["ticket_status"] as? NSArray{
                    for i in ticket_status {
                        let dict = i as? [String:Any]
                        let obj = importantObj.init(dict!)
                        self.arr_ticket_status.append(obj)
                    } }
                
                if  let ticket_type = data["ticket_type"] as? NSArray{
                    for i in ticket_type {
                        let dict = i as? [String:Any]
                        let obj = importantObj.init(dict!)
                        self.arr_ticket_type.append(obj)
                    } }
            }
            }else{
                self.hideLoadingActivity()
            }
            
            
        }
    }
    
    
    func get_user(search_key:String){

        var param :[String:Any] = [:]
        self.showLoadingActivity()
        APIController.shard.sendRequestGetAuth(urlString: "tc/getformuserslist?search=\(search_key)&lang_key=en&user_type_id=\(Auth_User.user_type_id)" ) { (response) in
            
            let status = response["status"] as? Bool
            if status == true{
                self.arr_user = []
                self.arr_lbluser = []
                if  let list = response["list"] as? NSArray{
                    for i in list {
                        let dict = i as? [String:Any]
                        let obj = SupplierObj.init(dict!)
                        self.arr_user.append(obj)
                        self.arr_lbluser.append(obj.label)
                        self.drop_userList()
                        
                    }
                    self.hideLoadingActivity()
                }
            }else {
                self.hideLoadingActivity()
            }
            
            
        }
    }

    
    func drop_userList(){
        let dropDown = DropDown()
        
            if self.arr_user.count == 0 {
                dropDown.dataSource = self.arr_NoData
                dropDown.selectionAction = { [unowned self] (index: Int, item: String) in
                   // self.imgDropMaterial.image = dropDownmage
                }
                dropDown.textColor = #colorLiteral(red: 0.8039215803, green: 0.8039215803, blue: 0.8039215803, alpha: 1)
            }else{
                
                dropDown.textColor = #colorLiteral(red: 0.1878142953, green: 0.1878142953, blue: 0.1878142953, alpha: 1)
                dropDown.dataSource = self.arr_lbluser
                dropDown.selectionAction = { [unowned self] (index: Int, item: String) in
                    
                    if item == self.arr_lbluser[index] {
                        let object =  self.arr_user[index]
                        self.arr_selected_user.append(object)
                        self.Viewcollection_user.isHidden = false
                        self.collection_user.reloadData()
                    }
                    
                }

            }
            dropDown.direction = .bottom
            dropDown.anchorView = view_users
            dropDown.bottomOffset = CGPoint(x: 0, y: view_users.bounds.height)
            dropDown.width = view_users.bounds.width
            dropDown.show()
     
    }
   
    func createStartDatePicker(){
          
          let toolbar = UIToolbar()
          toolbar.sizeToFit()
        datePicker.datePickerMode = .date
          let doneBtn = UIBarButtonItem(barButtonSystemItem: .done, target: nil, action: #selector(doneStartPressed))
          toolbar.setItems([doneBtn], animated: true)
        toolbar.backgroundColor = .white
        tfStartDate.inputAccessoryView = toolbar
        tfStartDate.inputView = datePicker
      }
    
    
    @objc func doneStartPressed(){
         
        tfStartDate.text = "\(datePicker.date.asStringyyyMMdd())"
        self.view.endEditing(true)
        
        
     }
    
    func createEndDatePicker(){
          
          let toolbar = UIToolbar()
          toolbar.sizeToFit()
        datePicker.datePickerMode = .date
          let doneBtn = UIBarButtonItem(barButtonSystemItem: .done, target: nil, action: #selector(doneEndtPressed))
          toolbar.setItems([doneBtn], animated: true)
        toolbar.backgroundColor = .white
        tfEndDate.inputAccessoryView = toolbar
        tfEndDate.inputView = datePicker
      }
    
    
    @objc func doneEndtPressed(){
         
        tfEndDate.text = "\(datePicker.date.asStringyyyMMdd())"
        self.view.endEditing(true)
        
        
     }
    
    
    
    @IBAction func btnPriority_Click(_ sender: Any) {
        let vc :PickerVC = AppDelegate.mainSB.instanceVC()
        vc.arr_data =  arr_important.map({"\($0.name)"})
        vc.isModalInPresentation = true
        vc.modalPresentationStyle = .overFullScreen
        vc.definesPresentationContext = true
        vc.delegate = {name , index in
            self.lblPriority.text = name
            self.important_id = self.arr_important[index].id
        }
        self.present(vc, animated: true, completion: nil)
    }
    
    
    @IBAction func btnType_Click(_ sender: Any) {
        let vc :PickerVC = AppDelegate.mainSB.instanceVC()
        vc.arr_data =  arr_ticket_type.map({"\($0.name)"})
        vc.isModalInPresentation = true
        vc.modalPresentationStyle = .overFullScreen
        vc.definesPresentationContext = true
        vc.delegate = {name , index in
            self.lblType.text = name
            self.ticket_type = self.arr_ticket_type[index].id
        }
        self.present(vc, animated: true, completion: nil)
    }
    
    @IBAction func btnSignature_Click(_ sender: Any) {
        let vc :PickerVC = AppDelegate.mainSB.instanceVC()
        vc.arr_data =  arr_sig_id.map({"\($0.name)"})
        vc.isModalInPresentation = true
        vc.modalPresentationStyle = .overFullScreen
        vc.definesPresentationContext = true
        vc.delegate = {name , index in
            self.lblSignature.text = name
            self.sig_id = self.arr_sig_id[index].id
        }
        self.present(vc, animated: true, completion: nil)
    }
    
    
    @IBAction func btnStatus_Click(_ sender: Any) {
        let vc :PickerVC = AppDelegate.mainSB.instanceVC()
        vc.arr_data =  arr_ticket_status.map({"\($0.name)"})
        vc.isModalInPresentation = true
        vc.modalPresentationStyle = .overFullScreen
        vc.definesPresentationContext = true
        vc.delegate = {name , index in
            self.lblStatus.text = name
            self.ticket_status = self.arr_ticket_status[index].id
        }
        self.present(vc, animated: true, completion: nil)
    }
    
    @IBAction func btnModule_Click(_ sender: Any) {
        let vc :PickerVC = AppDelegate.mainSB.instanceVC()
        vc.arr_data =  arr_modules.map({"\($0.module_key)"})
        vc.isModalInPresentation = true
        vc.modalPresentationStyle = .overFullScreen
        vc.definesPresentationContext = true
        vc.delegate = {name , index in
            self.lblSignature.text = name
            self.ref_model = self.arr_modules[index].module_key
        }
        self.present(vc, animated: true, completion: nil)
    }
    
    @IBAction func btnSubmit_Click(_ sender: Any) {
        
        self.params["ticket_no"] = self.tfTicketNumber.text ?? ""
        self.params["link_issue"] = self.tflinkIssue.text ?? ""
        self.params["ticket_type"] = self.ticket_type
        self.params["users"] = ""
        self.params["ticket_status"] = self.ticket_status
        self.params["important_id"] = self.important_id
        self.params["sig_id"] = self.sig_id
        self.params["start_date"] = self.tfStartDate.text ?? ""
        self.params["end_date"] = self.tfEndDate.text ?? ""
        self.params["ref_model"] = self.ref_model
        
        delegate!(self.params)
        self.navigationController?.popViewController(animated: true)
        
        
    }
    
  
}


extension TaskFilterVC: UICollectionViewDataSource ,UICollectionViewDelegate , UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
      
            return arr_selected_user.count
       
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "unitCVCell", for: indexPath) as! unitCVCell
        
            let arr = arr_selected_user.map({"\($0.label)"})
            cell.lblTitle.text = arr[indexPath.row]
            cell.viewBack.setBorderWithColor("458FB8".getUIColor())
            cell.lblTitle.font = .kufiRegularFont(ofSize: 13)
            
            cell.btnDeleteAction = {
              
                self.arr_selected_user.remove(at: indexPath.item)
                self.collection_user.reloadData()
                if self.arr_user.count == 0 {
                    self.Viewcollection_user.isHidden = true
                }
                
            }
            
            return cell
      
    }
    
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
       // cell.view_img.backgroundColor = HelperClassSwift.acolor.getUIColor()
        
    }
}



extension TaskFilterVC : UITextFieldDelegate{
    
    
    func textFieldShouldBeginEditing(_ textField: UITextField) -> Bool {
        if textField == tfUser {
            self.view_users.setBorderWithColor("2D7FC1".getUIColor())
     
        }
        return true
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        
            if textField == tfUser {
                if tfUser.text == "" {
                    self.view_users.setBorderWithColor(.clear)
                    
                }else{
                   
                    get_user(search_key: tfUser.text!)
                }
            }
        
    }
}

