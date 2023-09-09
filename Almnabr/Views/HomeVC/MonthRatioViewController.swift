//
//  MonthRatioViewController.swift
//  Almnabr
//
//  Created by Hany Alkahlout on 27/10/2022.
//  Copyright © 2022 Samar Akkila. All rights reserved.
//

import UIKit

class MonthRatioViewController: UIViewController {

    @IBOutlet weak var empNumberLabel: UILabel!
    @IBOutlet weak var empNameLabel: UILabel!
    @IBOutlet weak var ratioLabel: UILabel!
    
    var date = ""
    var empNumber = ""
    var empName = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.empNumberLabel.text = empNumber
        self.empNameLabel.text = empName
        getRatioMonth()
    }
    
    @IBAction func closeAction(_ sender: Any) {
        navigationController?.dismiss(animated: true)
    }
    
}
// MARK: - API Handling
extension MonthRatioViewController{
    private func getRatioMonth(){
        let body = [
            "date": date,
            "employee_number": empNumber
        ]
        showLoadingActivity()
        APIController.shard.ratioMonthViolation(body: body) { data in
            self.hideLoadingActivity()
            if let status = data.status,status{
                DispatchQueue.main.async {
                    self.ratioLabel.text = data.ratio_month ?? ""
                }
            }
        }
    }
}
