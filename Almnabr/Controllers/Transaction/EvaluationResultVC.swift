//
//  EvaluationResultVC.swift
//  Almnabr
//
//  Created by MacBook on 07/12/2021.
//  Copyright © 2021 Samar Akkila. All rights reserved.
//

import UIKit

var EvaluationDidReply :Bool = false


protocol AttachnmentDelegate {
    func pass_arr(data: [notes])
}

class EvaluationResultVC: UIViewController, UINavigationControllerDelegate , AttachnmentDelegate {
  
    
    
    @IBOutlet weak var icon_noPermission: UIImageView!
    @IBOutlet weak var view_noPermission: UIView!
    @IBOutlet weak var lbl_noPermission: UILabel!
    
    @IBOutlet weak var lbl_Title: UILabel!
    @IBOutlet weak var lbl_Notes: UILabel!
    
    @IBOutlet weak var lbl_No: UILabel!
    @IBOutlet weak var lbl_EvalTitle: UILabel!
    @IBOutlet weak var lbl_Result: UILabel!
    
    @IBOutlet weak var btn_AddConsultant: UIButton!
    
    @IBOutlet weak var btn_submit: UIButton!
    
    @IBOutlet weak var view_main: UIView!
    @IBOutlet weak var tableHeight: NSLayoutConstraint!
    @IBOutlet weak var lbl_EvaluationResult: UILabel!
    @IBOutlet weak var btn_EvaluationResult: UIButton!
    @IBOutlet weak var lbl_EvaluationResultSelect: UILabel!
    @IBOutlet weak var view_EvaluationResult: UIView!
    @IBOutlet weak var imgDropEvaluation: UIImageView!
    @IBOutlet weak var btn_cancel_Evaluation: UIButton!
    
    @IBOutlet weak var table: UITableView!
    
    var arr_Notes:[NotesObj] = []
    var arr_attachments:[AttachNotes] = []
    
    var Selected_index:Int = 0
    
    let dropDownmage =  UIImage.fontAwesomeIcon(name: .chevronDown , style: .solid, textColor:  .gray, size: CGSize(width: 40, height: 40))
    
    
    let imagePickerController = UIImagePickerController()
    var documentInteractionController: UIDocumentPickerViewController? = nil
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
//        if EvaluationDidReply {
////            self.showLoadingActivity()
//            DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
//                self.configGUI()
//                self.hideLoadingActivity()
//                EvaluationDidReply = false
//            }
//        }else{
//            configGUI()
//            EvaluationDidReply = true
//        }
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        if StatusObject?.Evaluation_Result == false {
            view_noPermission.isHidden = false
            self.view_main.isHidden = true
            
        }else{
            view_noPermission.isHidden = true
            self.view_main.isHidden = false
           // self.get_notes()
        }
    }
    
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        //configGUI()
    }
    
    
    override func viewWillLayoutSubviews() {
        super.updateViewConstraints()
        self.tableHeight?.constant = self.table.contentSize.height
    }
    
    
//    func passByPhasesArr(data: [ByPhaseObj]) { //conforms to protocol
//        // implement your own implementation
//        self.arr_ByPhase = self.arr_ByPhase + data
//        self.tableByPhase.reloadData()
//    }
    
    func pass_arr(data: [notes]) {
        
        if let row = self.arr_attachments.firstIndex(where: {$0.index == self.Selected_index}) {
            
            arr_attachments[row].arr = data
            self.table.reloadData()
        }
        
//        self.arr_attachments = self.arr_attachments + data
        self.table.reloadData()
    }
    
    func submit_Request(){
        
        
        
        for i in arr_attachments{
            guard i.title != "" else {
                showAMessage(withTitle: "error".localized(), message: "missing data ".localized())
                return
            }
        }
        
        self.showLoadingActivity()
        
        var params : [String:String] = [:]
        params["transaction_request_id"] = obj_transaction?.transaction_request_id ?? "0"
        
        
        for i in arr_attachments {
            params["Evaludation_Result[\(i.index)][title]"] = i.title
            params["Evaludation_Result[\(i.index)][projects_from_consultant_id]"] = i.id
            params["Evaludation_Result[\(i.index)][status]"] = ""
            params["Evaludation_Result[\(i.index)][result]"] = i.result
           // params["Evaludation_Result[\(i.index)][form_wir_file_attach_method]"] = "file"
            for item in i.arr{
//                params["Evaludation_Result[\(i.index)][attachments][\(item.index)][file]"] = item.id
                params["Evaludation_Result[\(i.index)][attachments][\(item.index)][attach_title]"] = item.title
                params["valudation_Result[\(i.index)][attachments][\(item.index)][required]"] = ""
            }
            
        }
        
        APIController.shard.func_UploadEvalution(queryString: "form/\(obj_transaction?.transaction_key ?? " ")/Evaluation_Result/1",arr_attachments, param: params ) { (response) in
            self.hideLoadingActivity()
            
            
            let status = response["status"] as? Bool
            let msg = response["msg"] as? String
            let error = response["error"] as? String
            
            if status == true{
                self.hideLoadingActivity()
                self.showAMessage(withTitle: "Success".localized(), message: msg ?? "Thank you. The operation was completed successfully.", completion: {
                    
                    //                    self.configGUI()
                    //                    self.change_page(SelectedIndex:8)
                    self.update_Config()
                })
                
            }else{
                self.hideLoadingActivity()
                self.showAMessage(withTitle: "Error", message: error ?? "Some thing went wrong")
                
            }
        }
        
        
    }
    
    
    
    func get_notes(){
        
        self.showLoadingActivity()
        
        let params = ["transaction_request_id" : obj_transaction?.transaction_request_id ?? "0"]
        APIController.shard.sendRequestPostAuth(urlString: "form/\(obj_transaction?.transaction_key ?? " ")/Evaluation_Result/0", parameters: params ) { (response) in
            self.hideLoadingActivity()
            
            
            let status = response["status"] as? Bool
            let msg = response["msg"] as? String
            let error = response["error"] as? String
            self.arr_Notes = []
            if status == true{
                self.hideLoadingActivity()
                let final_result = response["final_result"] as? String
                self.lbl_EvaluationResultSelect.text = final_result
                
                if  let records = response["Notes"] as? NSDictionary{
                    self.lbl_Notes.text = "Notes"
                    self.btn_AddConsultant.isHidden = true
                    for i in records {
                        let obj = NotesObj.init(i.value as! [String : Any])
                        self.arr_Notes.append(obj)
                        
                    }
                }
                
                if  let Consultant_Recommendations = response["Consultant_Recommendations"] as? NSArray{
                    self.lbl_Notes.text = "Consultant Recommendations"
                    self.btn_AddConsultant.isHidden = false
                    self.lbl_Result.isHidden = true
                    
                    for i in Consultant_Recommendations {
                        
                        let dict = i as? [String:Any]
                        let obj = NotesObj.init(dict!)
                        self.arr_Notes.append(obj)
                        
                    }
                }
                
                var index = 0
                for i in self.arr_Notes{
                    let obj = AttachNotes(id: i.projects_consultant_recommendations_id,title: i.extra1_title, result: i.extra1_result, Required: "1", img: nil, url: nil, type: nil, index: index, IsNew: false , arr : [])
                    self.arr_attachments.append(obj)
                    index = index + 1
                }
                
                
                self.table.reloadData()
                
            }else{
                self.hideLoadingActivity()
                self.showAMessage(withTitle: "Error", message: error ?? "Some thing went wrong")
                
            }
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
        
        submit_Request()
    }
    
    @IBAction func btnAddFile_Click(_ sender: Any) {
        
        //        var is_nil = false
        //
        //        for i in arr_attachments {
        //
        //            let urlStr = i.url
        //            let img = i.img
        //
        //            if (urlStr == nil && img == nil) {
        //                is_nil = true
        //                break
        //            }
        //        }
        //
        //        if is_nil{
        //            self.showAMessage(withTitle: "error".localized(), message: "Attach file to the last entry at First")
        //        }else{
        
        let new_index = self.arr_attachments.count + 1
        let obj = AttachNotes(id:"", title: "", result: "", Required: "0", img: nil, url: nil, type: "file", index: new_index, IsNew: true, arr : [])
        self.arr_attachments.append(obj)
        //  self.table.reloadData()
        
        self.table.beginUpdates()
        self.table.insertRows(at: [IndexPath.init(row: self.arr_attachments.count-1, section: 0)], with: .automatic)
        self.table.endUpdates()
        
        //        }
        
        
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

extension EvaluationResultVC: UITableViewDelegate , UITableViewDataSource{
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return arr_attachments.count
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "NotesCell", for: indexPath) as! NotesCell
        
        let obj = arr_attachments[indexPath.item]
        cell.lbl_No.text =   "\(indexPath.item + 1)"
        cell.lbl_No.font = .kufiRegularFont(ofSize: 12)
        
        cell.lbl_Title.text =  obj.title
        cell.lbl_Title.font = .kufiRegularFont(ofSize: 12)
        
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
        
        
        if obj.IsNew == true {
            cell.lbl_Title.isHidden = true
            cell.view_Title.isHidden = false
            cell.btn_delete.isHidden = false
        }else{
            cell.lbl_Title.isHidden = false
            cell.view_Title.isHidden = true
            cell.btn_delete.isHidden = true
        }
        
        
        if obj.result == "" {
            cell.lbl_Result.isHidden = true
            cell.btn_upload.isHidden = false
        }else{
            cell.lbl_Result.isHidden = false
            cell.btn_upload.isHidden = true
        }
        
        
        cell.btnUploadAction  = {
            
            self.Selected_index = indexPath.item
         
            let vc:AddAttachmentsVC  = AppDelegate.TransactionSB.instanceVC()
            
            vc.isModalInPresentation = true
            vc.modalPresentationStyle = .overFullScreen
            vc.definesPresentationContext = true
            vc.delegate = self
//            vc.Selected_index = indexPath.item
            vc.arr_attachments = self.arr_attachments
            vc.arr_notes = obj.arr
            
            self.present(vc, animated: true, completion: nil)
//            self.Upload_file()
        }
        
        cell.btnDeleteAction = {
            
            self.arr_attachments.remove(at: indexPath.item)
            self.table.reloadData()
            
        }
        
        cell.btnEndEditingAction = {
            
            self.arr_attachments[indexPath.item].title = cell.tf_Title.text!
            self.table.reloadData()
            
        }
        
        return cell
        
        
        
    }
    
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        self.viewWillLayoutSubviews()
    }
    
}



extension EvaluationResultVC : UIImagePickerControllerDelegate  {
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]){
        
        if let image = (info[.originalImage] as? UIImage){
            
            if let row = self.arr_attachments.firstIndex(where: {$0.index == self.Selected_index }) {
                
                arr_attachments[row].type = "img"
                arr_attachments[row].img = image
                arr_attachments[row].url = nil
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





extension EvaluationResultVC: UIDocumentPickerDelegate {
    
    
    
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
                    
                    
                    if let row = self.arr_attachments.firstIndex(where: {$0.index == self.Selected_index}) {
                        
                        arr_attachments[row].type = "file"
                        arr_attachments[row].img = nil
                        arr_attachments[row].url = url
                        
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
