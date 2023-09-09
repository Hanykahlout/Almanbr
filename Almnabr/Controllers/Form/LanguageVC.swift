//
//  LanguageVC.swift
//  Almnabr
//
//  Created by MacBook on 05/11/2021.
//  Copyright © 2021 Samar Akkila. All rights reserved.
//

import UIKit
import DropDown
import DPLocalization

var IsTransaction:Bool = false

class LanguageVC: UIViewController {

    
    @IBOutlet weak var lblLanguage: UILabel!
    
    @IBOutlet weak var lblLanguageSelect: UILabel!
   
    @IBOutlet weak var viewLanguageSelect: UIView!
   
    @IBOutlet weak var btnLanguageSelect: UIButton!
    
    @IBOutlet weak var imgDropLanguageSelect: UIImageView!
    
    @IBOutlet weak var imgStep: UIImageView!
    @IBOutlet weak var viewStep: UIView!
    @IBOutlet weak var lblStep: UILabel!
    
    @IBOutlet weak var mainView: UIView!
    @IBOutlet weak var btnNext: UIButton!
    @IBOutlet weak var icon_noPermission: UIImageView!
    @IBOutlet weak var view_noPermission: UIView!
    @IBOutlet weak var lbl_noPermission: UILabel!
    
    
    
    var arr_Language:[ModuleObj] = []
    var arr_LanguageLabel:[String] = []
    var arr_NoData:[String] = ["No items found".localized()]
    
    var arr_lang = ["English".localized(),"Arabic".localized()]
    var ProjectObj:templateObj?
    
//    var FormWirObj:form_wir_dataObj?
    var transactions_name:String = "WIR"
    var StrLanguage:String = "en"
    var IsFromTransaction:Bool = false
    
    let dropUpmage =  UIImage.fontAwesomeIcon(name: .chevronUp , style: .solid, textColor:  .gray, size: CGSize(width: 40, height: 40))
    
    let dropDownmage =  UIImage.fontAwesomeIcon(name: .chevronDown , style: .solid, textColor:  .gray, size: CGSize(width: 40, height: 40))
//    var isFromTransaction:Bool = false
   
    override func viewDidLoad() {
        super.viewDidLoad()

        configGUI()
        get_Lang()
        update_observer()
   
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        self.navigationController?.setNavigationBarHidden(true, animated: true)
        
        configGUI()
    
    }
    
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        // Show the Navigation Bar
//        self.navigationController?.setNavigationBarHidden(true, animated: true)
    }
    
    

    
    
    //MARK: - Config GUI
    //------------------------------------------------------
    func configGUI() {
     
        self.view.backgroundColor = .white//F0F4F8
        
        lblLanguage.textColor = maincolor
        lblLanguage.font = .kufiBoldFont(ofSize: 15)
        lblLanguage.text = "txt_Language".localized()
        
       
        self.lblLanguageSelect.text =  "English".localized()
        self.lblLanguageSelect.font = .kufiRegularFont(ofSize: 15)
        
        self.viewLanguageSelect.setBorderGray()
        self.lblLanguage.text = "txt_Language".localized()
        self.lblLanguageSelect.font = .kufiRegularFont(ofSize: 15)
        
    
        self.imgDropLanguageSelect.image = dropDownmage
        
        
        self.viewStep.backgroundColor = HelperClassSwift.acolor.getUIColor()
        self.lblStep.text = "txt_Language".localized()
        self.lblStep.font = .kufiRegularFont(ofSize: 15)
        self.lblStep.textColor = "#616263".getUIColor()
        //HelperClassSwift.acolor.getUIColor()
        
        //self.btnNext.backgroundColor = HelperClassSwift.acolor.getUIColor()
        
        
        self.viewStep.setBorderGrayWidth(0.5)
        let Stepimage =  UIImage.fontAwesomeIcon(name: .building, style: .solid, textColor: HelperClassSwift.bcolor.getUIColor(), size: CGSize(width: 40, height: 40))
        self.imgStep.image = Stepimage
        
        icon_noPermission.no_permission()
        
        self.lbl_noPermission.text =  "You not have permission to access this step".localized()
        self.lbl_noPermission.font = .kufiRegularFont(ofSize: 15)
        self.lbl_noPermission.textColor =  "#333".getUIColor()
         
      
        if IsFromTransaction == true{
            
            if StatusObject?.Configurations == false {
                view_noPermission.isHidden = false
                self.btnNext.isHidden = true
            }else{
                view_noPermission.isHidden = true
                self.btnNext.isHidden = false
                self.SetConfigGUI()
            }
        }else{
            self.btnNext.isHidden = false
            view_noPermission.isHidden = true
        }
        
        self.btnNext.setTitle("Next".localized(), for: .normal)
        if L102Language.currentAppleLanguage() == "ar" {
            self.btnNext.setImage(UIImage(systemName: "arrow.left"), for: .normal)
        }
        //arrow.right
//        self.btnNext.backgroundColor =  HelperClassSwift.acolor.getUIColor()
//        self.btnNext.setTitleColor(.white, for: .normal)
//        self.btnNext.setRounded(10)

    }
    
    
    func get_Lang(){
        
        self.showLoadingActivity()
        APIController.shard.sendRequestGetAuth(urlString: "tc/tlanguages" ) { (response) in
            
            
            let status = response["status"] as? Bool
            if status == true{
                if  let list = response["records"] as? NSArray{
                    for i in list {
                        let dict = i as? [String:Any]
                        let obj = ModuleObj.init(dict!)
                        self.arr_Language.append(obj)
                        // for echitem in obj{
                        self.arr_LanguageLabel.append(obj.label)
                        // }
                        
                    }
                    self.hideLoadingActivity()
                }
            }
            
            
        }
    }
    
    func SetConfigGUI(){
        
        if  let view_request = data_FormWir["view_request"] as? [String:Any]{
            
            if  let transaction_request = view_request["transactions_request"] as? [String:Any]{
                
                let records = transaction_request["records"] as! [String:Any]
                let obj = Tcore(records)
                self.lblLanguageSelect.text = obj.language_name
                self.StrLanguage = obj.lang_key
                self.IsFromTransaction = true
                self.transactions_name = obj.transactions_name
            }
        }
    }
    
    private func update_observer(){
        NotificationCenter.default.addObserver(forName: NSNotification.Name("update_langVC"), object: nil, queue: .main) { notifi in
                 // guard let index = notifi.object as? Int else { return }
            if IsTransaction == false{
                if StatusObject?.Configurations == false {
                  self.view_noPermission.isHidden = false
                    self.btnNext.isHidden = true
                    //self.mainView.isHidden = true
                   
                }
            }
           
        }
    }
    
    
    @IBAction func btnLanguage_Click(_ sender: Any) {
        
        let dropDown = DropDown()
        dropDown.anchorView = view
        dropDown.backgroundColor = .white
        dropDown.cornerRadius = 2.0
  
        dropDown.dataSource = self.arr_lang
        dropDown.selectionAction = { [unowned self] (index: Int, item: String) in
            
            if item == self.arr_lang[0] {
                self.StrLanguage = "en"
                self.lblLanguageSelect.text = item
            }else{
                self.StrLanguage = "ar"
                self.lblLanguageSelect.text =  self.arr_lang[1]
            }
            
        }
        dropDown.direction = .bottom
        dropDown.anchorView = btnLanguageSelect
        dropDown.bottomOffset = CGPoint(x: 0, y: btnLanguageSelect.bounds.height)
        dropDown.width = btnLanguageSelect.bounds.width
        dropDown.show()
        
    }
    
  
    @IBAction func btnSiteLevel_Click(_ sender: Any) {
        
        
        if  IsFromTransaction == false{
            self.transactions_name = ProjectObj?.templatename ?? "WIR"
        }
        
        switch self.transactions_name {
        case "MSR":
            let vc:LocationVC = AppDelegate.mainSB.instanceVC()
            vc.StrLanguage = self.StrLanguage
            vc.ProjectObj = self.ProjectObj
            self.navigationController?.pushViewController(vc, animated: true)
        case "WIR":
            let vc:SiteLevelVC = AppDelegate.mainSB.instanceVC()
            vc.StrLanguage = self.StrLanguage
            vc.ProjectObj = self.ProjectObj
            vc.wirObject = data_FormWir
            vc.IsFromTransaction = self.IsFromTransaction
            self.navigationController?.pushViewController(vc, animated: true)
        default:
            let vc:SiteLevelVC = AppDelegate.mainSB.instanceVC()
            vc.StrLanguage = self.StrLanguage
            vc.ProjectObj = self.ProjectObj
         
            self.navigationController?.pushViewController(vc, animated: true)
        }
       
        
    }
    
}

extension UIImageView {
    func no_permission() {
        self.image = .init(named: "no-permission2")
    }
}
