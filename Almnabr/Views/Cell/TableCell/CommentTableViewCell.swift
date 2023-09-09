//
//  CommentTableViewCell.swift
//  Almnabr
//
//  Created by Hany Alkahlout on 01/08/2022.
//  Copyright © 2022 Samar Akkila. All rights reserved.
//

import UIKit
import SCLAlertView

protocol CommentTableViewCellDelegate{
    func editTicketCommentAction(comment_id:String,commentText:String,index:Int)
    func deleteTicketCommentAction(comment_id:String)
    func reloadCommentReplyAction(replyIsHidden:Bool,index:Int)
    func reloadCommentHideShowTableView(replyIsHidden:Bool,index:Int)
    func saveReplyComment(comment_id:String,replyText:String,index:Int,afterSuccess:@escaping ()->Void)
}

typealias CommentCellDelegate = CommentTableViewCellDelegate & UIViewController

class CommentTableViewCell: UITableViewCell {
    
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var commentLabel: UILabel!
    @IBOutlet weak var editButton: UIButton!
    @IBOutlet weak var deleteButton: UIButton!
    @IBOutlet weak var replyButton: UIButton!
    @IBOutlet weak var repliesButton: UIButton!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var tableHeight: NSLayoutConstraint!
    @IBOutlet weak var replyView: UIView!
    @IBOutlet weak var replyTextView: UITextView!
    @IBOutlet weak var notTypingCommentLabel: UILabel!
    
    
    var delegate:CommentCellDelegate?
    
    
    private var data = [Return_row]()
    private var index = 0
    private var id = ""
    
    override func awakeFromNib() {
        super.awakeFromNib()
        replyTextView.delegate = self
        setUpTableView()
    }
    

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        // Configure the view for the selected state
    }
    
    
    
    func setData(data:CommentDataResponse,index:Int){
        self.index = index
        self.data = data.reply ?? []
        
        self.data = self.data.sorted(by: {$0.insert_date ?? "0" > $1.insert_date ?? "0"})
        self.id = data.history_id ?? ""
        
        if self.data.isEmpty || (data.isHidden ?? true) {
            self.tableView.isHidden = true
        }else{
            self.tableView.isHidden = false
        }
        
        self.repliesButton.isHidden = data.reply?.isEmpty ?? true
        self.replyView.isHidden = data.isHiddenReply
        self.tableView.reloadData()
        
        
        self.nameLabel.text = data.emp_name ?? ""
        self.commentLabel.text = data.notes_history ?? ""
        self.dateLabel.text = data.insert_date ?? ""
        
        deleteButton.isHidden = data.emp_id != Auth_User.user_id
        editButton.isHidden = data.emp_id != Auth_User.user_id
    }

    
    @IBAction func editAction(_ sender: Any) {
        delegate?.editTicketCommentAction(comment_id:id,commentText:commentLabel.text!,index:index)
    }
    
    
    @IBAction func deleteAction(_ sender: Any) {
        delegate?.deleteTicketCommentAction(comment_id: id)
    }
    
    
    @IBAction func replyAction(_ sender: Any) {
        replyView.isHidden = !replyView.isHidden
        delegate?.reloadCommentReplyAction(replyIsHidden: replyView.isHidden, index: index)
    }
    
    
    @IBAction func hideShowRepliesAction(_ sender: Any) {
        if !data.isEmpty{
            tableView.isHidden = !tableView.isHidden
            delegate?.reloadCommentHideShowTableView(replyIsHidden: tableView.isHidden, index: index)
        }
    }
    
    
    @IBAction func saveAction(_ sender: Any) {
        delegate?.saveReplyComment(comment_id: id, replyText: replyTextView.text!, index: index,afterSuccess: {
            self.replyTextView.text = ""
            self.replyTextView.endEditing(true)
            self.notTypingCommentLabel.isHidden = false
        })
    }

}


extension CommentTableViewCell:UITableViewDelegate,UITableViewDataSource{
    
    private func setUpTableView(){
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(.init(nibName: "ReplyCommentTableViewCell", bundle: nil), forCellReuseIdentifier: "ReplyCommentTableViewCell")
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return data.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ReplyCommentTableViewCell", for: indexPath) as! ReplyCommentTableViewCell
        cell.setData(data: data[indexPath.row],comment_index: index,reply_index: indexPath.row)
        return cell
    }
    

}

extension CommentTableViewCell:UITextViewDelegate{
    func textViewDidBeginEditing(_ textView: UITextView) {
        notTypingCommentLabel.isHidden = true
    }
}
