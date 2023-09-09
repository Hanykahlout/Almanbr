//
//  TaskAttachmentVC.swift
//  Almnabr
//
//  Created by MacBook on 25/04/2022.
//  Copyright © 2022 Samar Akkila. All rights reserved.
//

import UIKit
import SCLAlertView

class TaskAttachmentVC: UIViewController {
    
    @IBOutlet weak var table: UITableView!
    @IBOutlet weak var img_nodata: UIImageView!
    
    private var documentPickerController: UIDocumentPickerViewController!
    
    var arr_data:[DocumentObj] = []
    var updateArr: ((_ isDelete:Bool,_ obj:DocumentObj?,_ index:Int)->Void)?
    var ticket_id:String = ""
    var task_id = ""
    var is_from_task :Bool = false
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configNavigation()
        configGUI()
        attachmentsObserver()
        setupAddButtonItem()

        if is_from_task {
            if arr_data.count == 0 {
                self.img_nodata.isHidden = false
            }else{
                self.img_nodata.isHidden = true
            }
        }else{
            get_data()
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
        addNavigationBarTitle(navigationTitle: "Attachments".localized())
        UINavigationBar.appearance().backgroundColor = maincolor
    }
    
    
    func setupAddButtonItem() {
        let addButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(addTapped(_:)))
        navigationItem.rightBarButtonItem = addButtonItem
    }
    
    @objc func addTapped(_ sender: Any) {
        let alertVC = UIAlertController(title: "", message: "", preferredStyle: .actionSheet)
        alertVC.addAction(.init(title: "Choose Photo".localized(), style: .default, handler: { action in
            self.setImageBy(source: .photoLibrary)
        }))
        alertVC.addAction(.init(title: "Choose Pdf".localized(), style: .default, handler: { action in
            self.selectAttachment()
        }))

        alertVC.addAction(.init(title: "Cancel", style: .cancel))

        present(alertVC, animated: true, completion: nil)
    }
    
    private func selectAttachment(){
        documentPickerController = UIDocumentPickerViewController(
            forOpeningContentTypes: [.pdf])
        documentPickerController.delegate = self
        self.present(documentPickerController, animated: true, completion: nil)
    }
    
    
    //MARK: - Config GUI
    //------------------------------------------------------
    func configGUI() {
        table.dataSource = self
        table.delegate = self
        let nib = UINib(nibName: "TaskAttachmentCell", bundle: nil)
        table.register(nib, forCellReuseIdentifier: "TaskAttachmentCell")
        
    }
    
    
    
    func get_data(){
        
        self.showLoadingActivity()
        let param :[String:Any] = ["ticket_id" : ticket_id]
        APIController.shard.sendRequestPostAuth(urlString: "tasks/get_files_in_ticket", parameters: param ) { (response) in
            self.arr_data.removeAll()
            let status = response["status"] as? Bool
            if status == true{
                if  let records = response["files"] as? NSArray{
                    for i in records {
                        let dict = i as? [String:Any]
                        let obj =  DocumentObj.init(dict!)
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
    
    
    func Delete_attachment(index:Int,id:String){
        
        self.showLoadingActivity()
        let param :[String:Any] = ["file_id" : id]
        APIController.shard.sendRequestPostAuth(urlString: "tasks/delete_file_ticket", parameters: param ) { (response) in
            self.hideLoadingActivity()
            let status = response["status"] as? Bool
            if status == false{
                self.showAMessage(withTitle: "error", message: "The attachment wasn't  deleted ")
            }
            
        }
        
        
    }
    
    
}


extension TaskAttachmentVC: UITableViewDelegate , UITableViewDataSource{
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return arr_data.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "TaskAttachmentCell", for: indexPath) as! TaskAttachmentCell
        
        let obj = arr_data[indexPath.item]
        
        
        cell.lblname.text = obj.file_name_en
        cell.lblType.text = obj.file_extension
        cell.lblDate.text = obj.insert_date
        cell.index = indexPath.row
        
        cell.btnDeleteAction = { (index) in
            self.Delete_attachment(index: index,id: obj.file_records_id)
        }
        
        
        return cell
    }
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let obj = arr_data[indexPath.item]
        if obj.file_path != "" {
            let vc:PDFViewrVC  = AppDelegate.mainSB.instanceVC()
            vc.isModalInPresentation = true
            vc.definesPresentationContext = true
            vc.Strurl = obj.file_path
            self.present(vc, animated: true, completion: nil)
        }
        
    }
    
}

// MARK: - Socket Handling
extension TaskAttachmentVC{
    
    private func attachmentsObserver(){
        ticketAttachObserver()
        taskAttchObserver()
    }
    
    private func ticketAttachObserver(){
        SocketIOController.shard.attachHandler(ticketId: ticket_id, userID: Auth_User.user_id) { data in
            guard let data = data.first as? [String:Any],
                  let content = data["content"] as? [String:Any],
                  let type = data["type"] as? String,
                  !self.is_from_task
            else { return }
            switch type{
            case "files_ticket":
                let obj = DocumentObj(content)
                self.arr_data.insert(obj, at: 0)
                
            case "delete_attachment":
                let index = self.arr_data.firstIndex(where: {$0.file_records_id == content["file_id"] as! String})
                if let index = index {
                    self.arr_data.remove(at: index)
                }
                
            default :
                break
            }
            
            self.img_nodata.isHidden = !self.arr_data.isEmpty
            self.table.reloadData()
        }
    }
    
    private func taskAttchObserver(){
        
        SocketIOController.shard.taskAttachmentsHandler(ticketId: ticket_id, taskId: task_id, userID: Auth_User.user_id){ data in
            guard let data = data.first as? [String:Any],
                  let content = data["content"] as? [String:Any],
                  let type = data["type"] as? String,
                  self.is_from_task
            else { return }
            switch type{
            case "files_ticket":
                let obj = DocumentObj(content)
                self.arr_data.insert(obj, at: 0)
                self.updateArr?(false,obj,0)
            case "delete_attachment":
                
                
                let index = self.arr_data.firstIndex(where: {$0.file_records_id == content["file_id"] as! String})
                if let index = index {
                    self.arr_data.remove(at: index)
                    self.updateArr?(true,nil,index)
                }
                
                
            default :
                break
            }
            
            self.img_nodata.isHidden = !self.arr_data.isEmpty
            self.table.reloadData()
        }
    }
    
    
}

// MARK: - UIImagePickerControllerDelegate
extension TaskAttachmentVC : UIImagePickerControllerDelegate , UINavigationControllerDelegate{
    private func setImageBy(source:UIImagePickerController.SourceType){
        let imagePicker = UIImagePickerController()
        imagePicker.delegate = self
        imagePicker.allowsEditing = true
        imagePicker.sourceType = source
        present(imagePicker, animated: true, completion: nil)
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        let imgUrl = info[UIImagePickerController.InfoKey.imageURL] as? URL
        if let imgUrl = imgUrl{
            uploadAttachData(url: imgUrl, attach_title: imgUrl.lastPathComponent)
        }

        dismiss(animated: true, completion: nil)
    }
}


// MARK: - UIDocumentPickerViewControllerDelegate
extension TaskAttachmentVC:UIDocumentPickerDelegate{
    public func documentPicker(_ controller: UIDocumentPickerViewController, didPickDocumentsAt urls: [URL]) {
        guard let myURL = urls.first else {
            return
        }
        uploadAttachData(url: myURL, attach_title: myURL.lastPathComponent)
    }
    
    func documentPickerWasCancelled(_ controller: UIDocumentPickerViewController) {
        dismiss(animated: true, completion: nil)
    }
}

extension TaskAttachmentVC{
    
    private func uploadAttachData(url:URL,attach_title:String){
        let requestUrl = is_from_task ? "tasks/add_files_in_task" : "tasks/add_files_in_ticket"
        
        var parameters:[String:Any] = [
            "attachments[0][attach_title]": attach_title
        ]
        
        if is_from_task{
            parameters["task_id"] = task_id
        }else{
            parameters["ticket_id"] = ticket_id
        }
        
        showLoadingActivity()
        APIController.shard.uploadAttachInTicket(url:requestUrl,parameters: parameters, fileUrl: url) { data in
            self.hideLoadingActivity()
            if data.status == nil || data.status == false{
                SCLAlertView().showError("error".localized(), subTitle: data.error ?? "There is an unknow error")
            }
        }
        
    }
    
}
