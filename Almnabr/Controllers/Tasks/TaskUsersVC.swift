//
//  TaskUsersVC.swift
//  Almnabr
//
//  Created by MacBook on 11/05/2022.
//  Copyright © 2022 Samar Akkila. All rights reserved.
//

import UIKit
import DropDown

class TaskUsersVC: UIViewController {
    
   
    @IBOutlet weak var lblUsers: UILabel!
    @IBOutlet weak var tfUser: UITextField!
    @IBOutlet var view_users: UIView!
//    @IBOutlet var Viewcollection_user: UIView!
    @IBOutlet var collection_user: UICollectionView!
    
    @IBOutlet weak var btnSubmit: UIButton!
    @IBOutlet weak var btnCancel: UIButton!
    
    let dropUpmage =  UIImage.fontAwesomeIcon(name: .chevronUp , style: .solid, textColor:  .gray, size: CGSize(width: 40, height: 40))
    let dropDownmage =  UIImage.fontAwesomeIcon(name: .chevronDown , style: .solid, textColor:  .gray, size: CGSize(width: 40, height: 40))
    
    var arr_NoData:[String] = ["No items found".localized()]
    var arr_user :[HistoryObj] = []
    var arr_selected_user :[HistoryObj] = []
    var arr_drop_user :[HistoryObj] = []
    var arr_lbluser :[String] = []
    var params = [:] as [String : Any]
    
    var task_id:String = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()

        configGUI()
        get_users()
    }
    

    
    //MARK: - Config GUI
    //------------------------------------------------------
    func configGUI() {
        
        self.lblUsers.font = .kufiRegularFont(ofSize: 15)
        self.lblUsers.text = "Users".localized()
        
        self.view_users.setBorderGray()
        
        self.tfUser.placeholder = "Add Users".localized()
        self.tfUser.font = .kufiRegularFont(ofSize: 15)
        
        self.tfUser.delegate = self
        
        self.btnSubmit.setTitle("Submit".localized(), for: .normal)
        self.btnSubmit.backgroundColor =  maincolor
        self.btnSubmit.setTitleColor(.white, for: .normal)
        self.btnSubmit.setRounded(10)
        self.btnSubmit.titleLabel?.font = .kufiRegularFont(ofSize: 14)
        
        self.btnCancel.setTitle("Cancel".localized(), for: .normal)
        self.btnCancel.backgroundColor =  maincolor
        self.btnCancel.setTitleColor(.white, for: .normal)
        self.btnCancel.setRounded(10)
        self.btnCancel.titleLabel?.font = .kufiRegularFont(ofSize: 14)
    }

    
    func get_users(){
        
        self.showLoadingActivity()
        APIController.shard.sendRequestPostAuth(urlString: "tasks/get_emp_in_task", parameters: ["task_id":self.task_id] ) { (response) in
            self.hideLoadingActivity()
            
            let status = response["status"] as? Bool
           
            if status == true{
                
                if let data = response["data"] as? NSArray {
//                if  let status_done = data["task_status_done"] as? NSArray{
                    for i in data {
                        let dict = i as? [String:Any]
                        let obj = HistoryObj.init(dict!)
                        self.arr_user.append(obj)
                        self.arr_selected_user.append(obj)
                    }
                    self.collection_user.reloadData()
                   
            }
                self.hideLoadingActivity()
            }else{
                self.hideLoadingActivity()
            }
        }
    }
    
    
    
    func get_user(search_key:String){

        var param :[String:Any] = [:]
        self.showLoadingActivity()
//        tasks/emp_in_ticket
        APIController.shard.sendRequestGetAuth(urlString: "tc/getformuserslist?search=\(search_key)&lang_key=en&user_type_id=\(Auth_User.user_type_id)" ) { (response) in
            
            let status = response["status"] as? Bool
            if status == true{
                self.arr_drop_user = []
                self.arr_lbluser = []
                if  let list = response["list"] as? NSArray{
                    for i in list {
                        let dict = i as? [String:Any]
                        let obj = HistoryObj.init(dict!)
                        self.arr_drop_user.append(obj)
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
        
            if self.arr_drop_user.count == 0 {
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
                        let object =  self.arr_drop_user[index]
                        object.emp_name = object.label
                        object.emp_id = object.value
                        self.arr_selected_user.append(object)
                        self.arr_user.append(object)
                        
//                        self.arr_selected_user.append(obj)
                       // self.Viewcollection_user.isHidden = false
                      
                    }
                    self.collection_user.reloadData()
                }

            }
            dropDown.direction = .bottom
            dropDown.anchorView = view_users
            dropDown.bottomOffset = CGPoint(x: 0, y: view_users.bounds.height)
            dropDown.width = view_users.bounds.width
            dropDown.show()
     
    }
    
    
    func add_user(){
        
        showLoadingActivity()
        let Url = "tasks/add_emp_on_task"
        
       
        var Ids:String = ""
        if arr_selected_user.count > 1 {
            for i in arr_selected_user{
                if i.emp_id == arr_selected_user.last?.emp_id
                {
                    Ids = Ids + i.emp_id
                }else{
                    Ids = Ids + i.emp_id + ","
                }
                
            }
        }else{
            Ids = arr_selected_user[0].emp_id
        }
        
        
        let param:[String:Any] = ["task_id" : self.task_id,
                                  "emp_id" : Ids]
        
        APIController.shard.sendRequestPostAuth(urlString: Url, parameters: param ) { (response) in
            
            
            let status = response["status"] as? Bool
            let errors = response["error"] as? String

            
            if status == true{
                if let message = response["message"] as? String {
                    self.showAMessage(withTitle: "", message: message,  completion: {
                        
                        self.dismiss(animated: true, completion: nil)
                    })
                }
            }else{
                
                self.hideLoadingActivity()
                self.showAMessage(withTitle: "error".localized(), message: errors ?? "something went wrong")
            }
            self.hideLoadingActivity()
            
            
        }

    }
    
    @IBAction func btnCancel_Click(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func btnSubmit_Click(_ sender: Any) {
        
//        if (StrWorkLevel == "" ){
//            self.showAMessage(withTitle: "Error", message: "missed data")
//        }else{
//            let obj = ByPhaseObj(number: 1, zones: StrZone, Blocks: StrBlocks, Clusters: StrCluster, units: StrUnit, Worklevels: StrWorkLevel,lblWorklevels:self.StrWL_label)
//            var arr:[ByPhaseObj] = []
//            arr.append(obj)
//            Phasesdelegate.passByPhasesArr(data: arr)
//
//
        if arr_selected_user.count > 0 {
            self.add_user()
        }else{
            self.dismiss(animated: true, completion: nil)
        }
           
//        }
       
    }
    
    

}



extension TaskUsersVC: UICollectionViewDataSource ,UICollectionViewDelegate , UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
      
            return arr_user.count
       
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "unitCVCell", for: indexPath) as! unitCVCell
        
        let obj = arr_user[indexPath.item]
//            .map({"\($0.label)"})
        cell.lblTitle.text = obj.emp_name
            cell.viewBack.setBorderWithColor("458FB8".getUIColor())
            cell.lblTitle.font = .kufiRegularFont(ofSize: 13)
        cell.lblTitle.textColor = "458FB8".getUIColor()
            cell.btnDeleteAction = {
              
                self.arr_selected_user.remove(at: indexPath.item)
                self.arr_user.remove(at: indexPath.item)
                
                self.collection_user.reloadData()
//                if self.arr_user.count == 0 {
//                   // self.Viewcollection_user.isHidden = true
//                }
                
            }
            
            return cell
      
    }
    
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
       // cell.view_img.backgroundColor = HelperClassSwift.acolor.getUIColor()
        
    }
}



extension TaskUsersVC : UITextFieldDelegate{
    
    
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

