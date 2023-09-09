//
//  TopCountRequestsViewController.swift
//  Almnabr
//
//  Created by Hany Alkahlout on 11/10/2022.
//  Copyright © 2022 Samar Akkila. All rights reserved.
//

import UIKit

class TopCountRequestsViewController: UIViewController {
    @IBOutlet weak var limitTextField: UITextField!
    @IBOutlet weak var tableView: UITableView!
    var projects_work_area_id = ""
    
    private var data = [TopCountRequestsRecords]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        initlization()
        // Do any additional setup after loading the view.
    }
    
    private func initlization(){
        setUpTableView()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        self.navigationController?.setNavigationBarHidden(false, animated: true)
        addNavigationBarTitle(navigationTitle: "Top Count Requests")
        limitTextField.text = "10"
        getTopCountRequests()
    }
    
    @IBAction func searchAction(_ sender: Any) {
        getTopCountRequests()
    }
    
    
}

extension TopCountRequestsViewController:UITableViewDelegate,UITableViewDataSource{
    private func setUpTableView(){
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(.init(nibName: "TopCountRequestsTableViewCell", bundle: nil), forCellReuseIdentifier: "TopCountRequestsTableViewCell")
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return data.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "TopCountRequestsTableViewCell", for: indexPath) as! TopCountRequestsTableViewCell
        cell.setData(index: indexPath.row, data: data[indexPath.row])
        return cell
    }
    
    
    
}
// MARK: - API Handling
extension TopCountRequestsViewController{
    private func getTopCountRequests(){
        showLoadingActivity()
        APIController.shard.getTopCountRequests(projects_work_area_id: projects_work_area_id, limit: limitTextField.text!) { data in
            self.hideLoadingActivity()
            if let status = data.status , status{
                self.data = data.records ?? []
            }else{
                self.data.removeAll()
            }
            self.tableView.reloadData()
        }
    }
        
    
    
    
}


