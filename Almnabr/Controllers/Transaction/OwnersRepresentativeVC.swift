//
//  OwnersRepresentativeVC.swift
//  Almnabr
//
//  Created by MacBook on 07/12/2021.
//  Copyright © 2021 Samar Akkila. All rights reserved.
//

import UIKit

class OwnersRepresentativeVC: UIViewController, UINavigationControllerDelegate {
    @IBOutlet weak var icon_noPermission: UIImageView!
    @IBOutlet weak var view_noPermission: UIView!
    @IBOutlet weak var lbl_noPermission: UILabel!
    
    @IBOutlet weak var lbl_Title: UILabel!
    @IBOutlet weak var lbl_notes: UILabel!
    
    @IBOutlet weak var txt_notes: UITextView!
    @IBOutlet weak var btn_submit: UIButton!
    
    @IBOutlet weak var view_main: UIView!
    
    @IBOutlet weak var view_txtView: UIView!
    @IBOutlet weak var table: UITableView!
    @IBOutlet weak var btn_upload: UIButton!
    @IBOutlet weak var lbl_uploadAttachments: UILabel!
    
    var Selected_index:Int = 0
    
    var arr_data:[AttachmentsObj] = []
    var arr_file:[attachment] = []
    var parm = [:] as [String : String]
    
    let imagePickerController = UIImagePickerController()
    var documentInteractionController: UIDocumentPickerViewController? = nil
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configGUI()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
          configGUI()
    }
    
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        // configGUI()
    }
    
    
    
    //MARK: - Config GUI
    //------------------------------------------------------
    func configGUI() {
        
        icon_noPermission.no_permission()
        
        self.lbl_noPermission.text =  "You not have permission to access this step".localized()
        self.lbl_noPermission.font = .kufiRegularFont(ofSize: 15)
        self.lbl_noPermission.textColor =  "#333".getUIColor()
        
        self.lbl_uploadAttachments.text = "Upload attachment".localized() + " *"
        self.lbl_uploadAttachments.font = .kufiRegularFont(ofSize: 15)
        
        if StatusObject?.Owners_Representative == false {
            view_noPermission.isHidden = false
            self.view_main.isHidden = true
            
        }else{
            view_noPermission.isHidden = true
            self.view_main.isHidden = false
        }
        
        btn_upload.isUserInteractionEnabled = true
        self.txt_notes.text = ""
        self.lbl_Title.text =  "Owner Representative".localized()
        self.lbl_Title.font = .kufiRegularFont(ofSize: 13)
        self.lbl_Title.textColor =  maincolor
        
        
        self.lbl_notes.text =  "Notes".localized() + " :"
        self.lbl_notes.font = .kufiRegularFont(ofSize: 13)
        self.lbl_notes.textColor =  maincolor
        
        
        self.view_txtView.setBorderGray()
        
        
        self.btn_submit.setTitle("Submit".localized(), for: .normal)
        self.btn_submit.backgroundColor =  "#1A3665".getUIColor()
        self.btn_submit.setTitleColor(.white, for: .normal)
        
        
        table.dataSource = self
        table.delegate = self
        let nib = UINib(nibName: "AttachmentsCell", bundle: nil)
        table.register(nib, forCellReuseIdentifier: "AttachmentsCell")
        
        
        imagePickerController.delegate = self
    }
    
    
    func Submit_request(){
        
//        guard arr_file.count != 0 else {
//            showAMessage(withTitle: "error".localized(), message: "Please enter your file".localized())
//            return
//        }
        
        guard txt_notes.text != "" else {
            showAMessage(withTitle: "error".localized(), message: "Please enter your Notes".localized())
            return
        }
        
        for i in arr_file {
            self.parm["attachments[\(i.index)][attach_title]"] = i.title
            self.parm["attachments[\(i.index )][required]"] = i.Required
        }
        
        parm["transaction_request_id"] =  obj_transaction?.transaction_request_id ?? "0"
        parm["notes"] = self.txt_notes.text ?? ""
        
        showLoadingActivity()
        
        APIController.shard.func_Upload(queryString: "/form/\(obj_transaction?.transaction_key ?? " ")/Owners_Representative/0", arr_file, param: self.parm ) { (respnse ) in
            
            let status = respnse["status"] as? Bool
            let msg = respnse["msg"] as? String
            let error = respnse["error"] as? String
            
            if status == true{
                self.hideLoadingActivity()
                self.showAMessage(withTitle: "Success".localized(), message: msg ?? "Thank you. The operation was completed successfully.", completion: {
                    
                    self.update_Config()
                    //                    self.configGUI()
                    //                    self.change_page(SelectedIndex:10)
                })
                
            }else{
                self.hideLoadingActivity()
                self.showAMessage(withTitle: "Error", message: error ?? "Some thing went wrong")
                
            }
            
            self.hideLoadingActivity()
            
            
        }
        
        
        
    }
    
    
    
    
    
    func Upload_file(){
        
        imagePickerController.allowsEditing = true
        let actionsheet = UIAlertController(title: nil, message: nil, preferredStyle: .actionSheet)
        actionsheet.addAction(UIAlertAction(title: "Choose photo".localized(), style: .default, handler: { (action:UIAlertAction)in
            self.imagePickerController.allowsEditing = true
            self.imagePickerController.mediaTypes = ["public.image"]
            
            self.present(self.imagePickerController, animated: true, completion: nil)
            self.imagePickerController.sourceType = .photoLibrary
            
        }))
        
        
        actionsheet.addAction(UIAlertAction(title: "Choose Pdf".localized(), style: .default, handler: { (action:UIAlertAction)in
            
            self.documentInteractionController = UIDocumentPickerViewController(documentTypes: ["public.pdf", "public.data"], in: .import)
            self.documentInteractionController?.delegate = self
            self.present(self.documentInteractionController!, animated: true, completion: nil)
            
            
        }))
        
        actionsheet.addAction(UIAlertAction(title: "Close".localized(), style: .cancel, handler: nil))
        self.present(actionsheet,animated: true, completion: nil)
        
    }
    
    
    
    
    @IBAction func btnSubmit_Click(_ sender: Any) {
        
        Submit_request()
    }
    
    @IBAction func btnAddFile_Click(_ sender: Any) {
        
        var is_nil = false
        
        for i in arr_file {
            
            let urlStr = i.url
            let img = i.img
            
            if (urlStr == nil && img == nil) {
                is_nil = true
                break
            }
        }
        
        if is_nil{
            self.showAMessage(withTitle: "error".localized(), message: "Attach file to the last entry at First")
        }else{
            
            let new_index = arr_file.count
            self.arr_file.append(attachment(title: "", Required: "No", img: nil, url: nil,type: "file", index: new_index))
            
            self.table.beginUpdates()
            self.table.insertRows(at: [IndexPath.init(row: self.arr_file.count-1, section: 0)], with: .automatic)
            self.table.endUpdates()
        }
        
        
    }
    
    
    
    private func change_page(SelectedIndex:Int) {
        NotificationCenter.default.post(name: NSNotification.Name("Change_Form_Step"),
                                        object: SelectedIndex)
    }
    
    private func update_Config() {
        NotificationCenter.default.post(name: NSNotification.Name("update_Config"),
                                        object: nil)
    }
    
}



extension OwnersRepresentativeVC: UITableViewDelegate , UITableViewDataSource{
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        
        return arr_file.count
        
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "AttachmentsCell", for: indexPath) as! AttachmentsCell
        
        let obj = arr_file[indexPath.item]
        
        
        cell.btn_Select.setImage( UIImage(systemName: "plus.rectangle.fill.on.folder.fill"), for: .normal)
        
        cell.lblNo.text =  "#" + "\(indexPath.item + 1)"
        cell.lblNo.font = .kufiRegularFont(ofSize: 17)
        // cell.tfTitle.text = ""
        cell.tfTitle.placeholder = "Description".localized()
        cell.btn_Select.tintColor = HelperClassSwift.acolor.getUIColor()
        cell.btn_delete.isHidden = false
        cell.tfTitle.isUserInteractionEnabled = true
        
        if (obj.img != nil || obj.url != nil) {
            cell.btn_Select.tintColor = "#3ea832".getUIColor()
        }
        
        cell.btnDeleteAction = {
            () in
            self.arr_file.remove(at: indexPath.item)
            self.table.reloadData()
            
        }
        
        cell.btnUploadAction = {
            () in
            
            self.Selected_index = indexPath.item
            self.Upload_file()
            
        }
        
        cell.btnEndEditingAction = {
            
            self.arr_file[indexPath.item].title = cell.tfTitle.text ?? ""
            
        }
        
        
        return cell
        
        
        
    }
    
    
}



extension OwnersRepresentativeVC : UIImagePickerControllerDelegate  {
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]){
        
        if let image = (info[.originalImage] as? UIImage){
            
            
            if let row = self.arr_file.firstIndex(where: {$0.index == self.Selected_index}) {
                
                arr_file[row].type = "img"
                arr_file[row].img = image
                arr_file[row].url = nil
                self.table.reloadData()
            }
        }
        
        if let editedImage = info[UIImagePickerController.InfoKey.editedImage] as? UIImage{
            self.imagePickerController.allowsEditing = true
            
            let data =  editedImage.jpegData(compressionQuality:0.6)
            let imageSize: Int = data?.count ?? 0
            print(imageSize/1000000)
            let size  = imageSize/1000000
            
            if size > 10 {
                self.showAMessage(withTitle: "error".localized(), message: "image must be less than 10 MB".localized())
                return
            }
        }
        
        picker.dismiss(animated: true) {
            
        }
    }
    
    
    
    
}





extension OwnersRepresentativeVC: UIDocumentPickerDelegate {
    
    
    
    func documentPicker(_ controller: UIDocumentPickerViewController, didPickDocumentsAt urls: [URL]) {
        print(urls)
        for url in urls {
            let cico = url as URL
            
            
            print(cico)
            print(url)
            print(url.lastPathComponent)
            print(url.pathExtension)
            getDataFrom(url: url) { (data) in
                if let data = data {
                    
                    
                    if let row = self.arr_file.firstIndex(where: {$0.index == self.Selected_index}) {
                        
                        arr_file[row].type = "file"
                        arr_file[row].img = nil
                        arr_file[row].url = url
                        
                        self.table.reloadData()
                    }
                    
                    
                    let Size1: Int = data.count ?? 0
                    let size  = Size1/1000000
                    
                    if size > 10 {
                        self.showAMessage(withTitle: "error".localized(), message: "Pdf must be less than 10 MB".localized())
                        return
                    }
                    
                }
                
                
            }
        }
    }
    
    
    func getDataFrom(url: URL, completion: (Data?)->()) {
        do {
            let data = try Data.init(contentsOf: url, options: .dataReadingMapped)
            print(data)
            completion(data)
        }catch {
            print(error)
            completion(nil)
        }
    }
    
    
    
    func json(from object: Any) -> String? {
        guard let data = try? JSONSerialization.data(withJSONObject: object, options: []) else {
            return nil
        }
        return String(data: data, encoding: String.Encoding.utf8)
    }
    
}

