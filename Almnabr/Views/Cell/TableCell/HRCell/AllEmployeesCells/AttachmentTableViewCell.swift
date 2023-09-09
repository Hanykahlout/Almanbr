//
//  AttachmentTableViewCell.swift
//  Almnabr
//
//  Created by Hany Alkahlout on 20/06/2022.
//  Copyright © 2022 Samar Akkila. All rights reserved.
//

import UIKit
import DropDown
protocol AttachmentCellDelegate{
    func deleteAction(data: AttachmentRecords,indexPath:IndexPath)
    func editAattchment(data:AttachmentRecords)
    func previewAttachmentAction(data:AttachmentRecords)
}

class AttachmentTableViewCell: UITableViewCell {

    @IBOutlet weak var typeLabel: UILabel!
    @IBOutlet weak var subjectLabel: UILabel!
    @IBOutlet weak var fileExtentionLabel: UILabel!
    @IBOutlet weak var fileLevelLabel: UILabel!
    @IBOutlet weak var writerLabel: UILabel!
    @IBOutlet weak var onDateLabel: UILabel!
    @IBOutlet weak var settingsButton: UIButton!
    
    private var dropDown = DropDown()
    
    private var indexPath:IndexPath!
    private var data:AttachmentRecords!
    
    var delegate:(AttachmentCellDelegate & UIViewController)?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        setUpDropDown()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    private func setUpDropDown(){
        dropDown.anchorView = settingsButton
        
        dropDown.bottomOffset = CGPoint(x: 0, y:(dropDown.anchorView?.plainView.bounds.height)!)
        dropDown.dataSource = ["File","Edit"]
        dropDown.selectionAction = { (index: Int, item: String) in
            if index == 0 {
                // View Attachment
                self.delegate?.previewAttachmentAction(data: self.data)
            }else{
                // Edit Attachment
                self.delegate?.editAattchment(data: self.data)
            }
        }

    }
    
    func setData(data:AttachmentRecords,indexPath:IndexPath){
        self.data = data
        self.indexPath = indexPath
        typeLabel.text = data.type_name ?? ""
        subjectLabel.text = data.file_name ?? ""
        fileExtentionLabel.text = data.file_extension ?? ""
        fileLevelLabel.text = data.level_keys ?? ""
        writerLabel.text = data.writer ?? ""
        onDateLabel.text = data.created_datetime ?? ""
    }
    
    
    @IBAction func cellSettingAction(_ sender: Any) {
        dropDown.show()
    }
    
    @IBAction func deleteAction(_ sender: Any) {
        delegate?.deleteAction(data: data, indexPath: indexPath)
    }
    
}
