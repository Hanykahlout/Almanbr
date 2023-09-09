//
//  CheckListVC.swift
//  Almnabr
//
//  Created by MacBook on 14/05/2022.
//  Copyright © 2022 Samar Akkila. All rights reserved.
//

import UIKit

class CheckListVC: UIViewController {

    
    @IBOutlet weak var table: UITableView!
    @IBOutlet weak var img_nodata: UIImageView!
  
  
    var arr_data:[PointTaskObj] = []
    var ticket_id:String = ""
    var task_id:String = ""
    var is_from_task :Bool = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configNavigation()
        configGUI()
        get_data()
        setupAddButtonItem()
        
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

    func setupAddButtonItem() {
        let addButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(addTapped(_:)))
        navigationItem.rightBarButtonItem = addButtonItem
    }
    
    @objc func addTapped(_ sender: Any) {
        
        let vc:AddChecklistVC  = AppDelegate.TicketSB.instanceVC()
        
        vc.isModalInPresentation = true
        vc.modalPresentationStyle = .overFullScreen
        vc.definesPresentationContext = true
        vc.task_id = self.task_id
        
        self.present(vc, animated: true, completion: nil)
    }
    
    
    // MARK: - Config Navigation
    func configNavigation() {
        
        _ = self.navigationController?.preferredStatusBarStyle
        self.view.backgroundColor = maincolor //F0F4F8
        //navigationController?.navigationBar.barTintColor = .buttonBackgroundColor()
        navigationController?.navigationBar.barTintColor = maincolor
       addNavigationBarTitle(navigationTitle: "Check List".localized())
        UINavigationBar.appearance().backgroundColor = maincolor
    }
//    func setupAddButtonItem() {
//        let addButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(addTapped(_:)))
//        navigationItem.rightBarButtonItem = addButtonItem
//    }
    

    
    //MARK: - Config GUI
    //------------------------------------------------------
    func configGUI() {
        table.dataSource = self
        table.delegate = self
        table.estimatedRowHeight = 100
        table.rowHeight = UITableView.automaticDimension
        let nib = UINib(nibName: "CheckListCell", bundle: nil)
        table.register(nib, forCellReuseIdentifier: "CheckListCell")
        
    }


    
    func get_data(){
        
        self.showLoadingActivity()
        let param :[String:Any] = ["task_id" : task_id]
        
        APIController.shard.sendRequestPostAuth(urlString: "tasks/get_points_task_main", parameters: param ) { (response) in
            self.arr_data.removeAll()
            let status = response["status"] as? Bool
            if status == true{
                if  let records = response["data"] as? NSArray{
                    for i in records {
                        let dict = i as? [String:Any]
                        let obj =  PointTaskObj.init(dict!)
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
                self.img_nodata.isHidden = false
            }
        }
    }
    
    
    func delete_item(point_id:String){
        
        self.showLoadingActivity()
        let param :[String:Any] = ["point_id" : point_id]
        
        APIController.shard.sendRequestPostAuth(urlString: "tasks/delete_task_point_main", parameters: param ) { (response) in
            self.hideLoadingActivity()
           
            let status = response["status"] as? Bool
            if status == true{
                self.get_data()
             
            }else{
                self.hideLoadingActivity()
              
            }
        }
    }

    
    
    func change_task_point(point_id:String){
        
        self.showLoadingActivity()
        let param :[String:Any] = ["point_id" : point_id]
        
        APIController.shard.sendRequestPostAuth(urlString: "tasks/change_task_point", parameters: param ) { (response) in
            self.hideLoadingActivity()
           
            let status = response["status"] as? Bool
            if status == true{
                self.get_data()
             
            }else{
                self.hideLoadingActivity()
              
            }
        }
    }
    
    
    
    
}


extension CheckListVC: UITableViewDelegate , UITableViewDataSource{
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return arr_data.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "CheckListCell", for: indexPath) as! CheckListCell
        
        let obj = arr_data[indexPath.item]
        
        cell.arr_data = obj.sub_checks
        cell.titleTextField.text = obj.title
        cell.lblPercent.text = obj.progres + "%"
        
        let value = Float(obj.progres) ?? 0.0
        cell.setUpTable()
        cell.Progress.progress = value / 100.0
        
        cell.dropView.isHidden = obj.isHidden
      
        if Auth_User.user_id == obj.user_add_id {
            cell.deleteBtn.isHidden = false
        }else{
            cell.deleteBtn.isHidden = true
        }
        
        cell.btnDeleteAction = {
            self.delete_item(point_id: obj.check_id)
        }
        
        cell.btnAddItemAction = {
            
            let vc:AddPointVC  = AppDelegate.TicketSB.instanceVC()
            vc.point_id = obj.check_id
            self.navigationController?.pushViewController(vc, animated: true)
        }
        
        return cell
        
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
//        guard let expandableItem = arr_data[indexPath.item] else {return}
        
        
        let obj = arr_data[indexPath.item]
        obj.isHidden = !(obj.isHidden )
        table.reloadRows(at: [indexPath], with: UITableView.RowAnimation.automatic)
//        let vc:SubTaskListVC = AppDelegate.TicketSB.instanceVC()
//        vc.str_title = obj.title
//        vc.task_id = self.task_id
//        vc.arr_data = obj.sub_checks
//        self.navigationController?.pushViewController(vc, animated: true)
    }
}


