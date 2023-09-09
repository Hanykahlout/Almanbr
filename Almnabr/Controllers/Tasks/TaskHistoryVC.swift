//
//  TaskHistoryVC.swift
//  Almnabr
//
//  Created by MacBook on 27/04/2022.
//  Copyright © 2022 Samar Akkila. All rights reserved.
//

import UIKit

class TaskHistoryVC: UIViewController {
    
    
    @IBOutlet weak var table: UITableView!
    @IBOutlet weak var img_nodata: UIImageView!
    
    
    var arr_data:[HistoryObj] = []
    var data: [ListItemHistoryData]?
    var ticket_id:String = ""
    var task_id:String = ""
    var is_from_task :Bool = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configNavigation()
        configGUI()
        if data == nil{
            historySocket()
            ticketStatckTimeLine()
            if is_from_task == true {
                get_Task_data()
            }else{
                get_data()
            }
        }else{
            img_nodata.isHidden = !data!.isEmpty
        }
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
        addNavigationBarTitle(navigationTitle: "History".localized())
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
        let nib = UINib(nibName: "TaskHistoryCell", bundle: nil)
        table.register(nib, forCellReuseIdentifier: "TaskHistoryCell")
        
    }
    
    
    @objc func addTapped(_ sender: Any) {
        
    }
    
    func get_data(){
        
        self.showLoadingActivity()
        let param :[String:Any] = ["ticket_id" : ticket_id,
                                   "type" : "1"]
        APIController.shard.sendRequestPostAuth(urlString: "tasks/time_line/desc", parameters: param ) { (response) in
            self.arr_data.removeAll()
            let status = response["status"] as? Bool
            if status == true{
                if  let records = response["data"] as? NSArray{
                    for i in records {
                        let dict = i as? [String:Any]
                        let obj =  HistoryObj.init(dict!)
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
    
    func get_Task_data(){
        
        self.showLoadingActivity()
        let param :[String:Any] = ["task_id" : task_id,
                                   "type" : "2"]
        APIController.shard.sendRequestPostAuth(urlString: "tasks/time_line_task/desc", parameters: param ) { (response) in
            self.arr_data.removeAll()
            let status = response["status"] as? Bool
            if status == true{
                if  let records = response["data"] as? NSArray{
                    for i in records {
                        let dict = i as? [String:Any]
                        let obj =  HistoryObj.init(dict!)
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
    
    
    
}


extension TaskHistoryVC: UITableViewDelegate , UITableViewDataSource{
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return data == nil ? arr_data.count : data!.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "TaskHistoryCell", for: indexPath) as! TaskHistoryCell
        if let data = data{
            let obj = data[indexPath.row]
            
            cell.lbl_emp_name.text = obj.firstname_english ?? ""
            cell.lbl_title.text = obj.notes ?? ""
            cell.lbl_insert_date.text = obj.insert_date ?? ""
            
        }else{
            let obj = arr_data[indexPath.item]
            
            
            cell.lbl_emp_name.text = obj.emp_name
            cell.lbl_title.text = obj.en_title
            cell.lbl_insert_date.text = obj.insert_date
        }
        return cell
        
    }
    
}


// MARK: - Socket Handling 

extension TaskHistoryVC{
    private func ticketStatckTimeLine(){
        SocketIOController.shard.ticketStatusTimeLine(ticketId: ticket_id, userID: Auth_User.user_id) { data in
            guard let data = data.first as? [String:Any] else { return }
            guard let content = data["content"] as? [String:Any] else { return }
            DispatchQueue.main.async {
                let obj = HistoryObj.init(content)
                self.arr_data.insert(obj, at: 0)
                self.table.reloadData()
            }
        }
    }
}


// MARK: - Socket Handler

extension TaskHistoryVC{

    private func historySocket(){
        SocketIOController.shard.taskTimeLineHandler(ticketId: ticket_id, taskId: task_id, userID: Auth_User.user_id) { data in
            guard let data = data.first as? [String:Any],
                  let content = data["content"] as? [String:Any]
            else { return }
            
            let obj = HistoryObj.init(content)
            self.arr_data.insert(obj, at: 0)
            self.table.insertRows(at: [IndexPath(row: 0, section: 0)], with: .automatic)
        }
    }
    
    
}




