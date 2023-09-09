//
//  FormVersionVC.swift
//  Almnabr
//
//  Created by MacBook on 05/11/2021.
//  Copyright © 2021 Samar Akkila. All rights reserved.
//

import UIKit
import DPLocalization

class FormVersionVC: UIViewController {
    
    @IBOutlet weak var mainView: UIView!
    @IBOutlet weak var table: UITableView!
    
    @IBOutlet weak var imgStep: UIImageView!
    @IBOutlet weak var viewStep: UIView!
    @IBOutlet weak var lblStep: UILabel!
    @IBOutlet weak var lblnodata: UILabel!
    @IBOutlet weak var img_nodata: UIImageView!
    
    @IBOutlet weak var btnNext: UIButton!
    @IBOutlet weak var btnPrevious: UIButton!
    
    var arr_data:[FormTransactionObj] = []
    var arr_unit:[uintObj] = []
    
    var form_wir_data:templateObj?
    
    var pageNumber = 1
    var IsOneChar:Bool = false
    var allItemDownloaded = false
    
    var ProjectObj:templateObj!
    var units_and_level:String = ""
    var transaction_separation:String = ""
    
    var projects_work_area_id:String = ""
    var template_platform_code_system:String = ""
    var template_platform_group_type_code_system:String = ""
    var template_id:String = ""
    var transaction_id:String = "0"
    var level_Unit = ""
    var StrLanguage:String = "en"
    
    var work_site:String = "ALL"
    var params = [:] as [String : String]
    var units :String = ""
    
    var IsFromTransaction:Bool = false
    
    var Skipnext :Bool = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configGUI()
        get_Form()

    }
    
    
    
    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        // Hide the Navigation Bar
        self.navigationController?.setNavigationBarHidden(true, animated: true)
    }
    
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        // Show the Navigation Bar
        self.navigationController?.setNavigationBarHidden(true, animated: true)
    }
    
    //MARK: - Config GUI
    //------------------------------------------------------
    func configGUI() {
        
        self.lblnodata.text =  "txt_NoData".localized()
        self.lblnodata.font = .kufiRegularFont(ofSize: 15)
        self.lblnodata.isHidden = true
        
        self.img_nodata.isHidden = false
        
        
        //self.mainView.setBorderGray()
        
        self.viewStep.backgroundColor = HelperClassSwift.acolor.getUIColor()
        self.lblStep.text = "txt_FormVersion".localized()
        self.lblStep.font = .kufiRegularFont(ofSize: 15)
        self.lblStep.textColor = "#616263".getUIColor()
        //HelperClassSwift.acolor.getUIColor()
        
        self.viewStep.setBorderGrayWidth(3)
        let Stepimage =  UIImage.fontAwesomeIcon(name: .building, style: .solid, textColor: HelperClassSwift.bcolor.getUIColor(), size: CGSize(width: 40, height: 40))
        self.imgStep.image = Stepimage
        
        table.dataSource = self
        table.delegate = self
        let nib = UINib(nibName: "FormVersionCell", bundle: nil)
        table.register(nib, forCellReuseIdentifier: "FormVersionCell")
        
        self.btnNext.setTitle("Next".localized(), for: .normal)
//        self.btnNext.backgroundColor =  HelperClassSwift.acolor.getUIColor()
//        self.btnNext.setTitleColor(.white, for: .normal)
//        self.btnNext.setRounded(10)
        
        
        self.btnPrevious.setTitle("Previous".localized(), for: .normal)
//        self.btnPrevious.backgroundColor =  HelperClassSwift.acolor.getUIColor()
//        self.btnPrevious.setTitleColor(.white, for: .normal)
//        self.btnPrevious.setRounded(10)
        
        if L102Language.currentAppleLanguage() == "ar" {
            self.btnNext.setImage(UIImage(systemName: "arrow.left"), for: .normal)
            self.btnPrevious.setImage(UIImage(systemName: "arrow.right"), for: .normal)
        }
        
    }
    
    func get_Form(){
        
        self.showLoadingActivity()
        
        //        guard ProjectObj != nil else{
        //            return
        //        }
        if IsOneChar == true{
            self.units_and_level = units_and_level.replacingOccurrences(of: ",", with: "")
            
            
        }
        var Formurl :String = ""
        let code = self.template_platform_group_type_code_system
        if code == "MIR" || code == "MSR" || code == "SQR"{
            Formurl = "form/FORM_\(self.template_platform_group_type_code_system)/cr/4/\(transaction_id)"
        }else{
            Formurl = "form/FORM_\(self.template_platform_group_type_code_system)/cr/3/\(transaction_id)"
        }
        APIController.shard.sendRequestPostAuth(urlString: Formurl, parameters: self.params ) { (response) in
            self.hideLoadingActivity()
            
            
            let status = response["status"] as? Bool
            if status == true{
                
                let page = response["page"] as? [String:Any]
                
                if  let list = response["records"] as? NSArray{
                    for i in list {
                        let dict = i as? [String:Any]
                        let obj = FormTransactionObj.init(dict!)
                        self.arr_data.append(obj)
                        self.table.reloadData()
                        
                    }
                    
                    let pageObj = PageObj(page!)
                    
                    if pageObj.total_pages > self.pageNumber {
                        self.allItemDownloaded = false
                    }else{
                        self.allItemDownloaded = true
                    }
                    if list.count == 0 {
                        self.img_nodata.isHidden = false
                       // self.lblnodata.isHidden = false
                    }else{
                        self.img_nodata.isHidden = true
                       // self.lblnodata.isHidden = true
                    }
                    self.hideLoadingActivity()
                }
            }
            
            
            
        }
    }
    
    
    
    
    @IBAction func btnNext_Click(_ sender: Any) {
        
//        if Skipnext == true {
//
//            let VC:AttachmentsVC = AppDelegate.mainSB.instanceVC()
//            VC.ProjectObj = self.ProjectObj
//            VC.StrLanguage = self.StrLanguage
//            VC.units_and_level = self.units_and_level
//            VC.transaction_separation = transaction_separation
//            VC.arr_unit = self.arr_unit
//            VC.parm = self.params
//            VC.work_site = self.work_site
//            VC.units = self.units
//            VC.level_Unit = self.level_Unit
//
//            VC.template_id = self.template_id
//            VC.projects_work_area_id = self.projects_work_area_id
//            VC.template_platform_code_system = self.template_platform_code_system
//
//            self.navigationController?.pushViewController(VC, animated: true)
//        }else{
            
        let VC:RelatedFormsVC = AppDelegate.mainSB.instanceVC()
        
        VC.ProjectObj = self.ProjectObj
        VC.StrLanguage = self.StrLanguage
        VC.units_and_level = self.units_and_level
        VC.transaction_separation = transaction_separation
        VC.arr_unit = self.arr_unit
        VC.params = self.params
        VC.work_site = self.work_site
        VC.units = self.units
        VC.level_Unit = self.level_Unit
        VC.Skipnext = self.Skipnext
        VC.template_id = self.template_id
        VC.projects_work_area_id = self.projects_work_area_id
        VC.template_platform_code_system = self.template_platform_code_system
        VC.transaction_id = self.transaction_id
        VC.template_platform_group_type_code_system = self.template_platform_group_type_code_system
        VC.form_wir_data = self.form_wir_data
        VC.IsFromTransaction = self.IsFromTransaction
        self.navigationController?.pushViewController(VC, animated: true)
    }
      
        
    //}
    
    @IBAction func btnBack_Click(_ sender: Any) {
        
        self.navigationController?.popViewController(animated: true)
    }
    
}



extension FormVersionVC: UITableViewDelegate , UITableViewDataSource{
    
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


