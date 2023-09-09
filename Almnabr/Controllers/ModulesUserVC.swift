//
//  ModulesUserVC.swift
//  Almnabr
//
//  Created by MacBook on 14/04/2022.
//  Copyright © 2022 Samar Akkila. All rights reserved.
//

import UIKit

class ModulesUserVC: UIViewController {

    @IBOutlet weak var table: UITableView!
    @IBOutlet weak var img_nodata: UIImageView!
    
    var object:ModulesObj?
    
    var pageNumber = 1
    
    var arr_data:[ModuleUsersObj] = []
    var allItemDownloaded = false
    var params:[String:Any] = [:]
    
    var profile_obj:ProfileObj?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configNavigation()
        configGUI()
        get_data(showLoading: true, loadOnly: true)
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
       addNavigationBarTitle(navigationTitle: "Users".localized())
        UINavigationBar.appearance().backgroundColor = maincolor
    }
    
    
    
    //MARK: - Config GUI
    //------------------------------------------------------
    func configGUI() {
        
        self.params["mention_id"] = object?.mention_id
        self.params["branch_id"] = object?.branch_id
        self.params["user_id"] = object?.user_id
        self.params["user_type_id"] = object?.user_type_id
        self.params["module_key"] = object?.module_key
        self.params["permission_key"] = object?.permission_key
        self.params["private_key"] = object?.private_key
        self.params["private_value"] = object?.private_value
        self.params["group_key"] = object?.group_key
        self.params["create_by_user_id"] = object?.create_by_user_id
        self.params["create_date"] = object?.create_date
        self.params["modulename"] = object?.modulename
        self.params["writer"] = object?.writer
        
        table.dataSource = self
        table.delegate = self
        let nib = UINib(nibName: "ModuleUserTVCell", bundle: nil)
        table.register(nib, forCellReuseIdentifier: "ModuleUserTVCell")
        
    }


   
    func get_data(showLoading: Bool, loadOnly: Bool){
        
            self.showLoadingActivity()
       
        APIController.shard.sendRequestPostAuth(urlString: "moduleusers", parameters: self.params ) { (response) in
            self.hideLoadingActivity()
            
            let status = response["status"] as? Bool
            if status == true{
                
                
                if  let records = response["records"] as? NSArray{
                    for i in records {
                        let dict = i as? [String:Any]
                        let obj =  ModuleUsersObj.init(dict!)
                        self.arr_data.append(obj)
                    }
                   
                    if records.count == 0 {
                        self.img_nodata.isHidden = false
                    }else{
                        self.img_nodata.isHidden = true
                    }
                    self.table.reloadData()
                    self.hideLoadingActivity()
                }
                
            }else{
                self.hideLoadingActivity()
            }
            
            
        }
    }

    
}


extension ModulesUserVC: UITableViewDelegate , UITableViewDataSource{

func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return arr_data.count
}

func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    
    let cell = tableView.dequeueReusableCell(withIdentifier: "ModuleUserTVCell", for: indexPath) as! ModuleUserTVCell
    
    let obj = arr_data[indexPath.item]
    
    let Title = "Title".localized() + ": \(obj.title)"
    let Positions = "Positions".localized() + ": \(obj.groupname)"
    let ServicePositions = "Service Positions".localized() + ": \(obj.project_group_name)"
    let ServiceProjectName = "Service Project Name".localized() + ": \(obj.quotation_subject)"
    
    cell.lblName.text = obj.name
    
   
    let Titleattributed: NSAttributedString = Title.attributedStringWithColor(["Title".localized()], color: maincolor)
    cell.lblTitle.attributedText = Titleattributed
    
    let Positionsattributed: NSAttributedString = Positions.attributedStringWithColor(["Positions".localized()], color: maincolor)
    cell.lblPositions.attributedText = Positionsattributed
     
    let ServiceProjectNameattributed: NSAttributedString = ServiceProjectName.attributedStringWithColor(["Service Project Name".localized()], color: maincolor)
    cell.lblServiceProjectName.attributedText = ServiceProjectNameattributed
    
    let ServicePositionsattributed: NSAttributedString = ServicePositions.attributedStringWithColor(["Service Positions".localized()], color: maincolor)
    cell.lblServicePositions.attributedText = ServicePositionsattributed
    return cell
    
}

func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    
    //                let obj = arr_data[indexPath.item]
    //                let vc:ProjectDetailsVC = AppDelegate.mainSB.instanceVC()
    //                vc.title =  self.title
    //                vc.Object = obj
    //                vc.MenuObj = self.MenuObj
    //                vc.StrSubMenue =  self.StrSubMenue
    //                vc.StrMenue = self.StrMenue
    //        self.navigationController?.pushViewController(vc, animated: true)
    //                _ =  panel?.center(vc)
}


func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
    if tableView.tag == 0 {
        
        
//        print(indexPath.section)
//        if indexPath.row   == arr_data.count - 1  {
//            updateNextSet()
//            print("next step")
//
//        }
    }
}

func updateNextSet(){
    print("On Completetion")
    if !allItemDownloaded {
        pageNumber = pageNumber + 1
        get_data(showLoading: false, loadOnly: true)
    }
}
}



