//
//  AccountHistoryViewController.swift
//  Almnabr
//
//  Created by Hany Alkahlout on 22/02/2023.
//  Copyright © 2023 Samar Akkila. All rights reserved.
//

import UIKit
import DropDown
import Fastis
class AccountHistoryViewController: UIViewController {
    
    @IBOutlet weak var logActionTextField: UITextField!
    @IBOutlet weak var logActionArrow: UIImageView!
    @IBOutlet weak var startEndDateTextField: UITextField!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var emptyDataImageView: UIImageView!
    
    private var logActionDropDown = DropDown()
    private var pageNumber = 1
    private var totalPages = 1
    private var data = [AccountHistoryRecord]()
    private var log_action = ""
    private var log_action_start_date = ""
    private var log_action_end_date = ""
    private let fastisController = FastisController(mode: .range)
    var id = ""
    var account_operation = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        logActionTextField.addTapGesture {
            self.logActionDropDown.show()
        }
        setUpDropDown()
        setUpTableView()
        setUpFastisController()
        startEndDateTextField.addTapGesture {
            self.fastisController.present(above: self)
        }
        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        navigationController?.setNavigationBarHidden(false, animated: true)
        addNavigationBarTitle(navigationTitle: "History")
        let cancelButton = UIButton(type: .system)
        cancelButton.setTitle("Cancel", for: .normal)
        cancelButton.setTitleColor(.white, for: .normal)
        cancelButton.addTarget(self, action: #selector(cancelAction), for: .touchUpInside)
        navigationItem.leftBarButtonItem = .init(customView:cancelButton)
        getAccountHistoryData(isFromBottom: false)
    }
    
    
    private func setUpDropDown(){
        //    logActionDropDown
        logActionDropDown.anchorView = logActionTextField
        logActionDropDown.bottomOffset = CGPoint(x: 0, y:(logActionDropDown.anchorView?.plainView.bounds.height)!)
        logActionDropDown.dataSource = ["Clear","Insert","Update","Delete"]
        logActionDropDown.selectionAction = { [unowned self] (index: Int, item: String) in
            logActionArrow.transform = .init(rotationAngle: 0)
            if index == 0 {
                self.log_action = ""
                logActionTextField.text = ""
            }else{
                self.log_action = item.lowercased()
                logActionTextField.text = item
            }
            getAccountHistoryData(isFromBottom: false)
        }
        
    }
    
    private func setUpFastisController(){
        fastisController.title = "Choose Date".localized()
        fastisController.allowToChooseNilDate = true
        fastisController.shortcuts = [.today]
        fastisController.doneHandler = { result in
            self.log_action_start_date = self.formatedDate(date: result?.fromDate)
            self.log_action_end_date = self.formatedDate(date: result?.toDate)
            self.startEndDateTextField.text = "\(self.log_action_start_date) - \(self.log_action_end_date)"

            self.getAccountHistoryData(isFromBottom: false)
        }
    }
    
    @objc private func cancelAction(){
        navigationController?.dismiss(animated: true)
    }
    
    
    @IBAction func clearAction(_ sender: Any) {
        log_action_start_date = ""
        log_action_end_date = ""
        log_action = ""
        logActionTextField.text = ""
        startEndDateTextField.text = ""
        self.getAccountHistoryData(isFromBottom: false)
    }
    
}
extension AccountHistoryViewController: UITableViewDelegate, UITableViewDataSource{
    private func setUpTableView(){
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(.init(nibName: "AccountHistoryTableViewCell", bundle: nil), forCellReuseIdentifier: "AccountHistoryTableViewCell")
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return data.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "AccountHistoryTableViewCell", for: indexPath) as! AccountHistoryTableViewCell
        cell.setData(data:data[indexPath.row])
        return cell
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        if indexPath.row == data.count - 1 {
            if pageNumber < totalPages{
                pageNumber += 1
                getAccountHistoryData(isFromBottom: true)
            }
        }
    }
}


extension AccountHistoryViewController{
    private func getAccountHistoryData(isFromBottom:Bool){
        let body = [
            "log_action":log_action,
            "account_operation":account_operation,
            "log_action_start_date":log_action_start_date,
            "log_action_end_date":log_action_end_date,
            "id":id
        ]
        if !isFromBottom{
            pageNumber = 1
        }
        showLoadingActivity()
        APIController.shard.getAccountHistory(body: body, pageNumber: String(pageNumber)) { data in
            DispatchQueue.main.async { [weak self] in
                self?.hideLoadingActivity()
                if data.status ?? false{
                    if isFromBottom{
                        self?.data.append(contentsOf: data.records ?? [])
                    }else{
                        self?.data = data.records ?? []
                    }
                }else{
                    if !isFromBottom{
                        self?.data.removeAll()
                    }
                }
                self?.tableView.reloadData()
                self?.emptyDataImageView.isHidden = !(self?.data.isEmpty ?? true)
                self?.totalPages = data.page?.total_pages ?? 1
            }
        }
    }
}

