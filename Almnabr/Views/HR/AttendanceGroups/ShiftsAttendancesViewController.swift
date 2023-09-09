//
//  ShiftsAttendancesViewController.swift
//  Almnabr
//
//  Created by Hany Alkahlout on 02/11/2022.
//  Copyright © 2022 Samar Akkila. All rights reserved.
//

import UIKit
import SCLAlertView
class ShiftsAttendancesViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    private var data = [ShiftsRecords]()
    
    private var pageNumber = 1
    private var totalPages = 1
    override func viewDidLoad() {
        super.viewDidLoad()
        initlization()
        // Do any additional setup after loading the view.
    }
    
    private func initlization(){
        setUpTableView()
        NotificationCenter.default.addObserver(forName: .init("UpdateShiftsGroups"), object: nil, queue: .main) { notify in
            self.getShiftsAttendance(isFromBottom: false)
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(false, animated: true)
        addNavigationBarTitle(navigationTitle: "Shifts")
        getShiftsAttendance(isFromBottom: false)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        navigationController?.setNavigationBarHidden(true, animated: true)
    }
    
    @IBAction func addShiftAction(_ sender: Any) {
        let vc = AddShiftViewController()
        let nav = UINavigationController(rootViewController: vc)
        nav.modalPresentationStyle = .overCurrentContext
        navigationController?.present(nav, animated: true)
    }
    
    
}
extension ShiftsAttendancesViewController:UITableViewDelegate,UITableViewDataSource{
    private func setUpTableView(){
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(.init(nibName: "ShiftsTableViewCell", bundle: nil), forCellReuseIdentifier: "ShiftsTableViewCell")
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return data.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ShiftsTableViewCell", for: indexPath) as! ShiftsTableViewCell
        let objc = data[indexPath.row]
        cell.setData(data: objc)
        cell.editAction = {
            let vc = AddShiftViewController()
            vc.data = objc
            let nav = UINavigationController(rootViewController: vc)
            nav.modalPresentationStyle = .overCurrentContext
            self.navigationController?.present(nav, animated: true)
        }
        
        cell.deleteAction = {
            self.deleteShiftGroups(index: indexPath.row , deleteId: objc.shift_id ?? "")
        }
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        if indexPath.row == data.count - 1 {
            if pageNumber < totalPages{
                pageNumber += 1
                self.getShiftsAttendance(isFromBottom: true)
            }
        }
    }
}

// MARK: - API Handling
extension ShiftsAttendancesViewController{
    private func getShiftsAttendance(isFromBottom:Bool){
        if !isFromBottom{
            pageNumber = 1
        }
        APIController.shard.getShiftsAttendance(pageNumber: String(pageNumber)) { data in
            if let status = data.status , status{
                if isFromBottom{
                    self.data.append(contentsOf: data.records ?? [])
                }else{
                    self.data = data.records ?? []
                }
            }else{
                SCLAlertView().showError("error".localized(), subTitle: data.error ?? "")
                self.data.removeAll()
            }
            self.tableView.reloadData()
        }
    }
    
    private func deleteShiftGroups(index:Int,deleteId:String){
        showLoadingActivity()
        APIController.shard.deleteShiftGroups(deleteId: deleteId) { data in
            DispatchQueue.main.async{
                self.hideLoadingActivity()
                if let status = data.status, status{
                    SCLAlertView().showSuccess("Success".localized(), subTitle: data.msg ?? "")
                    self.data.remove(at: index)
                    self.tableView.reloadData()
                }else{
                    SCLAlertView().showError("error".localized(), subTitle: data.error ?? "")
                }
            }
        }
    }
}
