//
//  JobApplicationVC.swift
//  Almnabr
//
//  Created by Hany Alkahlout on 06/12/2022.
//  Copyright © 2022 Samar Akkila. All rights reserved.
//

import UIKit
import SCLAlertView
import DropDown
class JobApplicationVC: UIViewController {

    
    
    @IBOutlet weak var headerView: HeaderView!
    @IBOutlet weak var jobAppContentStackView: UIStackView!
    @IBOutlet weak var jobAppHeaderStackView: UIStackView!
    @IBOutlet weak var filterTextField: UITextField!
    @IBOutlet weak var filterArrow: UIImageView!
    @IBOutlet weak var searchTextField: UITextField!
    @IBOutlet weak var tableView: UITableView!
    private var dropDown = DropDown()
    private var data = [JobAppRecord]()
    private var pageNumber = 1
    private var totalPages = 1
    private var selectedStatus = "ALL"
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        initlization()
        // Do any additional setup after loading the view.
    }
    
    private func initlization(){
        setUpTableView()
        headerView.btnAction = menu_select
        searchTextField.addTarget(self, action: #selector(searchAction), for: .editingChanged)
        filterTextField.isUserInteractionEnabled = true
        filterTextField.addTapGesture {
            self.filterArrow.transform = .init(rotationAngle: .pi)
            self.dropDown.show()
        }
        setUpDropDownList()
        
    }
    
    
    
    private func setUpDropDownList(){
        // Filter Drop Down
        dropDown.anchorView = filterTextField
        
        dropDown.bottomOffset = CGPoint(x: 0 , y:(dropDown.anchorView?.plainView.bounds.height)!)
        dropDown.dataSource = ["All","Pending","Rejected","Waiting"]
        
        dropDown.selectionAction = { [unowned self] (index: Int, item: String) in
            self.filterArrow.transform = .init(rotationAngle: 0)
            filterTextField.text = item
            self.selectedStatus = index == 0 ? "ALL" : "\(index + 1)"
            self.getJobAppData(isFromBottom: false)
        }
        
        dropDown.cancelAction = { [unowned self] in
            self.filterArrow.transform = .init(rotationAngle: 0)
        }

    }
    
    private func menu_select(){
        let language =  L102Language.currentAppleLanguage()
        if language == "ar"{
            panel?.openRight(animated: true)
        }else{
            panel?.openLeft(animated: true)
        }
    }
    
    
    @objc private func searchAction(){
        getJobAppData(isFromBottom: false)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        getJobAppData(isFromBottom: false)
    }
    
    
}



extension JobApplicationVC: UITableViewDelegate , UITableViewDataSource{
    
    private func setUpTableView(){
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(.init(nibName: "JopAppTableViewCell", bundle: nil), forCellReuseIdentifier: "JopAppTableViewCell")
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return data.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "JopAppTableViewCell", for: indexPath) as! JopAppTableViewCell
        let obj = data[indexPath.row]
        cell.setData(data: obj)
        cell.didClickOnDelete = {
            let alertController = UIAlertController(title: "Confirmation", message: "Are you sure !?", preferredStyle: .alert)
            alertController.addAction(.init(title: "Yes", style: .default,handler: { action in
                // Delete Action
                self.deleteJobAppRecord(id: obj.employee_number ?? "")
            }))
            alertController.addAction(.init(title: "Cancel", style: .cancel))
            self.present(alertController, animated: true)
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        if indexPath.row == data.count - 1{
            if pageNumber < totalPages{
                pageNumber += 1
                getJobAppData(isFromBottom:true)
            }
        }
    }
    
    
}



// MARK:- API Handling
extension JobApplicationVC{
    private func getJobAppData(isFromBottom:Bool){
        let body: [String:Any] = [
                "searchKey":searchTextField.text!,
                "searchStatus":selectedStatus
        ]
        if !isFromBottom{
            pageNumber = 1
        }
        showLoadingActivity()
        APIController.shard.getJobAppData(pageNumber: String(pageNumber), body: body) { data in
            DispatchQueue.main.async {
                self.hideLoadingActivity()
                if let status = data.status,status{
                    if isFromBottom{
                        self.data.append(contentsOf: data.records ?? [])
                    }else{
                        self.data = data.records ?? []
                    }
                    self.totalPages = data.page?.total_pages ?? 1
                }else{
                    self.data.removeAll()
                }
                self.tableView.reloadData()
            }
        }
    }
    
    private func deleteJobAppRecord(id:String){
        APIController.shard.deleteJobAppRecord(userId: id) { data in
            if let status = data.status,status{
                self.getJobAppData(isFromBottom: false)
            }else{
                SCLAlertView().showError("error".localized(), subTitle: data.error ?? "There is an unknown error!")
            }
        }
    }
}
