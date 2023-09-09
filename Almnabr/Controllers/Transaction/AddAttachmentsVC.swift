//
//  AddAttachmentsVC.swift
//  Almnabr
//
//  Created by MacBook on 09/06/2022.
//  Copyright © 2022 Samar Akkila. All rights reserved.
//

import UIKit

class AddAttachmentsVC: UIViewController, UINavigationControllerDelegate {

    @IBOutlet weak var btn_submit: UIButton!
    @IBOutlet weak var btn_cancel: UIButton!
    
    @IBOutlet var tableHeight: NSLayoutConstraint!
    @IBOutlet weak var table: UITableView!
    
    @IBOutlet weak var lbl_No: UILabel!
    @IBOutlet weak var lbl_Title: UILabel!
    
    @IBOutlet weak var lbl_Attachments: UILabel!
    var arr_attachments:[AttachNotes] = []
    var arr_notes:[notes] = []
    
    var Selected_index:Int = 0
    let imagePickerController = UIImagePickerController()
    var documentInteractionController: UIDocumentPickerViewController? = nil
    
   
    var delegate: AttachnmentDelegate!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        register_nib()
        configGUI()
        
    }
    
    override func viewWillLayoutSubviews() {
        super.updateViewConstraints()
        self.tableHeight?.constant = self.table.contentSize.height
    }
    
    
    //MARK: - Config GUI
    //------------------------------------------------------
    func configGUI() {
        
      
        self.lbl_Attachments.text =  "Attachments".localized()
        self.lbl_Attachments.font = .kufiBoldFont(ofSize: 13)
        self.lbl_Attachments.textColor =  maincolor
        
        
       
        self.btn_submit.setTitle("Submit".localized(), for: .normal)
        self.btn_submit.backgroundColor =  "#1A3665".getUIColor()
        self.btn_submit.setTitleColor(.white, for: .normal)
        
        self.btn_cancel.setTitle("Cancel".localized(), for: .normal)
        self.btn_cancel.backgroundColor =  .lightGray
        self.btn_cancel.setTitleColor(.white, for: .normal)
       
       
        
        imagePickerController.delegate = self
        
        
        if arr_notes.count == 0 {
            let new_index = self.arr_notes.count
            let obj = notes(id:"", title: "", result: "", Required: "0", img: nil, url: nil, type: "file", index: new_index, IsNew: true)
            self.arr_notes.append(obj)
            //  self.table.reloadData()
            
            self.table.beginUpdates()
            self.table.insertRows(at: [IndexPath.init(row: self.arr_notes.count, section: 0)], with: .automatic)
            self.table.endUpdates()
        }
        self.table.reloadData()
//        else{
//
//            for item in arr_notes {
//                let obj = notes(id: item.id, title: item.title, result: "", Required: "0", img: item.img, url: item.url, type: item.type, index: item.index, IsNew: item.IsNew)
//                    self.arr_notes.append(obj)
//            }
//
//            self.table.reloadData()
//
//        }
        
    }
    
    
    func register_nib(){
        table.dataSource = self
        table.delegate = self
        let nib = UINib(nibName: "NotesCell", bundle: nil)
        table.register(nib, forCellReuseIdentifier: "NotesCell")
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
        
       
        for i in arr_notes{
            guard i.title != "" else {
                showAMessage(withTitle: "error".localized(), message: "missing data ".localized())
                return
            }
        }
        for i in arr_notes {
            let urlStr = i.url
            let img = i.img
                 
            if (urlStr == nil && img == nil) {
                showAMessage(withTitle: "error".localized(), message: "Please enter your file".localized())
                return
            }else{
                delegate.pass_arr(data: self.arr_notes)
                self.dismiss(animated: true, completion: nil)
            }}
        
        
        
       
    }
    
    @IBAction func btnCancel_Click(_ sender: Any) {
 
        self.dismiss(animated: true, completion: nil)
    }
    
    
    @IBAction func btnAddNewAttach_Click(_ sender: Any) {
        var is_nil = false
        
        for i in arr_notes {
            
            let urlStr = i.url
            let img = i.img
                 
            if (urlStr == nil && img == nil) {
                is_nil = true
                break
            }
        }
        
        if is_nil {
            self.showAMessage(withTitle: "error".localized(), message: "Attach file to the last entry at First")
        }else{
            let new_index = self.arr_notes.count + 1
            let obj = notes(id: "", title: "", result: "", Required: "0", img: nil, url: nil, type: "file", index: new_index, IsNew: true)
            self.arr_notes.append(obj)
            //  self.table.reloadData()
            
            self.table.beginUpdates()
            self.table.insertRows(at: [IndexPath.init(row: self.arr_notes.count-1, section: 0)], with: .automatic)
            self.table.endUpdates()
        }
        
      
     
    }
    
    
    

}

extension AddAttachmentsVC: UITableViewDelegate , UITableViewDataSource{
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return arr_notes.count
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "NotesCell", for: indexPath) as! NotesCell
        
        let obj = arr_notes[indexPath.item]
        cell.lbl_No.text =   "\(indexPath.item + 1)"
        cell.lbl_No.font = .kufiRegularFont(ofSize: 12)
        
        cell.tf_Title.text =  obj.title
        cell.tf_Title.font = .kufiRegularFont(ofSize: 12)
        
//        cell.lb
        cell.lbl_Result.text =  obj.result
        cell.lbl_Result.font = .kufiRegularFont(ofSize: 12)
        
//        if (obj.img != nil || obj.url != nil) {
//            cell.btn_upload.tintColor = "#3ea832".getUIColor()
//        }
        if (obj.img != nil || obj.url != nil) {
            cell.btn_upload.tintColor = "#3ea832".getUIColor()
        }else{
            cell.btn_upload.tintColor = HelperClassSwift.acolor.getUIColor()
        }
        
        
//        if obj.IsNew == true {
            cell.lbl_Title.isHidden = true
            cell.view_Title.isHidden = false
            cell.btn_delete.isHidden = false
//        }else{
//            cell.lbl_Title.isHidden = false
//            cell.view_Title.isHidden = true
//            cell.btn_delete.isHidden = true
//        }
        
        
//        if obj.result == "" {
//            cell.lbl_Result.isHidden = true
            cell.btn_upload.isHidden = false
//        }else{
//            cell.lbl_Result.isHidden = false
//            cell.btn_upload.isHidden = true
//        }
        
        
        cell.btnUploadAction  = {
            
            self.Selected_index = indexPath.item
            self.Upload_file()
        }
        
        cell.btnDeleteAction = {
            
            self.arr_notes.remove(at: indexPath.item)
            self.table.reloadData()
            
        }
        
        cell.btnEndEditingAction = {
            
            self.arr_notes[indexPath.item].title = cell.tf_Title.text!
            self.table.reloadData()
            
        }
        
        return cell
        
        
        
    }
    
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        self.viewWillLayoutSubviews()
    }
    
}



extension AddAttachmentsVC : UIImagePickerControllerDelegate  {
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]){
        
        if let image = (info[.originalImage] as? UIImage){
            
            if let row = self.arr_notes.firstIndex(where: {$0.index == self.Selected_index }) {
                
                arr_notes[row].type = "img"
                arr_notes[row].img = image
                arr_notes[row].url = nil
                self.table.reloadData()
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
                // self.Collection.reloadData()
            }
            
            picker.dismiss(animated: true) {
                
            }
        }
        
    }
    
    
}





extension AddAttachmentsVC: UIDocumentPickerDelegate {
    
    
    
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
                    
                    
                    if let row = self.arr_notes.firstIndex(where: {$0.index == self.Selected_index}) {
                        
                        arr_notes[row].type = "file"
                        arr_notes[row].img = nil
                        arr_notes[row].url = url
                        
                        self.table.reloadData()
                    }
                    
                    
                    let Size1: Int = data.count ?? 0
                    let size  = Size1/1000000
                    
                    if size > 10 {
                        self.showAMessage(withTitle: "error".localized(), message: "Pdf must be less than 10 MB".localized())
                        return
                    }
                    
                    //  self.Collection.reloadData()
                    
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
