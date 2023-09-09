//
//  HeaderView.swift
//  Almnabr
//
//  Created by MacBook on 08/10/2021.
//  Copyright © 2021 Samar Akkila. All rights reserved.
//

import Foundation
import UIKit
import DPLocalization
import FAPanels

var puplic_total :Int = 0
var isFirstLunch :Bool = true

class HeaderView:  UIView {
    
    @IBOutlet weak var viewTheme: UIView!
    @IBOutlet weak var btnMenu: UIView!
    
    var btnAction : (()->())?
    var btnNotifyAction : (()->())?
    
    static let shared = NotifiRoute()
    
    var isLoad :Bool = false
    override func awakeFromNib() {
        super.awakeFromNib()
        self.addShape()
        viewTheme.backgroundColor = .clear
        
        update_Function()
       // if isFirstLunch == true {
            self.get_Notificaions_data()
       
       // }else{
//            if HelperClassSwift.IsLoadTheme == false {
//                self.get_theme()
//            }else{
               
            //}
       // }
        
        if L102Language.currentAppleLanguage() == "ar"{
            self.flipView(view: self)
        }
    }


    
    private func flipView(view:UIView){
        view.transform = .init(scaleX: -1.0, y: 1.0)
    }
    
    
    private func update_Function(){
        NotificationCenter.default.addObserver(forName: NSNotification.Name("update_Function"), object: nil, queue: .main) { notifi in
            self.get_Notificaions_data()
        }
    }
    
    func get_Notificaions_data(){
        
        APIController.shard.sendRequestGetAuth(urlString: "notification/get_noti_list?page=1" ) { (response) in
            
            let status = response["status"] as? Bool
            var total = response["total"] as? Int
            print(total)
            puplic_total = total ?? 0
           isFirstLunch = false
            self.addShape()
//            if HelperClassSwift.IsLoadTheme == false {
//                self.get_theme()
//            }else{
//                self.addShape(acolor: HelperClassSwift.acolor, bcolor: HelperClassSwift.bcolor)
//            }
        }
        
    }
    
    
    
    func addShape(){
        
        //add a shape
//        let shape = CAShapeLayer()
//        self.viewTheme.layer.addSublayer(shape)
//        shape.strokeColor = UIColor.clear.cgColor
//        shape.fillColor = acolor.getUIColor().cgColor
//        self.viewTheme.backgroundColor =  bcolor.getUIColor()
//        let path = UIBezierPath()
//        path.move(to: .zero)
//        path.addLine(to: CGPoint(x: viewTheme.bounds.width/2, y: 0))
//        path.addLine(to: CGPoint(x: viewTheme.bounds.width/2 - 20 , y: viewTheme.bounds.height))
//        path.addLine(to: CGPoint(x: 0, y: self.viewTheme.bounds.height))
//        path.close()
//        shape.path = path.cgPath
        
        
//        HelperClassSwift.IsLoadTheme = true
//        let language = MOLHLanguage.currentAppleLanguage()
//
//
//        if language == "ar"{
//            self.btnMenu.isHidden = false
//
//            let width = viewTheme.frame.origin.x + viewTheme.frame.origin.x + 40
//
//            let notify_button = UIButton(frame: CGRect(x:  width, y: 44, width: 25, height: 25))
//            notify_button.setImage(UIImage(named: "notification"), for: .normal)
//
//            notify_button.addTarget(self, action: #selector(buttonNotificationAction), for: .touchUpInside)
//            self.viewTheme.addSubview(notify_button)
//
//
//            let notify_view = UIView(frame: CGRect(x:  width - 10, y: 33, width: 20, height: 20))
//            notify_view.backgroundColor = .red
//            notify_view.setRounded()
//
//            let getMainViewX = notify_view.frame.origin.x
//            let getMainViewY = notify_view.frame.origin.y
//            let label = UILabel(frame: CGRect(x: getMainViewX, y: getMainViewY, width: 20, height: 15))
//            label.text = "\(puplic_total)"
//            label.textAlignment = .center
//            label.font = .kufiRegularFont(ofSize: 12)
//            label.textColor = .white
//            self.viewTheme.addSubview(notify_view)
//            self.viewTheme.addSubview(label)
//
//        }else{
            
            self.btnMenu.isHidden = true
            
            let button = UIButton(frame: CGRect(x: 15, y: 44, width: 25, height: 25))
            button.setImage(UIImage(named: "menu-1"), for: .normal)
        
        button.tintColor = "#616263".getUIColor()
            button.addTarget(self, action: #selector(buttonMenuAction), for: .touchUpInside)
            self.viewTheme.addSubview(button)
            
            let width =  UIScreen.main.bounds.size.width - 40
            
            let notify_button = UIButton(frame: CGRect(x:  width, y: 44, width: 25, height: 25))
            notify_button.setImage(UIImage(named: "notification"), for: .normal)
        
        notify_button.tintColor = "#616263".getUIColor()
            notify_button.addTarget(self, action: #selector(buttonNotificationAction), for: .touchUpInside)
            self.viewTheme.addSubview(notify_button)
            
            
            let notify_view = UIView(frame: CGRect(x:  width - 10, y: 33, width: 20, height: 20))
            notify_view.backgroundColor = .red
            notify_view.setRounded()
            
            let getMainViewX = notify_view.frame.origin.x
            let getMainViewY = notify_view.frame.origin.y
            let label = UILabel(frame: CGRect(x: getMainViewX, y: getMainViewY, width: 20, height: 15))
            label.text = "\(puplic_total)"
            label.textAlignment = .center
            label.font = .kufiRegularFont(ofSize: 12)
            label.textColor = .white
            self.viewTheme.addSubview(notify_view)
            self.viewTheme.addSubview(label)
        //}
        
        
    }
    
    
    func get_theme(){
        APIController.shard.sendRequestGetAuthTheme(urlString: "gettheme" ) { (response) in
            
            let status = response["status"] as? Bool
            if status == true{
                if  let data = response["data"] as? [String:Any]{
                    let obj = themeObj(data)
                    HelperClassSwift.acolor = obj.acolor
                    HelperClassSwift.bcolor = obj.bcolor
                    HelperClassSwift.IsLoadTheme = true
                    // self.addShape(acolor: obj.acolor, bcolor: obj.bcolor)
                    
                }
            }else{
                //  self.addShape(acolor: "#1992bc", bcolor: "#000000")
                
            }
            
        }
    }
    
    
    @objc func buttonMenuAction(sender: UIButton!) {
        
        btnAction?()
    }
    
    @objc func buttonNotificationAction(sender: UIButton!) {
//        guard let top_vc = HeaderView.shared.menu_vc() else { return }
//        guard didLoadHome else { return }
//
        let vc: NotificationVC = AppDelegate.mainSB.instanceVC()
//
        
        if let appDelegate = UIApplication.shared.delegate as? AppDelegate,
        let root = appDelegate.window!.rootViewController as? FAPanelController,
        let nav = root.center as? UINavigationController{
            nav.pushViewController(vc, animated: true)
        }
       // btnNotifyAction?()
    }
    
    
    @IBAction func btnMenu_Click(_ sender: Any) {
        
        btnAction?()
        
    }
    
    @IBAction func btnNotification_Click(_ sender: Any) {
        
        guard let top_vc = HeaderView.shared.menu_vc() else { return }
        guard didLoadHome else { return }
        
        let vc: NotificationVC = AppDelegate.mainSB.instanceVC()
        
        top_vc.navigationController?.pushViewController(vc, animated: true)

      //  btnNotifyAction?()
        
    }
    
//    private func update_Notification(){
//        NotificationCenter.default.addObserver(forName: NSNotification.Name("update_Notification"), object: nil, queue: .main) { notifi in
//            self.awakeFromNib()
//            self.get_Notificaions_data()
//        }
//    }
    
}
