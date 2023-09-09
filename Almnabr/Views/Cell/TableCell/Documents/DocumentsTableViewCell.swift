//
//  DocumentsTableViewCell.swift
//  Almnabr
//
//  Created by Hany Alkahlout on 16/08/2022.
//  Copyright © 2022 Samar Akkila. All rights reserved.
//

import UIKit

class DocumentsTableViewCell: UITableViewCell {
    
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var branchLabel: UILabel!
    @IBOutlet weak var statusView: UIView!
    @IBOutlet weak var issueDateLabel: UILabel!
    @IBOutlet weak var expiryDateLabel: UILabel!
    
    private var data:DocumentData?
    
    var deleteDocAction:(()->Void)?
    var downloadDocAction:((_ filePath:String)->Void)?
    var viewDocAction:(()->Void)?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        statusView.isUserInteractionEnabled = true
        statusView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(statusAction)))
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
    
    func setData(data:DocumentData){
        self.data = data
        nameLabel.text = data.document_name ?? "------"
        branchLabel.text = data.branch_name ?? "------"
        issueDateLabel.text = data.document_issue_date_english ?? "------"
        expiryDateLabel.text = data.document_expire_date_english ?? "------"
        if data.status == "1"{
            statusView.backgroundColor = .green
        }else{
            statusView.backgroundColor = .red
        }
    }
    
    
    @objc private func statusAction(){
        if let data = data {
            showLoadingActivity()
            APIController.shard.updateDocumentStatus(documentId: data.document_id ?? "-1", status: data.status == "1" ? "0" : "1") { data in
                self.hideLoadingActivity()
                if let status = data.status , status{
                    self.statusView.backgroundColor = self.data!.status == "1" ? .red
                    : .green
                    self.data!.status = self.data!.status == "1" ? "0" : "1"
                }
            }
        }
    }
    
    
    @IBAction func viewAction(_ sender: Any) {
        viewDocAction?()
    }
    
    
    @IBAction func editAction(_ sender: Any) {
    }
    
    
    @IBAction func downloadAction(_ sender: Any) {
        downloadDocAction?(data?.last_file_path ?? "")
    }
    
    
    @IBAction func deleteAction(_ sender: Any) {
        deleteDocAction?()
    }
    
}
