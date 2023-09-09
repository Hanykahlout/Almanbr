//
//  SupervisionOperationVC.swift
//  Almnabr
//
//  Created by MacBook on 18/10/2021.
//  Copyright © 2021 Samar Akkila. All rights reserved.
//

import UIKit
import DPLocalization
import FontAwesome_swift

var ProjectName:String?
class SupervisionOperationVC: UIViewController {
    
    
    @IBOutlet weak var lblsupervision: UILabel!
    @IBOutlet weak var lblRequest: UILabel!
    
    @IBOutlet weak var viewsupervision: UIView!
    @IBOutlet weak var viewRequest: UIView!
    
    
    @IBOutlet weak var mainView: UIView!
    
    
    var parentPageViewController: MyPageViewController!
    
    var StrTitle:String = "Projects".localized()
    var StrSubMenue:String = "All Projects".localized()
    var StrMenue:String = ""
    var SelectedIndex:Int = 0
    var MenuObj:MenuObj?
    var projects_work_area_id = ""
    var index = 0
    var identifiers: NSArray = ["ProjectRequestVC", "SupervisionOperationDetailsVC"]
    
    
    var Object:projectObj?
   
    var arr_view :[UIViewController] = []
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configGUI()
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        // Hide the Navigation Bar
        self.addNavigationBarTitle(navigationTitle: "Project")
        self.navigationController?.setNavigationBarHidden(false, animated: true)
        NotificationCenter.default.post(name: .init("send_projects_work_area_id"), object: self.projects_work_area_id)
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
       
        self.lblsupervision.text = "Supervision Operation".localized()
        self.lblRequest.text = "Project Request".localized()
       
        self.lblsupervision.font = .kufiRegularFont(ofSize: 13)
        self.lblRequest.font = .kufiRegularFont(ofSize: 13)
        
        ProjectName = Object?.projects_profile_name_en
        
        self.viewsupervision.backgroundColor = maincolor
        self.lblsupervision.textColor = .white
        
        
        self.viewRequest.backgroundColor = .clear
        self.lblRequest.textColor = maincolor
        self.viewRequest.setBorderWithColor(maincolor)
       
    }
    
    @IBAction func btnProjectRequest_Click(_ sender: Any) {
        
        self.viewRequest.backgroundColor = maincolor
        self.lblRequest.textColor = .white
        
        
        self.viewsupervision.backgroundColor = .clear
        self.lblsupervision.textColor = maincolor
        self.viewsupervision.setBorderWithColor(maincolor)
        
        
        self.SelectedIndex = 1
        self.change_page()
        
    }
    
    @IBAction func btnsupervision_Click(_ sender: Any) {
        
        self.viewsupervision.backgroundColor = maincolor
        self.lblsupervision.textColor = .white
        
        
        self.viewRequest.backgroundColor = .clear
        self.lblRequest.textColor = maincolor
        self.viewRequest.setBorderWithColor(maincolor)
        
        self.SelectedIndex = 0
        self.change_page()
    }
    
    private func change_page() {
        NotificationCenter.default.post(name: NSNotification.Name("Change_Supervision"), object: (SelectedIndex,projects_work_area_id))
    }
    
}



