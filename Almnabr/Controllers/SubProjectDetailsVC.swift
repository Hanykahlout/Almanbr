//
//  SubProjectDetailsVC.swift
//  Almnabr
//
//  Created by MacBook on 13/10/2021.
//  Copyright © 2021 Samar Akkila. All rights reserved.
//

import UIKit
import DPLocalization
import FontAwesome_swift

class SubProjectDetailsVC: UIViewController {
    
    @IBOutlet weak var imgNext1: UIImageView!
    @IBOutlet weak var imgNext2: UIImageView!
    
    @IBOutlet weak var lblHome: UIButton!
    @IBOutlet weak var lblMenuName: UILabel!
    @IBOutlet weak var lblSubMenuName: UILabel!
    @IBOutlet weak var lblTitle: UILabel!
    
    @IBOutlet weak var lblAllProject: UILabel!
    @IBOutlet weak var lblMainProjectView: UILabel!
    @IBOutlet weak var lblSupervision: UILabel!
    
    @IBOutlet weak var View_AllProject: UIView!
    @IBOutlet weak var View_MainProjectView: UIView!
    @IBOutlet weak var View_Supervision: UIView!
    
    @IBOutlet weak var mainView: UIView!
    
    
    @IBOutlet weak var header: HeaderView!
    
    
    
    
    var StrTitle:String = ""
    var StrSubMenue:String = ""
    var StrMenue:String = ""
    var MenuObj:MenuObj?
    
    var Object:projectObj?
    
    let fontStyle: FontAwesomeStyle = .solid
    
    override func viewDidLoad() {
        super.viewDidLoad()

        configGUI()
        header.btnAction = self.menu_select
        
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        // Hide the Navigation Bar
        self.navigationController?.setNavigationBarHidden(true, animated: true)
    }
    
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        // Show the Navigation Bar
        self.navigationController?.setNavigationBarHidden(true, animated: false)
    }
    
    // MARK: - Config Navigation
    func configNavigation() {
        _ = self.navigationController?.preferredStatusBarStyle
        self.view.backgroundColor = "FFFFFF".getUIColor() //F0F4F8
        navigationController?.navigationBar.barTintColor = .red
        
        addNavigationBarTitle(navigationTitle: StrTitle)
    }
    
    
    //MARK: - Config GUI
    //------------------------------------------------------
    func configGUI() {
        
       
        lblHome.titleLabel?.textColor =  HelperClassSwift.bcolor.getUIColor()
        lblHome.titleLabel?.font = .kufiRegularFont(ofSize: 15)
        
        lblMenuName.textColor =  HelperClassSwift.acolor.getUIColor()
        lblMenuName.font = .kufiRegularFont(ofSize: 15)
        
        
        lblSubMenuName.textColor =  HelperClassSwift.acolor.getUIColor()
        lblSubMenuName.font = .kufiRegularFont(ofSize: 15)
        
        
        self.lblHome.titleLabel?.text =  "txt_Home".localized()
        self.lblHome.titleLabel?.font = .kufiRegularFont(ofSize: 15)
        
        
        self.lblAllProject.text =  "All Projects".localized()
        self.lblAllProject.font = .kufiRegularFont(ofSize: 14)
        self.lblAllProject.textColor =  .white
        
        self.lblMainProjectView.text =  "txt_MainProjectView".localized()
        self.lblMainProjectView.font = .kufiRegularFont(ofSize: 13)
        self.lblMainProjectView.textColor = .white
        
        self.lblSupervision.text =  "txt_AllProjects".localized()
        self.lblSupervision.font = .kufiRegularFont(ofSize: 13)
        self.lblSupervision.textColor =  .white
        
        self.mainView.setBorderGray()
        
        self.View_AllProject.setRounded(5)
        self.View_MainProjectView.setRounded(5)
        self.View_Supervision.setRounded(5)
        
        self.View_AllProject.backgroundColor = HelperClassSwift.acolor.getUIColor()
        self.View_MainProjectView.backgroundColor = HelperClassSwift.acolor.getUIColor()
        self.View_Supervision.backgroundColor = HelperClassSwift.acolor.getUIColor()
        
        self.lblMenuName.text =  self.StrMenue
        self.lblSubMenuName.text =  StrSubMenue
        let nextimage =  UIImage.fontAwesomeIcon(name: .angleRight, style: self.fontStyle, textColor: HelperClassSwift.bcolor.getUIColor(), size: CGSize(width: 40, height: 40))
        self.imgNext1.image = nextimage
        self.imgNext2.image = nextimage
  

        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(GoToAllProject))

        lblSubMenuName.isUserInteractionEnabled = true
        lblSubMenuName.addGestureRecognizer(tapGesture)
        
    }
    
    
    
    
    func menu_select(){
        let language =  L102Language.currentAppleLanguage()
        if language == "ar"{
            panel?.openRight(animated: true)
        }else{
            panel?.openLeft(animated: true)
        }
        
    }
    
    @objc func GoToAllProject() {
        let vc:AllPrpjectsVC = AppDelegate.mainSB.instanceVC()
        vc.MenuObj = MenuObj
        vc.StrSubMenue =  "All Projects".localized()
        vc.StrMenue = "Projects".localized()
        _ =  panel?.center(vc)
    }
    
    @objc func GoToMainProject() {
        let vc:ProjectDetailsVC = AppDelegate.mainSB.instanceVC()
        vc.MenuObj = MenuObj
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
    
    @IBAction func btnMainProject_Click(_ sender: Any) {
        
        let vc:ProjectDetailsVC = AppDelegate.mainSB.instanceVC()
        vc.MenuObj = MenuObj
        vc.StrSubMenue =  "All Projects".localized()
        vc.StrMenue = "Projects".localized()
        vc.Object = self.Object
       
        _ =  panel?.center(vc)
    }
    
    
    @IBAction func btnSupervision_Click(_ sender: Any) {
      
        let vc:SupervisionOperationVC = AppDelegate.mainSB.instanceVC()
        let page = UINavigationController.init(rootViewController: vc)
        vc.MenuObj = MenuObj
        vc.StrSubMenue =  "All Projects".localized()
        vc.StrMenue = "Projects".localized()
        vc.Object = self.Object
        _ =  panel?.center(page)
        
    }
}
