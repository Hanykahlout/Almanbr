//
//  PermissionViewController.swift
//  Almnabr
//
//  Created by Hany Alkahlout on 02/06/2022.
//  Copyright © 2022 Samar Akkila. All rights reserved.
//

import UIKit
import DropDown
class SettingViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var selectedFilterLabel: UILabel!
    @IBOutlet weak var filterView: UIView!
    @IBOutlet weak var searchTextField: UITextField!
    @IBOutlet weak var filterArrow: UIImageView!
    @IBOutlet weak var filterStackView: UIStackView!
    @IBOutlet weak var messageLabel: UILabel!
    
    
    private var filterDropDown = DropDown()
    private var data = [SettingsDataRecords]()
    private var refrechContrl = UIRefreshControl()
    private var pageNumber = 1
    private var totalPages:Int?
    private var seletedFitlerType = ""
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        initlization()
        // Do any additional setup after loading the view.
    }
    
    private func initlization(){
        setUpTableView()
        setUpViews()
        setUpDropDown()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        getSettingsData(isNewPage: false)
    }
    
    private func setUpViews(){
        refrechContrl.addTarget(self, action: #selector(refrech), for: .valueChanged)
        
        filterView.isUserInteractionEnabled = true
        filterView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(filterAction)))
        
        searchTextField.isUserInteractionEnabled = true
        searchTextField.addTarget(self, action: #selector(searchAction), for: .editingChanged)
    }
    
    
    private func setUpDropDown(){
        filterDropDown.anchorView = filterView
        filterDropDown.dataSource = ["All".localized(),"Bank Name".localized(), "Employee Title".localized(), "Job Positions".localized()]
        filterDropDown.bottomOffset = CGPoint(x: 0, y:(filterDropDown.anchorView?.plainView.bounds.height)!)
        filterDropDown.width = filterStackView.bounds.width
        
        filterDropDown.selectionAction = { [unowned self] (index: Int, item: String) in
            filterArrow.transform = .init(rotationAngle: 0)
            selectedFilterLabel.text = item
            self.seletedFitlerType = self.getType(title: item)
            self.getSettingsData(isNewPage: false)
        }
        
        filterDropDown.cancelAction = { [unowned self] in
            filterArrow.transform = .init(rotationAngle: 0)
        }
        
    }
    
    
    private func getType(title:String)->String{
        switch title{
        case "Bank Name".localized():
            return "BANK"
        case "All".localized():
            return "ALL"
        case "Employee Title".localized():
            return "ETIT"
        case "Job Positions".localized():
            return "JTIT"
        default:
            break
        }
        return ""
    }
    
    
    @objc private func refrech(){
        getSettingsData(isNewPage: false)
    }
    
    
    @objc private func filterAction(){
        filterDropDown.show()
        filterArrow.transform = .init(rotationAngle: .pi)
    }
    
    @objc private func searchAction(){
        getSettingsData(isNewPage: false)
    }
    
    
    
}

extension SettingViewController:UITableViewDelegate,UITableViewDataSource{
    private func setUpTableView(){
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(.init(nibName: "Settings2TableViewCell", bundle: nil), forCellReuseIdentifier: "Settings2TableViewCell")
        tableView.refreshControl = refrechContrl
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return data.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Settings2TableViewCell", for: indexPath) as! Settings2TableViewCell
        
        cell.setData(data: data[indexPath.row],indexPath:indexPath)
        cell.delegate = self
        return cell
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        if indexPath.row == data.count - 1{
            if let totalPages = totalPages{
                if totalPages > pageNumber{
                    pageNumber = pageNumber + 1
                    getSettingsData(isNewPage:true)
                }
            }
        }
    }
    
}

// MARK: - API Handling

extension SettingViewController{
    private func getSettingsData(isNewPage:Bool){
        if !isNewPage{
            pageNumber = 1
        }
        showLoadingActivity()
        APIController.shard.getSettingsData(pageNumber:String(pageNumber),searchType: seletedFitlerType, searchKey: searchTextField.text!) { data in
            DispatchQueue.main.async {
                if self.refrechContrl.isRefreshing{
                    self.refrechContrl.endRefreshing()
                }
                self.hideLoadingActivity()
                self.messageLabel.isHidden = true
                if let status = data.status , status{
                    
                    self.totalPages = data.page?.total_pages
                    if isNewPage{
                        self.data.append(contentsOf: data.records ?? [])
                    }else{
                        self.data = data.records ?? []
                    }
                    self.tableView.reloadData()
                    
                }else{
                    self.messageLabel.text = data.error ?? ""
                    self.messageLabel.isHidden = false
                    self.data.removeAll()
                    self.tableView.reloadData()
                }
            }
        }
    }
}


extension SettingViewController:Settings2TableViewCellDelegate{
    func deleteAction(indexPath:IndexPath) {
        APIController.shard.deleteSettingsData(id: data[indexPath.row].settings_id ?? "") { data in
            if let status = data.status{
                if status{
                    let alertVC = UIAlertController(title: "Success".localized(), message: data.msg ?? "", preferredStyle: .alert)
                    alertVC.addAction(.init(title: "Cancel".localized(), style: .cancel,handler: { action in
                        self.data.remove(at: indexPath.row)
                        self.tableView.reloadData()
                    }))
                    self.present(alertVC, animated: true)
                }else{
                    let alertVC = UIAlertController(title: "error".localized(), message: data.error ?? "", preferredStyle: .alert)
                    alertVC.addAction(.init(title: "Cancel".localized(), style: .cancel))
                    self.present(alertVC, animated: true)
                }
            }
        }
    }
    
    func goToUpdateVC(data: SettingsDataRecords) {
        let vc = SettingsUpdateViewController()
        vc.isUpdate = true
    
        vc.data = data
        navigationController?.pushViewController(vc, animated: true)
    }
    
    func goToSettingsAlert(data:SettingsDataRecords) {
        let vc = SettingsAlertViewController()
        vc.data = data
        let nav = UINavigationController(rootViewController: vc)
        nav.modalPresentationStyle = .overCurrentContext
        navigationController?.present(nav, animated: true)
    }
    
    
}
