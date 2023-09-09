//
//  LocationVC.swift
//  Almnabr
//
//  Created by MacBook on 02/03/2022.
//  Copyright © 2022 Samar Akkila. All rights reserved.
//

import UIKit

class LocationVC: UIViewController  {

    @IBOutlet weak var lblWorkSite: UILabel!
    @IBOutlet weak var lblAllUnits: UILabel!
    
    @IBOutlet weak var colleection_workLevel: UICollectionView!
    @IBOutlet weak var colleection_units: UICollectionView!
    
    @IBOutlet weak var imgStep: UIImageView!
    @IBOutlet weak var viewStep: UIView!
    @IBOutlet weak var lblStep: UILabel!
    
    @IBOutlet weak var btnNext: UIButton!
    @IBOutlet weak var btnPrevious: UIButton!
    
    var arr_Work:[ModuleObj] = []
    var arr_workLevelLabel:[String] = []
    var arr_unit:[String] = []
    
    var ProjectObj:templateObj!
    
    var projects_work_area_id:String = ""
    var template_platform_code_system:String = ""
    var template_id:String = ""
    var phase_zone_block_cluster_g_nos:String = ""
    var template_platform_group_type_code_system:String = ""
    
    var params = [:] as [String : String]
    var StrLanguage:String = "en"
    override func viewDidLoad() {
        super.viewDidLoad()

        //setup_collection()
        configGUI()
        get_WorkLevel()
        get_unit()
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
        
        
        self.btnNext.setTitle("Next".localized(), for: .normal)
        self.btnPrevious.setTitle("Previous".localized(), for: .normal)
        
        self.lblAllUnits.text =  "txt_units".localized()
        self.lblWorkSite.text = "txt_workLevels".localized()
       
        self.viewStep.backgroundColor = HelperClassSwift.acolor.getUIColor()
        self.lblStep.text = "txt_Location".localized()
        self.lblStep.font = .kufiRegularFont(ofSize: 15)
        self.lblStep.textColor = "#616263".getUIColor()
        //HelperClassSwift.acolor.getUIColor()
        
        self.viewStep.setBorderGrayWidth(3)
        let Stepimage =  UIImage.fontAwesomeIcon(name: .building, style: .solid, textColor: HelperClassSwift.bcolor.getUIColor(), size: CGSize(width: 40, height: 40))
        self.imgStep.image = Stepimage

        
        self.params["projects_work_area_id"] =  ProjectObj.projects_work_area_id
        self.params["platform_code_system"] = ProjectObj.template_platform_code_system
        self.params["lang_key"] = StrLanguage
        self.params["page_no"] = "1"
        self.params["page_size"] = "10"
        self.params["template_id"] = ProjectObj.template_id
       
        
        if L102Language.currentAppleLanguage() == "ar" {
            self.btnNext.setImage(UIImage(systemName: "arrow.left"), for: .normal)
            self.btnPrevious.setImage(UIImage(systemName: "arrow.right"), for: .normal)
        }
    }
    

    
    func get_WorkLevel(){

    
        self.showLoadingActivity()
        APIController.shard.sendRequestGetAuth(urlString: "form/FORM_\(ProjectObj.template_platform_group_type_code_system)/get_work_levels_for_transaction?projects_work_area_id=\( ProjectObj.projects_work_area_id)&platform_code_system=\( ProjectObj.template_platform_code_system)&template_id=\(ProjectObj.template_id)&lang_key=en" ) { (response) in
            
            let status = response["status"] as? Bool
            if status == true{
                if  let list = response["records"] as? NSArray{
                    for i in list {
                        let dict = i as? [String:Any]
                        let obj = ModuleObj.init(dict!)
                        self.arr_Work.append(obj)
                       
                        self.arr_workLevelLabel.append(obj.value)
                        
                    }
                    self.colleection_workLevel.reloadData()
                    self.hideLoadingActivity()
                }
            }
            //self.hideLoadingActivity()
            
        }
    }
    
    
    func get_unit(){

        self.showLoadingActivity()
        
        APIController.shard.sendRequestGetAuth(urlString: "form/FORM_\(ProjectObj.template_platform_group_type_code_system)/search_units_by_phases_general_no?projects_work_area_id=\( ProjectObj.projects_work_area_id)&platform_code_system=\( ProjectObj.template_platform_code_system)&template_id=\(ProjectObj.template_id)&lang_key=en" ) { (response) in
            
            let status = response["status"] as? Bool
            if status == true{
                if  let list = response["records"] as? String{
                    //self.arr_unit = list.split(separator: ",")
                    
                   let arr = list.components(separatedBy: ",")
                    self.arr_unit = arr
                    self.colleection_units.reloadData()
                  
                }
                self.hideLoadingActivity()
            }else{
                self.hideLoadingActivity()
            }
          
            
        }
    }
    
    
    
    
    @IBAction func btnNext_Click(_ sender: Any) {
 
        let VC:FormVersionVC = AppDelegate.mainSB.instanceVC()
        VC.params = self.params
        VC.ProjectObj=self.ProjectObj
        self.navigationController?.pushViewController(VC, animated: true)
        
    }
    
    @IBAction func btnBack_Click(_ sender: Any) {
        
        self.navigationController?.popViewController(animated: true)
    }
    
}


extension LocationVC: UICollectionViewDataSource ,UICollectionViewDelegate , UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        switch collectionView {
        case colleection_units:
            return arr_unit.count
        case colleection_workLevel:
            return arr_Work.count
        default:
            return 0
        }
       
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell1 = collectionView.dequeueReusableCell(withReuseIdentifier: "unitCVCell", for: indexPath) as! unitCVCell
        
        
        switch collectionView {
        case colleection_units:
            cell1.lblTitle.text = arr_unit[indexPath.row]
            cell1.viewBack.setBorderWithColor("C0DCF5".getUIColor())
            cell1.lblTitle.font = .kufiRegularFont(ofSize: 13)
            
            return cell1
        case colleection_workLevel:
            let object = arr_Work[indexPath.row]
            cell1.lblTitle.text = object.label
            cell1.lblTitle.font = .kufiRegularFont(ofSize: 13)
            cell1.viewBack.setBorderWithColor("458FB8".getUIColor())
            return cell1
        default:
            return UICollectionViewCell()
        }
    }
    
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
       // cell.view_img.backgroundColor = HelperClassSwift.acolor.getUIColor()
        
    }
}
