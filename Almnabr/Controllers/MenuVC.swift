//
//  MenVC.swift
//  Almnabr
//
//  Created by MacBook on 24/09/2021.
//  Copyright © 2021 Samar Akkila. All rights reserved.
//

import UIKit
import FontAwesome_swift
import FAPanels
import SCLAlertView
class MenuVC: UIViewController {
    
    @IBOutlet weak var imgUserProfile: UIImageView!
    @IBOutlet weak var lblUserName: UILabel!
    @IBOutlet weak var btnMobile: UIButton!
    @IBOutlet weak var btnEmail: UIButton!
    @IBOutlet weak var btnProfile: UIButton!
    @IBOutlet weak var btnLogout: UIButton!
    @IBOutlet weak var btnSetting: UIButton!
    @IBOutlet weak var tableview: UITableView!
    @IBOutlet weak var viewTheme: UIView!
    @IBOutlet weak var settingsTapStackView: UIStackView!
    
    private var arr_data : [MenuObj] = []
    private var arr_menu : [MenuObj] = []
    
    var selectedIndexPath: IndexPath?
    let fontStyle: FontAwesomeStyle = .solid
    var menu_id:String?
    var submenuObj:MenuObj?
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        get_data()
        setup_data()
        if userObj == nil {
            get_Userdata()
        }
        
        
        settingsTapStackView.isUserInteractionEnabled = true
        settingsTapStackView.addTapGesture {
            let vc = SettingsViewController()
            let nav = UINavigationController(rootViewController: vc)
            nav.isNavigationBarHidden = true
            self.panel?.center(nav)
        }

    }
    
    func setup_data(){
        
        
        tableview.estimatedRowHeight = 44.0
        tableview.rowHeight = UITableView.automaticDimension
        
        
        imgUserProfile.setRounded()
        //imgUserProfile.layer.borderColor = .white
        imgUserProfile.layer.borderWidth = 1
        imgUserProfile.layer.cornerRadius = 12.5
        
        self.lblUserName.font = .kufiRegularFont(ofSize: 14)
        self.btnEmail.titleLabel?.font = .kufiRegularFont(ofSize: 14)
        self.btnMobile.titleLabel?.font = .kufiRegularFont(ofSize: 14)
        self.btnProfile.titleLabel?.font = .kufiRegularFont(ofSize: 14)
        self.btnSetting.titleLabel?.font = .kufiRegularFont(ofSize: 14)
        self.btnLogout.titleLabel?.font = .kufiRegularFont(ofSize: 14)
        
        let obj = userObj
        self.lblUserName.text = obj?.user_username
        self.btnEmail.setTitle(obj?.user_email, for: .normal)
        self.btnMobile.setTitle(obj?.user_phone, for: .normal)
        self.btnProfile.setTitle("Profile".localized(), for: .normal)
        
        
        //        let image =  UIImage.fontAwesomeIcon(name: .cog, style: self.fontStyle, textColor: .white, size: CGSize(width: 40, height: 40))
        //        self.btnSetting.setImage(image, for: .normal)
        
        self.btnSetting.setTitle("nav_settings".localized(), for: .normal)
        
        
        //        let userimage =  UIImage.fontAwesomeIcon(name: .userCircle, style: self.fontStyle, textColor: HelperClassSwift.bcolor.getUIColor(), size: CGSize(width: 40, height: 40))
        //        self.btnProfile.setImage(userimage, for: .normal)
        
        //        let logoutimage =  UIImage.fontAwesomeIcon(name: .signOutAlt, style: self.fontStyle, textColor: HelperClassSwift.bcolor.getUIColor(), size: CGSize(width: 40, height: 40))
        //        self.btnLogout.setImage(logoutimage, for: .normal)
        self.btnLogout.setTitle("Log out".localized(), for: .normal)
        
    }
    
    
    
    func get_Userdata(){
        
        self.showLoadingActivity()
        APIController.shard.sendRequestGetAuth(urlString: "user?user_id=\(Auth_User.user_id)" ) { (response) in
            self.hideLoadingActivity()
            
            let status = response["status"] as? Bool
            if status == true{
                if  let records = response["result"] as? NSArray{
                    
                    for i in records {
                        let dict = i as? [String:Any]
                        let obj = UserObj.init(dict!)
                        userObj = obj
                        self.lblUserName.text = obj.user_username
                        self.btnEmail.setTitle(obj.user_email, for: .normal)
                        self.btnMobile.setTitle(obj.user_phone, for: .normal)
                        
                    }
                    
                    self.tableview.reloadData()
                }
            }
        }}
    
    
    func get_data(){
        
        self.showLoadingActivity()
        APIController.shard.sendRequestGetAuth(urlString: "menu" ) { (response) in
            let status = response["status"] as? Bool
            if status == true{
                if  let records = response["records"] as? NSArray{
                    
                    for i in records {
                        let dict = i as? [String:Any]
                        let obj = MenuObj.init(dict!)
                        self.arr_data.append(obj)
                    }
                    
                    //                     for obj in self.arr_menu {
                    //                         switch obj.menu_id {
                    //                         case "1":
                    //                             self.arr_data.append(obj)
                    //                         case "30":
                    //                             self.arr_data.append(obj)
                    //                             print(obj.menu_name)
                    //                         case "12":
                    //                             self.arr_data.append(obj)
                    //                             print(obj.menu_name)
                    //                         default:
                    //                             print("no needed")
                    //                         }
                    //                     }
                    
                    self.tableview.reloadData()
                    self.hideLoadingActivity()
                }
            }
        }
    }
    
    
    
    func userLogoutAlert() {
        let logoutAlert = UIAlertController(title: "lbl_logout".localized(), message: "are_you_sure".localized(), preferredStyle: .alert)
        
        logoutAlert.addAction(UIAlertAction(title: "btn_yes".localized(), style: .default, handler: { (action: UIAlertAction!) in
            HelperClassSwift.acolor = "#1992bc"
            HelperClassSwift.bcolor = "#000000"
            
            
            print("Handle yes Logic here")
            self.showLoadingActivity()
            isFirstLunch = true
            self.makeUserLogout()
            HelperClassSwift.IsLoggedOut = true
            SocketIOController.shard.disconnect()
            
        }))
        logoutAlert.addAction(UIAlertAction(title: "btn_no".localized(), style: .cancel, handler: { (action: UIAlertAction!) in
            print("Handle no Logic here")
        }))
        present(logoutAlert, animated: true, completion: nil)
    }
    
    
    
    @IBAction func didTapProfile(_ sender: AnyObject) {
        
        let vc:ProfileVC = AppDelegate.mainSB.instanceVC()
        let nav = UINavigationController.init(rootViewController: vc)
        _ =  panel?.center(nav)
        //self.navigationController?.pushViewController(nav, animated: true)
    }
    
    @IBAction func didTapSignOut(_ sender: AnyObject) {
        
        userLogoutAlert()
    }
    
    
    @IBAction func linkDeviceAction(_ sender: Any) {
        let vc = QRScannerViewController()
        vc.isFromWidget = false
        let nav = UINavigationController(rootViewController: vc)
        let navCenter =  panel?.center as? UINavigationController
        navCenter?.present(nav, animated: true, completion: nil)
    }
    
}


extension MenuVC : UITableViewDataSource  , UITableViewDelegate{
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return arr_data.count
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    
        let section = arr_data[section]
        if section.IsOpened{
            return section.menu.count + 1
        }else{
            return 1
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as! MenuCell
        let obj = arr_data[indexPath.section]
        let color = "E3E3E3".getUIColor()
        if indexPath.row == 0 {
            
            cell.icon_dropdown.isHidden = true
            cell.lbl_title.text = obj.menu_name
            cell.lbl_title.textColor = color
            cell.lbl_title.font = .kufiRegularFont(ofSize: 13)
                //.kufiBoldFont(ofSize: 15)
            if  obj.icon == "fa fa-product-hunt"{
                print("no icon")
                cell.icon.image = UIImage(named: "product-hunt-brands")
                cell.icon.tintColor = color
            } else if  obj.icon == "fa fa-delicious"{
                print("no icon")
                cell.icon.image = UIImage(named: "delicious-brands")
                cell.icon.tintColor = color
            }else{
                let str = obj.icon.dropFirst(3)
                cell.icon.image = UIImage.fontAwesomeIcon(code: String(str), style: self.fontStyle, textColor: color, size: CGSize(width: 40, height: 40))
            }
            
            if obj.menu.count > 0{
                cell.icon_dropdown.isHidden = false
                if obj.IsOpened {
                    cell.lbl_title.textColor = color
                    cell.icon_dropdown.image = UIImage.fontAwesomeIcon(name: .chevronUp , style: self.fontStyle, textColor:  color, size: CGSize(width: 40, height: 40))
                }else{
                    cell.icon_dropdown.image = UIImage.fontAwesomeIcon(name: .chevronDown , style: self.fontStyle, textColor:  color, size: CGSize(width: 40, height: 40))
                }}
//            else{
//                cell.icon_dropdown.isHidden = true
//           }
          

            
        }else{
            
            let objj = arr_data[indexPath.section].menu[indexPath.row - 1]
            cell.lbl_title.text = arr_data[indexPath.section].menu[indexPath.row - 1].menu_name
            cell.lbl_title.textColor = color

            cell.lbl_title.font = .kufiRegularFont(ofSize: 15)
            let str = objj.icon.dropFirst(3)
            cell.icon.image = UIImage.fontAwesomeIcon(code: String(str), style: self.fontStyle, textColor: color, size: CGSize(width: 40, height: 40))
           
           // cell.icon_dropdown.isHidden = true

        }
        
        return cell
    }

   
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 40
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as! MenuCell


        let obj = arr_data[indexPath.section]
        obj.IsOpened = !obj.IsOpened
        if indexPath.section == 0{
            let vc : HomeVC = AppDelegate.mainSB.instanceVC()
            let nav = UINavigationController.init(rootViewController: vc)
            _ =  panel?.center(nav)
            return 
        }
        if indexPath.row == 0 {
             
//            if arr_data[indexPath.row].menu_id == "1" {
//
//                let vc:HomeVC = AppDelegate.mainSB.instanceVC()
//                let nav = UINavigationController.init(rootViewController: vc)
//                _ =  panel?.center(nav)
//
//            }else{
                cell.lbl_title.textColor = HelperClassSwift.bcolor.getUIColor()
                tableview.reloadSections([indexPath.section], with: UITableView.RowAnimation.automatic)
         //   }
        }else{
            tableview.reloadSections([indexPath.section], with: UITableView.RowAnimation.automatic)
            print("Data ID:",obj.menu[indexPath.row - 1].menu_id)
            if arr_data[indexPath.section].menu.count > 0 {
                switch obj.menu[indexPath.row - 1].menu_id {
                case "13":
                    let vc: TransactionsVC = AppDelegate.mainSB.instanceVC()
                    let nav = UINavigationController(rootViewController: vc)
                    nav.isNavigationBarHidden = true
                    _ =  panel?.center(nav)
                case "19":
                    let vc:SettingsPermissionVC = AppDelegate.HRSB.instanceVC()
                    let nav = UINavigationController(rootViewController: vc)
                    nav.isNavigationBarHidden = true
                    panel?.center(nav)
                    
                case "21":
                    let vc = AllEmployeesVC()
                    let nav = UINavigationController(rootViewController: vc)
                    nav.isNavigationBarHidden = true
                    panel?.center(nav)
                    
                case "22":
                    let vc = JobApplicationVC()
                    let nav = UINavigationController(rootViewController: vc)
                    nav.isNavigationBarHidden = true
                    panel?.center(nav)
                    
                case "27":
                    cell.lbl_title.textColor = HelperClassSwift.bcolor.getUIColor()
                    let vc:ApproveTransactionVC = AppDelegate.mainSB.instanceVC()
                    vc.title =  obj.menu_name
                    vc.MenuObj = obj
                    vc.StrSubMenue =  obj.menu[indexPath.row - 1].menu_name
                    let nav = UINavigationController(rootViewController: vc)
                    nav.isNavigationBarHidden = true
                    _ =  panel?.center(nav)
                case "33":
                    let vc = AccountSettingsViewController()
                    let nav = UINavigationController(rootViewController: vc)
                    nav.isNavigationBarHidden = true
                    panel?.center(nav)
                case "36":
                    let vc = CostCenterViewController()
                    let nav = UINavigationController(rootViewController: vc)
                    nav.isNavigationBarHidden = true
                    panel?.center(nav)
                    
                case "37":
                    let vc = AccountMastersViewController()
                    let nav = UINavigationController(rootViewController: vc)
                    nav.isNavigationBarHidden = true
                    panel?.center(nav)
                case "42":
                    let vc = CreateReceiptViewController()
                    let nav = UINavigationController(rootViewController: vc)
                    nav.isNavigationBarHidden = true
                    panel?.center(nav)
                case "43":
                    let vc = AllReceiptsViewController()
                    let nav = UINavigationController(rootViewController: vc)
                    nav.isNavigationBarHidden = true
                    panel?.center(nav)
                case "44":
                    let vc = CreateReceiptViewController()
                    vc.isPayment = true
                    let nav = UINavigationController(rootViewController: vc)
                    nav.isNavigationBarHidden = true
                    panel?.center(nav)
                case "45":
                    let vc = AllReceiptsViewController()
                    vc.isPayment = true
                    let nav = UINavigationController(rootViewController: vc)
                    nav.isNavigationBarHidden = true
                    panel?.center(nav)
                    
                case "46":
                    let vc = CreateJournalVoucherVC()
                    let nav = UINavigationController(rootViewController: vc)
                    nav.isNavigationBarHidden = true
                    panel?.center(nav)
                case "47":
                    let vc = AllJournalVouchersViewController()
                    let nav = UINavigationController(rootViewController: vc)
                    nav.isNavigationBarHidden = true
                    panel?.center(nav)
                case "51":
                    SCLAlertView().showInfo("Sorry", subTitle: "You can create selling invoice from web")
                case "52":
                    let vc = AllSellingInvoiceViewController()
                    let nav = UINavigationController(rootViewController: vc)
                    nav.isNavigationBarHidden = true
                    panel?.center(nav)
                case "54":
                    let vc = AllSellingInvoiceViewController()
                    vc.isPurchase = true
                    let nav = UINavigationController(rootViewController: vc)
                    nav.isNavigationBarHidden = true
                    panel?.center(nav)
                case "55":
                    let vc = TransactionViewerViewController()
                    let nav = UINavigationController(rootViewController: vc)
                    nav.isNavigationBarHidden = true
                    panel?.center(nav)
                case "60":
                    let vc = StatementAccountsViewController()
                    vc.type = .account
                    let nav = UINavigationController(rootViewController: vc)
                    nav.isNavigationBarHidden = true
                    panel?.center(nav)
                case "61":
                    let vc = StatementAccountsViewController()
                    vc.type = .cost
                    let nav = UINavigationController(rootViewController: vc)
                    nav.isNavigationBarHidden = true
                    panel?.center(nav)
                case "62":
                    let vc = TrialBalanceViewController()
                    let nav = UINavigationController(rootViewController: vc)
                    nav.isNavigationBarHidden = true
                    panel?.center(nav)
                case "63":
                    let vc = TrialBalanceViewController()
                    vc.isCostSummary = true
                    let nav = UINavigationController(rootViewController: vc)
                    nav.isNavigationBarHidden = true
                    panel?.center(nav)
                case "64":
                    let vc = StatementAccountsViewController()
                    vc.type = .ledger
                    let nav = UINavigationController(rootViewController: vc)
                    nav.isNavigationBarHidden = true
                    panel?.center(nav)
                
                case "65":
                    let vc = BalanceSheetsViewController()
                    let nav = UINavigationController(rootViewController: vc)
                    nav.isNavigationBarHidden = true
                    panel?.center(nav)
                case "66":
                    let vc = BalanceSheetsViewController()
                    vc.isBalanceSheets = false
                    let nav = UINavigationController(rootViewController: vc)
                    nav.isNavigationBarHidden = true
                    panel?.center(nav)
                case "68":
                    let vc = TransactionListingViewController()
                    let nav = UINavigationController(rootViewController: vc)
                    nav.isNavigationBarHidden = true
                    panel?.center(nav)
                case "69":
                    cell.lbl_title.textColor = HelperClassSwift.bcolor.getUIColor()
                    let vc:CronTransactionVC = AppDelegate.mainSB.instanceVC()
                    vc.title =  obj.menu_name
                    vc.MenuObj = obj
                    vc.StrSubMenue =  obj.menu[indexPath.row - 1].menu_name
                    let nav = UINavigationController(rootViewController: vc)
                    nav.isNavigationBarHidden = true
                    _ =  panel?.center(nav)
                
                case "73":
                    cell.lbl_title.textColor = HelperClassSwift.bcolor.getUIColor()
                    let vc:AllPrpjectsVC = AppDelegate.mainSB.instanceVC()
                    let nav = UINavigationController.init(rootViewController: vc)
                    vc.title =  obj.menu_name
                    vc.MenuObj = obj
                    vc.StrSubMenue =  obj.menu[indexPath.row - 1].menu_name
                    nav.isNavigationBarHidden = true
                    _ =  panel?.center(nav)
                case "74":
                    let vc = CommunicationListsViewController()
                    let nav = UINavigationController(rootViewController: vc)
                    nav.isNavigationBarHidden = true
                    panel?.center(nav)
                    
                case "90":
                    let vc = AccountsTrialViewController()
                    let nav = UINavigationController(rootViewController: vc)
                    nav.isNavigationBarHidden = true
                    panel?.center(nav)
                case "94":
                    cell.lbl_title.textColor = HelperClassSwift.bcolor.getUIColor()
                    let vc:AllTicketVC = AppDelegate.TicketSB.instanceVC()
                    let nav = UINavigationController.init(rootViewController: vc)
                    //vc.title =  obj.menu_name
                    //obj.menu[indexPath.row - 1].menu_name
                    nav.isNavigationBarHidden = true
                      _ =  panel?.center(nav)
                case "95":
                    let vc:AttendanceViewController = AppDelegate.HRSB.instanceVC()
                    let nav = UINavigationController(rootViewController: vc)
                    nav.isNavigationBarHidden = true
                    panel?.center(nav)
                case "96":
                    let vc:PayRoleViewController = PayRoleViewController()
                    let nav = UINavigationController(rootViewController: vc)
                    nav.isNavigationBarHidden = true
                    panel?.center(nav)
                    break
                case "101":
                    let vc = DocumentsViewController()
                    let nav = UINavigationController(rootViewController: vc)
                    nav.isNavigationBarHidden = true
                    panel?.center(nav)
                case "103":
                    let vc = OpeningBalanceViewController()
                    let nav = UINavigationController(rootViewController: vc)
                    nav.isNavigationBarHidden = true
                    panel?.center(nav)
                    break
                case "107":
                    SCLAlertView().showInfo("Sorry", subTitle: "You can create invoice reversal from web")
                    break
                case "109":
                    SCLAlertView().showInfo("Sorry", subTitle: "You can create invoice note from web")
                    break
                default:
                    print(" no menu id ")
                }
              
            }else{
                print("dashboard")
            }
        }
    }
    
}


extension String {
    
    func fontAwesomeString(name: String) -> String {
        
        switch name {
        case "fa-close":
            return "\u{f00d}"
        default:
            return "\u{f00d}"// manage exhaustive case accordingly
        }
    }
}


extension UILabel {
// MARK:  set center alignment
   public func setFontAwesomeIcon(fromChar iconCode: String,
                        color: UIColor) {
    self.font = UIFont.fontAwesome(ofSize: 30, style: .solid)
    self.textColor = color

    let iconDecimal = Int(iconCode, radix: 16)!
    let unicodeIcon = Character(UnicodeScalar(iconDecimal)!)
    self.text = "\(unicodeIcon)"
    self.sizeToFit()
  }
}
