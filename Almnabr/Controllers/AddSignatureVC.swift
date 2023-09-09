//
//  AddSignatureVC.swift
//  Almnabr
//
//  Created by MacBook on 11/04/2022.
//  Copyright © 2022 Samar Akkila. All rights reserved.
//

import UIKit
import SwiftSignatureView

class AddSignatureVC: UIViewController, YPSignatureDelegate {
    
    func didStart(_ view: YPDrawSignatureView) {
        
        self.scrollView.isScrollEnabled = false
     
    }
    
    func didFinish(_ view: YPDrawSignatureView) {
        self.scrollView.isScrollEnabled = true
    }
    var profile_obj:ProfileObj?

    @IBOutlet weak var btn_Email: UIButton!
    @IBOutlet weak var btn_Mobile: UIButton!
    @IBOutlet weak var btn_Whatsapp: UIButton!
    @IBOutlet weak var btn_sendCode: UIButton!
    @IBOutlet weak var btn_Submit: UIButton!
    @IBOutlet weak var view_Signature: YPDrawSignatureView!
    @IBOutlet weak var view_Mark: YPDrawSignatureView!
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var stackVerificationCode: UIStackView!
    @IBOutlet weak var tfVerificationCode: UITextField!
    
    var verification_method:String = ""
    override func viewDidLoad() {
        super.viewDidLoad()

        configNavigation()
        configGUI()
        
        //let tapGesture = UITapGestureRecognizer(target: self, action: #selector(handleTap(sender:)))
        
        // 2. add the gesture recognizer to a view
        //view_Signature.addGestureRecognizer(tapGesture)
        
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

    
    //MARK: - Config GUI
    //------------------------------------------------------
    func configGUI() {
       
        
        view_Signature.delegate = self
        view_Mark.delegate = self
        view_Signature.setBorderGray()
        view_Mark.setBorderGray()
        
        btn_Email.setTitle("Email (\(profile_obj!.user_email))", for: .normal)
        btn_Mobile.setTitle("Mobile (\(profile_obj!.user_phone))", for: .normal)
        btn_Whatsapp.setTitle("Whatsapp (\(profile_obj!.user_phone))", for: .normal)
        
        btn_Email.setBorderWithColor(maincolor)
        btn_Mobile.setBorderWithColor(maincolor)
        btn_Whatsapp.setBorderWithColor(maincolor)
        
        btn_sendCode.setTitle("send Code", for: .normal)
        btn_Submit.setTitle("Submit", for: .normal)
        
       
        self.stackVerificationCode.isHidden = true
        
//        view_Signature.addTapGesture{
//            self.scrollView.isScrollEnabled = false
//        }
        
        
    }
    
    func save_img(){
        
        if let signatureImage = self.view_Signature.getSignature(scale: 10) {
            UIImageWriteToSavedPhotosAlbum(signatureImage, nil, nil, nil)
            self.view_Signature.clear()
        }
        
        if let markImage = self.view_Mark.getSignature(scale: 10) {
            UIImageWriteToSavedPhotosAlbum(markImage, nil, nil, nil)
            self.view_Mark.clear()
        }
        
    }
    
    func send_code(){
        
        let param :[String:Any] = ["id_number":11,
                                   "verification_method":verification_method]
   
   
        self.showLoadingActivity()
        APIController.shard.sendRequestPostAuth(urlString: "signup/send_verify_code/", parameters: param) { (response) in
         
            let status = response["status"] as? Bool
            if status == true{
                if let msg = response["msg"] as? String {
                    
                    self.showAMessage(withTitle: "", message: msg)
                }
                
                self.stackVerificationCode.isHidden = false
                    self.hideLoadingActivity()
                }
            }
        }

    func submit(){
        
       
        
   //mark
   //signature
        var mark :String = ""
        let markImage = self.view_Mark.getSignature(scale: 10)
        mark =   convertImageToBase64String(img: markImage!)
        var signature :String = ""
        let signatureImage = self.view_Mark.getSignature(scale: 10)
        signature =   convertImageToBase64String(img: signatureImage!)
        
        
       
      
        
        let param :[String:Any] = ["verification_method":verification_method,
                                   "verification_code": tfVerificationCode.text ?? "0000",
                                   "id_number":profile_obj?.user_id ?? "0",
                                   "signature":signature,
                                   "mark":mark]
   
       
        self.showLoadingActivity()
        APIController.shard.sendRequestPostAuth(urlString: "submit_signature", parameters: param) { (response) in
         
            let status = response["status"] as? Bool
            if status == true{
                if let msg = response["msg"] as? String {
                    
                    self.showAMessage(withTitle: "", message: msg)
                }
                
                self.stackVerificationCode.isHidden = false
                    self.hideLoadingActivity()
                }
            }
        }
    
    func convertImageToBase64String (img: UIImage) -> String {
        return img.jpegData(compressionQuality: 1)?.base64EncodedString() ?? ""
    }
    
    @IBAction func btnEmail_Click(_ sender: Any) {
        btn_Email.setTitleColor(.white, for: .normal)
        btn_Mobile.setTitleColor(maincolor, for: .normal)
        btn_Whatsapp.setTitleColor(maincolor, for: .normal)
        
        btn_Email.backgroundColor = maincolor
        btn_Mobile.backgroundColor = .white
        btn_Whatsapp.backgroundColor = .white
        self.verification_method = "email"
    }
    
    @IBAction func btnMobile_Click(_ sender: Any) {
        btn_Email.setTitleColor(maincolor, for: .normal)
        btn_Mobile.setTitleColor(.white, for: .normal)
        btn_Whatsapp.setTitleColor(maincolor, for: .normal)
        
        btn_Email.backgroundColor = .white
        btn_Mobile.backgroundColor = maincolor
        btn_Whatsapp.backgroundColor = .white
        self.verification_method = "mobile"
    }
    
    @IBAction func btnWhatsapp_Click(_ sender: Any) {
        btn_Email.setTitleColor(maincolor, for: .normal)
        btn_Mobile.setTitleColor(maincolor, for: .normal)
        btn_Whatsapp.setTitleColor(.white, for: .normal)
        
        btn_Email.backgroundColor = .white
        btn_Mobile.backgroundColor = .white
        btn_Whatsapp.backgroundColor = maincolor
        self.verification_method = "whatsapp"
    }
    
    
    @IBAction func didTapview_SignatureClear() {
        view_Signature.clear()
    }

    
    @IBAction func didTapview_MarkClear() {
        view_Mark.clear()
    }
    
    @IBAction func didTapSendCode() {
        guard self.verification_method != "" else {
            return self.showAMessage(withTitle: "", message: "choose verification method please")
       }
        self.send_code()
    }
    
    @IBAction func didTapSubmit() {
        
        
        guard self.tfVerificationCode.text != "" else {
            return self.showAMessage(withTitle: "", message: "Enter verification code please")
       }
        
        submit()
    }
}

//extension  AddSignatureVC: SwiftSignatureViewDelegate {
//
//    func swiftSignatureViewDidDrawGesture(_ view: ISignatureView, _ tap: UIGestureRecognizer) {
//        print("swiftSignatureViewDidDrawGesture")
//
//    }
//
//    func swiftSignatureViewDidDraw(_ view: ISignatureView) {
//        print("swiftSignatureViewDidDraw")
//       // self.scrollView.isScrollEnabled = true
//    }
//
//}

extension UIView {
    
    func addTapGesture(action : @escaping ()->Void ){
        let tap = MyTapGestureRecognizer(target: self , action: #selector(self.handleTap(_:)))
        tap.action = action
        tap.numberOfTapsRequired = 1
        
        self.addGestureRecognizer(tap)
        self.isUserInteractionEnabled = true
        
    }
    @objc func handleTap(_ sender: MyTapGestureRecognizer) {
        sender.action!()
    }
}

class MyTapGestureRecognizer: UITapGestureRecognizer {
    var action : (()->Void)? = nil
}

