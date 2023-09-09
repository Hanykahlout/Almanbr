//
//  SubTaskListVC.swift
//  Almnabr
//
//  Created by MacBook on 15/05/2022.
//  Copyright © 2022 Samar Akkila. All rights reserved.
//

import UIKit


class SubTaskListVC: UIViewController {
    
    @IBOutlet weak var table: UITableView!
    @IBOutlet weak var img_nodata: UIImageView!
    
    
    var arr_data:[SubCheckObj] = []
    var ticket_id:String = ""
    var task_id:String = ""
    var is_from_task :Bool = false
    var str_title:String = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configNavigation()
        configGUI()
        setupAddButtonItem()
        if arr_data.count == 0 {
            self.img_nodata.isHidden = false
        }else{
            self.img_nodata.isHidden = true
        }
        self.table.reloadData()
        
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
        addNavigationBarTitle(navigationTitle: str_title)
        UINavigationBar.appearance().backgroundColor = maincolor
    }
    func setupAddButtonItem() {
        let addButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(addTapped(_:)))
        navigationItem.rightBarButtonItem = addButtonItem
    }
    
    
    
    //MARK: - Config GUI
    //------------------------------------------------------
    func configGUI() {
        table.dataSource = self
        table.delegate = self
        let nib = UINib(nibName: "SubTaskTVCell", bundle: nil)
        table.register(nib, forCellReuseIdentifier: "SubTaskTVCell")
        
    }
    
    
    @objc func addTapped(_ sender: Any) {
        
    }
    
    func delete_task_point(point_id:String ){
        APIController.shard.sendRequestPostAuth(urlString: "tasks/delete_task_point", parameters: ["point_id" : point_id]  ) { (response) in
            let status = response["status"] as? Bool
            if status == true{
            }else{
            } }
        
        
    }
    
    
    
}


extension SubTaskListVC: UITableViewDelegate , UITableViewDataSource{
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return arr_data.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "SubTaskTVCell", for: indexPath) as! SubTaskTVCell
        
        let obj = arr_data[indexPath.item]
        
        cell.lblTitle.text = obj.notes
        cell.lblDate.text =  "End Date:" + "\(obj.end_date)"
        
        cell.btnDownloadAction = {
            
            let path = obj.files[0].path
            if path != "" {
                let vc:PDFViewrVC  = AppDelegate.mainSB.instanceVC()
                vc.isModalInPresentation = true
                vc.definesPresentationContext = true
                vc.Strurl = path
                self.present(vc, animated: true, completion: nil)
            }
        }
        
        cell.arr_user = obj.users
        
        let point_id = obj.point_id
        
        if obj.is_done == "1"{
            print("not Check")
            cell.btnCheck.setImage(UIImage(systemName: "square"), for: .normal)
        }else{
            print("Check")
            cell.btnCheck.setImage(UIImage(systemName: "checkmark.square.fill"), for: .normal)
        }
        
        cell.btnCheckAction = {
            
            if obj.is_done == "2"{
                print("not Check")
                self.showLoadingActivity()
                
                APIController.shard.sendRequestPostAuth(urlString: "tasks/change_task_point", parameters: ["point_id" : point_id]  ) { (response) in
                    let status = response["status"] as? Bool
                    if status == true{
                        cell.btnCheck.setImage(UIImage(systemName: "checkmark.square.fill"), for: .normal)
                        obj.is_done = "1"
                        self.hideLoadingActivity()
                        
                    }else{
                        cell.btnCheck.setImage(UIImage(systemName: "square"), for: .normal)
                        self.hideLoadingActivity()
                        obj.is_done = "2"
                        
                    }
                }
                
                
                
            }else{
                print("Check")
                self.showLoadingActivity()
                APIController.shard.sendRequestPostAuth(urlString: "tasks/change_task_point", parameters: ["point_id" : point_id]  ) { (response) in
                    DispatchQueue.main.async {
                        let status = response["status"] as? Bool
                        if status == true{
                            cell.btnCheck.setImage(UIImage(systemName: "square"), for: .normal)
                            obj.is_done = "2"
                            self.hideLoadingActivity()
                        }else{
                            cell.btnCheck.setImage(UIImage(systemName: "checkmark.square.fill"), for: .normal)
                            obj.is_done = "1"
                            self.hideLoadingActivity()
                            
                        }
                    }
                }
            }
            cell.collection.reloadData()
        }
        
        cell.btnDeleteAction = {
            self.showLoadingActivity()
            APIController.shard.sendRequestPostAuth(urlString: "tasks/delete_task_point", parameters: ["point_id" : point_id]  ) { (response) in
                let status = response["status"] as? Bool
                let message = response["message"] as? String
                if status == true{
                    self.arr_data.remove(at: indexPath.item)
                    self.table.reloadData()
                    self.hideLoadingActivity()
                }else{
                    self.showAMessage(withTitle: "error", message: message ?? "try again")
                    self.hideLoadingActivity()
                } }
            
            
            
        }
        return cell
        
    }
    
}

