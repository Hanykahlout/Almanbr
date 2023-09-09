//
//  InvoiceSettingsViewController.swift
//  Almnabr
//
//  Created by Hany Alkahlout on 03/01/2023.
//  Copyright © 2023 Samar Akkila. All rights reserved.
//

import UIKit
import DropDown
class InvoiceSettingsViewController: UIViewController {

    @IBOutlet weak var filterTextField: UITextField!
    @IBOutlet weak var filterArrow: UIImageView!
    
    @IBOutlet weak var searchTextField: UITextField!
    @IBOutlet weak var emptyDataImageView: UIImageView!
    @IBOutlet weak var tableView: UITableView!
    private var invoice_type = ""
    private var invoice_typeDropDown = DropDown()
    private var data = [InvoiceSettingsRecord]()
    private var observer:NSObjectProtocol?
    override func viewDidLoad() {
        super.viewDidLoad()
        initialization()
        // Do any additional setup after loading the view.
    }
   
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        getInvoiceSettingsData()
        observer = NotificationCenter.default.addObserver(forName: .init("ReloadInvoiceSettings"), object: nil, queue: .main) { notify in
            self.getInvoiceSettingsData()
        }
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        NotificationCenter.default.removeObserver(observer!)
    }
    
    private func initialization(){
        setUpTableView()
        setUpDropDown()
        searchTextField.addTarget(self, action: #selector(searchAction), for: .editingChanged)
    }
    
    private func setUpDropDown(){
        //  invoice_typeDropDown
        
        invoice_typeDropDown.anchorView = filterTextField
        invoice_typeDropDown.bottomOffset = CGPoint(x: 0, y:(invoice_typeDropDown.anchorView?.plainView.bounds.height)!)
        invoice_typeDropDown.dataSource = ["All","Purchase Invoice","Sales Invoice"]
        invoice_typeDropDown.selectionAction = { [unowned self] (index: Int, item: String) in
            filterArrow.transform = .init(rotationAngle: 0)
            switch index{
                case 0:
                    invoice_type = ""
                case 1:
                    invoice_type = "PINV"
                case 2:
                    invoice_type = "SINV"
                default:
                    break
            }
            
            self.filterTextField.placeholder = item
            self.getInvoiceSettingsData()
        }
        
        invoice_typeDropDown.cancelAction = { [unowned self] in
            filterArrow.transform = .init(rotationAngle: .pi)
        }
        
        filterTextField.addTapGesture {
            self.filterArrow.transform = .init(rotationAngle: .pi)
            self.invoice_typeDropDown.show()
        }
    }
    
    @objc private func searchAction(){
        self.getInvoiceSettingsData()
    }

}

// MARK: - Table View Delegte and Data Source
extension InvoiceSettingsViewController:UITableViewDelegate,UITableViewDataSource{
    private func setUpTableView(){
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(.init(nibName: "InvoiceSettingsTableViewCell", bundle: nil), forCellReuseIdentifier: "InvoiceSettingsTableViewCell")
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return data.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "InvoiceSettingsTableViewCell", for: indexPath) as! InvoiceSettingsTableViewCell
        cell.setData(data: data[indexPath.row])
        return cell
    }
}


// MARK: - API Handling
extension InvoiceSettingsViewController{
    
    private func getInvoiceSettingsData(){
        showLoadingActivity()
        APIController.shard.getInvoiceSettingsData(branch_id: AccountSettingsViewController.branch_id, search_key: searchTextField.text!, invoice_type: invoice_type, finance_id: AccountSettingsViewController.finance_id) { data  in
            DispatchQueue.main.async {
                self.hideLoadingActivity()
                if let status = data.status,status{
                    self.data = data.records ?? []
                }else{
                    self.data.removeAll()
                }
                self.emptyDataImageView.isHidden = !self.data.isEmpty
                self.tableView.reloadData()
            }
        }
    }
    
    
}
