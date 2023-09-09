//
//  JopDetailsTableViewCell.swift
//  Almnabr
//
//  Created by Hany Alkahlout on 14/06/2022.
//  Copyright © 2022 Samar Akkila. All rights reserved.
//

import UIKit

protocol JopDetailsCellDelegate{
    func deleteCell(id:String,indexPath:IndexPath)
    func goToUpdateVC(isView:Bool,positionId:String)
    
}

typealias JopDetailsDelegate = JopDetailsCellDelegate & UIViewController

class JopDetailsTableViewCell: UITableViewCell {
    
    @IBOutlet weak var positionsLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var onDateLabel: UILabel!
    @IBOutlet weak var writerLabel: UILabel!
    var delegate:JopDetailsDelegate?
    private var indexPath:IndexPath!
    private var id = ""
    
    
    func setData(data:JopDetailsRecords,indexPath:IndexPath){
        self.indexPath = indexPath
        id = data.position_id ?? ""
        positionsLabel.text = data.postition_name ?? ""
        descriptionLabel.text = data.job_descriptions ?? ""
        onDateLabel.text = data.created_datetime ?? ""
        writerLabel.text = data.name ?? ""
    }
    
    
    @IBAction func viewAction(_ sender: Any) {
        delegate?.goToUpdateVC(isView:true,positionId: id)
    }
    
    
    @IBAction func editAction(_ sender: Any) {
        delegate?.goToUpdateVC(isView:false,positionId: id)
    }
    
    
    @IBAction func deleteAction(_ sender: Any) {
        delegate?.deleteCell(id: id,indexPath:indexPath)
    }
    
}

