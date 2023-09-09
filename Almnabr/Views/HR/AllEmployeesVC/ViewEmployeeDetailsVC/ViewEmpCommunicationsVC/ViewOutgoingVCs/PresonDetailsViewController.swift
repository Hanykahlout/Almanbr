//
//  PresonDetailsViewController.swift
//  Almnabr
//
//  Created by Hany Alkahlout on 26/06/2022.
//  Copyright © 2022 Samar Akkila. All rights reserved.
//

import UIKit

class PresonDetailsViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    private var data = [TransactionsPersons]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        initlization()
    }

    private func initlization(){
        self.data = ViewOutgoingViewController.data?.transactions_persons?.records ?? []
        setUpTableView()
    }
    
    
}

extension PresonDetailsViewController:UITableViewDelegate,UITableViewDataSource{
    private func setUpTableView(){
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(.init(nibName: "PersonDetailsTableViewCell", bundle: nil), forCellReuseIdentifier: "PersonDetailsTableViewCell")
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return data.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "PersonDetailsTableViewCell", for: indexPath) as! PersonDetailsTableViewCell
        cell.setData(data: data[indexPath.row])
        return cell
    }
}
