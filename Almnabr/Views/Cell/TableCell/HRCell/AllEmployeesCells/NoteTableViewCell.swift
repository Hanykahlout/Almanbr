//
//  NoteTableViewCell.swift
//  Almnabr
//
//  Created by Hany Alkahlout on 20/06/2022.
//  Copyright © 2022 Samar Akkila. All rights reserved.
//

import UIKit

protocol NoteCellDelegate{
    func deleteAction(id:String,indexPath:IndexPath)
    func updateAction(isView:Bool,data:NoteRecords)
    
}

typealias NoteDelegate = UIViewController & NoteCellDelegate

class NoteTableViewCell: UITableViewCell {

    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var remainderDateLabel: UILabel!
    
    @IBOutlet weak var statusView: UIView!
    @IBOutlet weak var writerLabel: UILabel!
    
    var delegate:NoteDelegate?
    private var indexPath:IndexPath!
    private var data:NoteRecords!
    
    
    func setData(data:NoteRecords,indexPath:IndexPath){
        self.indexPath = indexPath
        self.data = data
        descriptionLabel.text = data.note_description ?? ""
        remainderDateLabel.text = data.note_remainder_date ?? "-------"
        statusView.backgroundColor = data.show_status == "1" ? .green : .red
        writerLabel.text = data.name ?? ""
    }
    
    
    @IBAction func viewAction(_ sender: Any) {
        delegate?.updateAction(isView: true, data: data)
    }
    
    
    @IBAction func editAction(_ sender: Any) {
        delegate?.updateAction(isView: false, data: data)
    }
    
    
    @IBAction func deleteAction(_ sender: Any) {
        delegate?.deleteAction(id: data.note_id ?? "", indexPath: indexPath)
    }
}
