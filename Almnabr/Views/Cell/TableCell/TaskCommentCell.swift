//
//  TaskCommentCell.swift
//  Almnabr
//
//  Created by MacBook on 11/05/2022.
//  Copyright © 2022 Samar Akkila. All rights reserved.
//

import UIKit

class TaskCommentCell: UITableViewCell ,UITableViewDataSource,UITableViewDelegate{
    
    @IBOutlet weak var lblUserName: UILabel!
    @IBOutlet weak var lblDate: UILabel!
    @IBOutlet weak var lblComment: UILabel!
    @IBOutlet weak var imgUser: UIImageView!
    @IBOutlet weak var viewBack: UIView!
    
    @IBOutlet weak var tableHeight: NSLayoutConstraint!
    @IBOutlet weak var replysTable: UITableView!
    
    @IBOutlet weak var editButton: UIButton!
    @IBOutlet weak var deleteButton: UIButton!
    @IBOutlet weak var replyButton: UIButton!
    @IBOutlet weak var repliesButton: UIButton!
    @IBOutlet weak var replyTextView: UITextView!
    @IBOutlet weak var replyView: UIView!
    
    @IBOutlet weak var dropView: UIView!
    
    var btnAddReply : ((_ comment_id:String,_ note:String) -> Void)?
    var btnViewReplyAction : ((_ isHidden:Bool)->())?
    var btnDeleteReplyAction : ((_ comment_id: String,_ replyIndex:Int?)-> Void)?
    var btnEditReplyAction : ((_ comment_id: String, _ comment: String,_ replyIndex:Int?)-> Void)?
    var reloadReplyView : ((_ isHidden:Bool)->())?
    
    var arr_reply :[ReplyObj] = []
    var comment_id = ""
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        selectionStyle = .none
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
    
    func setUpTable(){
        replysTable.dataSource = self
        replysTable.delegate = self
        
        let nib = UINib(nibName: "CommentRepltTableViewCell", bundle: nil)
        replysTable.register(nib, forCellReuseIdentifier: "CommentRepltTableViewCell")
        
        tableHeight.constant = CGFloat(arr_reply.count * 150 )
        self.replysTable.setNeedsLayout()
        
        self.replysTable.reloadData()
    }
    
    
    @IBAction func editAction(_ sender: Any) {
        btnEditReplyAction?(comment_id,lblComment.text!,nil)
    }
    
    
    @IBAction func deleteAction(_ sender: Any) {
        self.btnDeleteReplyAction!(comment_id,nil)
    }
    
    
    @IBAction func replyAction(_ sender: Any) {
        reloadReplyView?(!replyView.isHidden)
    }
    
    
    @IBAction func repliesAction(_ sender: Any) {
        btnViewReplyAction?(!dropView.isHidden)
    }
    
    
    @IBAction func saveReplyAction(_ sender: Any) {
        btnAddReply?(comment_id,replyTextView.text!)
    }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return arr_reply.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "CommentRepltTableViewCell", for: indexPath) as! CommentRepltTableViewCell
        
        let obj = arr_reply[indexPath.item]
        
        cell.lblDate.text = obj.comment_date
        cell.lblUserName.text = obj.userName
        cell.lblComment.text = obj.comment_content != "" ? obj.comment_content : obj.notes_history
        cell.deleteEditStackView.isHidden = obj.emp_id != Auth_User.user_id
        cell.btnEditAction = {
            self.btnEditReplyAction!(obj.history_id , cell.lblComment.text!,indexPath.row)
        }
        
        cell.btnDeleteAction = {
            self.btnDeleteReplyAction!(obj.history_id, indexPath.row)
        }
        
        return cell
        
    }
    
    
}
