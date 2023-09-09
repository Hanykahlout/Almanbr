//
//  PayRoleViewController.swift
//  Almnabr
//
//  Created by Hany Alkahlout on 22/11/2022.
//  Copyright © 2022 Samar Akkila. All rights reserved.
//

import UIKit

class PayRoleViewController: UIViewController {

    @IBOutlet weak var headerView: HeaderView!
    @IBOutlet weak var tableView: UITableView!
    private var data = [PayRoleData]()
    private var pageNumber = 1
    private var totalPages = 1
    
    override func viewDidLoad() {
        super.viewDidLoad()
        initization()
        // Do any additional setup after loading the view.
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        getPayRoleData(isFromBottom: false)
    }
    private func initization(){
        setUpTableView()
        headerView.btnAction = menu_select
    }
    
    private func menu_select(){
        let language =  L102Language.currentAppleLanguage()
        if language == "ar"{
            panel?.openRight(animated: true)
        }else{
            panel?.openLeft(animated: true)
        }
    }
    
    @IBAction func reviewersAction(_ sender: Any) {
        let vc = PayRoleReviewersViewController()
        navigationController?.pushViewController(vc, animated: true)
    }
    
    
    
}

extension PayRoleViewController: UITableViewDelegate , UITableViewDataSource{
    private func setUpTableView(){
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(.init(nibName: "PayRoleTableViewCell", bundle: nil), forCellReuseIdentifier: "PayRoleTableViewCell")
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return data.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "PayRoleTableViewCell", for: indexPath) as! PayRoleTableViewCell
        cell.setData(data:data[indexPath.row])
        return cell
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        if indexPath.row == data.count - 1{
            if pageNumber < totalPages{
                pageNumber += 1
                getPayRoleData(isFromBottom: true)
            }
        }
    }
    
}
// MARK: - API Handling
extension PayRoleViewController{
    private func getPayRoleData(isFromBottom:Bool){
        if !isFromBottom{
            pageNumber = 1
        }
        showLoadingActivity()
        APIController.shard.getPayRoleData(pageNumber: String(pageNumber)) { data in
            DispatchQueue.main.async {
                self.hideLoadingActivity()
                if let status = data.status , status{
                    if isFromBottom{
                        self.data.append(contentsOf: data.data ?? [])
                    }else{
                        self.data = data.data ?? []
                    }
                    self.totalPages = data.page?.total_pages ?? 1
                }else{
                    self.data.removeAll()
                    let alertVC = UIAlertController(title: "error".localized(), message: data.error ?? "" , preferredStyle: .alert)
                    alertVC.addAction(.init(title: "Cancel", style: .cancel))
                    self.present(alertVC, animated: true)
                }
                self.tableView.reloadData()
            }
        }
    }
}
