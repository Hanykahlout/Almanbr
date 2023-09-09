//
//  ActivityVC.swift
//  Almnabr
//
//  Created by MacBook on 02/07/2022.
//  Copyright © 2022 Samar Akkila. All rights reserved.
//

import UIKit

class ActivityVC: UIViewController {

    @IBOutlet weak var tableActivity: UITableView!
    @IBOutlet weak var tableHistory: UITableView!
    
    @IBOutlet var ActivitytableHeight: NSLayoutConstraint!
    @IBOutlet var HistorytableHeight: NSLayoutConstraint!
    
    @IBOutlet var lblActivity: UILabel!
    @IBOutlet var lblHistory: UILabel!
    
    @IBOutlet var btnDropActivity: UIButton!
    @IBOutlet var btnDropHistory: UIButton!
    
    
    @IBOutlet weak var viewActivity: UIView!
    @IBOutlet weak var viewHistory: UIView!
    
    @IBOutlet weak var view_Activity: UIView!
    @IBOutlet weak var view_History: UIView!
    
    @IBOutlet weak var stackComment: UIStackView!
    @IBOutlet weak var btnSaveComment: UIView!
    
    
    var arr_data:[HistoryObj] = []
    var arr_comments :[CommentObj] = []
    var ticket_id:String = ""
    var task_id:String = ""
    var is_from_task :Bool = false
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        configNavigation()
        configGUI()
        get_Task_data()
        get_data()
        get_comment_tasks()
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

    
    override func viewWillLayoutSubviews() {
        super.updateViewConstraints()
        self.ActivitytableHeight?.constant = self.tableActivity.contentSize.height
        self.HistorytableHeight?.constant = 700
//        CGFloat( arr_data.count )* 60
        
    }
    
    
    // MARK: - Config Navigation
    func configNavigation() {
        
        _ = self.navigationController?.preferredStatusBarStyle
        self.view.backgroundColor = maincolor //F0F4F8
        //navigationController?.navigationBar.barTintColor = .buttonBackgroundColor()
        navigationController?.navigationBar.barTintColor = maincolor
        addNavigationBarTitle(navigationTitle: " ")
        UINavigationBar.appearance().backgroundColor = maincolor
    }
    
    
    //MARK: - Config GUI
    //------------------------------------------------------
    func configGUI() {
        tableHistory.dataSource = self
        tableHistory.delegate = self
        let nib = UINib(nibName: "TaskHistoryCell", bundle: nil)
        tableHistory.register(nib, forCellReuseIdentifier: "TaskHistoryCell")
        
        tableActivity.dataSource = self
        tableActivity.delegate = self
        let nib1 = UINib(nibName: "TaskCommentCell", bundle: nil)
        tableActivity.register(nib1, forCellReuseIdentifier: "TaskCommentCell")
        
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
//                    if records.count == 0 {
//                        self.img_nodata.isHidden = false
//                    }else{
//                        self.img_nodata.isHidden = true
//                    }
                    self.tableHistory.reloadData()
                    self.hideLoadingActivity()
                }
                
            }else{
                self.hideLoadingActivity()
//                self.img_nodata.isHidden = false
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
//                    if records.count == 0 {
//                        self.img_nodata.isHidden = false
//                    }else{
//                        self.img_nodata.isHidden = true
//                    }
                    self.tableHistory.reloadData()
                    self.hideLoadingActivity()
                }
                
            }else{
                self.hideLoadingActivity()
//                self.img_nodata.isHidden = false
            }
        }
    }

    func get_comment_tasks(){
        
        self.showLoadingActivity()
        
        let param:[String:Any] = ["task_id" : self.task_id]
        APIController.shard.sendRequestPostAuth(urlString: "tasks/get_comment_tasks", parameters: param ) { (response) in
            self.hideLoadingActivity()
            
            let status = response["status"] as? Bool
            self.arr_comments.removeAll()
            if status == true{
                if  let records = response["data"] as? NSArray{
                    for i in records {
                        let dict = i as? [String:Any]
                        let obj =  CommentObj.init(dict!)
                        self.arr_comments.append(obj)
                    }
                    self.tableActivity.reloadData()
                    self.hideLoadingActivity()
                    
                }else{
                    self.hideLoadingActivity()
                }
            }
        }
        
    }

    func delete_comment(comment_id:String){
        
        self.showLoadingActivity()
        let param :[String:Any] = ["comment_id" : comment_id]
        
        APIController.shard.sendRequestPostAuth(urlString: "tasks/delete_comment_reply", parameters: param ) { (response) in
            self.hideLoadingActivity()
            
            let status = response["status"] as? Bool
            let message = response["message"] as? String
            if status == true{
                self.hideLoadingActivity()
                self.showAMessage(withTitle: "", message: message ?? "Deletion process has been successful", completion: {
                    self.get_comment_tasks()
                })
            }else{
                self.hideLoadingActivity()
                
            }
        }
    }
    
    var isHistoryDrop:Bool = false
    @IBAction func btnDropHistory_Click(_ sender: Any) {
        
//        if isHistoryDrop {
            self.viewActivity.isHidden = true
            self.tableHistory.isHidden = false
        self.lblHistory.textColor = .white
        self.lblActivity.textColor = maincolor
        
        
        self.view_Activity.backgroundColor  = .white
        self.view_History.backgroundColor  = maincolor
//            self.stackComment.isHidden = true
//            self.btnSaveComment.isHidden = true
//            isHistoryDrop = false
//        }else{
//            self.viewActivity.isHidden = false
//            self.viewHistory.isHidden = true
//            self.stackComment.isHidden = false
//            self.btnSaveComment.isHidden = false
//            isHistoryDrop = true
//        }
        
        
    }
    
    var isActivtyDrop:Bool = false
    @IBAction func btnDropActivity_Click(_ sender: Any) {
//
//        if isActivtyDrop {
//            self.viewActivity.isHidden = true
//            self.viewHistory.isHidden = false
//            self.stackComment.isHidden = true
//            self.btnSaveComment.isHidden = true
//            isActivtyDrop = false
//        }else{
            self.viewActivity.isHidden = false
            self.tableHistory.isHidden = true
        
        self.lblHistory.textColor = maincolor
        self.lblActivity.textColor = .white
        
        self.view_Activity.backgroundColor  = maincolor
        self.view_History.backgroundColor  = .white
        
//            self.stackComment.isHidden = false
//            self.btnSaveComment.isHidden = false
//            isActivtyDrop  = true
//        }
        
        
    }

}

extension ActivityVC: UITableViewDelegate , UITableViewDataSource{

func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    switch tableView {
    case tableActivity:
    return arr_data.count
    case tableHistory:
        return arr_data.count
    default:
        return 0
    }
}

func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    
    switch tableView {
    case tableActivity:
        let cell = tableView.dequeueReusableCell(withIdentifier: "TaskCommentCell", for: indexPath) as! TaskCommentCell
        
        let obj = arr_comments[indexPath.item]
        cell.arr_reply = obj.reply
        cell.lblDate.text = obj.insert_date
        cell.lblUserName.text = obj.emp_name
        cell.lblComment.text = obj.notes_history
        cell.setUpTable()
        cell.dropView.isHidden = obj.isHidden
        
        cell.btnViewReplyAction = { isHidden in
//            let obj = arr_comments[indexPath.item]
            obj.isHidden = !(obj.isHidden )
            self.tableActivity.reloadRows(at: [indexPath], with: UITableView.RowAnimation.automatic)
            
        }
        
        self.viewWillLayoutSubviews()
        
        cell.btnDeleteReplyAction = { comment_id , index in
            self.delete_comment(comment_id: comment_id)
        }
        
        
        cell.btnEditReplyAction = {  comment_id , comment , replyIndex in
            
            let vc:AddCommentVC  = AppDelegate.TicketSB.instanceVC()
            
            vc.isModalInPresentation = true
            vc.modalPresentationStyle = .overFullScreen
            vc.definesPresentationContext = true
            vc.comment_id = comment_id
            vc.comment =  comment
            vc.delegate = {
                self.get_comment_tasks()
            }
            self.present(vc, animated: true, completion: nil)
            
        }
        
        
        return cell
    case tableHistory:
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "TaskHistoryCell", for: indexPath) as! TaskHistoryCell
        
        let obj = arr_data[indexPath.item]
        
     
        cell.lbl_emp_name.text = obj.emp_name
        cell.lbl_title.text = obj.en_title
        cell.lbl_insert_date.text = obj.insert_date
        
    default:
        return UITableViewCell()
    }
    
    return UITableViewCell()
}
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        self.viewWillLayoutSubviews()
    }
    
    func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        switch tableView {
        case tableHistory:
            print("nthing")
        case tableActivity:
            let obj = arr_comments[indexPath.item]
            // Create you actionsheet - preferredStyle: .actionSheet
            let actionSheet = UIAlertController(title: nil, message: nil, preferredStyle: .actionSheet)
            
            // Create your actions - take a look at different style attributes
            let ReplyAction = UIAlertAction(title: "Reply", style: .default) { (action) in
                
                let vc:AddCommentVC  = AppDelegate.TicketSB.instanceVC()
                
                vc.isModalInPresentation = true
                vc.modalPresentationStyle = .overFullScreen
                vc.definesPresentationContext = true
                vc.comment_id = obj.history_id
    //            vc.comment =  obj.notes_history
                vc.header = "Add Reply".localized()
                vc.title_str = "reply".localized()
                vc.type = "reply"
                vc.task_id = self.task_id
                vc.delegate = {
                    self.get_comment_tasks()
                }
                self.present(vc, animated: true, completion: nil)
                
            }
            let EditAction = UIAlertAction(title: "Edit", style: .default) { (action) in
                
                let vc:AddCommentVC  = AppDelegate.TicketSB.instanceVC()
                
                vc.isModalInPresentation = true
                vc.modalPresentationStyle = .overFullScreen
                vc.definesPresentationContext = true
                vc.comment_id = obj.history_id
                vc.comment =  obj.notes_history
                vc.delegate = {
                    self.get_comment_tasks()
                }
                self.present(vc, animated: true, completion: nil)
                
            }
            
            let DeleteAction = UIAlertAction(title: "Delete", style: .destructive) { (action) in
                self.delete_comment(comment_id: obj.history_id)
            }
            
            let cancelAction = UIAlertAction(title: "Cancel", style: .cancel) { (action) in
                print("didPress cancel")
            }
            
            // Add the actions to your actionSheet
            actionSheet.addAction(ReplyAction)
           
            actionSheet.addAction(cancelAction)
            
            if obj.emp_id == Auth_User.user_id {
                actionSheet.addAction(EditAction)
                actionSheet.addAction(DeleteAction)
            }
            
            
            guard let top_vc = HeaderView.shared.menu_vc() else { return }
            // show the alert
            
            DispatchQueue.main.async(execute: {
                // top_vc.present(alert, animated: true, completion: nil)
                top_vc.present(actionSheet, animated: true, completion: nil)
            })
            
            
        default:
            print("nil")
        }
        
    }
        }


