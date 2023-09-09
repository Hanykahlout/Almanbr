//
//  SettingsViewController.swift
//  Almnabr
//
//  Created by Hany Alkahlout on 08/11/2022.
//  Copyright © 2022 Samar Akkila. All rights reserved.
//

import UIKit

class SettingsViewController: UIViewController {
    
    @IBOutlet weak var headerView: HeaderView!
    
    @IBOutlet weak var tableView: UITableView!
    
    private var data = [String]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        initialization()
        // Do any additional setup after loading the view.
    }
    
    private func initialization(){
        headerView.btnAction = self.menu_select
        setUpTableView()
        data.append("Change Password")
    }
    
    
    func menu_select(){
        let language =  L102Language.currentAppleLanguage()
        if language == "ar"{
            panel?.openRight(animated: true)
        }else{
            panel?.openLeft(animated: true)
        }
    }
    
    
}

extension SettingsViewController:UITableViewDelegate,UITableViewDataSource{
    private func setUpTableView(){
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(.init(nibName: "MenuSettingsTableViewCell", bundle: nil), forCellReuseIdentifier: "MenuSettingsTableViewCell")
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return data.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "MenuSettingsTableViewCell", for: indexPath) as! MenuSettingsTableViewCell
        cell.titleLabel.text = data[indexPath.row]
        return cell
    }
            
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        switch indexPath.row{
        case 0:
            let vc = ChangePasswordViewController()
            let nav = UINavigationController(rootViewController: vc)
            nav.isNavigationBarHidden = true
            nav.modalPresentationStyle = .overCurrentContext
            navigationController?.present(nav, animated: true)
        default:
            break
        }
    }
    
    
}
