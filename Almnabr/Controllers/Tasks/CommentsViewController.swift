//
//  CommentsViewController.swift
//  Almnabr
//
//  Created by Hany Alkahlout on 31/07/2022.
//  Copyright © 2022 Samar Akkila. All rights reserved.
//

import UIKit
import SCLAlertView
class CommentsViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var commentTextView: UITextView!
    @IBOutlet weak var notTypingCommentLabel: UILabel!
    
    var ticketId = ""
    private var data = [CommentDataResponse]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        initlization()
        tableView.isScrollEnabled = true
    }
    
    
    private func initlization(){
        commentTextView.delegate = self
        addNavigationBarTitlee(navigationTitle: "Comments".localized())
        setUpTableView()
        addObserver()
        socketObservers()
    }
    
    
    private func socketObservers(){
        addCommentObserver()
    }
    
    
    private func addObserver(){
        NotificationCenter.default.addObserver(forName: .init(rawValue: "ReloadAllComment"), object: nil, queue: .main) { notify in
            guard let data = notify.object as? (commentIndex:Int,newComment:String) else { return }
            self.data[data.commentIndex].notes_history = data.newComment
            self.tableView.reloadData()
        }
        
        NotificationCenter.default.addObserver(forName: .init(rawValue: "DeleteReplyComment"), object: nil, queue: .main) { notify in
            guard let obj = notify.object as? (String,Int,Int) else { return }
            let alertVC = UIAlertController(title: "Are you sure you want to delete this reply", message: "", preferredStyle: .alert)
            alertVC.addAction(.init(title: "Yes".localized(), style: .default, handler: { action in
                self.deleteCommentReply(comment_id: obj.0, comment_index: obj.1, reply_Index: obj.2)
            }))
            alertVC.addAction(.init(title: "No", style: .default))
            self.present(alertVC, animated: true)
        }
        
        NotificationCenter.default.addObserver(forName: .init(rawValue: "EditReplyComment"), object: nil, queue: .main) { notify in
            guard let obj = notify.object as? (String,String) else { return }
            self.editTicketCommentAction(comment_id: obj.0, commentText: obj.1,index: 0)
        }
        
    }
    
    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(false, animated: true)
        self.getAllComments()
    }
    
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        navigationController?.setNavigationBarHidden(true, animated: true)
    }
    
    
    @IBAction func saveAction(_ sender: Any) {
        addComment()
    }
    
    
}

extension CommentsViewController:UITableViewDelegate,UITableViewDataSource{
    private func setUpTableView(){
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(.init(nibName: "CommentTableViewCell", bundle: nil), forCellReuseIdentifier: "CommentTableViewCell")
    }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return data.count
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "CommentTableViewCell", for: indexPath) as! CommentTableViewCell
        cell.setData(data: data[indexPath.row],index: indexPath.row)
        cell.delegate = self
        return cell
    }
    
}

// MARK: - Cell Delegate

extension CommentsViewController:CommentTableViewCellDelegate{
    func editTicketCommentAction(comment_id: String, commentText: String,index:Int) {
        let vc = EditTicketCommentVC()
        vc.commentId = comment_id
        vc.reply = commentText
        vc.commentIndex = index
        vc.isReply = false
        let nav = UINavigationController(rootViewController: vc)
        nav.modalPresentationStyle = .overCurrentContext
        self.navigationController?.present(nav, animated: false)
    }
    
    
    func deleteTicketCommentAction(comment_id: String) {
        let alertVC = UIAlertController(title: "Are You sure you want to delete this comment", message: "", preferredStyle: .alert)
        alertVC.addAction(.init(title: "Yes".localized(), style: .default, handler: { action in
            self.deleteComment(comment_id: comment_id)
        }))
        alertVC.addAction(.init(title: "No".localized(), style: .default))
        self.present(alertVC, animated: true)
    }
    
    
    func reloadCommentReplyAction(replyIsHidden: Bool, index: Int) {
        self.data[index].isHiddenReply = replyIsHidden
        self.tableView.reloadRows(at: [IndexPath(row: index, section: 0)], with: UITableView.RowAnimation.automatic)
    }
    
    
    func reloadCommentHideShowTableView(replyIsHidden: Bool, index: Int) {
        self.data[index].isHidden = replyIsHidden
        self.tableView.reloadRows(at: [IndexPath(row: index, section: 0)], with: UITableView.RowAnimation.automatic)
    }
    
    
    func saveReplyComment(comment_id: String, replyText: String, index: Int,afterSuccess: @escaping () -> Void) {
        self.addReplyToComment(reply: replyText, comment_Id: comment_id,index: index,afterSuccess:afterSuccess)
    }
    
    
}


// MARK: - API Handling
extension CommentsViewController{
    private func getAllComments(){
        showLoadingActivity()
        APIController.shard.getAllComments(type: "1", ticketId: ticketId) { data in
            DispatchQueue.main.async {
                self.hideLoadingActivity()
                if let status = data.status,status{
                    self.data = data.data ?? []
                    self.data = self.data.sorted(by: {$0.insert_date ?? "0" > $1.insert_date ?? "0"})
                }else{
                    self.data.removeAll()
                    SCLAlertView().showError("error".localized(), subTitle: data.error ?? "")
                }
                self.tableView.reloadData()
            }
        }
    }
    
    
    private func addComment(){
        APIController.shard.addComment(comment: commentTextView.text!, ticketId: ticketId) { data in
            if let status = data.status,status{
                self.commentTextView.text = ""
                self.commentTextView.endEditing(true)
                self.notTypingCommentLabel.isHidden = false
                
            }else{
                SCLAlertView().showError("error".localized(), subTitle: data.error ?? "Something went wrong")
            }
        }
    }
    
    
    private func deleteComment(comment_id: String){
        APIController.shard.deleteCommentReply(comment_id: comment_id) { data in
            if data.status == nil || data.status == false{
                SCLAlertView().showError("error".localized(), subTitle: data.error ?? "")
            }
        }
    }
    
    
    private func addReplyToComment(reply:String,comment_Id:String,index:Int,afterSuccess:@escaping ()->Void){
        showLoadingActivity()
        APIController.shard.addCommentReply(ticketId: ticketId, reply: reply, comment_id: comment_Id) { data in
            self.hideLoadingActivity()
            if data.status == nil || data.status == false{
                SCLAlertView().showError("error".localized(), subTitle: data.error ?? "Something went wrong")
            }else{
                afterSuccess()
            }
        }
    }
    
    
    private func deleteCommentReply(comment_id:String,comment_index:Int,reply_Index:Int){
        showLoadingActivity()
        APIController.shard.deleteCommentReply(comment_id: comment_id) { data in
            self.hideLoadingActivity()
            if data.status == nil || data.status == false{
                SCLAlertView().showError("error".localized(), subTitle: data.error ?? "Someting went wrong")
            }
        }
    }
    
    
}


// MARK: - Socket Handling
extension CommentsViewController{
    private func addCommentObserver(){
        SocketIOController.shard.commentsTicketHandler(ticketId: ticketId, userID: Auth_User.user_id) { data in
            guard let data = data.first as? [String:Any],
                  let content = data["content"] as? [String:Any],
                  let type = data["type"] as? String
            else { return }
            
            
            switch type{
            case "add_comment":
                self.data.insert(.init(content), at: 0)
                self.tableView.insertRows(at: [IndexPath(row: 0, section: 0)], with: .automatic)
                
            case "edit_comment":
                let index = self.data.firstIndex(where: {$0.history_id == content["history_id"] as? String})
                let replies = self.data[index!].reply
                self.data.removeAll(where: {$0.history_id == content["history_id"] as? String})
                if let index = index {
                    var updatedObj:CommentDataResponse = .init(content)
                    updatedObj.reply = replies
                    self.data.insert(updatedObj, at: index)
                    self.tableView.reloadRows(at: [IndexPath(row: index, section: 0)], with: .automatic)
                }
                
            case "delete_comment":
                let index = self.data.firstIndex(where: {$0.history_id == content["history_id"] as? String})
                if let index = index {
                    self.data.remove(at: index)
                    self.tableView.deleteRows(at: [IndexPath(row: index, section: 0)], with: .automatic)
                }
                
            case "add_reply":
                let index = self.data.firstIndex(where: {$0.history_id == String(content["comment_id"] as! Int)})
                
                if let index = index, let newObj = content["reply"] as? [String:Any]{
                    if let _ = self.data[index].reply {
                        self.data[index].reply!.insert(.init(newObj), at: 0)
                    }else{
                        self.data[index].reply = [Return_row(newObj)]
                    }
                    self.data[index].isHidden = false
                    self.tableView.reloadRows(at: [IndexPath(row: index, section: 0)], with: .automatic)
                }
                
            case "edit_reply":
                let index = self.data.firstIndex(where: {$0.history_id == content["comment_id"] as? String})
                if let index = index, let newObj = content["reply"] as? [String:Any],let _ = self.data[index].reply{
                    let editedObj = Return_row.init(newObj)
                    let _index = self.data[index].reply!.firstIndex(where: {$0.history_id == editedObj.history_id})
                    if let _index = _index{
                        self.data[index].reply!.remove(at: _index)
                        self.data[index].reply!.insert(editedObj, at: _index)
                        self.data[index].isHidden = false
                    }
                    self.tableView.reloadRows(at: [IndexPath(row: index, section: 0)], with: .automatic)
                }
                
            case "delete_reply":
                let index = self.data.firstIndex(where: {$0.history_id == content["comment_id"] as? String})
                if let index = index, let reply = content["reply"] as? [String:Any]{
                    self.data[index].reply?.removeAll(where:  {$0.history_id == reply["history_id"] as? String})
                    self.tableView.reloadRows(at: [IndexPath(row: index, section: 0)], with: .automatic)
                }
                
            default:
                break
            }
        }
    }
    
}


extension CommentsViewController:UITextViewDelegate{
    func textViewDidBeginEditing(_ textView: UITextView) {
        notTypingCommentLabel.isHidden = true
    }
}
