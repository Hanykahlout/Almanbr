//
//  UsedUnusedReportViewController.swift
//  Almnabr
//
//  Created by Hany Alkahlout on 11/10/2022.
//  Copyright © 2022 Samar Akkila. All rights reserved.
//

import UIKit

class UsedUnusedReportViewController: UIViewController {


    @IBOutlet weak var totalOkLabel: UILabel!
    @IBOutlet weak var totalNotUsedLabel: UILabel!
    
    @IBOutlet weak var totalNotOkLabel: UILabel!
   
    @IBOutlet weak var consultantLateLabel: UILabel!
    @IBOutlet weak var contractorLateLabel: UILabel!
    
    var projects_work_area_id = ""
    private var headers = [UsedUnusedReportTableHeaders]()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        initlization()
        
    }
    private func initlization(){

    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        self.navigationController?.setNavigationBarHidden(false, animated: true)
        addNavigationBarTitle(navigationTitle: "Used Unused Report")
        getUsedUnusedReportData()
        getLateContractCount()
    }
    
}




// MARK: - API Handling

extension UsedUnusedReportViewController {
    private func getUsedUnusedReportData(){
        let body = [
            "projects_work_area_id": projects_work_area_id,
            "template_id": "",
            "zone_id": "",
            "block_id": "",
            "cluster_id": "",
            "unit_id": "",
            "group_1": "",
            "from_trigger":"1",
            "export": ""
        ]
        showLoadingActivity()
        APIController.shard.getUsedUnusedReport(body: body, limit: "10") { data in
            self.hideLoadingActivity()
            if let status = data.status,status{
                self.headers = data.table_headers ?? []
                self.totalOkLabel.text = data.totals?.first?.total_requests ?? ""
                self.totalNotUsedLabel.text = data.totals?[1].total_requests ?? ""
                self.totalNotOkLabel.text = data.totals?[2].total_requests ?? ""
                
            }
        }
    }
    
    
    private func getLateContractCount(){
        showLoadingActivity()
        APIController.shard.getLateContractCount(projects_work_area_id: projects_work_area_id) { data in
            if let status = data.status , status{
                self.consultantLateLabel.text = data.data?.late_supervision ?? ""
                self.contractorLateLabel.text = data.data?.late_contractor ?? ""
            }
        }
    }
    
}

