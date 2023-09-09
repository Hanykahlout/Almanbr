//
//  SubProjectTVCell.swift
//  Almnabr
//
//  Created by MacBook on 04/03/2022.
//  Copyright © 2022 Samar Akkila. All rights reserved.
//

import UIKit

class SubProjectTVCell: UITableViewCell {

    @IBOutlet weak var lblId: UILabel!
    @IBOutlet weak var lblQ_No: UILabel!
    @IBOutlet weak var lblSubject: UILabel!
    @IBOutlet weak var lblValNetAmount: UILabel!
    @IBOutlet weak var lblValGrandTotal: UILabel!
    @IBOutlet weak var lblValTaxAmount: UILabel!
    @IBOutlet weak var lblWriter: UILabel!
    @IBOutlet weak var lblDate: UILabel!
    @IBOutlet weak var lblApprovedDate: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func setData(data:ProjectServicesRecord){
        
        lblId.text = "ID: \(data.projects_supervision_id ?? "--")"
        lblQ_No.text = "Number: \(data.projects_work_area_id ?? "--")"
        lblSubject.text = data.quotation_subject ?? "----"
        lblValGrandTotal.text = data.quotation_grand_total ?? "--"
        lblValTaxAmount.text = data.quotation_tax_amount ?? "--"
        lblValNetAmount.text = data.quotation_net_amount ?? "--"
        lblWriter.text = "By: \(data.writer ?? "----")"
        lblApprovedDate.text = data.quotation_approved_date ?? "----"
        lblDate.text = data.projects_supervision_created_datetime ?? "--:--"
    }
    
    func setData(data:ProjectsDesignData){
        lblId.text = "ID: \(data.project_design_id ?? "--")"
        lblQ_No.text = "Number: \(data.projects_work_area_id ?? "--")"
        lblSubject.text = data.quotation_subject ?? "----"
        lblValGrandTotal.text = data.quotation_grand_total ?? "--"
        lblValTaxAmount.text = data.quotation_tax_amount ?? "--"
        lblValNetAmount.text = data.quotation_net_amount ?? "--"
        lblWriter.text = "By: ----"
        lblApprovedDate.text = "----"
        lblDate.text = data.create_project_design ?? "--:--"
    }
}
