//
//  SignatureVC.swift
//  Almnabr
//
//  Created by MacBook on 30/03/2022.
//  Copyright © 2022 Samar Akkila. All rights reserved.
//

import UIKit

class SignatureVC: UIViewController {
 
    @IBOutlet weak var lbl_mark: UILabel!
    @IBOutlet weak var lbl_Signature: UILabel!
    @IBOutlet weak var img_mark: UIImageView!
    @IBOutlet weak var img_Signature: UIImageView!
    @IBOutlet weak var stack_mark: UIStackView!
    @IBOutlet weak var stack_Signature: UIStackView!
    
    var profile_obj:ProfileObj?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        configNavigation()
        get_mark()
        get_Signature()
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
       addNavigationBarTitle(navigationTitle: "Signature".localized())
        UINavigationBar.appearance().backgroundColor = maincolor
    }


    
    func get_mark(){
        
        self.showLoadingActivity()
        let mark = "\(self.profile_obj?.employee_id_number ?? "0")M\(self.profile_obj!.user_id)"
        
        
       // (self.profile_obj?.employee_id_number!)! + "M" + self.profile_obj!.user_id

        APIController.shard.sendRequestGetAuth(urlString: "viewsmark/\(mark)" ) { (response) in
            self.hideLoadingActivity()
            
            let status = response["status"] as? Bool
            if status == true{
                let base64 = response["base64"] as? String
                self.img_mark.image =  base64?.imageFromBase64()
                //self.imageFromBase64(base64!)
            }else{
                self.hideLoadingActivity()
            }
            
            
        }
    }
    
    func get_Signature(){
        
        self.showLoadingActivity()
        let mark = "\(self.profile_obj?.employee_id_number ?? "0")S\(self.profile_obj!.user_id)"
        
        APIController.shard.sendRequestGetAuth(urlString: "viewsmark/\(mark)" ) { (response) in
            self.hideLoadingActivity()
            
            let status = response["status"] as? Bool
            if status == true{
                let base64 = response["base64"] as? String
               
                self.img_Signature.image =  base64?.imageFromBase64()
                //self.imageFromBase64(base64!)
            }else{
                self.hideLoadingActivity()
            }
            
            
        }
    }
    
    
    func imageFromBase64(_ base64: String) -> UIImage? {
        if let url = URL(string: base64), let data = try? Data(contentsOf: url) {
            return UIImage(data: data)
        }
        return nil
    }
    
    @IBAction func btnAddSignature_Click(_ sender: Any) {
        
        let vc:AddSignatureVC = AppDelegate.HRSB.instanceVC()
        vc.profile_obj = self.profile_obj
        self.navigationController?.pushViewController(vc, animated: true)
        
    }
    
    
}

extension String {
    func imageFromBase64() -> UIImage? {
        guard let data = Data(base64Encoded: self) else { return nil }

        return UIImage(data: data)
    }
}
