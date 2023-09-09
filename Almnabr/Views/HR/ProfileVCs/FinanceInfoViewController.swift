//
//  FinanceInfoViewController.swift
//  Almnabr
//
//  Created by Hany Alkahlout on 19/07/2022.
//  Copyright © 2022 Samar Akkila. All rights reserved.
//

import UIKit

class FinanceInfoViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    var data = [Finance]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        initlization()
        // Do any additional setup after loading the view.
    }

    private func initlization(){
        addNavigationBarTitle(navigationTitle: "Finance Information")
        navigationController?.navigationBar.barTintColor = maincolor
        setUpTableView()
    }
        
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(false, animated: true)
        
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        navigationController?.setNavigationBarHidden(true, animated: true)
        
    }

    
}

extension FinanceInfoViewController:UITableViewDelegate,UITableViewDataSource{
    private func setUpTableView(){
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(UINib(nibName: "FinanceInfoTableViewCell", bundle: nil), forCellReuseIdentifier: "FinanceInfoTableViewCell")
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return data.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "FinanceInfoTableViewCell", for: indexPath) as! FinanceInfoTableViewCell
        cell.setData(data: data[indexPath.row])
        return cell
    }
    
}
