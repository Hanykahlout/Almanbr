//
//  FinanialDetailsViewController.swift
//  Almnabr
//
//  Created by Hany Alkahlout on 27/11/2022.
//  Copyright © 2022 Samar Akkila. All rights reserved.
//

import UIKit
import SCLAlertView
import DropDown
class FinanialDetailsViewController: UIViewController {


    @IBOutlet weak var searchTextField: UITextField!
    @IBOutlet weak var typeTextField: UITextField!
    @IBOutlet weak var typeArrow: UIImageView!
    @IBOutlet weak var tableView: UITableView!
    
    private var data = [FinanialDetailsRecord]()
    private var pageNumber = 1
    private var totalPages = 1
    private var dropDown = DropDown()
    private var typesDataValues = ["all","deduct","bonus","loan","overtime"]
    private var typesDataLabels = ["All","Deduction","Bonus","Loan","Overtime"]
    private var selectTypeIndex = 0
    
    var profile_obj:ProfileObj?
    var isFromHR = false
    override func viewDidLoad() {
        super.viewDidLoad()
        initialization()
        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        getFinanialData(isFromBottm: false)
        if !isFromHR{
            addNavigationBarTitle(navigationTitle: "Finanial Details")
            navigationController?.setNavigationBarHidden(false, animated: true)
        }
    }
    
    private func initialization(){
        setUpTableView()
        setUpDropDownList()
        typeTextField.addTapGesture {
            self.typeArrow.transform = .init(rotationAngle: .pi)
            self.dropDown.show()
        }
        searchTextField.addTarget(self, action: #selector(searchAction), for: .editingChanged)
    }
    
    
    private func setUpDropDownList(){
        
        dropDown.anchorView = typeTextField
        dropDown.bottomOffset = CGPoint(x: 0, y:(dropDown.anchorView?.plainView.bounds.height)!)
        dropDown.dataSource = typesDataLabels
        
        dropDown.selectionAction = { [unowned self] (index: Int, item: String) in
            self.selectTypeIndex = index
            self.typeArrow.transform = .init(rotationAngle: 0)
            self.typeTextField.text = typesDataLabels[index]
            self.getFinanialData(isFromBottm: false)
        }
        
        dropDown.cancelAction = { [unowned self] in
            self.typeArrow.transform = .init(rotationAngle: 0)
        }
        
    }

    @objc private func searchAction(){
        getFinanialData(isFromBottm: false)
    }
    
}

// MARK: - Table View Delegate and Data Source
extension FinanialDetailsViewController:UITableViewDelegate , UITableViewDataSource{
    private func setUpTableView(){
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(.init(nibName: "FinanialDetailsTableViewCell", bundle: nil), forCellReuseIdentifier: "FinanialDetailsTableViewCell")
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return data.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "FinanialDetailsTableViewCell", for: indexPath) as! FinanialDetailsTableViewCell
        cell.setData(data: data[indexPath.row])
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        getPdfFile(path: data[indexPath.row].file_path ?? "")
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        if indexPath.row == data.count - 1{
            if pageNumber < totalPages{
                pageNumber += 1
                getFinanialData(isFromBottm: true)
            }
        }
    }
        
    
}
// MARK: - API Handling
extension FinanialDetailsViewController{
    private func getFinanialData(isFromBottm:Bool){
        if !isFromBottm{
            pageNumber = 1
        }
        
        let body:[String:Any] = [
            "finical_type":typesDataValues[selectTypeIndex],
            "search_value":searchTextField.text!,
            "employee_number":profile_obj?.employee_number ?? "",
        ]
        showLoadingActivity()
        APIController.shard.getFinanialDetailsData(pageNumber: String(pageNumber), body: body) { data in
            DispatchQueue.main.async {
                self.hideLoadingActivity()
                if let status = data.status,status{
                    if isFromBottm{
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
    
    private func getPdfFile(path:String){
        showLoadingActivity()
        APIController.shard.getImage(url: path) { data in
            DispatchQueue.main.async {
                self.hideLoadingActivity()
                if let status = data.status,status{
                    let vc = WebViewViewController()
                    vc.data = data
                    let nav = UINavigationController(rootViewController: vc)
                    self.navigationController?.present(nav, animated: true)
                }else{
                    SCLAlertView().showError("error".localized(), subTitle: data.error ?? "There is an unknown error!!")
                }
            }
        }
    }
    
    
    
}
