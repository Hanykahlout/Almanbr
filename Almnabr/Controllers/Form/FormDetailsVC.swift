//
//  FormDetailsVC.swift
//  Almnabr
//
//  Created by MacBook on 03/11/2021.
//  Copyright © 2021 Samar Akkila. All rights reserved.
//

import UIKit
import DPLocalization
import FontAwesome_swift

class FormDetailsVC: UIViewController {

    @IBOutlet weak var imgNext1: UIImageView!
    @IBOutlet weak var imgNext2: UIImageView!
    
    @IBOutlet weak var lblHome: UIButton!
    @IBOutlet weak var lblMenuName: UILabel!
    @IBOutlet weak var lblSubMenuName: UILabel!
    @IBOutlet weak var lblTitle: UILabel!
    
    @IBOutlet weak var lblConfig: UILabel!
    
    
    @IBOutlet weak var lblAllProject: UILabel!
    @IBOutlet weak var lblSupervision: UILabel!
    
    @IBOutlet weak var View_AllProject: UIView!
    @IBOutlet weak var View_Supervision: UIView!
    
    
    @IBOutlet weak var lblProjectTitle: UILabel!
    @IBOutlet weak var lblSupervisionID: UILabel!
    @IBOutlet weak var lblSupervisionName: UILabel!
    @IBOutlet weak var lblFormCode: UILabel!
    @IBOutlet weak var lblFormName: UILabel!
    @IBOutlet weak var lblFormSpecifications: UILabel!
    
    @IBOutlet weak var lblKeyProjectTitle: UILabel!
    @IBOutlet weak var lblKeySupervisionID: UILabel!
    @IBOutlet weak var lblKeySupervisionName: UILabel!
    @IBOutlet weak var lblKeyFormCode: UILabel!
    @IBOutlet weak var lblKeyFormName: UILabel!
    @IBOutlet weak var lblKeyFormSpecifications: UILabel!
  
    @IBOutlet weak var mainView: UIView!
    
    @IBOutlet weak var ConfigView: UIView!
    
    @IBOutlet weak var header: HeaderView!

    
    var ProjectObj:templateObj?
    var StrTitle:String = ""
    var StrSubMenue:String = ""
    var StrMenue:String = ""
    let fontStyle: FontAwesomeStyle = .solid
    
    var Object:projectObj?
    
    var MenuObj:MenuObj?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configNavigation()
        configGUI()
        
//        header.btnAction = menu_select

        // Do any additional setup after loading the view.
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        // Hide the Navigation Bar
        self.navigationController?.setNavigationBarHidden(true, animated: true)
    }
    
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        // Show the Navigation Bar
        self.navigationController?.setNavigationBarHidden(false, animated: true)
    }
    
    func menu_select(){
        let language =  L102Language.currentAppleLanguage()
        if language == "ar"{
            panel?.openRight(animated: true)
        }else{
            panel?.openLeft(animated: true)
        }
        
    }
//
//    // MARK: - Config Navigation
//    func configNavigation() {
//        _ = self.navigationController?.preferredStatusBarStyle
//        self.view.backgroundColor = "FFFFFF".getUIColor() //F0F4F8
//        navigationController?.navigationBar.barTintColor = .red
//
//        addNavigationBarTitle(navigationTitle: StrTitle)
//    }
    
    
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
        
        IsTransaction = true
        
    
        lblHome.titleLabel?.textColor =  HelperClassSwift.bcolor.getUIColor()
        lblHome.titleLabel?.font = .kufiRegularFont(ofSize: 15)
        
        lblMenuName.textColor =  HelperClassSwift.acolor.getUIColor()
        lblMenuName.font = .kufiRegularFont(ofSize: 15)
        
        lblTitle.textColor =  HelperClassSwift.acolor.getUIColor()
        lblTitle.font = .kufiBoldFont(ofSize: 15)
        
        lblConfig.textColor =  HelperClassSwift.acolor.getUIColor()
        lblConfig.font = .kufiBoldFont(ofSize: 15)
        lblConfig.text = "txt_config".localized()
        
        lblMenuName.text = "projects"
        self.mainView.setBorderGray()
        self.ConfigView.setBorderGray()
        
        
        lblSubMenuName.textColor =  HelperClassSwift.acolor.getUIColor()
        lblSubMenuName.font = .kufiRegularFont(ofSize: 15)
        
        
        self.lblHome.titleLabel?.text =  "txt_Home".localized()
        self.lblHome.titleLabel?.font = .kufiRegularFont(ofSize: 15)
        
        
        self.lblKeyProjectTitle.text = "Project Title".localized()
        self.lblKeySupervisionID.text = "Supervision ID".localized()
        self.lblKeySupervisionName.text = "Supervision Name".localized()
        self.lblKeyFormCode.text = "Form Code".localized()
        self.lblKeyFormName.text = "Form Name".localized()
        self.lblKeyFormSpecifications.text = "Form Specifications".localized()
       
        self.lblKeyProjectTitle.textColor =  HelperClassSwift.bcolor.getUIColor()
        self.lblKeySupervisionID.textColor =  HelperClassSwift.bcolor.getUIColor()
        self.lblKeySupervisionName.textColor =  HelperClassSwift.bcolor.getUIColor()
        self.lblKeyFormCode.textColor =  HelperClassSwift.bcolor.getUIColor()
        self.lblKeyFormName.textColor =  HelperClassSwift.bcolor.getUIColor()
        self.lblKeyFormSpecifications.textColor =  HelperClassSwift.bcolor.getUIColor()
       
      
        self.lblProjectTitle.text = ProjectName
        self.lblProjectTitle.font = .kufiRegularFont(ofSize: 15)
        self.lblProjectTitle.textColor =  HelperClassSwift.bcolor.getUIColor()
        
        
        
        lblSupervisionID.text = ProjectObj!.projects_work_area_id
        self.lblSupervisionID.font = .kufiRegularFont(ofSize: 15)
        self.lblSupervisionID.textColor = HelperClassSwift.bcolor.getUIColor()
        
        
        
        lblSupervisionName.text = ProjectName
        self.lblSupervisionName.font = .kufiRegularFont(ofSize: 15)
        self.lblSupervisionName.textColor =  HelperClassSwift.bcolor.getUIColor()
        
        
        lblFormCode.text = ProjectObj!.template_platform_code_system
        self.lblFormCode.font = .kufiRegularFont(ofSize: 15)
        self.lblFormCode.textColor =  HelperClassSwift.bcolor.getUIColor()
        
        
       
        self.lblFormName.text =  ProjectObj!.platformname
        self.lblFormName.font = .kufiRegularFont(ofSize: 15)
        self.lblFormName.textColor =  HelperClassSwift.bcolor.getUIColor()
        
        
        self.lblFormSpecifications.text = ""
        self.lblFormSpecifications.font = .kufiRegularFont(ofSize: 15)
        self.lblFormSpecifications.textColor =  HelperClassSwift.bcolor.getUIColor()
        
      
        self.lblMenuName.text =  self.StrMenue
        self.lblSubMenuName.text =  StrSubMenue
        self.lblTitle.text =  "Project Details".localized()
        
        
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(GoToAllProject))

        lblSubMenuName.isUserInteractionEnabled = true
        lblSubMenuName.addGestureRecognizer(tapGesture)
        
        
        let nextimage =  UIImage.fontAwesomeIcon(name: .angleRight, style: self.fontStyle, textColor: HelperClassSwift.bcolor.getUIColor(), size: CGSize(width: 40, height: 40))
        self.imgNext1.image = nextimage
        self.imgNext2.image = nextimage
        
        
        
        self.lblAllProject.text =  "All Projects".localized()
        self.lblAllProject.font = .kufiRegularFont(ofSize: 14)
        self.lblAllProject.textColor =  .white
        
        self.lblSupervision.text =  "txt_SupervisionDashboard".localized()
        self.lblSupervision.font = .kufiRegularFont(ofSize: 13)
        self.lblSupervision.textColor =  .white
        
        self.View_AllProject.setRounded(5)
        self.View_Supervision.setRounded(5)
        
        self.View_AllProject.backgroundColor = HelperClassSwift.acolor.getUIColor()
       
        self.View_Supervision.backgroundColor = HelperClassSwift.acolor.getUIColor()
        
        
        
       
      //  showLangVC()
        
     
       
    }
    
    
    
    func showLangVC() {
        self.performSegue(withIdentifier: "LanguageContainer", sender: self)
    }


    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if (segue.identifier == "LanguageContainer")
        {
            
            let destination = segue.destination as! UINavigationController
            let vc = destination.topViewController as! LanguageVC
            vc.IsFromTransaction = true
            IsTransaction = true
           // let vc: LanguageVC = segue.destination as! LanguageVC
            vc.ProjectObj = ProjectObj
        }
    }
    
    
//    func sendData() {
//
//        let CVC = children.last as! LanguageVC
//        CVC.ProjectObj = self.ProjectObj
//    }
    
    @objc func GoToAllProject() {
        let vc:AllPrpjectsVC = AppDelegate.mainSB.instanceVC()
        //vc.MenuObj = MenuObj
        vc.StrSubMenue =  "All Projects".localized()
        vc.StrMenue = "Projects".localized()
        _ =  panel?.center(vc)
    }
    

    
    
    @IBAction func btnAllProject_Click(_ sender: Any) {
        
        let vc:AllPrpjectsVC = AppDelegate.mainSB.instanceVC()
        vc.MenuObj = MenuObj
        vc.StrSubMenue =  "All Projects".localized()
        vc.StrMenue = "Projects".localized()
        vc.MenuObj = self.MenuObj
        _ =  panel?.center(vc)
        
    }
    
    @IBAction func btnSupervision_Click(_ sender: Any) {
      
        let vc:SupervisionOperationVC = AppDelegate.mainSB.instanceVC()
        vc.MenuObj = MenuObj
        vc.StrSubMenue =  "All Projects".localized()
        vc.StrMenue = "Projects".localized()
        //vc.Object = self.ProjectObj
       
        _ =  panel?.center(vc)
        
    }
    

}
