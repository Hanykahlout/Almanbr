//
//  FormVersionsVC.swift
//  Almnabr
//
//  Created by MacBook on 17/12/2021.
//  Copyright © 2021 Samar Akkila. All rights reserved.
//

import UIKit

class FormVersionsVC: UIViewController {

    @IBOutlet weak var table: UITableView!
    
    var params = [:] as [String : String]
    
    var arr_data:[FormTransactionObj] = []
    
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
        self.view.backgroundColor = maincolor //F0F4F8
        //navigationController?.navigationBar.barTintColor = .buttonBackgroundColor()
        navigationController?.navigationBar.barTintColor = maincolor
       addNavigationBarTitle(navigationTitle: "Form Versions".localized())
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
    
    
    
//    func get_Form(){
//
//        self.showLoadingActivity()
//
//    projects_work_area_id: 1
//    platform_code_system: 2.WIR.1.1
//    lang_key: en
//    page_no: 1
//    page_size: 10
//    transaction_separation: 0
//    work_site: GN
//    method: VIEW
//    units_and_level[level_all_building]: 234
//    template_id: 1
//
//
//        guard ProjectObj != nil else{
//            return
//        }
//
//        self.params["projects_work_area_id"] = obj_FormWir.projects_work_area_id
//
//        self.params["platform_code_system"] = obj_FormWir.template_platform_code_system
//        self.params["template_id"] = obj_FormWir.template_id
//        self.params["lang_key"] = "en"
//        self.params["transaction_separation"] = transaction_separation
//        self.params["page_no"] = "1"
//        self.params["page_size"] = "10"
//        self.params["work_site"] = obj_FormWir.work_site
//
//
//        if arr_unit.count == 0 {
//            self.params["units_and_level[\(self.level_Unit)]"] = self.units
//        }else{
//
//            var unit_str :String = ""
//            var value_str :String = ""
//
//            for i in arr_unit {
//
//                if value_str == i.value! {
//                    unit_str = unit_str + i.unit! + ","
//                    self.params["units_and_level[\(i.value ?? "level_all_building")]"] = i.unit
//                    value_str = i.value!
//                }else{
//                    self.params["units_and_level[\(i.value ?? "level_all_building")]"] = i.unit
//                    value_str = i.value!
//                }
//
//            }
//
//        }
//
//        APIManager.sendRequestPostAuth(urlString: "form/FORM_WIR/cr/3/\()", parameters: self.params ) { (response) in
//            self.hideLoadingActivity()
//
//
//            let status = response["status"] as? Bool
//            if status == true{
//
//                let page = response["page"] as? [String:Any]
//
//                if  let list = response["records"] as? NSArray{
//                    for i in list {
//                        let dict = i as? [String:Any]
//                        let obj = FormTransactionObj.init(dict!)
//                        self.arr_data.append(obj)
//                        self.table.reloadData()
//
//                    }
//
//                    let pageObj = PageObj(page!)
//
//                    if pageObj.total_pages > self.pageNumber {
//                        self.allItemDownloaded = false
//                    }else{
//                        self.allItemDownloaded = true
//                    }
//                    if list.count == 0 {
//                        self.lblnodata.isHidden = false
//                    }else{
//                        self.lblnodata.isHidden = true
//                    }
//                    self.hideLoadingActivity()
//                }
//            }
//
//
//
//            }
//        }

    
}






extension FormVersionsVC: UITableViewDelegate , UITableViewDataSource{
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    
      
            return arr_data.count
    
       
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
     
            let cell = tableView.dequeueReusableCell(withIdentifier: "FormVersionCell", for: indexPath) as! FormVersionCell
            
            let obj = arr_data[indexPath.item]
         
      
        let Number = "#" + "  \(indexPath.item + 1)"
        let TransactionNo = "Transaction Number".localized() +  "  \(obj.transaction_request_id)"
        let Unit = "Unit".localized() + "   \(obj.unit_id)"
        let WorkLevel = "Work Level".localized() + "   \(obj.levelname)"
        let Barcode = "Barcode".localized() + "   \(obj.tbv_barcodeData)"
        let Result = "Evaluation Result".localized() + "   \(obj.result_code)"
        let Date = "Date".localized() + "   \(obj.transactions_date_datetime)"
        
            
        cell.lblNo.text = Number
        cell.lblTransactionNo.text = TransactionNo
        cell.lblUnit.text = Unit
        cell.lblBarcode.text = Barcode
        cell.lblWorklevel.text = WorkLevel
        cell.lblDate.text = Date
        cell.lblEvaluationResult.text = Result
        
            let Numberattributed: NSAttributedString = Number.attributedStringWithColor(["#".localized()], color: HelperClassSwift.acolor.getUIColor())
            cell.lblNo.attributedText = Numberattributed
            
            let TransactionNoattributed: NSAttributedString = TransactionNo.attributedStringWithColor(["Transaction Number".localized()], color: HelperClassSwift.acolor.getUIColor())
            cell.lblTransactionNo.attributedText = TransactionNoattributed
            
            let Unitattributed: NSAttributedString = Unit.attributedStringWithColor(["Unit".localized()], color: HelperClassSwift.acolor.getUIColor())
            cell.lblUnit.attributedText = Unitattributed
            
            
            
            let WorkLevelattributed: NSAttributedString = WorkLevel.attributedStringWithColor(["Work Level".localized()], color: HelperClassSwift.acolor.getUIColor())
            cell.lblWorklevel.attributedText = WorkLevelattributed
            
            
            let Resultattributed: NSAttributedString = Result.attributedStringWithColor(["Evaluation Result".localized()], color: HelperClassSwift.acolor.getUIColor())
            cell.lblEvaluationResult.attributedText = Resultattributed
            
            let Barcodeattributed: NSAttributedString = Barcode.attributedStringWithColor(["Barcode".localized()], color: HelperClassSwift.acolor.getUIColor())
            cell.lblBarcode.attributedText = Barcodeattributed
            
        
        let Dateattributed: NSAttributedString = Date.attributedStringWithColor(["Date".localized()], color: HelperClassSwift.acolor.getUIColor())
        cell.lblDate.attributedText = Dateattributed
        
        if obj.file_path != "" {
            cell.btnAction.isHidden = false
        }else{
            cell.btnAction.isHidden = true
        }
           
        switch obj.color {
        case "RED":
            cell.viewColor.backgroundColor = .red
        case "ORANGE":
            cell.viewColor.backgroundColor = .orange
        default:
            cell.viewColor.backgroundColor = .lightGray
        }
        
                     cell.viewBack.setcorner()
         
                     let backgroundView = UIView()
                     backgroundView.backgroundColor = .white
                     cell.selectedBackgroundView = backgroundView
         
                     return cell
            
        
  
    }
   
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let obj = arr_data[indexPath.item]
        if obj.file_path != "" {
           // self.get_PDF(url:obj.file_path)
        let vc:PDFViewrVC  = AppDelegate.mainSB.instanceVC()
           
        vc.isModalInPresentation = true
        //vc.modalPresentationStyle = .overFullScreen
        vc.definesPresentationContext = true
        vc.Strurl = obj.file_path
        self.present(vc, animated: true, completion: nil)
    }}

}



