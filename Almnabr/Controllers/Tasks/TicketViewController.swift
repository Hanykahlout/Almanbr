//
//  TicketViewController.swift
//  Almnabr
//
//  Created by Hany Alkahlout on 31/07/2022.
//  Copyright © 2022 Samar Akkila. All rights reserved.
//


import UIKit
import MobileCoreServices
import SCLAlertView

class TicketViewController: UIViewController {

    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var statusView: UIView!
    
    var arr_data:[TaskObj] = []
    var ticket_id:String = ""
    var isFromNotificaion:Bool = false
    var boards:[Board] = []
    var object:TicketObj?
    
    private var isAdd = false
    private let status:[String:String] = ["1":"New","2":"In Progress","3":"Confirm","4":"Done"]
    private var selectedTicketStatus = "2"
    

    override func viewDidLoad() {
        super.viewDidLoad()
        setUpStatusView()
        getTicketRowDate()
        set_data()
        updateCollectionViewItem(with: view.bounds.size)
        get_data()
        setupNavigationBar()
        configNavigation()
        addSocketObservers()
        setUpCollectionView()
    }
    
    
    private func setUpStatusView(){
        statusView.isUserInteractionEnabled = true
        statusView.addTapGesture {
            self.getNewTicketStatus()
            self.showLoadingActivity()
            APIController.shard.changeTicketStatus(status: self.selectedTicketStatus, ticketId: self.ticket_id) { data in
                DispatchQueue.main.async {
                    self.hideLoadingActivity()
                    if let status = data.status , status{
                        self.setTicketStatus(status: self.selectedTicketStatus)
                    }else{
                        self.selectedTicketStatus = "1"
                    }
                }
            }
        }
    }

    
    private func getTicketRowDate(){
        APIController.shard.getTicketRow(ticketId: ticket_id) { data in
            if let status = data.status,status{
                self.isAdd = data.data?.canAddTask ?? false
                self.setTicketStatus(status: data.data?.ticket_status ?? "")
                self.collectionView.reloadData()
            }
        }
    }
    
    
    private func setTicketStatus(status:String){
        selectedTicketStatus = status
        switch status{
        case "1":
            //            Pending
            statusView.backgroundColor = .orange
        case "2":
            //            In Progress
            statusView.backgroundColor = .green
        case "3":
            //            Closed
            statusView.backgroundColor = .red
        default:
            break
        }
    }

    
    private func getNewTicketStatus(){
        switch selectedTicketStatus{
        case "3":
            selectedTicketStatus = "2"
        case "2":
            selectedTicketStatus = "1"
        case "1":
            selectedTicketStatus = "3"
        default:
            break
        }
        
    }
   

    
    private func setupNavigationBar() {
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
    
    
    // MARK: - Config Navigation
    
    func configNavigation() {
        
        _ = self.navigationController?.preferredStatusBarStyle
        self.view.backgroundColor = maincolor //F0F4F8
        //navigationController?.navigationBar.barTintColor = .buttonBackgroundColor()
        navigationController?.navigationBar.barTintColor = maincolor
        addNavigationBarTitlee(navigationTitle: "\(object?.ticket_titel ?? "---") - \(object?.ticket_no ?? "--")")
        UINavigationBar.appearance().backgroundColor = maincolor
    }
    
    
    func set_data(){
        
        var arr_1:[TaskObj] = []
        var arr_2:[TaskObj] = []
        var arr_3:[TaskObj] = []
        var arr_4:[TaskObj] = []
        
        for i in arr_data{
            switch i.task_status  {
            case "1":
                arr_1.append(i)
            case "2":
                arr_2.append(i)
            case "3":
                arr_3.append(i)
            case "4":
                arr_4.append(i)
            default:
                print("nil")
            }
        }

        self.boards = [
            Board(title: "New", items: arr_1 ),
            Board(title: "In Progress", items:  arr_2),
            Board(title: "Confirm", items:  arr_3),
            Board(title: "Done", items:  arr_4)
        ]
        
        self.collectionView.reloadData()
        
    }
    
    
    override func viewWillTransition(to size: CGSize, with coordinator: UIViewControllerTransitionCoordinator) {
        super.viewWillTransition(to: size, with: coordinator)
        updateCollectionViewItem(with: size)
    }
    
    
    private func updateCollectionViewItem(with size: CGSize) {
        guard let layout = collectionView.collectionViewLayout as? UICollectionViewFlowLayout else {
            return
        }
        layout.itemSize = CGSize(width: 225, height: size.height * 0.8)
    }
    
    func setupAddButtonItem() {
        //        let addButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(addListTapped(_:)))
        //        navigationItem.rightBarButtonItem = addButtonItem
        let activityButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(addListTapped(_:)))
        navigationItem.rightBarButtonItem = activityButtonItem
        let infoButtonItem = UIBarButtonItem(barButtonSystemItem: .edit, target: self, action: #selector(addListTapped(_:)))
        navigationItem.rightBarButtonItem = infoButtonItem
        
        let GroupImage  =  UIImage.fontAwesomeIcon(name: .ellipsisH , style: .solid, textColor:  .gray, size: CGSize(width: 20, height: 20))
        let commentImage  = UIImage.fontAwesomeIcon(name: .comment , style: .solid, textColor:  .gray, size: CGSize(width: 20, height: 20))
        
        let attachImage  = UIImage.fontAwesomeIcon(name: .paperclip , style: .solid, textColor:  .gray, size: CGSize(width: 20, height: 20))
        
        let GroupButton   = UIBarButtonItem(image: GroupImage,  style: .plain, target: self, action: #selector(didTapGroupButton(sender:)))
        
        let commentBtn = UIBarButtonItem(image: commentImage,  style: .plain, target: self, action: #selector(didTapCommentButton(sender:)))
        
        let attachButton = UIBarButtonItem(image: attachImage,  style: .plain, target: self, action: #selector(didTapAttachmentButton(sender:)))
        
        
        navigationItem.rightBarButtonItems = [GroupButton, commentBtn , attachButton]
    }
    
    
    func get_data(){
        
        self.showLoadingActivity()
        let param :[String:Any] = ["ticket_id" : self.ticket_id]
        
        APIController.shard.sendRequestPostAuth(urlString: "tasks/get_tasks", parameters: param ) { (response) in
            self.hideLoadingActivity()
            self.arr_data = []
            let status = response["status"] as? Bool
            if status == true{
                
                if  let records = response["data"] as? NSArray{
                    for i in records {
                        let dict = i as? [String:Any]
                        let obj =  TaskObj.init(dict!)
                        self.arr_data.append(obj)
                    }
                    self.set_data()
                    self.hideLoadingActivity()
                    if self.isFromNotificaion == true {
                        self.configNavigation()
                    }
                }
                
            }else{
                self.hideLoadingActivity()
                
            }
        }
    }
    
    func change_status(task_id:String, status:String){
        
        self.showLoadingActivity()
        let param :[String:Any] = ["task_id" : task_id,"status":status]
        
        APIController.shard.sendRequestPostAuth(urlString: "tasks/change_status_task", parameters: param ) { (response) in
            self.hideLoadingActivity()
            
            let status = response["status"] as? Bool
            if status == true{
                self.get_data()
                
            }else{
                self.hideLoadingActivity()
                
            }
        }
    }

    
    @objc func didTapGroupButton(sender: AnyObject){
        let vc:TaskHistoryVC = AppDelegate.TicketSB.instanceVC()
        vc.ticket_id =  object!.ticket_id
        self.navigationController?.pushViewController(vc, animated: true)
        
    }
    
    @objc func didTapAttachmentButton(sender: AnyObject){
        let vc:TaskAttachmentVC = AppDelegate.TicketSB.instanceVC()
        vc.ticket_id =  object!.ticket_id
        vc.is_from_task = false
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    @objc func didTapCommentButton(sender: AnyObject){
        let vc:CommentsViewController = AppDelegate.TicketSB.instanceVC()
        vc.ticketId = ticket_id
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    
    @objc func addListTapped(_ sender: Any) {
        let alertController = UIAlertController(title: "Add List", message: nil, preferredStyle: .alert)
        alertController.addTextField(configurationHandler: nil)
        alertController.addAction(UIAlertAction(title: "Add", style: .default, handler: { (_) in
            guard let text = alertController.textFields?.first?.text, !text.isEmpty else {
                return
            }
            
            self.boards.append(Board(title: text, items: []))
            
            let addedIndexPath = IndexPath(item: self.boards.count - 1, section: 0)
            
            self.collectionView.insertItems(at: [addedIndexPath])
            self.collectionView.scrollToItem(at: addedIndexPath, at: UICollectionView.ScrollPosition.centeredHorizontally, animated: true)
        }))
        
        alertController.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
        present(alertController, animated: true)
    }
    
    @IBAction func infoAction(_ sender: Any) {
        let vc:TicketDetailsVC = AppDelegate.TicketSB.instanceVC()
        vc.object =  object
        vc.ticket_id =  object!.ticket_id
        self.navigationController?.pushViewController(vc, animated: true)
        
    }
    
    
}


extension TicketViewController:UICollectionViewDelegate,UICollectionViewDataSource , UICollectionViewDelegateFlowLayout{
    private func setUpCollectionView(){
        collectionView.delegate = self
        collectionView.dataSource = self
        
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return boards.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "Cell", for: indexPath) as! BoardCollectionViewCell
        
        cell.setup(with: boards[indexPath.item])
        cell.parentVC = self
        cell.arr_task = self.arr_data
        cell.addView.isHidden = !isAdd

        cell.btnAddTaskAction = {
            let vc:AddTaskVC = AppDelegate.TicketSB.instanceVC()
            vc.delegate = {
                self.get_data()
            }
            vc.status = "\(indexPath.item + 1)"
            vc.ticket_id = self.object?.ticket_id ?? "0"
            vc.arr_related_task = self.arr_data
            vc.strTitle = "Add Task".localized()
            self.navigationController?.pushViewController(vc, animated: true)
        }
        
        cell.btnEditTaskAction = { task_id , object in
            if (self.object?.can_edit ?? false) {
                let vc:AddTaskVC = AppDelegate.TicketSB.instanceVC()
                vc.delegate = {
                    self.get_data()
                }
                vc.isEdit = true
                vc.task_id  = task_id
                vc.object = object
                vc.status = "\(indexPath.item + 1)"
                vc.ticket_id = self.object?.ticket_id ?? "0"
                vc.arr_related_task = self.arr_data
                vc.strTitle = "Edit Task".localized()
                self.navigationController?.pushViewController(vc, animated: true)
            }else{
                SCLAlertView().showNotice("You do not have permissions to edit this task", subTitle: "")
            }
        }
        
        cell.btnChangeStatusAction = { task_id , status in
                self.change_status(task_id: task_id, status: "\(status)")
        }
        
        cell.btnSelectAction = { task_id  in
            if (self.object?.can_view ?? false) {
                let vc:TaskDetailVC = AppDelegate.TicketSB.instanceVC()
                vc.ticket_id = self.ticket_id
                vc.task_id =  task_id
                vc.canDelete = self.object?.can_delete ?? false
                vc.delegate = {
                    self.get_data()
                }
                
                self.navigationController?.pushViewController(vc, animated: true)
            }else{
                SCLAlertView().showNotice("You do not have permissions to view this task", subTitle: "")
            }
        }
        
        return cell
    }
}

// MARK: - Socket IO Handling
extension TicketViewController{
    
    private func addSocketObservers(){

        SocketIOController.shard.ticketStatus(ticketId: ticket_id, userID: Auth_User.user_id) { data in
            guard let data = data.first as? [String:Any] else { return }
            guard let content = data["content"] as? [String:Any] else { return }
            let status = content["ticket_status"] as? String ?? ""
            DispatchQueue.main.async {
                self.setTicketStatus(status: String(status))
            }
        }
        
        SocketIOController.shard.taskHandler(ticketId: ticket_id, userID: Auth_User.user_id) { data in
            guard let data = data.first as? [String:Any] else { return }
            guard let content = data["content"] as? [String:Any] else { return }
            let index = Int(content["task_status"] as! String)! - 1
            let obj =  TaskObj.init(content)
            
            if let type = data["type"] as? String{
                switch type {
                case "edit_task":
                    self.boards[index].items.removeAll{$0.task_id == content["task_id"] as! String}
                    self.boards[index].items.append(obj)
                case "add_task":
                    self.boards[index].items.append(obj)
                case "delete_task":
                    self.boards[index].items.removeAll{$0.task_id == String(content["task_id"] as! Int)}
                case "change_status_task":
                    var oldIndex:Int?
                    for statusTable in self.boards{
                        for index in 0..<statusTable.items.count{
                            if statusTable.items[index].task_id == content["task_id"] as! String{
                                oldIndex = Int(statusTable.items[index].task_status)! - 1
                                self.boards[oldIndex!].items.remove(at: index)
                                break
                            }
                        }
                     
                    }
                    
                    if let oldIndex = oldIndex {
                        DispatchQueue.main.async {
                            let cell = self.collectionView.cellForItem(at: IndexPath(row: oldIndex, section: 0)) as! BoardCollectionViewCell
                            cell.tableView.reloadData()
                        }
                        
                    }
                    
                    
                    NotificationCenter.default.post(name: .init(rawValue: "UpdateTaskStatus"), object: obj.status_done_name)
                    self.boards[index].items.append(obj)
                default:
                    break
                }
                
                let cell = self.collectionView.cellForItem(at: IndexPath(row: index, section: 0)) as! BoardCollectionViewCell
                cell.tableView.reloadData()
            }
        }
    }
}



class Board {
    
    var title: String
    var items: [TaskObj]
    
    init(title: String, items: [TaskObj]) {
        self.title = title
        self.items = items
    }
}


struct TaskSocketResponse{
    var content:TaskObj?
    var type: String?
}


