//
//  TicketCollectionViewCell.swift
//  Almnabr
//
//  Created by MacBook on 24/04/2022.
//  Copyright © 2022 Samar Akkila. All rights reserved.
//

import UIKit
import MobileCoreServices

class BoardCollectionViewCell: UICollectionViewCell, UIContextMenuInteractionDelegate {
    //    func contextMenuInteraction(_ interaction: UIContextMenuInteraction, configurationForMenuAtLocation location: CGPoint) -> UIContextMenuConfiguration? {
    //
    //    }
    //
    
    func contextMenuInteraction(_ interaction: UIContextMenuInteraction, configurationForMenuAtLocation location: CGPoint) -> UIContextMenuConfiguration? {
        return UIContextMenuConfiguration(identifier: nil, previewProvider: nil) { _ -> UIMenu? in
            return self.createContextMenu()
        }
    }
    
    @IBOutlet weak var addView: UIView!
    @IBOutlet weak var tableView: UITableView!
    weak var parentVC: TicketViewController?
    var board: Board?
    var arr_task:[TaskObj] = []
    var task_id:String = ""
    var btnAddTaskAction : (()->())?
    var btnEditTaskAction : ((_ task_id: String , _ object :TaskObj) -> Void)?
    var btnChangeStatusAction : ((_ task_id: String ,_ status:Int) -> Void)?
    var btnSelectAction : ((_ task_id: String) -> Void)?
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        self.layer.masksToBounds = true
        self.layer.cornerRadius = 10.0
        
        //tableView.dragInteractionEnabled = true
        //  tableView.dragDelegate = self
        // tableView.dropDelegate = self
        
        tableView.tableFooterView = UIView()
        let nib = UINib(nibName: "TaskTVCell", bundle: nil)
        tableView.register(nib, forCellReuseIdentifier: "TaskTVCell")
    }
    
    func setup(with data: Board) {
        self.board = data
        tableView.reloadData()
    }
    
    
    @IBAction func addTapped(_ sender: Any) {
        btnAddTaskAction!()
        
        
        //        let alertController = UIAlertController(title: "Add Item", message: nil, preferredStyle: .alert)
        //        alertController.addTextField(configurationHandler: nil)
        //        alertController.addAction(UIAlertAction(title: "Add", style: .default, handler: { (_) in
        //            guard let text = alertController.textFields?.first?.text, !text.isEmpty else {
        //                return
        //            }
        //
        //            guard let data = self.board else {
        //                return
        //            }
        //
        //            //data.items.append(text)
        //            let addedIndexPath = IndexPath(item: data.items.count - 1, section: 0)
        //
        //            self.tableView.insertRows(at: [addedIndexPath], with: .automatic)
        //            self.tableView.scrollToRow(at: addedIndexPath, at: UITableView.ScrollPosition.bottom, animated: true)
        //        }))
        //
        //        alertController.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
        //        parentVC?.present(alertController, animated: true, completion: nil)
    }
    
    func createContextMenu() -> UIMenu {
        let shareAction = UIAction(title: "New") { _ in
            self.btnChangeStatusAction!(self.task_id, 1)
        }
        let copy = UIAction(title: "in progress") { _ in
            self.btnChangeStatusAction!(self.task_id, 2)
        }
        let saveToPhotos = UIAction(title: "confirm") { _ in
            self.btnChangeStatusAction!(self.task_id, 3)
        }
        let done = UIAction(title: "done") { _ in
            self.btnChangeStatusAction!(self.task_id, 4)
        }
        return UIMenu(title: "", children: [shareAction, copy, saveToPhotos, done])
    }
    
    func NewMenu() -> UIMenu {
        
        let in_progress = UIAction(title: "in progress") { _ in
            self.btnChangeStatusAction!(self.task_id, 2)
        }
        let confirm = UIAction(title: "confirm") { _ in
            self.btnChangeStatusAction!(self.task_id, 3)
        }
        let done = UIAction(title: "done") { _ in
            self.btnChangeStatusAction!(self.task_id, 4)
        }
        return UIMenu(title: "", children: [ in_progress, confirm, done])
    }
    
    func in_progressMenu() -> UIMenu {
        
        let new = UIAction(title: "New") { _ in
            self.btnChangeStatusAction!(self.task_id, 1)
        }
        let confirm = UIAction(title: "confirm") { _ in
            self.btnChangeStatusAction!(self.task_id, 3)
        }
        let done = UIAction(title: "done") { _ in
            self.btnChangeStatusAction!(self.task_id, 4)
        }
        return UIMenu(title: "", children: [ new, confirm, done])
    }
    
    func ConfirmMenu() -> UIMenu {
        
        let new = UIAction(title: "New") { _ in
            self.btnChangeStatusAction!(self.task_id, 1)
        }
        let in_progress = UIAction(title: "in progress") { _ in
            self.btnChangeStatusAction!(self.task_id, 2)
        }
        
        let done = UIAction(title: "done") { _ in
            self.btnChangeStatusAction!(self.task_id, 4)
        }
        return UIMenu(title: "", children: [ new , in_progress, done])
    }
    
    func DoneMenu() -> UIMenu {
        
        let new = UIAction(title: "New") { _ in
            self.btnChangeStatusAction!(self.task_id, 1)
        }
        let in_progress = UIAction(title: "in progress") { _ in
            self.btnChangeStatusAction!(self.task_id, 2)
        }
        let confirm = UIAction(title: "confirm") { _ in
            self.btnChangeStatusAction!(self.task_id, 3)
        }
        return UIMenu(title: "", children: [new, in_progress, confirm])
    }
    
    
    
    
    
}

extension BoardCollectionViewCell: UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return board?.items.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return board?.title
    }
    
    func tableView(_ tableView: UITableView, willDisplayHeaderView view: UIView, forSection section: Int) {
        (view as! UITableViewHeaderFooterView).contentView.backgroundColor = UIColor.white.withAlphaComponent(0.6)
        (view as! UITableViewHeaderFooterView).textLabel?.textColor = maincolor
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "TaskTVCell", for: indexPath) as! TaskTVCell
        
        let obj = board!.items[indexPath.row]
        // cell.lbltitle?.text = "\(board!.items[indexPath.row])"
        cell.lbltitle?.text = "\(obj.title)"
        
        cell.lbltask_no.text = obj.task_no
        cell.lblticket_no.text = obj.full_task_number
        
        cell.lbl_totalPoints.text = obj.total_points + "/\(obj.total_checked_points)"
        
        if obj.total_points == obj.total_checked_points {
            cell.img_check.tintColor = "3CB371".getUIColor()
        }
        var related:String = ""
        if obj.relateds_numbers.count == 1 {
            related = obj.relateds_numbers[0].sub_tasks_numbers
        }else{
            for i in obj.relateds_numbers{
                related = related + "," + i.sub_tasks_numbers
            }
        }
        cell.lbl_relatedTask.text = related
        if obj.relateds_numbers.count == 0 {
            cell.stack_related.isHidden = true
        }else{
            cell.stack_related.isHidden = false
        }
        let important_id = obj.important_id
        
        if obj.important_name == ""{
            cell.btnImportant.isHidden = true
        }else{
            cell.btnImportant.isHidden = false
            cell.btnImportant.setTitle(obj.important_name, for: .normal)
        }
        
        if obj.status_done_name == ""{
            cell.btnStatus.isHidden = true
        }else{
            cell.btnStatus.isHidden = false
            cell.btnStatus.setTitle(obj.status_done_name, for: .normal)
        }
        
        
        switch important_id {
        case "1":
            cell.btnImportant.backgroundColor = "#0079bf".getUIColor()
        case "2":
            cell.btnImportant.backgroundColor = "#f12b54".getUIColor()
        case "3":
            cell.btnImportant.backgroundColor = "#e3ac07".getUIColor()
        case "4":
            cell.btnImportant.backgroundColor = "#e3ac07".getUIColor()
            
        default:
            cell.btnImportant.backgroundColor = "#0079bf".getUIColor()
        }
        
        let status_id = obj.task_status_done
        
        
        switch status_id {
        case "1":
            cell.btnStatus.backgroundColor = "#f12b54".getUIColor()
        case "2":
            cell.btnStatus.backgroundColor = "#e3ac07".getUIColor()
        case "4":
            cell.btnStatus.backgroundColor = "#e3ac07".getUIColor()
            
        default:
            cell.btnStatus.backgroundColor = "#0079bf".getUIColor()
        }
        
        cell.btnEditAction = {
            self.btnEditTaskAction!(obj.task_id ,obj)
            
        }
        
        if obj.total_points == "0" {
            cell.stack_totalPoints.isHidden = true
        }
        
        let interaction = UIContextMenuInteraction(delegate: self)
        cell.btn_changeStatus.addInteraction(interaction)
        
        cell.btnChangeStatusAction = {
            self.task_id = obj.task_id
            cell.btn_changeStatus.showsMenuAsPrimaryAction = true
            
            switch self.board?.title {
            case "New":
                cell.btn_changeStatus.menu = self.NewMenu()
            case "In Progress":
                cell.btn_changeStatus.menu = self.in_progressMenu()
            case "Confirm":
                cell.btn_changeStatus.menu = self.ConfirmMenu()
            case "Done":
                cell.btn_changeStatus.menu = self.DoneMenu()
            default:
                cell.btn_changeStatus.menu = self.createContextMenu()
            }
            
            //  let interaction = UIContextMenuInteraction(delegate: self)
            //cell.btn_changeStatus.addInteraction(interaction)
        }
        
        if obj.is_can_edit == false {
            cell.btn_edit.isHidden = true
        }
//        if obj.is_can_view == true {
            cell.img_lock.isHidden = true
            
//        }else{
//            cell.img_lock.isHidden = false
//            cell.viewBack.backgroundColor = .systemGray4
//        }
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        let obj = board!.items[indexPath.row]
        btnSelectAction!(obj.task_id)
    }
    
}

//extension BoardCollectionViewCell: UITableViewDragDelegate {
//    
//    func tableView(_ tableView: UITableView, itemsForBeginning session: UIDragSession, at indexPath: IndexPath) -> [UIDragItem] {
//        guard let board = board, let stringData = board.items[indexPath.row].ticket_id.data(using: .utf8) else {
//            return []
//        }
//        
//        let itemProvider = NSItemProvider(item: stringData as NSData, typeIdentifier: kUTTypePlainText as String)
//        let dragItem = UIDragItem(itemProvider: itemProvider)
//        session.localContext = (board, indexPath, tableView)
//        
//        return [dragItem]
//    }
//    
//    func tableView(_ tableView: UITableView, dragSessionWillBegin session: UIDragSession) {
//        
//        //self.parentVC?.setupRemoveBarButtonItem()
//       // self.parentVC?.navigationItem.rightBarButtonItem = nil
//    }
//    
//    func tableView(_ tableView: UITableView, dragSessionDidEnd session: UIDragSession) {
//        self.parentVC?.setupAddButtonItem()
//        self.parentVC?.navigationItem.leftBarButtonItem = nil
//    }
//    
//}

//extension BoardCollectionViewCell: UITableViewDropDelegate {
//
//    func tableView(_ tableView: UITableView, performDropWith coordinator: UITableViewDropCoordinator) {
//        if coordinator.session.hasItemsConforming(toTypeIdentifiers: [kUTTypePlainText as String]) {
//            coordinator.session.loadObjects(ofClass: NSString.self) { (items) in
//                guard let string = items.first as? String else {
//                    return
//                }
//
//                switch (coordinator.items.first?.sourceIndexPath, coordinator.destinationIndexPath) {
//                case (.some(let sourceIndexPath), .some(let destinationIndexPath)):
//                    // Same Table View
//                    let updatedIndexPaths: [IndexPath]
//                    if sourceIndexPath.row < destinationIndexPath.row {
//                        updatedIndexPaths =  (sourceIndexPath.row...destinationIndexPath.row).map { IndexPath(row: $0, section: 0) }
//                    } else if sourceIndexPath.row > destinationIndexPath.row {
//                        updatedIndexPaths =  (destinationIndexPath.row...sourceIndexPath.row).map { IndexPath(row: $0, section: 0) }
//                    } else {
//                        updatedIndexPaths = []
//                    }
//                    self.tableView.beginUpdates()
//                    self.board?.items.remove(at: sourceIndexPath.row)
//                   // self.board?.items.insert(string, at: destinationIndexPath.row)
//                    self.tableView.reloadRows(at: updatedIndexPaths, with: .automatic)
//                    self.tableView.endUpdates()
//                    break
//
//                case (nil, .some(let destinationIndexPath)):
//                    // Move data from a table to another table
//                    self.removeSourceTableData(localContext: coordinator.session.localDragSession?.localContext)
//                    self.tableView.beginUpdates()
//                   self.board?.items.insert(string, at: destinationIndexPath.row)
//                    self.tableView.insertRows(at: [destinationIndexPath], with: .automatic)
//                    self.tableView.endUpdates()
//                    break
//
//
//                case (nil, nil):
//                    // Insert data from a table to another table
//                    self.removeSourceTableData(localContext: coordinator.session.localDragSession?.localContext)
//                    self.tableView.beginUpdates()
//                    self.board?.items.append(string)
//                    self.tableView.insertRows(at: [IndexPath(row: self.board!.items.count - 1 , section: 0)], with: .automatic)
//                    self.tableView.endUpdates()
//                    break
//
//                default: break
//
//                }
//            }
//        }
//    }
//
//    func removeSourceTableData(localContext: Any?) {
//        if let (dataSource, sourceIndexPath, tableView) = localContext as? (Board, IndexPath, UITableView) {
//            tableView.beginUpdates()
//            dataSource.items.remove(at: sourceIndexPath.row)
//            tableView.deleteRows(at: [sourceIndexPath], with: .automatic)
//            tableView.endUpdates()
//        }
//    }
//
//    func tableView(_ tableView: UITableView, dropSessionDidUpdate session: UIDropSession, withDestinationIndexPath destinationIndexPath: IndexPath?) -> UITableViewDropProposal {
//        return UITableViewDropProposal(operation: .move, intent: .insertAtDestinationIndexPath)
//    }
//
//}
