//
//  TaskDetailVC.swift
//  Almnabr
//
//  Created by MacBook on 10/05/2022.
//  Copyright © 2022 Samar Akkila. All rights reserved.
//

import UIKit
import SCLAlertView
class TaskDetailVC: UIViewController {
    
    @IBOutlet weak var deleteButton: UIButton!
    @IBOutlet weak var table_Activity: UITableView!
    @IBOutlet weak var lbl_title: UILabel!
    @IBOutlet weak var lbl_status: UILabel!
    @IBOutlet weak var lbl_status_done: UITextField!
    @IBOutlet weak var lbl_From: UITextField!
    @IBOutlet weak var lbl_To: UITextField!
    @IBOutlet weak var lbl_desc: UILabel!
    @IBOutlet weak var lbl_percentage: UITextField!
    
    @IBOutlet weak var txt_comment: UITextView!
    @IBOutlet weak var tableChecklist: UITableView!
    @IBOutlet weak var tableChecklistHeight: NSLayoutConstraint!
    
    
    @IBOutlet weak var btnAdd_comment: UIView! {
        didSet {
            btnAdd_comment.isHidden = false
        }
    }
    
    
    var object:TaskObj?
    var delegate : (() -> Void)?
    var task_id:String = ""
    var ticket_id:String = ""
    var arr_statusDone :[importantObj] = []
    var arr_comments :[CommentObj] = []
    var arr_data:[PointTaskObj] = []
    var canDelete = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupAddBarButtonItem()
        configNavigation()
        get_data()
        get_Chicklist_data()
        get_add_task()
        get_comment_tasks()
        setUpTableView()
        setUpObserver()
        table_Activity.dataSource = self
        table_Activity.delegate = self
        let nib = UINib(nibName: "TaskCommentCell", bundle: nil)
        table_Activity.register(nib, forCellReuseIdentifier: "TaskCommentCell")
        addSocketObservers()
    }
    
    
    private func setUpObserver(){
        NotificationCenter.default.addObserver(forName: .init("UpdateTaskStatus"), object: nil, queue: .main) { notify in
            guard let status = notify.object as? String else { return }
            self.lbl_status_done.text = status
        }
        
        NotificationCenter.default.addObserver(forName: .init(rawValue: "UpdateCheckListItemData"), object: nil, queue: .main) { notify in
            guard let data = notify.object as? SubCheckObj else { return }
            let checkListIndex = self.arr_data.firstIndex(where: {$0.check_id == data.point_id})
            if let checkListIndex = checkListIndex{
                let index = self.arr_data[checkListIndex].sub_checks.firstIndex(where: {$0.check_id == data.check_id})
                if let index = index {
                    self.arr_data[checkListIndex].sub_checks[index] = data
                    //                    self.tableChecklist.reloadRows(at: [IndexPath(row: checkListIndex, section: 0)], with: .automatic)
                    
                    let cell = self.tableChecklist.cellForRow(at: IndexPath(row: checkListIndex, section: 0)) as! CheckListCell
                    cell.itemTable.reloadRows(at: [IndexPath(row: index, section: 0)], with: .automatic)
                }
            }
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
        addNavigationBarTitle(navigationTitle: "Task Details".localized())
        UINavigationBar.appearance().backgroundColor = maincolor
        
    }
    
    private func setUpTableView(){
        tableChecklist.dataSource = self
        tableChecklist.delegate = self
        tableChecklist.estimatedRowHeight = 100
        tableChecklist.rowHeight = UITableView.automaticDimension
        let nib = UINib(nibName: "CheckListCell", bundle: nil)
        tableChecklist.register(nib, forCellReuseIdentifier: "CheckListCell")
    }
    
    
    
    func setupAddBarButtonItem() {
        let button = UIButton(type: .system)
        button.setImage(UIImage(systemName: "plus")!, for: .normal)
        button.setTitleColor(.red, for: .normal)
        button.addTarget(self, action: #selector(self.didTapAddButton(sender:)), for: .touchUpInside)
        navigationItem.rightBarButtonItem = UIBarButtonItem(customView: button)
    }
    
    
    @objc func didTapAddButton(sender: UIButton){
        addCheckListItem()
    }
    
    private func addCheckListItem(){
        let vc:AddChecklistVC  = AppDelegate.TicketSB.instanceVC()
        
        vc.isModalInPresentation = true
        vc.modalPresentationStyle = .overFullScreen
        vc.definesPresentationContext = true
        vc.task_id = self.task_id
        self.present(vc, animated: true, completion: nil)
        
    }
    
    //MARK: - Config GUI
    //------------------------------------------------------
    func configGUI() {
        
        self.lbl_title.font = .kufiRegularFont(ofSize: 14)
        self.lbl_title.text = object?.title ?? "---"
        
        let Status = "Status".localized() + ": \(object?.status_name ?? "---")"
        
        let Status_atr: NSAttributedString = Status.attributedStringWithColor(["Status".localized()], color: maincolor)
        self.lbl_status.attributedText = Status_atr
        self.lbl_status.font = .kufiRegularFont(ofSize: 14)
        
        let From = "From".localized() + ": \(object?.end_nearly ?? "---")"
        let From_atr: NSAttributedString = From.attributedStringWithColor(["From".localized()], color: maincolor)
        self.lbl_From.attributedText = From_atr
        self.lbl_From.font = .kufiRegularFont(ofSize: 11)
        
        let To = "To".localized() + ": \(object?.start_date ?? "--/--/--")"
        let To_atr: NSAttributedString = To.attributedStringWithColor(["To".localized()], color: maincolor)
        self.lbl_To.attributedText = To_atr
        self.lbl_To.font = .kufiRegularFont(ofSize: 11)
        
        let desc = "Description".localized() + "\n \(object?.task_detailes ?? "---")"
        let desc_atr: NSAttributedString = desc.attributedStringWithColor(["Description".localized()], color: maincolor)
        self.lbl_desc.attributedText = desc_atr
        self.lbl_desc.font = .kufiRegularFont(ofSize: 14)
        
        self.lbl_percentage.text = object?.progres
        
        self.lbl_status_done.text = object?.status_done_name
        self.lbl_status_done.font = .kufiRegularFont(ofSize: 13)
        
        txt_comment.delegate = self
        
        txt_comment.text = "comment".localized()
        txt_comment.font = .kufiRegularFont(ofSize: 14)
        txt_comment.textColor = .lightGray
        
    }
    
    
    private func CommentMenu() -> UIMenu {
        
        let Reply = UIAction(title: "Reply") { _ in
            // self.btnChangeStatusAction!(self.task_id, 1)
        }
        let Edit = UIAction(title: "Edit") { _ in
            //  self.btnChangeStatusAction!(self.task_id, 2)
        }
        let Delete = UIAction(title: "Delete") { _ in
            // self.btnChangeStatusAction!(self.task_id, 3)
        }
        return UIMenu(title: "", children: [Reply, Edit, Delete])
    }
    
    
    
    @IBAction func deleteAction(_ sender: Any) {
        if canDelete {
            delete_task(task_id: self.task_id)
        }else{
            SCLAlertView().showNotice("You do not have permissions to edit this task", subTitle: "")
        }
    }
    
    
    @IBAction func btnAttachments_Click(_ sender: Any) {
        
        let vc:TaskAttachmentVC = AppDelegate.TicketSB.instanceVC()
        vc.is_from_task = true
        vc.arr_data = object?.files ?? []
        vc.ticket_id = ticket_id
        vc.task_id = task_id
        vc.updateArr = { isDelete , obj , index in
            if isDelete{
                self.object?.files.remove(at: index)
            }else{
                self.object?.files.insert(obj!, at: index)
            }
        }
        
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    
    @IBAction func btnCheckList_Click(_ sender: Any) {
        addCheckListItem()
    }
    
    
    @IBAction func btnMembers_Click(_ sender: Any) {
        
        let vc:TaskUsersVC  = AppDelegate.TicketSB.instanceVC()
        
        vc.isModalInPresentation = true
        vc.modalPresentationStyle = .overFullScreen
        vc.definesPresentationContext = true
        vc.task_id = self.task_id
        self.present(vc, animated: true, completion: nil)
        
    }
    
    @IBAction func btnHistory_Click(_ sender: Any) {
        let vc:TaskHistoryVC = AppDelegate.TicketSB.instanceVC()
        vc.is_from_task = true
        vc.ticket_id = ticket_id
        vc.task_id = self.task_id
        self.navigationController?.pushViewController(vc, animated: true)
        
    }
    
    @IBAction func btnStatusDonne_Click(_ sender: Any) {
        let vc :PickerVC = AppDelegate.mainSB.instanceVC()
        vc.arr_data =  arr_statusDone.map({"\($0.name)"})
        vc.isModalInPresentation = true
        vc.modalPresentationStyle = .overFullScreen
        vc.definesPresentationContext = true
        vc.delegate = {name , index in
            self.lbl_status_done.text = name
            let status = self.arr_statusDone[index].id
            self.change_status(task_id: self.task_id, status: status)
        }
        self.present(vc, animated: true, completion: nil)
    }
    
    @IBAction func btnAddComment_Click(_ sender: Any) {
        
        guard txt_comment.text != "comment" else {
            return self.showAMessage(withTitle: "", message: "Comment Field Required!")
        }
        
        self.Add_comment(title: txt_comment.text!)
    }
    
}

extension TaskDetailVC: UITableViewDelegate , UITableViewDataSource{
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if tableView == tableChecklist{
            return arr_data.count
        }
        return arr_comments.count
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if tableView == tableChecklist{
            let cell = tableView.dequeueReusableCell(withIdentifier: "CheckListCell", for: indexPath) as! CheckListCell
            
            let obj = arr_data[indexPath.item]
            cell.hideSelectedItems = obj.isUnselectedData
            
            if cell.hideSelectedItems{
                cell.viewItemsButton.tag = 0
                cell.viewItemsButton.setImage(UIImage(systemName: "eye.slash"), for: .normal)
            }else{
                cell.viewItemsButton.tag = 1
                cell.viewItemsButton.setImage(UIImage(systemName: "eye"), for: .normal)
            }
            
            
            cell.editTitleButton.isHidden = obj.user_add_id != Auth_User.user_id
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
            
            cell.btnStartEndTimer = {
                self.showLoadingActivity()
                APIController.shard.startEndCheckListItem(point_id: obj.check_id) { data in
                    DispatchQueue.main.async {
                        self.hideLoadingActivity()
                        if let status = data.status , status{
                            cell.successStartEndTimer()
                        }
                    }
                }
            }
            
            
            cell.btnDeleteAction = {
                self.delete_item(point_id: obj.check_id)
            }
            
            cell.btnEditItemAction = { data in
                let vc:AddPointVC  = AppDelegate.TicketSB.instanceVC()
                vc.data = data
                vc.isView = false
                self.navigationController?.pushViewController(vc, animated: true)
            }
            
            cell.btnViewItemAction = { data in
                let vc:AddPointVC  = AppDelegate.TicketSB.instanceVC()
                vc.data = data
                vc.isView = true
                self.navigationController?.pushViewController(vc, animated: true)
            }
            
            cell.btnEditCheckListTitle = { title in
                self.showLoadingActivity()
                APIController.shard.updateCheckListTitle(pointId: obj.check_id, title: title) { data in
                    DispatchQueue.main.async {
                        self.hideLoadingActivity()
                        if data.status == nil || data.status == false{
                            SCLAlertView().showError("error".localized(), subTitle: data.error ?? "There is an unknown error...")
                        }else{
                            self.arr_data[indexPath.row].title = title
                        }
                    }
                }
            }
            
            cell.btnAddItemAction = {
                
                let vc:AddPointVC  = AppDelegate.TicketSB.instanceVC()
                vc.point_id = obj.check_id
                vc.isView = false
                self.navigationController?.pushViewController(vc, animated: true)
            }
            
            cell.viewSelectedItemsAction = {
                
                let obj = self.arr_data[indexPath.item]
                if !obj.isHidden{
                    self.tableChecklistHeight.constant -= CGFloat(cell.tableHeight.constant + 45)
                    if cell.viewItemsButton.tag == 0 {
                        // Show
                        cell.viewItemsButton.tag = 1
                        cell.viewItemsButton.setImage(UIImage(systemName: "eye"), for: .normal)
                        cell.hideSelectedItems = false
                        cell.tableHeight.constant = CGFloat(cell.arr_data.count * 51 )
                        obj.isUnselectedData = false
                        
                    }else{
                        // Hide
                        cell.viewItemsButton.tag = 0
                        cell.viewItemsButton.setImage(UIImage(systemName: "eye.slash"), for: .normal)
                        cell.hideSelectedItems = true
                        let numberOfUnselectedItems = cell.arr_data.filter({$0.is_done == "1"}).count
                        cell.tableHeight.constant = CGFloat(numberOfUnselectedItems * 51 )
                        obj.isUnselectedData = true
                    }
                    
                    let unSelectedArr = cell.arr_data.filter({$0.is_done == "1"}).count
                    let cellHeight = CGFloat(((cell.hideSelectedItems ? unSelectedArr : cell.arr_data.count) * 51) + 45)
                    
                    self.tableChecklistHeight.constant += cellHeight
                    
                    
                    self.tableChecklist.reloadRows(at: [indexPath], with: UITableView.RowAnimation.automatic)
                }
            }
            
            return cell
        }else{
            let cell = tableView.dequeueReusableCell(withIdentifier: "TaskCommentCell", for: indexPath) as! TaskCommentCell
            
            let obj = arr_comments[indexPath.item]
            cell.arr_reply = obj.reply
            cell.dropView.isHidden = obj.isHidden
            cell.replyView.isHidden = obj.isHiddenReply
            
            cell.repliesButton.isHidden = cell.arr_reply.isEmpty
            cell.editButton.isHidden = obj.emp_id != Auth_User.user_id
            cell.deleteButton.isHidden = obj.emp_id != Auth_User.user_id
            
            cell.comment_id = obj.history_id
            cell.lblDate.text = obj.insert_date
            cell.lblUserName.text = obj.emp_name
            cell.lblComment.text = obj.notes_history
            cell.setUpTable()
            cell.editButton.setUnderLine(stringValue: "Edit", withTextSize: 12)
            cell.deleteButton.setUnderLine(stringValue: "Delete", withTextSize: 12)
            cell.replyButton.setUnderLine(stringValue: "Reply", withTextSize: 12)
            
            if obj.isHidden {
                cell.repliesButton.setUnderLine(stringValue: "view replys", withTextSize: 12)
            }else{
                cell.repliesButton.setUnderLine(stringValue: "Hide replys", withTextSize: 12)
            }
            
            cell.btnAddReply = { comment_id , note in
                self.addReplyToComment(commentId: comment_id, note: note, index: indexPath.row)
            }
            
            cell.btnViewReplyAction = { isHidden in
                obj.isHidden = isHidden
                self.table_Activity.reloadRows(at: [IndexPath(row: indexPath.row, section: 0)], with: UITableView.RowAnimation.automatic)
            }
            
            
            cell.reloadReplyView = { isHidden  in
                obj.isHiddenReply = isHidden
                self.table_Activity.reloadRows(at: [IndexPath(row: indexPath.row, section: 0)], with: .automatic)
            }
            
            cell.btnDeleteReplyAction = { comment_id ,replyIndex in
                self.delete_comment(comment_id: comment_id,commentIndex:indexPath.row,replyIndex:replyIndex)
            }
            
            cell.btnEditReplyAction = {  comment_id , comment , replyIndex in
                
                let vc = EditTicketCommentVC()
                vc.commentId = comment_id
                vc.commentIndex = indexPath.row
                vc.reply = comment
                vc.replyIndex = replyIndex
                vc.isReply = true
                let nav = UINavigationController(rootViewController: vc)
                nav.setNavigationBarHidden(true, animated: false)
                nav.modalPresentationStyle = .overCurrentContext
                self.navigationController?.present(nav, animated: true)
            }
            
            self.viewWillLayoutSubviews()
            
            return cell
        }
    }
    
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        self.viewWillLayoutSubviews()
    }
    
    func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        if tableView == tableChecklist{
            return 100
        }else{
            return UITableView.automaticDimension
        }
    }
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if tableView == tableChecklist{
            
            let obj = arr_data[indexPath.item]
            obj.isHidden = !(obj.isHidden )
            let cell = tableChecklist.cellForRow(at: indexPath) as! CheckListCell
            let unSelectedArr = cell.arr_data.filter({$0.is_done == "1"}).count
            let cellHeight = CGFloat(((cell.hideSelectedItems ? unSelectedArr : cell.arr_data.count) * 51) + 45)
            let tableHeight = tableChecklistHeight.constant
            
            tableChecklistHeight.constant = obj.isHidden ? tableHeight - cellHeight : tableHeight + cellHeight
            
            tableChecklist.reloadRows(at: [indexPath], with: UITableView.RowAnimation.automatic)
            
        }else{
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
                //                self.delete_comment(comment_id: obj.history_id,commentIndex: )
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
            
            
        }
    }
    
}


extension TaskDetailVC: UITextViewDelegate {
    
    func textViewDidBeginEditing(_ textView: UITextView) {
        if txt_comment.textColor == .lightGray {
            txt_comment.text = ""
            txt_comment.textColor = .darkGray
            txt_comment.font = .kufiRegularFont(ofSize: 15)
            
        }
    }
    
    
    func textViewDidEndEditing(_ textView: UITextView) {
        
        if txt_comment.text == "" {
            
            txt_comment.text = "comment".localized()
            txt_comment.font = .kufiRegularFont(ofSize: 15)
            txt_comment.textColor = .lightGray
        }
        
    }
    
}

// MARK: - API Handling

extension TaskDetailVC{
    
    private func addReplyToComment(commentId:String,note:String,index:Int){
        showLoadingActivity()
        APIController.shard.addTaskReplyToComment(taskId: task_id, reply: note, comment_id: commentId) { data in
            self.hideLoadingActivity()
            if data.status == nil || data.status == false{
                SCLAlertView().showError("error".localized(), subTitle: data.error ?? "Something went wrong")
            }
        }
    }
    
    
    private func get_Chicklist_data(){
        
        self.showLoadingActivity()
        let param :[String:Any] = ["task_id" : task_id]
        
        APIController.shard.sendRequestPostAuth(urlString: "tasks/get_points_task_main", parameters: param ) { (response) in
            DispatchQueue.main.async {
                
                self.arr_data.removeAll()
                let status = response["status"] as? Bool
                if status == true{
                    if  let records = response["data"] as? NSArray{
                        for i in records {
                            let dict = i as? [String:Any]
                            let obj =  PointTaskObj.init(dict!)
                            self.arr_data.append(obj)
                        }
                        self.tableChecklistHeight.constant = CGFloat(self.arr_data.count * 100)
                        self.tableChecklist.reloadData()
                        self.hideLoadingActivity()
                    }
                }else{
                    self.tableChecklistHeight.constant = 0
                    self.hideLoadingActivity()
                }
            }
        }
    }
    
    
    private func get_data(){
        
        self.showLoadingActivity()
        
        let param:[String:Any] = ["task_id" : self.task_id]
        APIController.shard.sendRequestPostAuth(urlString: "tasks/get_task_only", parameters: param ) { (response) in
            self.hideLoadingActivity()
            
            let status = response["status"] as? Bool
            
            if status == true{
                
                if  let data = response["data"] as? [String:Any]{
                    
                    let obj =  TaskObj(data)
                    self.object = obj
                }
                self.configGUI()
                self.hideLoadingActivity()
                
            }else{
                self.hideLoadingActivity()
            }
        }
    }
    
    
    private func get_comment_tasks(){
        
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
                    
                    self.table_Activity.reloadData()
                    self.hideLoadingActivity()
                    
                }else{
                    self.hideLoadingActivity()
                }
            }
        }
        
    }
    
    
    private func get_add_task(){
        
        self.showLoadingActivity()
        
        APIController.shard.sendRequestPostAuth(urlString: "tasks/get_add_task", parameters: [:] ) { (response) in
            self.hideLoadingActivity()
            let status = response["status"] as? Bool
            
            if status == true{
                
                if let data = response["data"] as? [String:Any] {
                    
                    
                    if  let status_done = data["task_status_done"] as? NSArray{
                        for i in status_done {
                            let dict = i as? [String:Any]
                            let obj = importantObj.init(dict!)
                            self.arr_statusDone.append(obj)
                        } }
                    
                }
            }else{
                self.hideLoadingActivity()
            }
        }
    }
    
    
    private func change_status(task_id:String, status:String){
        
        self.showLoadingActivity()
        let param :[String:Any] = ["task_id" : task_id,"status":status]
        
        APIController.shard.sendRequestPostAuth(urlString: "tasks/change_status_done", parameters: param ) { (response) in
            self.hideLoadingActivity()
            
            //            let status = response["status"] as? Bool
            self.hideLoadingActivity()
            
        }
    }
    
    
    private func delete_task(task_id:String){
        
        self.showLoadingActivity()
        let param :[String:Any] = ["task_id" : task_id]
        
        APIController.shard.sendRequestPostAuth(urlString: "tasks/delete_task", parameters: param ) { (response) in
            self.hideLoadingActivity()
            
            let status = response["status"] as? Bool
            let message = response["message"] as? String
            if status == true{
                self.hideLoadingActivity()
                self.showAMessage(withTitle: "", message: message ?? "Deletion process has been successful", completion: {
                    self.delegate!()
                    self.navigationController?.popViewController(animated: true)
                })
            }else{
                self.hideLoadingActivity()
                
            }
        }
    }
    
    
    
    private func delete_comment(comment_id:String,commentIndex:Int,replyIndex:Int?){
        self.showLoadingActivity()
        let param :[String:Any] = ["comment_id" : comment_id]
        
        APIController.shard.sendRequestPostAuth(urlString: "tasks/delete_comment_reply", parameters: param ) { (response) in
            self.hideLoadingActivity()
            
            let status = response["status"] as? Bool
            if status == false || status == nil{
                SCLAlertView().showError("Delete Failed", subTitle: response["error"] as? String ?? "")
            }
        }
    }
    
    
    private func Add_comment(title:String){
        
        self.showLoadingActivity()
        let param : [String:Any] = ["task_id" : self.task_id,
                                    "notes" : title]
        APIController.shard.sendRequestPostAuth(urlString: "tasks/add_comment_task", parameters: param ) { (response) in
            self.hideLoadingActivity()
            
            let status = response["status"] as? Bool
            
            if status == false || status == nil{
                SCLAlertView().showError("error".localized(), subTitle: response["error"] as? String ?? "Something went wrong")
            }else{
                self.txt_comment.text = "comment".localized()
            }
        }
    }
    
    
    
    private func delete_item(point_id:String){
        
        self.showLoadingActivity()
        let param :[String:Any] = ["point_id" : point_id]
        
        APIController.shard.sendRequestPostAuth(urlString: "tasks/delete_task_point_main", parameters: param ) { (response) in
            self.hideLoadingActivity()
            
            let status = response["status"] as? Bool
            let error = response["error"] as? String
            if status == false || status == nil{
                SCLAlertView().showError("error".localized(), subTitle: error ?? "Something went wrong")
            }
        }
    }
    
}


// MARK: - Socket Handling

extension TaskDetailVC{
    
    private func addSocketObservers(){
        commentsSocket()
        checkListSocket()
    }
    
    private func checkListSocket(){
        SocketIOController.shard.taskCheckListsHandler(ticketId: ticket_id, taskId: task_id, userID: Auth_User.user_id) { data in
            print("DATATTTTTAAAAAA",data)
            
            guard let data = data.first as? [String:Any],
                  let content = data["content"] as? [String:Any],
                  let type = data["type"] as? String
            else { return }
            
            switch type{
                
            case "add_checklist":
                let obj = PointTaskObj(content)
                self.arr_data.insert(obj, at: 0)
                self.tableChecklist.insertRows(at: [IndexPath(row: 0, section: 0)], with: .automatic)
                
            case "update_checklist":
                let obj = PointTaskObj(content)
                let index = self.arr_data.firstIndex(where: {$0.check_id == obj.check_id})
                if let index = index {
                    self.arr_data[index].title = obj.title
                    self.tableChecklist.reloadRows(at: [IndexPath(row: index, section: 0)], with: .automatic)
                }
                
            case "delete_checklist":
                guard let check_id = content["check_id"] as? Int
                else { return }
                let index = self.arr_data.firstIndex(where: {$0.check_id == String(check_id)})
                if let index = index {
                    self.arr_data.remove(at: index)
                    self.tableChecklist.deleteRows(at: [IndexPath(row: index, section: 0)], with: .automatic)
                }
                
            case "add_checklist_item":
                guard let check_id = content["check_id"] as? Int
                else { return }
                let index = self.arr_data.firstIndex(where: {$0.check_id == String(check_id)})
                if let index = index , let check_item = content["check_item"] as? [String:Any]{
                    let obj = SubCheckObj(check_item)
                    self.arr_data[index].sub_checks.insert(obj, at: 0)
                    if !self.arr_data[index].isHidden{
                        self.tableChecklistHeight.constant += 45
                    }
                    self.tableChecklist.reloadRows(at: [IndexPath(row: index, section: 0)], with: .automatic)
                }
                
            case "update_checklist_item":
                guard let check_id = content["check_id"] as? Int
                else { return }
                
                let index = self.arr_data.firstIndex(where: {$0.check_id == String(check_id)})
                if let index = index , let check_item = content["check_item"] as? [String:Any]{
                    let obj = SubCheckObj(check_item)
                    let itemIndex = self.arr_data[index].sub_checks.firstIndex(where: {$0.check_id == obj.check_id})
                    if let itemIndex = itemIndex {
                        self.arr_data[index].sub_checks[itemIndex] = obj
                        self.tableChecklist.reloadRows(at: [IndexPath(row: index, section: 0)], with: .automatic)
                    }
                }
                
            case "delete_checklist_item":
                guard let check_id = content["check_id"] as? String,
                      let item_check_id = content["check_item_id"] as? Int
                else { return }
                
                let index = self.arr_data.firstIndex(where: {$0.check_id == check_id})
                if let index = index{
                    let itemIndex = self.arr_data[index].sub_checks.firstIndex(where: {$0.check_id == String(item_check_id)})
                    if let itemIndex = itemIndex {
                        self.arr_data[index].sub_checks.remove(at: itemIndex)
                        self.tableChecklist.reloadRows(at: [IndexPath(row: index, section: 0)], with: .automatic)
                    }
                }
            case "change_progress":
                guard let check_id = content["check_id"] as? String,
                      let sub_check_id = content["sub_check_id"] as? Int,
                      let new_status = content["new_status"] as? String
                else { return }
                
                let index = self.arr_data.firstIndex(where: {$0.check_id == check_id})
                if let index = index{
                    let itemIndex = self.arr_data[index].sub_checks.firstIndex(where: {$0.check_id == String(sub_check_id)})
                    if let itemIndex = itemIndex {
                        self.arr_data[index].sub_checks[itemIndex].is_done = new_status
                        self.tableChecklist.reloadRows(at: [IndexPath(row: index, section: 0)], with: .automatic)
                    }
                }
                
                
            default:
                break
            }
            
        }
    }
    
    
    
    private func commentsSocket(){
        SocketIOController.shard.commentsTaskHandler(ticketId: ticket_id , taskId: task_id, userID: Auth_User.user_id) { data in
            guard let data = data.first as? [String:Any],
                  let content = data["content"] as? [String:Any],
                  let type = data["type"] as? String
            else { return }
            
            switch type{
            case "add_comment":
                let obj = CommentObj.init(content)
                self.arr_comments.append(obj)
                self.table_Activity.insertRows(at: [IndexPath(row: self.arr_comments.count - 1, section: 0)], with: .automatic)
            case "edit_comment":
                let obj = CommentObj.init(content)
                let index = self.arr_comments.firstIndex(where: {$0.history_id == obj.history_id})
                if let index = index {
                    self.arr_comments[index] = obj
                    self.table_Activity.reloadRows(at: [IndexPath(row: index, section: 0)], with: .automatic)
                }
            case "delete_comment":
                let obj = CommentObj.init(content)
                let index = self.arr_comments.firstIndex(where: {$0.history_id == obj.history_id})
                if let index = index {
                    self.arr_comments.remove(at: index)
                    self.table_Activity.deleteRows(at: [IndexPath(row: index, section: 0)], with: .automatic)
                }
            case "add_reply":
                guard let comment_id = content["comment_id"] as? Int,
                      let dic = content["reply"] as? [String:Any]
                else { return }
                
                
                let reply = ReplyObj.init(dic)
                let index = self.arr_comments.firstIndex(where: {$0.history_id == String(comment_id)})
                if let index = index {
                    self.arr_comments[index].reply.append(reply)
                    self.table_Activity.reloadRows(at: [IndexPath(row: index, section: 0)], with: .automatic)
                }
                
            case "edit_reply":
                guard let comment_id = content["comment_id"] as? String,
                      let dic = content["reply"] as? [String:Any]
                else { return }
                
                let reply = ReplyObj.init(dic)
                let index = self.arr_comments.firstIndex(where: {$0.history_id == comment_id})
                if let index = index {
                    let replyIndex = self.arr_comments[index].reply.firstIndex(where: {$0.history_id == reply.history_id})
                    if let replyIndex = replyIndex{
                        self.arr_comments[index].reply[replyIndex] = reply
                        self.table_Activity.reloadRows(at: [IndexPath(row: index, section: 0)], with: .automatic)
                    }
                }
                
            case "delete_reply":
                guard let comment_id = content["comment_id"] as? String,
                      let reply_id = content["reply_id"] as? Int
                else { return }
                let index = self.arr_comments.firstIndex(where: {$0.history_id == comment_id})
                if let index = index {
                    let replyIndex = self.arr_comments[index].reply.firstIndex(where: {$0.history_id == String(reply_id)})
                    if let replyIndex = replyIndex{
                        self.arr_comments[index].reply.remove(at: replyIndex)
                        self.table_Activity.reloadRows(at: [IndexPath(row: index, section: 0)], with: .automatic)
                    }
                }
            default:
                break
            }
        }
    }
}


extension UIScrollView {
    
    func resizeScrollViewContentSize() {
        
        var contentRect = CGRect.zero
        
        for view in self.subviews {
            
            contentRect = contentRect.union(view.frame)
            
        }
        
        self.contentSize = contentRect.size
        
    }
    
}
