//
//  FormsAttachmentsVC.swift
//  Almnabr
//
//  Created by MacBook on 09/12/2021.
//  Copyright © 2021 Samar Akkila. All rights reserved.
//

import UIKit

class FormsAttachmentsVC: UIViewController {

    
    @IBOutlet weak var table: UITableView!
    
    var arr_data:[Configurations_AttachmentsObj] = []
    var attachData:[FormHrv1AttachmentsRecords]?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        configNavigation()
        SetupTable()
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
        self.view.backgroundColor = maincolor//F0F4F8
        //navigationController?.navigationBar.barTintColor = .buttonBackgroundColor()
        navigationController?.navigationBar.barTintColor = maincolor
       addNavigationBarTitle(navigationTitle: "Attachments".localized())
        UINavigationBar.appearance().backgroundColor = maincolor
    }
    
    
    
    // MARK: - Setup Table
    
    func SetupTable(){
        
        table.dataSource = self
        table.delegate = self
        let nib = UINib(nibName: "FormVersionCell", bundle: nil)
        table.register(nib, forCellReuseIdentifier: "FormVersionCell")
        self.table.reloadData()
    }
}




extension FormsAttachmentsVC: UITableViewDelegate , UITableViewDataSource{
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    
      
        return attachData == nil ? arr_data.count : attachData!.count
    
       
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
     
            let cell = tableView.dequeueReusableCell(withIdentifier: "FormVersionCell", for: indexPath) as! FormVersionCell
            
            
         
      
        var Number:String = ""
        var AttachmentsTitle:String = ""
        var Writer:String = ""
        var Date:String = ""
        var FileSize:String = ""
        var AttachmentType:String = ""
        
        if attachData == nil{
            let obj = arr_data[indexPath.item]
            Number = "#" + "  \(indexPath.item + 1)"
            AttachmentsTitle = "Attachments Title".localized() + "   \(obj.project_supervision_form_file_attach_title)"
            Writer = "Writer".localized() + "   \(obj.writer_name)"
            Date = "Date".localized() + "   \(obj.created_datetime)"
            FileSize = "File Size".localized() + "   \(obj.project_supervision_form_file_size)"
            AttachmentType = "Attachment Type".localized() + "   \(obj.project_supervision_form_file_attach_type_label)"
            
            if obj.project_supervision_form_file_path != "" {
                cell.btnAction.isHidden = false
            }else{
                cell.btnAction.isHidden = true
            }
            
        }else{
            let obj = attachData![indexPath.item]
            let isAr = L102Language.currentAppleLanguage() == "ar"
            Number = "#" + "  \(indexPath.item + 1)"
            AttachmentsTitle = "Attachments Title".localized() + "   \(isAr ? obj.file_name_ar ?? "" : obj.file_name_en ?? "")"
            Writer = "Writer".localized() + "   \(obj.writer_name ?? "")"
            Date = "Date".localized() + "   \(obj.created_datetime ?? "")"
            FileSize = "File Size".localized() + "   \(obj.file_size ?? "")"
            AttachmentType = "Attachment Type".localized() + "   \(obj.file_extension ?? "")"
            if obj.link != "" {
                cell.btnAction.isHidden = false
            }else{
                cell.btnAction.isHidden = true
            }
        }

        
        cell.lblNo.text = Number
        cell.lblUnit.text = AttachmentsTitle
        cell.lblWorklevel.text = Writer
        cell.lblEvaluationResult.text = Date
        cell.lblDate.text = FileSize
        cell.lblBarcode.text = AttachmentType
        
        
        
        cell.lblTransactionNo.isHidden = true
        
     
       
        let Numberattributed: NSAttributedString = Number.attributedStringWithColor(["#".localized()], color: maincolor)
        cell.lblNo.attributedText = Numberattributed
        
        
        let AttachmentsTitleattributed: NSAttributedString = AttachmentsTitle.attributedStringWithColor(["Attachments Title".localized()], color: maincolor)
        cell.lblUnit.attributedText = AttachmentsTitleattributed
       
            
        let Writerattributed: NSAttributedString = Writer.attributedStringWithColor(["Writer".localized()], color: maincolor)
            cell.lblWorklevel.attributedText = Writerattributed
            
            
            let Dateattributed: NSAttributedString = Date.attributedStringWithColor(["Date".localized()], color: maincolor)
            cell.lblEvaluationResult.attributedText = Dateattributed
            
        
        let FileSizeattributed: NSAttributedString = FileSize.attributedStringWithColor(["File Size".localized()], color: maincolor)
        cell.lblDate.attributedText = FileSizeattributed
        
        let AttachmentTypeattributed: NSAttributedString = AttachmentType.attributedStringWithColor(["Attachment Type".localized()], color: maincolor)
        cell.lblBarcode.attributedText = AttachmentTypeattributed
        
        
        
        cell.viewBack.setcorner()
        
        
        return cell
        
        
  
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let obj = arr_data[indexPath.item]
        if obj.project_supervision_form_file_path != "" {
        let vc:PDFViewrVC  = AppDelegate.mainSB.instanceVC()
           
        vc.isModalInPresentation = true
        //vc.modalPresentationStyle = .overFullScreen
        vc.definesPresentationContext = true
        vc.Strurl = obj.project_supervision_form_file_path
        self.present(vc, animated: true, completion: nil)
    }}
}
