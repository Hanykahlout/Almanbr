//
//  RelatedFormsVC.swift
//  Almnabr
//
//  Created by MacBook on 05/11/2021.
//  Copyright © 2021 Samar Akkila. All rights reserved.
//

import UIKit
import DPLocalization

class RelatedFormsVC: UIViewController {

   
    @IBOutlet weak var mainView: UIView!
    @IBOutlet weak var table: UITableView!
    
    @IBOutlet weak var imgStep: UIImageView!
    @IBOutlet weak var viewStep: UIView!
    @IBOutlet weak var lblStep: UILabel!
    @IBOutlet weak var lblnodata: UILabel!
//    @IBOutlet weak var lblRelatedFormKey: UILabel!
    @IBOutlet weak var lblRelatedFormValue: UILabel!
    
    @IBOutlet weak var stackRelatedForm: UIStackView!
    
    @IBOutlet weak var btnNext: UIButton!
    @IBOutlet weak var img_nodata: UIImageView!
    
    @IBOutlet weak var btnPrevious: UIButton!
    
    var arr_data:[RelatedFormObj] = []
    var arr_unit:[uintObj] = []
    
    var pageNumber = 1
    var allItemDownloaded = false
    
    var ProjectObj:templateObj!
    var transaction_separation:String = ""
    var units_and_level :String = ""
    var StrLanguage:String = "en"
    var units :String = ""
    var work_site:String = "ALL"
    var params = [:] as [String : String]
    var level_Unit = ""
    
    var IsFromTransaction:Bool = false
    
    var form_wir_data:templateObj?
    var transaction_id:String = "0"
    
    var Skipnext :Bool = false
    
    var projects_work_area_id:String = ""
    var template_platform_code_system:String = ""
    var template_id:String = ""
    var template_platform_group_type_code_system:String = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if self.Skipnext == true {
            
            switch self.template_platform_group_type_code_system {
            case "MSR":
                let vc:RequirementsVC = AppDelegate.mainSB.instanceVC()
                self.navigationController?.pushViewController(vc, animated: true)
            case "WIR":
                let VC:AttachmentsVC = AppDelegate.mainSB.instanceVC()
                VC.ProjectObj = self.ProjectObj
                VC.StrLanguage = self.StrLanguage
                VC.units_and_level = self.units_and_level
                VC.transaction_separation = transaction_separation
                VC.arr_unit = self.arr_unit
                VC.parm = self.params
                VC.work_site = self.work_site
                VC.units = self.units
                VC.level_Unit = self.level_Unit
                VC.transaction_id = self.transaction_id
                VC.template_id = self.template_id
                VC.projects_work_area_id = self.projects_work_area_id
                VC.template_platform_code_system = self.template_platform_code_system
                VC.template_platform_group_type_code_system = self.template_platform_group_type_code_system
                self.navigationController?.pushViewController(VC, animated: true)
            default:
              print("nil")
            }
            
         
        }
        configGUI()
        get_Form(showLoading: true, loadOnly: true)
        
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
 
      
        //self.lblnodata.isHidden = true
        self.img_nodata.isHidden = true
        
        //self.mainView.setBorderGray()
        
        self.viewStep.backgroundColor = HelperClassSwift.acolor.getUIColor()
        self.lblStep.text = "txt_Relatedforms".localized()
        self.lblStep.font = .kufiRegularFont(ofSize: 15)
        self.lblStep.textColor = "#616263".getUIColor()
        //HelperClassSwift.acolor.getUIColor()
        
        
//        self.lblRelatedFormKey.text = "Related Forms : ".localized()
//        self.lblRelatedFormKey.font = .kufiRegularFont(ofSize: 15)
//        self.lblRelatedFormKey.textColor = .gray
        
        
        self.lblRelatedFormValue.font = .kufiRegularFont(ofSize: 13)
//        self.lblRelatedFormValue.textColor = .red
 
        
        self.viewStep.setBorderGrayWidth(3)
        let Stepimage =  UIImage.fontAwesomeIcon(name: .building, style: .solid, textColor: HelperClassSwift.bcolor.getUIColor(), size: CGSize(width: 40, height: 40))
        self.imgStep.image = Stepimage
        
        
        table.dataSource = self
        table.delegate = self
        let nib = UINib(nibName: "RelatedFormTVCell", bundle: nil)
        table.register(nib, forCellReuseIdentifier: "RelatedFormTVCell")
       
        
//        self.btnNext.backgroundColor =  HelperClassSwift.acolor.getUIColor()
//        self.btnNext.setTitleColor(.white, for: .normal)
//        self.btnNext.setRounded(10)
        
        self.btnNext.setTitle("Next".localized(), for: .normal)
        self.btnPrevious.setTitle("Previous".localized(), for: .normal)
//        self.btnPrevious.backgroundColor =  HelperClassSwift.acolor.getUIColor()
//        self.btnPrevious.setTitleColor(.white, for: .normal)
//        self.btnPrevious.setRounded(10)
        if L102Language.currentAppleLanguage() == "ar" {
            self.btnNext.setImage(UIImage(systemName: "arrow.left"), for: .normal)
            self.btnPrevious.setImage(UIImage(systemName: "arrow.right"), for: .normal)
        }
        
    }
    
    func get_Form(showLoading: Bool, loadOnly: Bool){
        
        
        if showLoading {
            self.showLoadingActivity()
        }
        
        
        APIController.shard.sendRequestPostAuth(urlString: "form/FORM_\(self.template_platform_group_type_code_system)/cr/1/\(transaction_id)", parameters: self.params ) { (response) in
            self.hideLoadingActivity()
           
            
            if self.pageNumber == 1 {
                self.arr_data.removeAll()
            }
            
           
            if loadOnly {
                self.table.reloadData()
            }
            
            
            let status = response["status"] as? Bool
            let NextButton = response["NextButton"] as? Bool
            let SkipPage = response["SkipPage"] as? Bool
            let Rule = response["Rule"] as? [String:Any]
            
            self.Skipnext = SkipPage ?? false
            if status == true{
                
                let page = response["page"] as? [String:Any]
                
                if  let list = response["records"] as? NSArray{
                    for i in list {
                        let dict = i as? [String:Any]
                        let obj = RelatedFormObj.init(dict!)
                        self.arr_data.append(obj)
                        self.table.reloadData()
                    }
                }else{
                   // self.lblRelatedFormValue.isHidden = true
                    self.img_nodata.isHidden = false
                }
                
                let RuleObj = RuleObj(Rule!)
                let related = "RelatedForms: "
                let text = "all related forms must be approved then you can open again :".localized() + " \(RuleObj.all_platforms_required)"

                let all = related + text

                let maincolor = "#c22c21".getUIColor()
               
                let attribute: NSAttributedString = all.attributedStringWithColor([text], color: maincolor)
                self.lblRelatedFormValue.attributedText = attribute
                
                if NextButton == false {
                    self.btnNext.isHidden = true
                }
                let pageObj = PageObj(page!)
              
                if pageObj.total_pages > self.pageNumber {
                    self.allItemDownloaded = false
                }else{
                    self.allItemDownloaded = true
                }
                
                if RuleObj.all_platforms_required == "0" {
                    self.lblRelatedFormValue.isHidden = true
                }else{
                    self.lblRelatedFormValue.isHidden = false
                }
                
                
                self.hideLoadingActivity()
                

            }

            
           
            }
        }

    
    
    @IBAction func btnNext_Click(_ sender: Any) {
        
        //        let VC:AttachmentsVC = AppDelegate.mainSB.instanceVC()
        //
        //        VC.transaction_id = self.transaction_id
        //
        //        VC.ProjectObj = self.ProjectObj
        //        VC.StrLanguage = self.StrLanguage
        //        VC.units_and_level = self.units_and_level
        //        VC.transaction_separation = transaction_separation
        //        VC.arr_unit = self.arr_unit
        //        VC.parm = self.params
        //        VC.work_site = self.work_site
        //        VC.units = self.units
        //        VC.level_Unit = self.level_Unit
        //        VC.template_platform_group_type_code_system = self.template_platform_group_type_code_system
        //        VC.template_id = self.template_id
        //        VC.projects_work_area_id = self.projects_work_area_id
        //        VC.template_platform_code_system = self.template_platform_code_system
        //
        //        self.navigationController?.pushViewController(VC, animated: true)
        
        switch self.template_platform_group_type_code_system {
        case "MSR":
            let vc:RequirementsVC = AppDelegate.mainSB.instanceVC()
            vc.params = self.params
            vc.ProjectObj = self.ProjectObj 
            self.navigationController?.pushViewController(vc, animated: true)
        case "SQR":
            let vc:RequirementsVC = AppDelegate.mainSB.instanceVC()
            vc.params = self.params
            vc.ProjectObj = self.ProjectObj
            self.navigationController?.pushViewController(vc, animated: true)
        case "MIR":
            let vc:RequirementsVC = AppDelegate.mainSB.instanceVC()
            vc.params = self.params
            vc.ProjectObj = self.ProjectObj
            self.navigationController?.pushViewController(vc, animated: true)
        case "WIR":
            let VC:AttachmentsVC = AppDelegate.mainSB.instanceVC()
            VC.ProjectObj = self.ProjectObj
            VC.StrLanguage = self.StrLanguage
            VC.units_and_level = self.units_and_level
            VC.transaction_separation = transaction_separation
            VC.arr_unit = self.arr_unit
            VC.parm = self.params
            VC.work_site = self.work_site
            VC.units = self.units
            VC.level_Unit = self.level_Unit
            VC.transaction_id = self.transaction_id
            VC.template_id = self.template_id
            VC.projects_work_area_id = self.projects_work_area_id
            VC.template_platform_code_system = self.template_platform_code_system
            VC.template_platform_group_type_code_system = self.template_platform_group_type_code_system
            VC.form_wir_data = self.form_wir_data
            VC.IsFromTransaction = self.IsFromTransaction
            self.navigationController?.pushViewController(VC, animated: true)
        default:
          print("nil")
        }
        
        
    }
    
    
    @IBAction func btnBack_Click(_ sender: Any) {
        
        self.navigationController?.popViewController(animated: true)
    }

}



extension RelatedFormsVC: UITableViewDelegate , UITableViewDataSource{
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    
      
            return arr_data.count
    
       
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
     
            let cell = tableView.dequeueReusableCell(withIdentifier: "RelatedFormTVCell", for: indexPath) as! RelatedFormTVCell
            
            let obj = arr_data[indexPath.item]
         
      
        let Number = "#" + "  \(indexPath.item + 1)"
        let Unit = "Unit".localized() + " \n \(obj.unit)"
        let WorkLevel = "Work Level".localized() + " \n \(obj.work_level_label)"
        let Result = "Evaluation Result".localized() + " \n \(obj.result_code)"
        let RelatedForms = "Related Forms".localized() + ":   \(obj.platform_label)"
        
        let maincolor = "#1A3665".getUIColor()
        
      
        cell.lblNumber.text = Number
        
       
        let Unitattribute: NSAttributedString = Unit.attributedStringWithColor(["Unit"], color: maincolor)
        cell.lblunit.attributedText = Unitattribute
        
        let WorkLevelattribute: NSAttributedString = WorkLevel.attributedStringWithColor(["Work Level"], color: maincolor)
        cell.lblWorkLevel.attributedText = WorkLevelattribute
        
        let Resultattribute: NSAttributedString = Result.attributedStringWithColor(["Evaluation Result"], color: maincolor)
        cell.lblEvalution.attributedText = Resultattribute
        
        let RelatedFormsattribute: NSAttributedString = RelatedForms.attributedStringWithColor(["Related Forms"], color: maincolor)
        cell.lblRelatedForms.attributedText = RelatedFormsattribute
     
       
        if obj.file_path != "" {
            cell.btnFile.isHidden = false
        }else{
            cell.btnFile.isHidden = true
        }
       
            
        
        switch obj.color {
        case "RED":
            cell.viewStatus.backgroundColor = "#c22c21".getUIColor()
        case "ORANGE":
            cell.viewStatus.backgroundColor = "#fcc868".getUIColor()
        default:
            cell.viewStatus.backgroundColor = .lightGray
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
    }}
    
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
                get_Form(showLoading: false, loadOnly: true)
            }
       }


}


