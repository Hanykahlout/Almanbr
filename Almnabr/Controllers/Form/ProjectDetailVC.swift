//
//  ProjectDetailVC.swift
//  Almnabr
//
//  Created by MacBook on 03/03/2022.
//  Copyright © 2022 Samar Akkila. All rights reserved.
//

import UIKit
import DPLocalization
import FontAwesome_swift
import Alamofire

class ProjectDetailVC: UIViewController {
    
    @IBOutlet weak var lblProjectDetails: UILabel!
    
    @IBOutlet weak var Projectview: UIView!
    
    @IBOutlet weak var lblProjectTitle: UILabel!
    @IBOutlet weak var lblSupervisionID: UILabel!
    @IBOutlet weak var lblSupervisionName: UILabel!
    @IBOutlet weak var lblFormCode: UILabel!
    @IBOutlet weak var lblFormName: UILabel!
    @IBOutlet weak var lblFormSpecifications: UILabel!
    
    @IBOutlet weak var lblSupervision: UILabel!
    @IBOutlet weak var lblForm: UILabel!
    
    @IBOutlet weak var lblStep: UILabel!
    
    @IBOutlet weak var stepView: UIView!
    

    
    var ProjectObj:templateObj?
    var StrTitle:String = ""
    var Drawing_file:String = ""
    
    var Object:projectObj?
    
    var MenuObj:MenuObj?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        configNavigation()
        configGUI()
        
        
        get_data()
       
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
       addNavigationBarTitle(navigationTitle: "Project Details".localized())
        UINavigationBar.appearance().backgroundColor = maincolor
    }
    
    
    //MARK: - Config GUI
    //------------------------------------------------------
    func configGUI() {
        
        IsTransaction = false
        
    
        lblProjectDetails.font = .kufiBoldFont(ofSize: 18)
        lblProjectDetails.text = "Project Details".localized()
        
        lblStep.textColor =  "1A3665".getUIColor()
        lblStep.font = .kufiBoldFont(ofSize: 15)
        lblStep.text = "txt_config".localized()
        
        lblProjectTitle.font = .kufiBoldFont(ofSize: 15)
        lblProjectTitle.text = ProjectName
        
        lblSupervision.text = "Supervision".localized()
        lblSupervision.font = .kufiRegularFont(ofSize: 16)
        lblSupervision.textColor =  "#616263".getUIColor()
        
        lblForm.text = "Form".localized()
        lblForm.font = .kufiRegularFont(ofSize: 16)
        lblForm.textColor =  "#616263".getUIColor()
        
        lblSupervisionID.text = "ID".localized() + ": " + ProjectObj!.projects_work_area_id + "     Name".localized() + ": " + ProjectName!
        lblSupervisionID.font = .kufiRegularFont(ofSize: 15)
        lblSupervisionID.textColor =  "1A3665".getUIColor()
        
        lblSupervisionName.text = "Name".localized() + ": " + ProjectName!
        lblSupervisionName.font = .kufiRegularFont(ofSize: 15)
        lblSupervisionName.textColor =  "1A3665".getUIColor()
        
        
        lblFormCode.text = "Code".localized() + ": " + ProjectObj!.template_platform_code_system
        lblFormCode.font = .kufiRegularFont(ofSize: 15)
        lblFormCode.textColor =  "1A3665".getUIColor()
        
        lblFormName.text = "Name".localized() + ": " + ProjectObj!.platformname
        lblFormName.font = .kufiRegularFont(ofSize: 15)
        lblFormName.textColor =  "1A3665".getUIColor()
        
        
        lblFormSpecifications.text = "Specifications".localized() + ": ---"
        lblFormSpecifications.font = .kufiRegularFont(ofSize: 15)
        lblFormSpecifications.textColor =  "1A3665".getUIColor()
        
        Projectview.setBorderGray()
        stepView.setBorderGray()
        
        Projectview.layer.applySketchShadow(
          color: .black,
          alpha: 0.06,
          x: 0,
          y: 13,
          blur: 16,
          spread: 0)
        
        stepView.layer.applySketchShadow(
          color: .black,
          alpha: 0.06,
          x: 0,
          y: 13,
          blur: 16,
          spread: 0)
    }
    
    func get_data(){
    
      self.showLoadingActivity()
        
        let param = ["projects_work_area_id" : ProjectObj?.projects_work_area_id ?? "1",
                     "platform_code_system" : ProjectObj?.template_platform_code_system ?? "2.WIR.1.1",
                     "template_id" : ProjectObj?.template_id ?? "1"] as [String :Any]
        APIController.shard.sendRequestPostAuth(urlString: "form/FORM_\(ProjectObj?.template_platform_group_type_code_system ?? "WIR")/cr/0/0",parameters: param) { (response) in
            //,Parameters : param
            let status = response["status"] as? Bool
            if status == true{
                if  let data = response["data"] as? [String:Any]{
                    
                    self.Drawing_file = data["drawing_file"] as? String ?? ""
                    self.hideLoadingActivity()
                }
            }else{
                self.hideLoadingActivity()
            }
            
            
        }
    }
    
    
    
    func showLangVC() {
        self.performSegue(withIdentifier: "LanguageContainer", sender: self)
    }


    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if (segue.identifier == "LanguageContainer")
        {
            
            let destination = segue.destination as! UINavigationController
            let vc = destination.topViewController as! LanguageVC
            vc.IsFromTransaction = false
            IsTransaction = false
           // let vc: LanguageVC = segue.destination as! LanguageVC
            vc.ProjectObj = ProjectObj
        }
    }

 
    func menu_select(){
        let language =  L102Language.currentAppleLanguage()
        if language == "ar"{
            panel?.openRight(animated: true)
        }else{
            panel?.openLeft(animated: true)
        }
        
    }
    
    
    @IBAction func btnMenu_Click(_ sender: Any) {
        menu_select()
        
    }
    
    @IBAction func btnDrawing_file_Click(_ sender: Any) {
        let url = Drawing_file
        let vc:PDFViewrVC  = AppDelegate.mainSB.instanceVC()
        vc.isModalInPresentation = true
        vc.definesPresentationContext = true
        vc.Strurl = self.Drawing_file
        self.present(vc, animated: true, completion: nil)
        
    }

}
