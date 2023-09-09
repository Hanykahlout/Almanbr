//
//  EducationDetailsTableViewCell.swift
//  Almnabr
//
//  Created by Hany Alkahlout on 15/06/2022.
//  Copyright © 2022 Samar Akkila. All rights reserved.
//

import UIKit

protocol EducationDetailsCellDelegate{
    func deleteAction(id:String,indexPath:IndexPath)
    func updateAction(data:EducationRecord)
    func viewAction(data:EducationRecord)

}

typealias EducationDetailsDelegate = EducationDetailsCellDelegate & UIViewController

class EducationDetailsTableViewCell: UITableViewCell {

    @IBOutlet weak var educationTitleLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var durationLabel: UILabel!
    @IBOutlet weak var writerLabel: UILabel!
    @IBOutlet weak var onDateLabel: UILabel!
    var delegate:EducationDetailsDelegate?
    private var data:EducationRecord!
    private var indexPath:IndexPath!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    
    func setData(data:EducationRecord,indexPath:IndexPath){
        self.data = data
        self.indexPath = indexPath
        educationTitleLabel.text = data.education_title ?? ""
        descriptionLabel.text = data.education_descriptions ?? ""
        durationLabel.text = "\(data.education_start_date ?? "") To \(data.education_end_date ?? "")"
        writerLabel.text = data.name ?? ""
        onDateLabel.text = data.education_createddatetime ?? ""
        
    }
    
    @IBAction func deleteAction(_ sender: Any) {
        delegate?.deleteAction(id: data.education_id ?? "",indexPath: indexPath)
    }
    
    @IBAction func editAction(_ sender: Any) {
        delegate?.updateAction(data:data)
    }
    
    @IBAction func viewAction(_ sender: Any) {
        delegate?.viewAction(data: data)
    }
}
