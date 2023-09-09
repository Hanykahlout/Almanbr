//
//  SendCodeWaysVC.swift
//  Almnabr
//
//  Created by Hany Alkahlout on 25/08/2022.
//  Copyright © 2022 Samar Akkila. All rights reserved.
//

import UIKit
import SCLAlertView

class SendCodeWaysVC: UIViewController {
    
    @IBOutlet weak var transactionDataLabel: UILabel!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var closeButton: UIButton!
    @IBOutlet weak var sendCodeButton: UIButton!
    @IBOutlet weak var tableViewHeight: NSLayoutConstraint!
    @IBOutlet weak var verificationButton: UIButton!
    @IBOutlet weak var codeFieldStackView: UIStackView!
    @IBOutlet weak var verificationTextField: UITextField!
    
    
    private var data = [SearchBranchRecords]()
    private var ways = ["Whatsapp","Email","Mobile"]
    private var selectedItem:SearchBranchRecords?
    var approvalStep:String?
    var id = ""
    var withVerificationField = false
    var type = ""
    var actionAfterVerification : ( ()->Void )?
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpTableView()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        transactionDataLabel.text = "# \(id) Edit Contract"
        getCodeWays()
    }
    
    
    @IBAction func closeAction(_ sender: Any) {
        navigationController?.dismiss(animated: true)
    }
    
    
    @IBAction func sendCodeAction(_ sender: Any) {
        sendCodeAction()
    }
    
    @IBAction func verificationAction(_ sender: Any) {
        doVerification()
    }
    
    
}

extension SendCodeWaysVC:UITableViewDelegate,UITableViewDataSource{
    private func setUpTableView(){
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(.init(nibName: "CodeTypeTableViewCell", bundle: nil), forCellReuseIdentifier: "CodeTypeTableViewCell")
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return data.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "CodeTypeTableViewCell", for: indexPath) as! CodeTypeTableViewCell
        cell.typeLabel.text = ways[indexPath.row]
        cell.exampleLabel.text = "(\(data[indexPath.row].label ?? ""))"
        cell.radioButton.isSelected = data[indexPath.row].isSelected
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        for index in 0..<data.count{
            self.data[index].isSelected = index == indexPath.row
            if index == indexPath.row{
                self.selectedItem = self.data[index]
            }
        }
        tableView.reloadData()
        self.sendCodeButton.isHidden = false
    }
    
}


// MARK: - API Handling
extension SendCodeWaysVC{
    private func getCodeWays(){
        showLoadingActivity()
        APIController.shard.getSendCodeWays { [weak self] data in
            self?.hideLoadingActivity()
            if let status = data.status , status{
                self?.data = data.data ?? []
                DispatchQueue.main.async {
                    self?.tableViewHeight.constant = CGFloat(self!.data.count * 50)
                    self?.tableView.reloadData()
                }
            }
        }
    }
    
    private func sendCodeAction(){
        let body:[String:Any] = [
            "transaction_request_id": id,
            "transaction_persons_type": type == "do_all" ? "" : type,
            "sender_type": selectedItem?.value ?? "",
            "do": type == "do_all" ? type : "do",
            "transactions_persons_last_step": approvalStep ?? ""
        ]
        showLoadingActivity()
        APIController.shard.sendCodeForApproval(body: body) { data in
            DispatchQueue.main.async {
                self.hideLoadingActivity()
                if let status = data.status , status{
                    SCLAlertView().showSuccess("Success".localized(), subTitle: data.msg ?? "")
                    if self.withVerificationField{
                        self.codeFieldStackView.isHidden = false
                        self.verificationButton.isHidden = false
                        self.sendCodeButton.isHidden = true
                    }else{
                        self.navigationController?.dismiss(animated: true)
                    }
                    
                }else{
                    SCLAlertView().showError("error".localized(), subTitle: data.error ?? "")
                }
            }
        }
    }
    
    
    private func doVerification(){
        let param = [
            "transaction_request_id": id,
            "transaction_persons_type": type == "do_all" ? "" : type,
            "sender_type":selectedItem?.value ?? "",
            "do": type == "do_all" ? type : "do",
            "transactions_persons_action_code":verificationTextField.text!,
            "transactions_persons_last_step": approvalStep ?? ""
        ]
        showLoadingActivity()
        APIController.shard.doVerification(param: param) { data in
            DispatchQueue.main.async {
                self.hideLoadingActivity()
                if let status = data.status,status{
                    self.actionAfterVerification?()
                    self.navigationController?.dismiss(animated: true)
                }else{
                    SCLAlertView().showError("error".localized(), subTitle: data.error ?? "")
                }
            }
        }
    }
    
    
}



