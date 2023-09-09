//
//  MailLoginViewController.swift
//  Almnabr
//
//  Created by Hany Alkahlout on 17/01/2023.
//  Copyright © 2023 Samar Akkila. All rights reserved.
//
//
//import UIKit
//import GoogleSignIn
//
//class MailLoginViewController: UIViewController {
//
//    override func viewDidLoad() {
//        super.viewDidLoad()
//
//        // Do any additional setup after loading the view.
//    }
//
//
//    @IBAction func mailSignIn(_ sender: Any) {
//        signInWithGoogle()
//    }
//}
//
//
//extension MailLoginViewController{
//
//    func signInWithGoogle(){
//
////        let signInConfig = GIDConfiguration.init(clientID: "802945329626-3co9soa67il2kjedpgker7l8frp40tuu.apps.googleusercontent.com")
//
//        GIDSignIn.sharedInstance.signIn(withPresenting: self, hint: nil) { [weak self] result, error in
//            guard error == nil else { return }
//            guard let user = result?.user else { return }
//
//            if user.grantedScopes == nil || !user.grantedScopes!.contains("https://mail.google.com/") {
//              // Request additional Drive scope.
//                let additionalScopes = ["https://mail.google.com/"]
//
//
//                user.addScopes(additionalScopes, presenting: self!) { signInResult, error in
//                    guard error == nil else { return }
//                    guard let user = signInResult?.user else { return }
//                    UserDefaults.standard.set(user.userID, forKey: "gmail_user_id")
//                    UserDefaults.standard.set(user.accessToken.tokenString, forKey: "gmail_accessToken")
//                    self?.goToMailInboxs()
//                    // Check if the user granted access to the scopes you requested.
//                }
//            }else{
//                UserDefaults.standard.set(user.userID, forKey: "gmail_user_id")
//                UserDefaults.standard.set(user.accessToken.tokenString, forKey: "gmail_accessToken")
//
//            self?.goToMailInboxs()
//            }
//
//        }
//
//    }
//
//
//    private func goToMailInboxs(){
//        let vc = AppDelegate.mainSB.instantiateViewController(withIdentifier: "GmailViewController") as! GmailViewController
//        let nav = UINavigationController(rootViewController: vc)
//        nav.isNavigationBarHidden = true
//        nav.modalPresentationStyle = .fullScreen
//        navigationController?.present(nav, animated: true, completion: nil)
//    }
//}
