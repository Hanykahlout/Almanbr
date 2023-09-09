//
//  NotifiRoute.swift
//  Almnabr
//
//  Created by MacBook on 25/12/2021.
//  Copyright © 2021 Samar Akkila. All rights reserved.
//

import UIKit
import FAPanels

var obj_TempNotifi: M_Notifi?
var didLoadHome: Bool = false

class NotifiRoute : NSObject {
    
    static let shared = NotifiRoute()
    
    func check_notifi() {
        
        guard let obj = obj_TempNotifi else { return }
        guard let top_vc = menu_vc() else { return }
        guard didLoadHome else { return }
        
        let vc: TransactionFormDetailsVC = AppDelegate.TransactionSB.instanceVC()
        vc.str_url = obj.url
        vc.IsFromNotification = true
        
        top_vc.navigationController?.pushViewController(vc, animated: true)

        obj_TempNotifi = nil
    }
    
    func menu_vc() -> UIViewController? {
        if let window = UIApplication.window {
            if let menu = window.rootViewController as? UINavigationController {
                if let _menu = menu.viewControllers.first as? FAPanelController{
                    if let nav = _menu.children[2] as? UINavigationController {
                        if let top = nav.topViewController {
                            return top
                        }
                    }
                    return nil
                }
            }
        }
        
        return nil
    }

}


//enum Notifi_Type {
//
//    case details, none
//
//    init(_ type : String) {
//        switch type {
//        case "details" :
//            self = .details
//        default:
//            self = .none
//        }
//    }
//
//}

struct M_Notifi {
    
    //    var id: Int
    var url: String
    //    var notifi_type : Notifi_Type  = .none
    
    init(url: String) {
        
        self.url = url
        //        self.id = obj["id"] as? Int ?? 0
        //        self.url = obj["title"] as? String ?? ""
        
        //        let action = obj["action"] as? String ?? ""
        //        self.notifi_type = .init(action)
    }
    
}

extension UIApplication {
    
    class func get_topvc(base: UIViewController? = UIApplication.window?.rootViewController ) -> UIViewController? {
        
        if let nav = base as? UINavigationController {
            return get_topvc(base: nav.visibleViewController)
        }
        
        if let tab = base as? UITabBarController {
            if let selected = tab.selectedViewController {
                return get_topvc(base: selected)
            }
        }
        
        if let presented = base?.presentedViewController {
            return get_topvc(base: presented)
        }
        
        return base
    }
}

