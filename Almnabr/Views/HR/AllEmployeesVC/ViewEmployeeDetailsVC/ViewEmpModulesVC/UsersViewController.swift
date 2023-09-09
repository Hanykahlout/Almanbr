//
//  UsersViewController.swift
//  Almnabr
//
//  Created by Hany Alkahlout on 26/06/2022.
//  Copyright © 2022 Samar Akkila. All rights reserved.
//

import UIKit
class UsersViewController: UIViewController {

    @IBOutlet weak var emptyDataImageView: UIImageView!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var backButton: UIButton!
    private var data = [ModuleUersRecords]()
    var module:AllModulesRecords?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        initlziation()
        // Do any additional setup after loading the view.
    }
    
    private func initlziation(){
        if L102Language.currentAppleLanguage() == "ar"{
            backButton.transform = .init(rotationAngle: .pi)
        }
        setUpTableView()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        if let module = module {
            var body:[String:Any] = [:]
            body["mention_id"] = module.mention_id ?? ""
            body["branch_id"] = module.branch_id ?? ""
            body["user_id"] = module.user_id ?? ""
            body["user_type_id"] = module.user_type_id ?? ""
            body["module_key"] = module.module_key ?? ""
            body["permission_key"] = module.permission_key ?? ""
            body["private_key"] = module.private_key ?? ""
            body["private_value"] = module.private_value ?? ""
            body["group_key"] = module.group_key ?? ""
            body["create_by_user_id"] = module.create_by_user_id ?? ""
            body["create_date"] = module.create_date ?? ""
            body["modulename"] = module.modulename ?? ""
            body["writer"] = module.writer ?? ""
            self.getModuleUsers(body: body)
        }
        
    }

    
    
    @IBAction func backAction(_ sender: Any) {
        navigationController?.popViewController(animated: true)
    }
    
}

extension UsersViewController:UITableViewDelegate,UITableViewDataSource{
    private func setUpTableView(){
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(.init(nibName: "UserTableViewCell", bundle: nil), forCellReuseIdentifier: "UserTableViewCell")
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return data.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "UserTableViewCell", for: indexPath) as! UserTableViewCell
        cell.setData(data: data[indexPath.row])
        return cell
    }
}

// MARK: - API Handling

extension UsersViewController{
    private func getModuleUsers(body:[String:Any]){
        showLoadingActivity()
        APIController.shard.getModuleUers(body: body) { data in
            DispatchQueue.main.async {
                self.hideLoadingActivity()
                if let status = data.status , status{
                    self.data = data.records ?? []
                    self.emptyDataImageView.isHidden = !self.data.isEmpty
                }else{
                    self.emptyDataImageView.isHidden = false
                    self.data.removeAll()
                }
                self.tableView.reloadData()
            }
        }
    }
    
    
}
