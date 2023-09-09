//
//  UserAttachmentsVC.swift
//  Almnabr
//
//  Created by MacBook on 30/03/2022.
//  Copyright © 2022 Samar Akkila. All rights reserved.
//

import UIKit
import DropDown

class UserAttachmentsVC: UIViewController {
 
    @IBOutlet weak var table: UITableView!
    @IBOutlet weak var img_nodata: UIImageView!
    @IBOutlet weak var viewsearch: UIView!

    @IBOutlet weak var lblsearchLevel: UILabel!
    @IBOutlet weak var viewsearchLevel: UIView!
    @IBOutlet weak var imgDropLevel: UIImageView!
     
    var SearchKey:String = ""
    var SearchFilter:String = ""
    var pageNumber = 1
    var arr_data:[attachmentObj] = []
    var allItemDownloaded = false
    var params:[String:Any] = [:]
    
    var arr_Filter:[module_attach_typesObj] = []
    var arr_label: [String] = []
    var arr_NoData:[String] = ["No items found".localized()]
    
    var profile_obj:ProfileObj?
    
    let dropUpmage =  UIImage.fontAwesomeIcon(name: .chevronUp , style: .solid, textColor:  .gray, size: CGSize(width: 40, height: 40))
    let dropDownmage =  UIImage.fontAwesomeIcon(name: .chevronDown , style: .solid, textColor:  .gray, size: CGSize(width: 40, height: 40))
    
   
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configNavigation()
        configGUI()
        get_level()
        get_data(showLoading: true, loadOnly: true)
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
       addNavigationBarTitle(navigationTitle: "User Attachments".localized())
        UINavigationBar.appearance().backgroundColor = maincolor
    }
    
    
    
    //MARK: - Config GUI
    //------------------------------------------------------
    func configGUI() {
        
        self.viewsearch.setBorderGrayWidthCorner(1, 20)
        self.viewsearchLevel.setBorderGrayWidthCorner(1, 20)
        
        self.imgDropLevel.image = dropDownmage
        
        self.lblsearchLevel.font = .kufiRegularFont(ofSize: 15)
        self.lblsearchLevel.text = "Document Type".localized()
        
        table.dataSource = self
        table.delegate = self
        let nib = UINib(nibName: "profileAttachmentsTVCell", bundle: nil)
        table.register(nib, forCellReuseIdentifier: "profileAttachmentsTVCell")
        
    }


    func get_data(showLoading: Bool, loadOnly: Bool){
        
        if showLoading {
            self.showLoadingActivity()
        }
        let search:String = SearchKey.replacingOccurrences(of: " ", with: "%20").trim()
        self.params["search_key"] = search
        self.params["employee_number"] = profile_obj?.employee_number
        self.params["branch_id"] = profile_obj?.branch_id
        self.params["attachmentType"] = SearchFilter

        
        APIController.shard.sendRequestPostAuth(urlString: "my_attachments/\(pageNumber)/10", parameters: self.params ) { (response) in
            self.hideLoadingActivity()
            
            if self.pageNumber == 1 {
                self.arr_data.removeAll()
            }
            let status = response["status"] as? Bool
            if loadOnly {
                self.table.reloadData()
            }
            
            
            let page = response["page"] as? [String:Any]
            if status == true{
                
                
                if  let records = response["records"] as? NSArray{
                    for i in records {
                        let dict = i as? [String:Any]
                        let obj =  attachmentObj.init(dict!)
                        self.arr_data.append(obj)
                    }
                    let pageObj = PageObj(page!)
                    
                    if pageObj.total_pages > self.pageNumber {
                        self.allItemDownloaded = false
                    }else{
                        self.allItemDownloaded = true
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

    
    func get_level(){
        
        self.showLoadingActivity()
        APIController.shard.sendRequestGetAuth(urlString: "module_attach_types/?module_name=human_resources" ) { (response) in
            
            
            let status = response["status"] as? Bool
            if status == true{
                if  let list = response["records"] as? NSArray{
                    for i in list {
                        let dict = i as? [String:Any]
                        let obj = module_attach_typesObj.init(dict!)
                        self.arr_Filter.append(obj)
                        self.arr_label.append(obj.title)
                        
                    }
                    self.hideLoadingActivity()
                }
            }
            
            
        }
    }
    
    
    @IBAction func btnSearchLevel_Click(_ sender: Any) {
        
      
        self.imgDropLevel.image = dropUpmage
        
        let dropDown = DropDown()
        dropDown.anchorView = view
        dropDown.backgroundColor = .white
        dropDown.cornerRadius = 2.0
        
        dropDown.dataSource = self.arr_label
        dropDown.selectionAction = { [unowned self] (index: Int, item: String) in
            
            if item == self.arr_label[index] {
                self.lblsearchLevel.text =  item
                let i =  self.arr_Filter[index]
                self.SearchFilter = i.attach_type_id
                self.imgDropLevel.image = dropDownmage
                get_data(showLoading: true, loadOnly: true)
            }
            
        }
        dropDown.direction = .bottom
        dropDown.anchorView = viewsearchLevel
        dropDown.bottomOffset = CGPoint(x: 0, y: viewsearchLevel.bounds.height)
        dropDown.width = viewsearchLevel.bounds.width
        dropDown.show()
    }
    
    

}


extension UserAttachmentsVC: UITableViewDelegate , UITableViewDataSource{

func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return arr_data.count
}

func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    
    let cell = tableView.dequeueReusableCell(withIdentifier: "profileAttachmentsTVCell", for: indexPath) as! profileAttachmentsTVCell
    
    let obj = arr_data[indexPath.item]
    
    let Type = "Type".localized() + ": \(obj.type_name)"
    let Subject = "Subject".localized() + ": \(obj.file_name)"
    let FileExtention = "File Extention".localized() + ": \(obj.file_extension)"
    let FileLevel = "File Level".localized() + ": \(obj.level_keys)"
  
    let writer = "By".localized() + ": \(obj.writer)"
    
    cell.lblOnDate.text = obj.created_datetime
    
    let Typeattributed: NSAttributedString = Type.attributedStringWithColor(["Type".localized()], color: maincolor)
    cell.lblType.attributedText = Typeattributed
    
    let Subjectattributed: NSAttributedString = Subject.attributedStringWithColor(["Subject".localized()], color: maincolor)
    cell.lblSubject.attributedText = Subjectattributed
   
    let Extentionattributed: NSAttributedString = FileExtention.attributedStringWithColor(["File Extention".localized()], color: maincolor)
    cell.lblFileExtention.attributedText = Extentionattributed
   
    let Levelattributed: NSAttributedString = FileLevel.attributedStringWithColor(["File Level".localized()], color: maincolor)
    cell.lblFileLevel.attributedText = Levelattributed
    
   
    let Writerattributed: NSAttributedString = writer.attributedStringWithColor(["By".localized()], color: maincolor)
    cell.lblWriter.attributedText = Writerattributed
    
   
    cell.btnLinkAction = {
        
        if obj.file_path != "" {
            let vc:PDFViewrVC  = AppDelegate.mainSB.instanceVC()
            
            vc.isModalInPresentation = true
            //vc.modalPresentationStyle = .overFullScreen
            vc.definesPresentationContext = true
            vc.Strurl = obj.file_path
            self.present(vc, animated: true, completion: nil)
        }
    }
    
    
    return cell
    
}

func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    
    let obj = arr_data[indexPath.item]
    if obj.file_path != "" {
    let vc:PDFViewrVC  = AppDelegate.mainSB.instanceVC()
       
    vc.isModalInPresentation = true
    //vc.modalPresentationStyle = .overFullScreen
    vc.definesPresentationContext = true
    vc.Strurl = obj.file_path
    self.present(vc, animated: true, completion: nil)
    }
    
}


func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
    if tableView.tag == 0 {
        
        
        print(indexPath.section)
        if indexPath.row   == arr_data.count - 1  {
            updateNextSet()
            print("next step")
            
        }
    }
}

func updateNextSet(){
    print("On Completetion")
    if !allItemDownloaded {
        pageNumber = pageNumber + 1
        get_data(showLoading: false, loadOnly: true)
    }
}
}

