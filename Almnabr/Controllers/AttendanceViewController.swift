//
//  AttendanceViewController.swift
//  Almnabr
//
//  Created by Hany Alkahlout on 30/10/2022.
//  Copyright © 2022 Samar Akkila. All rights reserved.
//

import UIKit
import SCLAlertView
class AttendanceViewController: UIViewController {
    @IBOutlet weak var calenderUsersStackView: UIStackView!
    
    @IBOutlet weak var header: HeaderView!
    @IBOutlet weak var tableView: UITableView!
    
    @IBOutlet weak var groupsHeaderStackView: UIView!
    @IBOutlet weak var calenderHeaderStackView: UIView!
    
    
    @IBOutlet weak var groupsArrow: UIImageView!
    @IBOutlet weak var calenderArrow: UIImageView!
    
    @IBOutlet weak var groupContentStackView: UIStackView!
    @IBOutlet weak var calenderContentStackView: UIStackView!
    
    private var attendanceGroupsData = [AttendanceGroupsRecords]()
    private var pageNumber = 1
    private var totolPages = 1
    private let calenderView = CalenderView(frame: .init())
    private let multiselectionUsersView = UsersSearchView(frame: .init())
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        initialization()
        // Do any additional setup after loading the view.
    }
    
    
    private func initialization(){
        setUpTableView()
        header.btnAction = menu_select
        groupsHeaderStackView.isUserInteractionEnabled = true
        groupsHeaderStackView.addTapGesture {
            self.openGroupsView()
            self.openCalenderView()
        }
        calenderHeaderStackView.isUserInteractionEnabled = true
        calenderHeaderStackView.addTapGesture {
            self.openCalenderView()
            self.openGroupsView()
        }
        addCalenderView()

    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        groupContentStackView.isHidden = false
        calenderContentStackView.isHidden = true
        
        calenderView.getCalenderData()
        getAttendanceGroups(isFromBottom: false)
    }
    
    private func addCalenderView(){
        
        calenderView.isForAllEmployee = true
        calenderView.delegate = self
        calenderContentStackView.addArrangedSubview(calenderView)
  
        multiselectionUsersView.selectionType = .multiSelection
        multiselectionUsersView.usersResult = { results in
            self.calenderView.users = results
            self.calenderView.getCalenderData()
        }
        calenderUsersStackView.insertArrangedSubview(multiselectionUsersView, at: 0)

    }
    
    private func openGroupsView(){
        self.groupContentStackView.isHidden = !self.groupContentStackView.isHidden
        self.groupsArrow.transform = .init(rotationAngle: self.groupContentStackView.isHidden ? 0 : .pi)
    }
    
    private func openCalenderView(){
        self.calenderContentStackView.isHidden = !self.calenderContentStackView.isHidden
        self.calenderArrow.transform = .init(rotationAngle: self.calenderContentStackView.isHidden ? 0 : .pi)
    }
    
    private func menu_select(){
        let language =  L102Language.currentAppleLanguage()
        if language == "ar"{
            panel?.openRight(animated: true)
        }else{
            panel?.openLeft(animated: true)
        }
    }
    
    
    @IBAction func updateStatusAction(_ sender: Any) {
        let vc = UpdateAttendanceStatusViewController()
        let nav = UINavigationController(rootViewController: vc)
        nav.modalPresentationStyle = .overCurrentContext
        nav.setNavigationBarHidden(true, animated: false)
        navigationController?.present(nav, animated: true)
    }
    
    @IBAction func showShiftsAction(_ sender: Any) {
        let vc = ShiftsAttendancesViewController()
        navigationController?.pushViewController(vc, animated: true)
    }
    
    @IBAction func updateShiftAction(_ sender: Any) {
        let vc = UpdateShiftViewController()
        navigationController?.pushViewController(vc, animated: true)
    }
    
    @IBAction func addGroupAction(_ sender: Any) {
        let vc:UpdateAttendanceGroupViewController = AppDelegate.HRSB.instanceVC()
        navigationController?.pushViewController(vc, animated: true)
    }
    
}


// MARK: - Calender View Delegate
extension AttendanceViewController:UICalenderViewDelegate{
    
    
    func weekRatioViolationAction(date:String,empNumber:String){
        let vc = WeekRatioViewController()
        vc.empNumber = empNumber
        vc.date = date
        let nav = UINavigationController(rootViewController: vc)
        nav.modalPresentationStyle = .overCurrentContext
        nav.setNavigationBarHidden(true, animated: false)
        self.navigationController?.present(nav, animated: true)
    }
    
    func monthRatioViolationAction(date:String,empNumber:String,empName:String){
        let vc = MonthRatioViewController()
        vc.empName = empName
        vc.empNumber = empNumber
        vc.date = date
        let nav = UINavigationController(rootViewController: vc)
        nav.modalPresentationStyle = .overCurrentContext
        nav.setNavigationBarHidden(true, animated: false)
        self.navigationController?.present(nav, animated: true)
    }
    
    func goToCreateViolationVC(isCreate:Bool,data:[ViolationRecords]){
        let vc = CreateViolationViewController()
        vc.isCreate = isCreate
        vc.data = data
        let nav = UINavigationController(rootViewController: vc)
        nav.setNavigationBarHidden(true, animated: false)
        nav.modalPresentationStyle = .overCurrentContext
        self.navigationController?.present(nav, animated: true)
    }
    
    
}


extension AttendanceViewController: UITableViewDelegate,UITableViewDataSource{
    private func setUpTableView(){
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(.init(nibName: "AttendanceTableViewCell", bundle: nil), forCellReuseIdentifier: "AttendanceTableViewCell")
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return attendanceGroupsData.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "AttendanceTableViewCell", for: indexPath) as! AttendanceTableViewCell
        let obj = attendanceGroupsData[indexPath.row]
        cell.setData(data:obj)
        cell.updateAction = {
            let vc:UpdateAttendanceGroupViewController = AppDelegate.HRSB.instanceVC()
            vc.data = obj
            self.navigationController?.pushViewController(vc, animated: true)
        }
        cell.deleteAction = {
            let alertVC = UIAlertController(title: "Are you sure?", message: "You won't be able to revert this!", preferredStyle: .alert)
            alertVC.addAction(.init(title: "Yes", style: .default,handler: { action in
                self.deleteAttendanceGroup(groupId: obj.group_id ?? "")
            }))
            alertVC.addAction(.init(title: "No", style: .cancel))
            self.present(alertVC, animated: true)
        }
        return cell
    }
    
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        if indexPath.row == attendanceGroupsData.count - 1 {
            if pageNumber < totolPages{
                pageNumber += 1
                getAttendanceGroups(isFromBottom: true)
            }
        }
    }
}

// MARK: - APIHandling
extension AttendanceViewController{
    private func getAttendanceGroups(isFromBottom:Bool){
        if !isFromBottom{
            pageNumber = 1
        }
        showLoadingActivity()
        APIController.shard.getAttendanceGroups(pageNumber: String(pageNumber)) { data in
            self.hideLoadingActivity()
            DispatchQueue.main.async {
                if let status = data.status , status{
                    self.totolPages = data.page?.total_pages ?? 1
                    if isFromBottom{
                        self.attendanceGroupsData.append(contentsOf: data.records ?? [])
                    }else{
                        self.attendanceGroupsData = data.records ?? []
                    }
                }else{
                    self.attendanceGroupsData.removeAll()
                }
                self.tableView.reloadData()
            }
        }
    }
    
    private func deleteAttendanceGroup(groupId:String){
        showLoadingActivity()
        APIController.shard.deleteAttendanceGroupsData(groupId: groupId) { data in
            DispatchQueue.main.async {
                self.hideLoadingActivity()
                if let status = data.status,status{
                    SCLAlertView().showSuccess("Success".localized(), subTitle: data.msg ?? "")
                    self.getAttendanceGroups(isFromBottom: false)
                }else{
                    SCLAlertView().showError("error".localized(), subTitle: data.error ?? "")
                }
            }
        }
    }
}
