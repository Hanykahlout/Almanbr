//
//  SendMailViewController.swift
//  Almnabr
//
//  Created by Hany Alkahlout on 04/01/2023.
//  Copyright © 2023 Samar Akkila. All rights reserved.
//

import UIKit
import SCLAlertView
class SendMailViewController: UIViewController {

    @IBOutlet weak var fromTextField: UITextField!
    @IBOutlet weak var toTextField: UITextField!
    @IBOutlet weak var subjectTextField: UITextField!
    @IBOutlet weak var messageTextView: UITextView!


    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }


    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        addNavigationBarTitle(navigationTitle: "Compose")
        navigationController?.setNavigationBarHidden(false, animated: true)
        
    }
    
    @IBAction func sendAction(_ sender: Any) {
        sendMail()
    }
    
}
// MARK: - APIHandling
extension SendMailViewController{
    private func sendMail(){
        showLoadingActivity()
        APIController.shard.sendMail(subject: subjectTextField.text!, to: toTextField.text!, from: fromTextField.text!, body: messageTextView.text!) { data in
            DispatchQueue.main.async {
                self.hideLoadingActivity()
                if let status = data.status,status{
//                    SCLAlertView().showSuccess("Success".lowercased(), subTitle: data.)
                }
            }
        }
    }
}
