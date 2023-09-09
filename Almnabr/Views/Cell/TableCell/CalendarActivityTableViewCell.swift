//
//  CalendarActivityTableViewCell.swift
//  Almnabr
//
//  Created by Hany Alkahlout on 26/10/2022.
//  Copyright © 2022 Samar Akkila. All rights reserved.
//

import UIKit

class CalendarActivityTableViewCell: UITableViewCell {

    @IBOutlet weak var countLabel: UILabel!
    @IBOutlet weak var employeeNumberLabel: UILabel!
    @IBOutlet weak var employeeNameLabel: UILabel!
    var creatViolationAction: ((_ empNumber:String) -> Void)?
    var cancelViolationAction: ((_ empNumber:String) -> Void)?
    var openDetailsViolationAction: ((_ userId:String) -> Void)?
    var weekRatioViolationAction: ((_ empNumber:String) -> Void)?
    var monthRatioViolationAction: ((_ empNumber:String , _ empName:String) -> Void)?
    
    private var data: No_settings?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    
    func setData(index:Int,data:No_settings){
        self.data = data
        countLabel.text = "# \(index + 1)"
        employeeNameLabel.text = data.employee_name ?? ""
        employeeNumberLabel.text = data.employee_number ?? ""
    }
    
    
    @IBAction func creatViolationAction(_ sender: Any) {
        creatViolationAction?(data?.employee_number ?? "")
    }
    
    @IBAction func cancelViolationAction(_ sender: Any) {
        cancelViolationAction?(data?.employee_number ?? "")
    }
    
    @IBAction func openDetailsViolationAction(_ sender: Any) {
        openDetailsViolationAction?(data?.user_id ?? "")
    }
    
    @IBAction func weekRatioViolationAction(_ sender: Any) {
        weekRatioViolationAction?(data?.employee_number ?? "")
    }
    
    @IBAction func monthRatioViolationAction(_ sender: Any) {
        monthRatioViolationAction?(data?.employee_number ?? "",data?.employee_name ?? "")
    }
    
}
