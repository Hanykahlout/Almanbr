//
//  ContractDataVC.swift
//  Almnabr
//
//  Created by Hany Alkahlout on 24/08/2022.
//  Copyright © 2022 Samar Akkila. All rights reserved.
//

import UIKit

class ContractDataVC: UIViewController {

    @IBOutlet weak var typeLAbel: UILabel!
    @IBOutlet weak var subjectLabel: UILabel!
    @IBOutlet weak var fromOrganizationLabel: UILabel!
    @IBOutlet weak var workDomainLabel: UILabel!
    @IBOutlet weak var workLocationLabel: UILabel!
    @IBOutlet weak var workTypeLabel: UILabel!
    @IBOutlet weak var joiningDateEnglishLabel: UILabel!
    @IBOutlet weak var joiningDateArabicLabel: UILabel!
    @IBOutlet weak var probationPeriodLabel: UILabel!
    @IBOutlet weak var contractStartDateLabel: UILabel!
    @IBOutlet weak var contractEndDateLabel: UILabel!
    @IBOutlet weak var contractPeriodLabel: UILabel!
    @IBOutlet weak var HRNotificationPeriodLabel: UILabel!
    @IBOutlet weak var autoRenewLabel: UILabel!
    @IBOutlet weak var hoursWorkTypeLabel: UILabel!
    @IBOutlet weak var workingHoursLabel: UILabel!
    @IBOutlet weak var workingDaysLabel: UILabel!
    @IBOutlet weak var vacationPaidDaysLabel: UILabel!
    @IBOutlet weak var ticketAmountLabel: UILabel!
    @IBOutlet weak var basicSalaryLabel: UILabel!
    @IBOutlet weak var homeAllowanceLabel: UILabel!
    @IBOutlet weak var netAmountLabel: UILabel!
    @IBOutlet weak var accountNumberLabel: UILabel!
    @IBOutlet weak var bankNameLabel: UILabel!
    @IBOutlet weak var penaltyClauseFirstPartyLabel: UILabel!
    @IBOutlet weak var penaltyClauseSecondPartyLabel: UILabel!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var firstPartyLabel: UILabel!
    @IBOutlet weak var secondPartyLabel: UILabel!

    private var addtionalAllowancesData = [AdditionalTermsRecords]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpTableView()
        
    }
    
    
    func setData(data:Form_ct1_data?,addtionalAllowances:Form_ct1_data_additional_terms?){
        if let data = data , let record = data.records{
            
            typeLAbel.text = record.contract_type ?? ""
            subjectLabel.text = record.subject ?? ""
            fromOrganizationLabel.text = record.branchname ?? ""
            workDomainLabel.text = record.tr_work_domain ?? ""
            workLocationLabel.text = record.work_location ?? ""
            workTypeLabel.text = record.work_type ?? "" == "1" ? "Full Time" : "Part Time"
            joiningDateEnglishLabel.text = record.joining_date_english ?? ""
            joiningDateArabicLabel.text = record.joining_date_arabic ?? ""
            probationPeriodLabel.text = record.probation_period ?? ""
            contractStartDateLabel.text = "\(record.contract_start_date_english ?? "") - \(record.contract_start_date_arabic ?? "")"
            contractEndDateLabel.text = "\(record.contract_end_date_english ?? "") - \(record.contract_end_date_arabic ?? "")"
            contractPeriodLabel.text = record.contract_period ?? ""
            HRNotificationPeriodLabel.text = record.notification_period ?? ""
            autoRenewLabel.text = record.auto_renew ?? "" == "0" ? "No" : "Yes"
            hoursWorkTypeLabel.text = record.working_hours_type ?? ""
            workingHoursLabel.text = record.working_hours ?? ""
            workingDaysLabel.text = record.working_days_per_week ?? ""
            vacationPaidDaysLabel.text = record.vacation_paid_days ?? ""
            ticketAmountLabel.text = record.ticket_amount ?? ""
            basicSalaryLabel.text = record.basic_salary ?? ""
            homeAllowanceLabel.text = record.home_allowance ?? ""
            netAmountLabel.text = record.net_amount ?? ""
            accountNumberLabel.text = record.account_number ?? ""
            bankNameLabel.text = record.bankname ?? ""
            penaltyClauseFirstPartyLabel.text = record.penalty_clause_first_party ?? ""
            penaltyClauseSecondPartyLabel.text = record.penalty_clause_second_party ?? ""
            firstPartyLabel.text = record.first_party_user_name ?? ""
            secondPartyLabel.text = record.second_party_user_name ?? ""
        }
        
        if let addtionalAllowances = addtionalAllowances{
            addtionalAllowancesData = addtionalAllowances.records ?? []
            self.tableView.reloadData()
        }
        
        Timer.scheduledTimer(timeInterval: 0.5, target: self, selector: #selector(changePageControllerHeight), userInfo: nil, repeats: false)
    }
    

    @objc private func changePageControllerHeight(){
        NotificationCenter.default.post(name: .init(rawValue: "UpdatePageControllerHeight"), object: nil)
    }
    
}



extension ContractDataVC:UITableViewDelegate,UITableViewDataSource{
    private func setUpTableView(){
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(.init(nibName: "ContractDataTableViewCell", bundle: nil), forCellReuseIdentifier: "ContractDataTableViewCell")
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return addtionalAllowancesData.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ContractDataTableViewCell", for: indexPath) as! ContractDataTableViewCell
        cell.setDate(data: addtionalAllowancesData[indexPath.row])
        return cell
    }


}






