//
//  OutgoingAttachmentTableViewCell.swift
//  Almnabr
//
//  Created by Hany Alkahlout on 22/06/2022.
//  Copyright © 2022 Samar Akkila. All rights reserved.
//

import UIKit

protocol OutgoingAttachmentCellDelegate{
    func deleteAction()
    func selectFileAction(index:Int)
}


class OutgoingAttachmentTableViewCell: UITableViewCell {
    
    @IBOutlet weak var attachwithPdfButton: UIButton!
    @IBOutlet weak var officialPaperButton: UIButton!
    @IBOutlet weak var descriptionTextField: UITextField!
    @IBOutlet weak var selectFileButton: UIButton!
    
    @IBOutlet weak var deleteButton: UIButton!
    @IBOutlet weak var attachwithPdfStackView: UIStackView!
    @IBOutlet weak var officialPaperStackView: UIStackView!
    
    
    var delegate: (OutgoingAttachmentCellDelegate & UIViewController)?
    var index:Int?
    var fileUrl:URL?
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        attachwithPdfStackView.isUserInteractionEnabled = true
        officialPaperStackView.isUserInteractionEnabled = true
        attachwithPdfStackView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(attachwithPdfStackViewAction)))
        officialPaperStackView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(officialPaperStackViewAction)))
    }
    
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
    
    @objc private func attachwithPdfStackViewAction(){
        attachwithPdfButton.isSelected = !attachwithPdfButton.isSelected
    }
    
    
    @objc private func officialPaperStackViewAction(){
        officialPaperButton.isSelected = !officialPaperButton.isSelected
    }
    
    
    @IBAction func selectFileAction(_ sender: Any) {
        if let  index = index {
            delegate?.selectFileAction(index: index)
        }
    }
    
    
    @IBAction func deleteAction(_ sender: Any) {
        delegate?.deleteAction()
    }
    
}

