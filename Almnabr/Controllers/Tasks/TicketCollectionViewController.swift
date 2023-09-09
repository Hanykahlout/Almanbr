//
//  TicketCollectionViewController.swift
//  Almnabr
//
//  Created by MacBook on 24/04/2022.
//  Copyright © 2022 Samar Akkila. All rights reserved.
//

//import UIKit
//import MobileCoreServices
//import SCLAlertView
//
//class TicketCollectionViewController: UICollectionViewController, UICollectionViewDelegateFlowLayout {
//
//    var arr_data:[TaskObj] = []
//    var ticket_id:String = ""
//    var isFromNotificaion:Bool = false
//    private let status:[String:String] = ["1":"New","2":"In Progress","3":"Confirm","4":"Done"]
//
//    var boards:[Board] = []
//
//    var object:TicketObj?
//    private var isAdd = false
//
//    override func viewDidLoad() {
//        super.viewDidLoad()
//        getTicketRowDate()
//        set_data()
//        updateCollectionViewItem(with: view.bounds.size)
//        get_data()
//        setupNavigationBar()
//        configNavigation()
//        addSocketObserver()
//    }
//
//    private func getTicketRowDate(){
//        APIController.shard.getTicketRow(ticketId: ticket_id) { data in
//            if let status = data.status,status{
//                self.isAdd = data.data?.canAddTask ?? false
//                self.collectionView.reloadData()
//            }
//        }
//    }
//
//
//    private func addSocketObserver(){
//        SocketIOController.shard.ticketStatus(ticketId: ticket_id, userID: Auth_User.user_id) { data in
//            print("TESTING \(data)")
//        }
//
//        SocketIOController.shard.taskHandler(ticketId: ticket_id, userID: Auth_User.user_id) { data in
//            guard let data = data.first as? [String:Any] else { return }
//            guard let content = data["content"] as? [String:Any] else { return }
//            let index = Int(content["task_status"] as! String)! - 1
//            let obj =  TaskObj.init(content)
//
//            if let type = data["type"] as? String{
//                switch type {
//                case "edit_task":
//                    self.boards[index].items.removeAll{$0.task_id == content["task_id"] as! String}
//                    self.boards[index].items.append(obj)
//                case "add_task":
//                    self.boards[index].items.append(obj)
//                case "delete_task":
//                    self.boards[index].items.removeAll{$0.task_id == String(content["task_id"] as! Int)}
//                case "change_status_task":
//                    var oldIndex:Int?
//                    for statusTable in self.boards{
//                        var isExist = false
//                        for index in 0..<statusTable.items.count{
//                            if statusTable.items[index].task_id == content["task_id"] as! String{
//                                isExist = true
//                                oldIndex = Int(statusTable.items[index].task_status)! - 1
//                                self.boards[oldIndex!].items.remove(at: index)
//                                break
//                            }
//                        }
//
//                        if(isExist){
//                            break
//                        }
//                    }
//
//                    if let oldIndex = oldIndex {
//                        let cell = self.collectionView.cellForItem(at: IndexPath(row: oldIndex, section: 0)) as! BoardCollectionViewCell
//                        cell.tableView.reloadData()
//                    }
//
//                    self.boards[index].items.append(obj)
//                default:
//                    break
//                }
//
//                let cell = self.collectionView.cellForItem(at: IndexPath(row: index, section: 0)) as! BoardCollectionViewCell
//                cell.tableView.reloadData()
//            }
//        }
//    }
//
//    private func setupNavigationBar() {
//        setupAddButtonItem()
//    }
//
//
//    override func viewWillAppear(_ animated: Bool) {
//        super.viewWillAppear(animated)
//        // Hide the Navigation Bar
//
//        self.navigationController?.setNavigationBarHidden(false, animated: true)
//    }
//
//
//    override func viewWillDisappear(_ animated: Bool) {
//        super.viewWillDisappear(animated)
//        // Show the Navigation Bar
//        self.navigationController?.setNavigationBarHidden(false, animated: true)
//    }
//
//    // MARK: - Config Navigation
//    func configNavigation() {
//
//        _ = self.navigationController?.preferredStatusBarStyle
//        self.view.backgroundColor = maincolor //F0F4F8
//        //navigationController?.navigationBar.barTintColor = .buttonBackgroundColor()
//        navigationController?.navigationBar.barTintColor = maincolor
//        addNavigationBarTitlee(navigationTitle: "\(object?.ticket_titel ?? "---") - \(object?.ticket_no ?? "--")")
//        UINavigationBar.appearance().backgroundColor = maincolor
//    }
//
//    func set_data(){
//
//        var arr_1:[TaskObj] = []
//        var arr_2:[TaskObj] = []
//        var arr_3:[TaskObj] = []
//        var arr_4:[TaskObj] = []
//
//        for i in arr_data{
//            switch i.task_status  {
//            case "1":
//                arr_1.append(i)
//            case "2":
//                arr_2.append(i)
//            case "3":
//                arr_3.append(i)
//            case "4":
//                arr_4.append(i)
//            default:
//                print("nil")
//            }
//        }
//
//
//        self.boards = [
//            Board(title: "New", items: arr_1 ),
//            Board(title: "In Progress", items:  arr_2),
//            Board(title: "Confirm", items:  arr_3),
//            Board(title: "Done", items:  arr_4)
//        ]
//        self.collectionView.reloadData()
//
//    }
//
//    override func viewWillTransition(to size: CGSize, with coordinator: UIViewControllerTransitionCoordinator) {
//        super.viewWillTransition(to: size, with: coordinator)
//        updateCollectionViewItem(with: size)
//    }
//
//    private func updateCollectionViewItem(with size: CGSize) {
//        guard let layout = collectionView.collectionViewLayout as? UICollectionViewFlowLayout else {
//            return
//        }
//        layout.itemSize = CGSize(width: 225, height: size.height * 0.8)
//    }
//
//    func setupAddButtonItem() {
//        //        let addButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(addListTapped(_:)))
//        //        navigationItem.rightBarButtonItem = addButtonItem
//        let activityButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(addListTapped(_:)))
//        navigationItem.rightBarButtonItem = activityButtonItem
//        let infoButtonItem = UIBarButtonItem(barButtonSystemItem: .edit, target: self, action: #selector(addListTapped(_:)))
//        navigationItem.rightBarButtonItem = infoButtonItem
//
//        let GroupImage  =  UIImage.fontAwesomeIcon(name: .ellipsisH , style: .solid, textColor:  .gray, size: CGSize(width: 20, height: 20))
//        let infoImage  = UIImage.fontAwesomeIcon(name: .infoCircle , style: .solid, textColor:  .gray, size: CGSize(width: 20, height: 20))
//
//        let attachImage  = UIImage.fontAwesomeIcon(name: .paperclip , style: .solid, textColor:  .gray, size: CGSize(width: 20, height: 20))
//
//        let GroupButton   = UIBarButtonItem(image: GroupImage,  style: .plain, target: self, action: #selector(didTapGroupButton(sender:)))
//        let infoButton = UIBarButtonItem(image: infoImage,  style: .plain, target: self, action: #selector(didTapInfoButton(sender:)))
//
//        let attachButton = UIBarButtonItem(image: attachImage,  style: .plain, target: self, action: #selector(didTapAttachmentButton(sender:)))
//
//        navigationItem.rightBarButtonItems = [GroupButton, infoButton,attachButton]
//
//        //info.circle.fill
//        // rectangle.grid.2x2
//
//    }
//
//
//    func get_data(){
//
//        self.showLoadingActivity()
//        let param :[String:Any] = ["ticket_id" : self.ticket_id]
//
//        APIManager.sendRequestPostAuth(urlString: "tasks/get_tasks", parameters: param ) { (response) in
//            self.hideLoadingActivity()
//            self.arr_data = []
//            let status = response["status"] as? Bool
//            if status == true{
//
//                if  let records = response["data"] as? NSArray{
//                    for i in records {
//                        let dict = i as? [String:Any]
//                        let obj =  TaskObj.init(dict!)
//                        self.arr_data.append(obj)
//                    }
//                    self.set_data()
//                    self.hideLoadingActivity()
//                    if self.isFromNotificaion == true {
//                        self.configNavigation()
//                    }
//                }
//
//            }else{
//                self.hideLoadingActivity()
//
//            }
//        }
//    }
//
//    func change_status(task_id:String, status:String){
//
//        self.showLoadingActivity()
//        let param :[String:Any] = ["task_id" : task_id,"status":status]
//
//        APIManager.sendRequestPostAuth(urlString: "tasks/change_status_task", parameters: param ) { (response) in
//            self.hideLoadingActivity()
//
//            let status = response["status"] as? Bool
//            if status == true{
//                self.get_data()
//
//            }else{
//                self.hideLoadingActivity()
//
//            }
//        }
//    }
//
//
//
//    @objc func didTapGroupButton(sender: AnyObject){
//        let vc:TaskHistoryVC = AppDelegate.TicketSB.instanceVC()
//        vc.ticket_id =  object!.ticket_id
//        self.navigationController?.pushViewController(vc, animated: true)
//
//    }
//
//    @objc func didTapAttachmentButton(sender: AnyObject){
//        let vc:TaskAttachmentVC = AppDelegate.TicketSB.instanceVC()
//        vc.ticket_id =  object!.ticket_id
//        self.navigationController?.pushViewController(vc, animated: true)
//    }
//
//    @objc func didTapInfoButton(sender: AnyObject){
//        let vc:TicketDetailsVC = AppDelegate.TicketSB.instanceVC()
//        vc.object =  object
//        vc.ticket_id =  object!.ticket_id
//        self.navigationController?.pushViewController(vc, animated: true)
//    }
//
//    //    func setupRemoveBarButtonItem() {
//    //        let button = UIButton(type: .system)
//    //        button.setTitle("Delete", for: .normal)
//    //        button.setTitleColor(.red, for: .normal)
//    //        button.addInteraction(UIDropInteraction(delegate: self))
//    //        let removeBarButtonItem = UIBarButtonItem(customView: button)
//    //        navigationItem.leftBarButtonItem = removeBarButtonItem
//    //    }
//
//    @objc func addListTapped(_ sender: Any) {
//        let alertController = UIAlertController(title: "Add List", message: nil, preferredStyle: .alert)
//        alertController.addTextField(configurationHandler: nil)
//        alertController.addAction(UIAlertAction(title: "Add", style: .default, handler: { (_) in
//            guard let text = alertController.textFields?.first?.text, !text.isEmpty else {
//                return
//            }
//
//            self.boards.append(Board(title: text, items: []))
//
//            let addedIndexPath = IndexPath(item: self.boards.count - 1, section: 0)
//
//            self.collectionView.insertItems(at: [addedIndexPath])
//            self.collectionView.scrollToItem(at: addedIndexPath, at: UICollectionView.ScrollPosition.centeredHorizontally, animated: true)
//        }))
//
//        alertController.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
//        present(alertController, animated: true)
//    }
//
//    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
//        return boards.count
//    }
//
//    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
//        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "Cell", for: indexPath) as! BoardCollectionViewCell
//
//        cell.setup(with: boards[indexPath.item])
////        cell.parentVC = self
//        cell.arr_task = self.arr_data
//        cell.addView.isHidden = !isAdd
//
//        cell.btnAddTaskAction = {
//            let vc:AddTaskVC = AppDelegate.TicketSB.instanceVC()
//            vc.delegate = {
//                self.get_data()
//            }
//            vc.status = "\(indexPath.item + 1)"
//            vc.ticket_id = self.object?.ticket_id ?? "0"
//            vc.arr_related_task = self.arr_data
//            vc.strTitle = "Add Task".localized()
//            self.navigationController?.pushViewController(vc, animated: true)
//        }
//
//
//
//
//
//        cell.btnEditTaskAction = { task_id , object in
//            if (self.object?.can_edit ?? false) {
//                let vc:AddTaskVC = AppDelegate.TicketSB.instanceVC()
//                vc.delegate = {
//                    self.get_data()
//                }
//                vc.isEdit = true
//                vc.task_id  = task_id
//                vc.object = object
//                vc.status = "\(indexPath.item + 1)"
//                vc.ticket_id = self.object?.ticket_id ?? "0"
//                vc.arr_related_task = self.arr_data
//                vc.strTitle = "Edit Task".localized()
//                self.navigationController?.pushViewController(vc, animated: true)
//            }else{
//                SCLAlertView().showNotice("You do not have permissions to edit this task", subTitle: "")
//            }
//        }
//
//        cell.btnChangeStatusAction = { task_id , status in
//                self.change_status(task_id: task_id, status: "\(status)")
//        }
//
//        cell.btnSelectAction = { task_id  in
//            if (self.object?.can_view ?? false) {
//                let vc:TaskDetailVC = AppDelegate.TicketSB.instanceVC()
//                vc.task_id =  task_id
//                vc.canDelete = self.object?.can_delete ?? false
//                vc.delegate = {
//                    self.get_data()
//                }
//                self.navigationController?.pushViewController(vc, animated: true)
//            }else{
//                SCLAlertView().showNotice("You do not have permissions to view this task", subTitle: "")
//            }
//        }
//
//
//        //  AddTaskVC
//
//        // vc.delegate = {params  in
//
//        //            self.params = params
//        //            self.get_data(showLoading: true, loadOnly: true)
//        //}
//
//
//
//
//        return cell
//    }
//
//}

//extension TicketCollectionViewController: UIDropInteractionDelegate {
//
//    func dropInteraction(_ interaction: UIDropInteraction, sessionDidUpdate session: UIDropSession) -> UIDropProposal {
//        return UIDropProposal(operation: .move)
//    }
//
//    func dropInteraction(_ interaction: UIDropInteraction, performDrop session: UIDropSession) {
//
//        if session.hasItemsConforming(toTypeIdentifiers: [kUTTypePlainText as String]) {
//            session.loadObjects(ofClass: NSString.self) { (items) in
//                guard let _ = items.first as? String else {
//                    return
//                }
//
//                if let (dataSource, sourceIndexPath, tableView) = session.localDragSession?.localContext as? (Board, IndexPath, UITableView) {
//                    tableView.beginUpdates()
//                    dataSource.items.remove(at: sourceIndexPath.row)
//                    tableView.deleteRows(at: [sourceIndexPath], with: .automatic)
//                    tableView.endUpdates()
//                }
//            }
//        }
//    }
//}

