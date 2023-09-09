//
//  EditTicketCommentVC.swift
//  Almnabr
//
//  Created by Hany Alkahlout on 03/08/2022.
//  Copyright © 2022 Samar Akkila. All rights reserved.
//

import UIKit
import SCLAlertView

class EditTicketCommentVC: UIViewController {

    @IBOutlet weak var replyTextView: UITextView!
    var commentId = ""
    var reply = ""
    var isReply = false
    var commentIndex: Int?
    var replyIndex:Int?
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(true, animated: true)
        replyTextView.text = reply
    }
    
    
    private func editComment(reply:String,comment_id: String){
        showLoadingActivity()
        APIController.shard.editComment(note: reply, comment_id: comment_id) { data in
            self.hideLoadingActivity()
            if let status = data.status, status{
                self.navigationController?.dismiss(animated: true)
            }else{
                SCLAlertView().showError("error".localized(), subTitle: data.error ?? "Something went wrong")
            }
        }
    }

    
    @IBAction func cloasAction(_ sender: Any) {
        navigationController?.dismiss(animated: false)
    }
    
    
    @IBAction func submitAction(_ sender: Any) {
        editComment(reply: replyTextView.text!, comment_id: commentId)
    }
    
    
}
