//
//  ProjectCell.swift
//  Almnabr
//
//  Created by MacBook on 10/10/2021.
//  Copyright © 2021 Samar Akkila. All rights reserved.
//

import UIKit

class ProjectCell: UICollectionViewCell {

    
    @IBOutlet weak var lbldash: UILabel!
    @IBOutlet weak var lblId: UILabel!
    @IBOutlet weak var lblTitle: UILabel!
    @IBOutlet weak var lblBranch: UILabel!
    @IBOutlet weak var lblCustomer: UILabel!
    @IBOutlet weak var lblType: UILabel!
    @IBOutlet weak var lblOnDate: UILabel!
    @IBOutlet weak var lblWriter: UILabel!
    @IBOutlet weak var btnCheck: UIButton!
    
    func setRecord( dash: String,
                    projects_profile_id: String,
                    project_title: String,
                    branch_name: String,
                    customer_title_ar: String,
                    customer_type: String,
                    projects_profile_created_datetime: String,
                    writer:String) {
        
        lbldash.text = dash
        lblId.text = projects_profile_id
        lblTitle.text = project_title
        lblBranch.text = branch_name
        lblCustomer.text = customer_title_ar
        lblType.text = customer_type
        lblOnDate.text = projects_profile_created_datetime
        lblWriter.text = writer
    }

    override func layoutSubviews() {
        super.layoutSubviews()

//        let thickness = 1 / (window?.screen.scale ?? 1)
//        let size = bounds.size
//        rightSeparator.frame = CGRect(x: size.width - thickness, y: 0, width: thickness, height: size.height)
//        bottomSeparator.frame = CGRect(x: 0, y: size.height - thickness, width: size.width, height: thickness)
    }


}
