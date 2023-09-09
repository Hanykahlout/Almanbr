//
//  CostCenterViewController.swift
//  Almnabr
//
//  Created by Hany Alkahlout on 08/01/2023.
//  Copyright © 2023 Samar Akkila. All rights reserved.
//

import UIKit
import SCLAlertView
class CostCenterViewController: UIViewController {
    
    @IBOutlet weak var mainStackView: UIStackView!
    @IBOutlet weak var headerView: HeaderView!
    @IBOutlet weak var searchTextField: UITextField!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var emptyDataImageView: UIImageView!
    
    private var branchSelectionView: BranchSelection!
    private var selectedBranchId = ""
    var data = [CostCentersRecord]()
    private var temp = [CostCentersRecord]()
    private let refreshControl = UIRefreshControl()
    private var observer:NSObjectProtocol?
    var isChild = false
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        initialization()
        // Do any additional setup after loading the view.
    }
    
    private func initialization(){
        handleHeaderView()
        setUpTableView()
        branchSelectionView = BranchSelection(frame: .init())
        branchSelectionView.withFinancialYearSelection = false
        branchSelectionView.branchSelectionAction = { value in
            self.selectedBranchId = value
            self.getCostCentersData()
        }
        mainStackView.insertArrangedSubview(branchSelectionView, at: 0)
        searchTextField.addTarget(self, action: #selector(searchAction), for: .editingChanged)
        refreshControl.addTarget(self, action: #selector(refresh), for: .valueChanged)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.navigationBar.tintColor = maincolor
        if !isChild{
            getCostCentersData()
            headerView.isHidden = false
            navigationController?.setNavigationBarHidden(true, animated: true)
        }else{
            headerView.isHidden = true
            navigationController?.setNavigationBarHidden(false, animated: true)
            
            searchTextField.isHidden = true
            branchSelectionView.isHidden = true
        }
        observer = NotificationCenter.default.addObserver(forName: .init("ReloadCostCenters"), object: nil, queue: .main) { notify in
            guard let object = (notify.object) as? (CostCentersRecord,Int) else {return}
            self.data[object.1] = object.0
            self.tableView.reloadRows(at: [IndexPath.init(row: object.1, section: 0)], with: .automatic)
        }
    }
    
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
            NotificationCenter.default.removeObserver(observer!)
    }
    
    
    private func handleHeaderView(){
        
        headerView.btnAction = {
            let language =  L102Language.currentAppleLanguage()
            if language == "ar"{
                self.panel?.openRight(animated: true)
            }else{
                self.panel?.openLeft(animated: true)
            }
        }
    }
    
    @objc private func searchAction(){
        if searchTextField.text! == ""{
            data = temp
        }else{
            if data.isEmpty{
                data = temp
            }
            data = data.filter{($0.name ?? "").hasPrefix(searchTextField.text!)}
            
        }
        tableView.reloadData()
    }
    
    @objc private func refresh(){
        getCostCentersData()
    }
    
    
}

extension CostCenterViewController:UITableViewDelegate,UITableViewDataSource{
    private func setUpTableView(){
        tableView.refreshControl = refreshControl
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(.init(nibName: "CostCenterTableViewCell", bundle: nil), forCellReuseIdentifier: "CostCenterTableViewCell")
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return data.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "CostCenterTableViewCell", for: indexPath) as! CostCenterTableViewCell
        let data = data[indexPath.row]
        cell.setData(data: data)
        let isSupportSub = data.cost_center_sub ?? "" == "1"
        cell.addButton.isHidden = !isSupportSub
        cell.deletButton.isHidden = isSupportSub
        
        cell.addCostCenterAction = { [weak self] in
            self?.goToAddCostCenterVC(data:data,isAdd: true,index: indexPath.row)
        }
        
        cell.editCostCenterAction = { [weak self] in
            self?.goToAddCostCenterVC(data:data,isAdd: false,index: indexPath.row)
        }
        
        cell.deleteCostCenterAction = {[weak self] in
            let alertVC = UIAlertController(title:"Confirmation !!!".localized() , message: "Are you sure !?".localized(), preferredStyle: .alert)
            alertVC.addAction(.init(title: "Yes", style: .default,handler: { [weak self] action in
                self?.deleteCostCentersData(record_id: data.cost_center_id ?? "")
            }))
            alertVC.addAction(.init(title: "No", style: .default))
            self?.present(alertVC, animated: true)
        }
        
        cell.branchesButtonAction = { [weak self] in
            let vc = CostCenterViewController()
            vc.isChild = true
            vc.data = data.children ?? []
            self?.navigationController?.pushViewController(vc, animated: true)
        }
        return cell
    }
    
    private func goToAddCostCenterVC(data:CostCentersRecord,isAdd:Bool,index:Int){
        let vc = AddCostCenterViewController()
        vc.data = data
        vc.isAdd = isAdd
        vc.index = index
        let nav = UINavigationController(rootViewController: vc)
        nav.modalPresentationStyle = .overCurrentContext
        nav.isNavigationBarHidden = true
        navigationController?.present(nav, animated: true)
    }
}


// MARK: - API Handling
extension CostCenterViewController{
    private func getCostCentersData(){
        showLoadingActivity()
        APIController.shard.getCostCentersData(branch_id: selectedBranchId) { data in
            DispatchQueue.main.async {
                self.hideLoadingActivity()
                if let status = data.status,status{
                    self.data = data.records ?? []
                    self.temp = data.records ?? []
                }else{
                    self.data.removeAll()
                }
                self.emptyDataImageView.isHidden = !self.data.isEmpty
                self.tableView.reloadData()
                if self.refreshControl.isRefreshing{
                    self.refreshControl.endRefreshing()
                }
            }
        }
    }
    
    private func deleteCostCentersData(record_id:String){
        showLoadingActivity()
        APIController.shard.deleteCostCenters(branch_id: selectedBranchId,record_id:record_id) { [weak self ] data in
            DispatchQueue.main.async {
                self?.hideLoadingActivity()
                if let status = data.status,status{
                    SCLAlertView().showSuccess("Success".localized(), subTitle: data.msg ?? "")
                    self?.getCostCentersData()
                }else{
                    SCLAlertView().showError("error".localized(), subTitle: data.error ?? "There is an unknow error!!")
                }
            }
        }
    }
}





