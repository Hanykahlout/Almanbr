//
//  WeekRatioViewController.swift
//  Almnabr
//
//  Created by Hany Alkahlout on 27/10/2022.
//  Copyright © 2022 Samar Akkila. All rights reserved.
//

import UIKit

class WeekRatioViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    
    private var data = [RatioWeekData]()
    var date = ""
    var empNumber = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        initialization()
    }
    
    
    private func initialization(){
        setUpTableView()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        ratioWeekViolation()
    }

    
    @IBAction func closeAction(_ sender: Any) {
        navigationController?.dismiss(animated: true)
    }
    
    
}

extension WeekRatioViewController:UITableViewDelegate,UITableViewDataSource{
    private func setUpTableView(){
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(.init(nibName: "WeekRatioTableViewCell", bundle: nil), forCellReuseIdentifier: "WeekRatioTableViewCell")
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return data.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "WeekRatioTableViewCell", for: indexPath) as! WeekRatioTableViewCell
        cell.setData(data: data[indexPath.row])
        return cell
    }
    
}
//MARK: - API Handling
extension WeekRatioViewController{
    private func ratioWeekViolation(){
        let body = [
            "date": date,
            "employee_number": empNumber
            ]
        showLoadingActivity()
        APIController.shard.ratioWeekViolation(body: body) { data in
            self.hideLoadingActivity()
            if let status = data.status , status{
                DispatchQueue.main.async {
                    self.data = data.data ?? []
                    self.tableView.reloadData()
                }
            }
        }
    }
}
