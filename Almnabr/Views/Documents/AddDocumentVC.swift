//
//  AddDocumentVC.swift
//  Almnabr
//
//  Created by Hany Alkahlout on 18/08/2022.
//  Copyright © 2022 Samar Akkila. All rights reserved.
//

import UIKit

class AddDocumentVC: UIViewController {
    
    @IBOutlet weak var nameEnTextField: UITextView!
    @IBOutlet weak var nameArTextField: UITextView!
    @IBOutlet weak var typeTextField: UITextView!
    @IBOutlet weak var branchTextField: UITextView!
    @IBOutlet weak var issueDateTextField: UITextView!
    @IBOutlet weak var idExpiryTextField: UITextView!
    @IBOutlet weak var documentIdTextField: UITextView!
    @IBOutlet weak var descriptionTextView: UITextView!
    @IBOutlet weak var descriptionHintLabel: UILabel!
    @IBOutlet weak var attachTableView: UITableView!
    @IBOutlet weak var tableViewHeight: NSLayoutConstraint!
    @IBOutlet weak var plusButton: UIButton!
    @IBOutlet weak var addAttachsView: UIView!
    @IBOutlet weak var viewAttachView: UIView!
    
    var data:DocumentData?
    private var counter = 1
    
    override func viewDidLoad() {
        super.viewDidLoad()
        initlization()
        // Do any additional setup after loading the view.
    }
    
    private func initlization(){
        addNavigationBarTitle(navigationTitle: "Document Details")
        setUpTableView()
        reloadTableViewHeight()
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        navigationController?.setNavigationBarHidden(false, animated: true)
        setUpFieldWithData()
    }
    
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        navigationController?.setNavigationBarHidden(true, animated: true)
    }
    
    private func reloadTableViewHeight(){
        let isFromAdd = data == nil
        tableViewHeight.constant = CGFloat((isFromAdd ? 130 : 200) * counter)
    }
    
    
    private func setUpFieldWithData(){
        let isFromAdd = data == nil
        nameEnTextField.isEditable = isFromAdd
        nameArTextField.isEditable = isFromAdd
        typeTextField.isEditable = isFromAdd
        branchTextField.isEditable = isFromAdd
        issueDateTextField.isEditable = isFromAdd
        idExpiryTextField.isEditable = isFromAdd
        documentIdTextField.isEditable = isFromAdd
        descriptionTextView.isEditable = isFromAdd
        nameEnTextField.backgroundColor = isFromAdd ? .clear : .systemGray6
        nameArTextField.backgroundColor = isFromAdd ? .clear : .systemGray6
        typeTextField.backgroundColor = isFromAdd ? .clear : .systemGray6
        branchTextField.backgroundColor = isFromAdd ? .clear : .systemGray6
        issueDateTextField.backgroundColor = isFromAdd ? .clear : .systemGray6
        idExpiryTextField.backgroundColor = isFromAdd ? .clear : .systemGray6
        documentIdTextField.backgroundColor = isFromAdd ? .clear : .systemGray6
        descriptionTextView.backgroundColor = isFromAdd ? .clear : .systemGray6
        plusButton.isHidden = !isFromAdd
        addAttachsView.isHidden = !isFromAdd
        viewAttachView.isHidden = isFromAdd
        
        
        if let data = data {
            nameEnTextField.text = data.document_name ?? ""
            nameArTextField.text = data.document_name ?? ""
            typeTextField.text = data.document_type_name ?? ""
            branchTextField.text = data.branch_name ?? ""
            issueDateTextField.text = data.document_issue_date_english ?? ""
            idExpiryTextField.text = data.document_expire_date_english ?? ""
            documentIdTextField.text = data.document_id ?? ""
            descriptionTextView.text = data.notes ?? ""
            descriptionHintLabel.isHidden = !descriptionTextView.text.isEmpty
            
        }
    }
    
    @IBAction func addAttachAction(_ sender: Any) {
        counter += 1
        reloadTableViewHeight()
        attachTableView.reloadData()
    }
    
    
    @IBAction func attachAction(_ sender: Any) {
        let vc = DocAttachViewController()
        vc.document_id = data?.document_id ?? ""
        navigationController?.pushViewController(vc, animated: true)
    }
    
    
    @IBAction func submitAction(_ sender: Any) {
    }
    
    
}

extension AddDocumentVC:UITableViewDelegate,UITableViewDataSource{
    private func setUpTableView(){
        attachTableView.delegate = self
        attachTableView.dataSource = self
        attachTableView.register(.init(nibName: "OutgoingAttachmentTableViewCell", bundle: nil), forCellReuseIdentifier: "OutgoingAttachmentTableViewCell")
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return counter
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "OutgoingAttachmentTableViewCell", for: indexPath) as! OutgoingAttachmentTableViewCell
        cell.index = indexPath.row
        cell.delegate = self
        return cell
    }
    
}

extension AddDocumentVC: OutgoingAttachmentCellDelegate{
    func deleteAction() {
        if counter > 1{
            counter -= 1
            reloadTableViewHeight()
            attachTableView.reloadData()
        }
    }
    
    func selectFileAction(index: Int) {
        
    }
}
