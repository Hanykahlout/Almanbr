//
//  PayRoleReviewersViewController.swift
//  Almnabr
//
//  Created by Hany Alkahlout on 24/11/2022.
//  Copyright © 2022 Samar Akkila. All rights reserved.
//

import UIKit
import SCLAlertView
class PayRoleReviewersViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    private var data = [PayRoleReviewersRecord]()
    override func viewDidLoad() {
        super.viewDidLoad()
        initialization()
        // Do any additional setup after loading the view.
    }

    private func initialization(){
        setUpTableView()
        NotificationCenter.default.addObserver(forName: .init("ReloadPayRoleReviewers"), object: nil, queue: .main) { notify in
            self.getPayRoleReviewersData()
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        getPayRoleReviewersData()
        addNavigationBarTitle(navigationTitle: "Reviewers")
        navigationController?.setNavigationBarHidden(false, animated: true)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        navigationController?.setNavigationBarHidden(true, animated: true)
    }
    
    @IBAction func addReviewer(_ sender: Any) {
        let vc = AddReviewerViewController()
        
        let nav = UINavigationController(rootViewController: vc)
        nav.modalPresentationStyle = .overCurrentContext
        nav.isNavigationBarHidden = true
        navigationController?.present(nav, animated: true)
    }
    
    
}
// MARK: - UITable View Delegate and DataSource
extension PayRoleReviewersViewController: UITableViewDelegate , UITableViewDataSource{
    private func setUpTableView(){
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(.init(nibName: "PayRoleReviewersTableViewCell", bundle: nil), forCellReuseIdentifier: "PayRoleReviewersTableViewCell")
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return data.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "PayRoleReviewersTableViewCell", for: indexPath) as! PayRoleReviewersTableViewCell
        let obj = data[indexPath.row]
        cell.setData(data:obj)
        cell.didClickDeleteButton = {
            let alertVC = UIAlertController(title: "Are you sure !?", message: "", preferredStyle: .alert)
            alertVC.addAction(.init(title: "Yes", style: .default,handler: { action in
                self.deletePayRoleReviewers(userId: obj.user_id ?? "")
            }))
            alertVC.addAction(.init(title: "No", style: .default))
            self.present(alertVC, animated: true)
        }
        return cell
    }
        
}


// MARK: - API Handling
extension PayRoleReviewersViewController{
    private func getPayRoleReviewersData(){
        showLoadingActivity()
        APIController.shard.getPayRoleReviewersData { data in
            DispatchQueue.main.async {
                self.hideLoadingActivity()
                if let status = data.status,status{
                    self.data = data.records ?? []
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
    
    private func deletePayRoleReviewers(userId:String){
        showLoadingActivity()
        APIController.shard.deletePayRoleReviewers(userId: userId) { data in
            DispatchQueue.main.async {
                self.hideLoadingActivity()
                if let status = data.status,status{
                    SCLAlertView().showSuccess("Success".localized(), subTitle: data.msg ?? "")
                    self.getPayRoleReviewersData()
                }else{
                    SCLAlertView().showError("error".localized(), subTitle: data.error ?? "")
                }
            }
        }
        
    }
    
}
