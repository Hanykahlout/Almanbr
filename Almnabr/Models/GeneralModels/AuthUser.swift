//
//  AuthUser.swift
//  Almnabr
//
//  Created by MacBook on 29/09/2021.
//  Copyright © 2021 Samar Akkila. All rights reserved.
//

import Foundation
import UIKit
import FAPanels


struct Auth_User {
    
    
    static var Token : String {
        get {
            let ud = UserDefaults.standard
            return ud.value(forKey: "token") as? String ?? ""
        }
        set(token) {
            let ud = UserDefaults.standard
            ud.set(token, forKey: "token")
        }
    }
    
  
    static var user_id : String {
        get {
            let ud = UserDefaults.standard
            return ud.value(forKey: "user_id") as? String ?? ""
        }
        set(user_id) {
            let ud = UserDefaults.standard
            ud.set(user_id, forKey: "user_id")
        }
    }
    
    static var isAdmin : Bool {
        get {
            let ud = UserDefaults.standard
            return ud.value(forKey: "is_admin") as? Bool ?? false
        }
        set(isAdmin) {
            let ud = UserDefaults.standard
            ud.set(isAdmin, forKey: "is_admin")
        }
    }

    static var user_type_id : String {
        get {
            let ud = UserDefaults.standard
            return ud.value(forKey: "user_type_id") as? String ?? ""
        }
        set(user_id) {
            let ud = UserDefaults.standard
            ud.set(user_id, forKey: "user_type_id")
        }
    }

    
    
    static var FCMtoken : String {
        get {
            let ud = UserDefaults.standard
            return ud.value(forKey: "FCMtoken") as? String ?? ""
        }
        set(token) {
            let ud = UserDefaults.standard
            ud.set(token, forKey: "FCMtoken")
        }
    }
  
    static func topVC() -> UIViewController? {
        if var topController = UIApplication.shared.keyWindow?.rootViewController {
            while  let presentedViewController = topController.presentingViewController {
                topController = presentedViewController
            }
            
            return topController
        }
        
        return nil
    }
    
    static var push_menu_nav : UIViewController? {
        if let window = UIApplication.window {
            if let menu = window.rootViewController as? FAPanelController {
                if let nav = menu.children[2] as? UINavigationController {
                    if let top = nav.topViewController {
                        return top
                    }
                }
                return nil
            }
        }
        return nil
    }

      
//    static func func_openSpecificScreen(_ values:[AnyHashable:Any])  {
//        var content = values["content"] as? String ?? ""
//        var click_action = values["click_action"] as? String ?? ""
//
//        switch click_action {
//        case "new_order":
//
//              let vc: NewOrderVC = AppDelegate.mainSB.instanceVC()
//              vc.Id_ = Int(content.westernArabicNumeralsOnly)!
//             self.navigationController.pushViewController(vc, animated: true)
//        case "offer_accepted":
//            let vc: ViewOfferVC = AppDelegate.mainSB.instanceVC()
//             vc.OfferId = Int(content.westernArabicNumeralsOnly)!
//            self.navigationController?.pushViewController(vc, animated: true)
//        case "offer_rejected":
//            let vc: ViewOfferVC = AppDelegate.mainSB.instanceVC()
//             vc.OfferId = Int(object.content.westernArabicNumeralsOnly)!
//            self.navigationController?.pushViewController(vc, animated: true)
//        case "dashboard_msg":
//            print("dashboard_msg")
//        case "message_receive":
//            let vc: ChatVC = AppDelegate.mainSB.instanceVC()
//            self.navigationController?.pushViewController(vc, animated: true)
//        case "contact_us_reply":
//            print("contact_us_reply")
//        case "withdraw_accepted":
//            self.tabBarController?.selectedIndex = 2
//        case "withdraw_rejected":
//            self.tabBarController?.selectedIndex = 2
//        case "bank_transfer_accepted":
//            self.tabBarController?.selectedIndex = 2
//        case "bank_transfer_rejected":
//            self.tabBarController?.selectedIndex = 2
//        default:
//            break
//        }
//
//
//        let appdelegate = UIApplication.shared.delegate as! AppDelegate
////        if let panel = appdelegate.window?.rootViewController as? FAPanelController {
////            if let root = panel.childViewControllers[1] as? UITabBarController {
////                if type == "Approve_Private_Yacht" {
////                    root.selectedIndex = 3
////                }
////            }
////        }
////        if let tab = appdelegate.window?.rootViewController as? UITabBarController {
////            if let nav = tab.TabBarViewController as? UITabBarController {
////                if type == "Approve_Private_Yacht" {
////                    let vc : SRCartTVC = AppDelegate.appsStory.instanceVC()
////                    nav.pushViewController(vc, animated: true)
////
////                }else if type == "Reject_Private_Yacht" {
//////                    let vc : SRPriceDetailVC = AppDelegate.appsStory.instanceVC()
//////                    vc.id = Int(LinkTableName)!
//////                    nav.present(vc , animated: true)
////                }else {
////
////                }
////            }
////        }
//
//    }
}

