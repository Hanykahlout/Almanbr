//
//  ReplyCommentTableViewCell.swift
//  Almnabr
//
//  Created by Hany Alkahlout on 01/08/2022.
//  Copyright © 2022 Samar Akkila. All rights reserved.
//

import UIKit


class ReplyCommentTableViewCell: UITableViewCell {

    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var commentLabel: UILabel!
    @IBOutlet weak var editingStack: UIStackView!
    
    var id  = ""
    private var comment_index = 0
    private var reply_index = 0
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    
    func setData(data:Return_row,comment_index:Int,reply_index:Int){
        self.comment_index = comment_index
        self.reply_index = reply_index
        id = data.history_id ?? ""
        nameLabel.text = data.userName ?? ""
        dateLabel.text = data.comment_date ?? ""
        commentLabel.text = data.comment_content ?? data.notes_history ?? ""
        editingStack.isHidden = data.emp_id != Auth_User.user_id
    }
    
    
    @IBAction func editAction(_ sender: Any) {
        NotificationCenter.default.post(name: .init(rawValue: "EditReplyComment"), object: (id,commentLabel.text))
    }
    
    
    @IBAction func deleteAction(_ sender: Any) {
        NotificationCenter.default.post(name: .init(rawValue: "DeleteReplyComment"), object: (id,comment_index,reply_index))
    }
    

    
}
