//
//  CreateTransactionViewController.swift
//  Almnabr
//
//  Created by Hany Alkahlout on 12/10/2022.
//  Copyright © 2022 Samar Akkila. All rights reserved.
//

import UIKit
import DropDown
class CreateTransactionViewController: UIViewController {
    
    @IBOutlet weak var templateNameTextField: UITextField!
    @IBOutlet weak var groupTypeTextField: UITextField!
    @IBOutlet weak var group1TextField: UITextField!
    @IBOutlet weak var group2TextField: UITextField!
    @IBOutlet weak var searchTextField: UITextField!
    
    @IBOutlet weak var tableView: UITableView!
    
    @IBOutlet weak var templateNameArrow: UIImageView!
    @IBOutlet weak var groupTypeArrow: UIImageView!
    @IBOutlet weak var group1Arrow: UIImageView!
    @IBOutlet weak var group2Arrow: UIImageView!
    
    
    
    private var templatesNames = [GetTemplateRecord]() {
        didSet{
            templateNameDropDown.dataSource = templatesNames.map{$0.label ?? ""}
        }
    }
    
    private var groupTypes = [GetGroupTypesRecord]() {
        didSet{
            groupTypeDropDown.dataSource = groupTypes.map{ $0.label ?? ""}
        }
    }
    
    
    private var group1 = [GetGroupTypesRecord]() {
        didSet{
            group1DropDown.dataSource = group1.map{$0.label ?? ""}
        }
    }
    
    
    private var group2 = [GetGroupTypesRecord]() {
        didSet{
            group2DropDown.dataSource = group2.map{$0.label ?? ""}
        }
    }
    
    private var results = [GetGroupTypesRecord](){
        didSet{
            self.tableView.reloadData()
        }
    }
    
    private var templateNameDropDown = DropDown()
    private var groupTypeDropDown = DropDown()
    private var group1DropDown = DropDown()
    private var group2DropDown = DropDown()
    
    private var templateId = ""
    private var typeCodeSystem = ""
    private var group1CodeSystem = ""
    private var group2CodeSystem = ""

    var projects_work_area_id = ""
    var projects_work_area_title = ""
    override func viewDidLoad() {
        super.viewDidLoad()
        initlization()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        addNavigationBarTitle(navigationTitle: "Create Transaction")
        navigationController?.setNavigationBarHidden(false, animated: true)
        getTemplets()
    }
    
    
    private func initlization(){
        setUpTableView()
        setUpDropDownLists()
        setUpTextFieldActions()
    }
    
    private func setUpTextFieldActions(){
        templateNameTextField.isUserInteractionEnabled = true
        templateNameTextField.isEnabled = true
        templateNameTextField.addTapGesture {
            self.templateNameArrow.transform = .init(rotationAngle: .pi)
            self.templateNameDropDown.show()
        }
        groupTypeTextField.isUserInteractionEnabled = true
        groupTypeTextField.addTapGesture {
            self.groupTypeArrow.transform = .init(rotationAngle: .pi)
            self.groupTypeDropDown.show()
        }
        group1TextField.isUserInteractionEnabled = true
        group1TextField.addTapGesture {
            self.group1Arrow.transform = .init(rotationAngle: .pi)
            self.group1DropDown.show()
        }
        group2TextField.isUserInteractionEnabled = true
        group2TextField.addTapGesture {
            self.group2Arrow.transform = .init(rotationAngle: .pi)
            self.group2DropDown.show()
        }
        searchTextField.addTarget(self, action: #selector(searchAction), for: .editingChanged)
        
    }
    
    
    private func setUpDropDownLists(){
        // templateNameDropDown
        templateNameDropDown.anchorView = templateNameTextField
        templateNameDropDown.bottomOffset = CGPoint(x: 0, y:(templateNameDropDown.anchorView?.plainView.bounds.height)!)
        templateNameDropDown.dataSource = ["No items found"]
        templateNameDropDown.selectionAction = { [unowned self] (index: Int, item: String) in
            templateNameArrow.transform = .init(rotationAngle: 0)
            if !templatesNames.isEmpty{
                let objc = templatesNames[index]
                self.templateNameTextField.text = objc.label
                self.templateId = objc.value ?? ""
                self.getGroupType()
            }
        }
        
        templateNameDropDown.cancelAction = { [unowned self] in
            templateNameArrow.transform = .init(rotationAngle: 0)
        }
        
        
        // groupTypeDropDown
        groupTypeDropDown.anchorView = groupTypeTextField
        groupTypeDropDown.bottomOffset = CGPoint(x: 0, y:(groupTypeDropDown.anchorView?.plainView.bounds.height)!)
        groupTypeDropDown.dataSource = ["No items found"]
        groupTypeDropDown.selectionAction = { [unowned self] (index: Int, item: String) in
            groupTypeArrow.transform = .init(rotationAngle: 0)
            if !groupTypes.isEmpty{
                let objc = groupTypes[index]
                self.groupTypeTextField.text = objc.label ?? ""
                self.typeCodeSystem = objc.value ?? ""
                self.getGroup1()
            }
        }
        
        groupTypeDropDown.cancelAction = { [unowned self] in
            groupTypeArrow.transform = .init(rotationAngle: 0)
        }
        
        
        // group1DropDown
        group1DropDown.anchorView = group1TextField
        group1DropDown.bottomOffset = CGPoint(x: 0, y:(group1DropDown.anchorView?.plainView.bounds.height)!)
        group1DropDown.dataSource = ["No items found"]
        group1DropDown.selectionAction = { [unowned self] (index: Int, item: String) in
            group1Arrow.transform = .init(rotationAngle: 0)
            if !group1.isEmpty{
                let objc = group1[index]
                self.group1TextField.text = objc.label ?? ""
                self.group1CodeSystem = objc.value ?? ""
                self.getGroup2()
            }
        }
        
        group1DropDown.cancelAction = { [unowned self] in
            group1Arrow.transform = .init(rotationAngle: 0)
        }
        
        
        // group2DropDown
        group2DropDown.anchorView = group2TextField
        group2DropDown.bottomOffset = CGPoint(x: 0, y:(group2DropDown.anchorView?.plainView.bounds.height)!)
        group2DropDown.dataSource = ["No items found"]
        group2DropDown.selectionAction = { [unowned self] (index: Int, item: String) in
            group2Arrow.transform = .init(rotationAngle: 0)
            if !group2.isEmpty{
                
                let objc = group2[index]
                self.group2TextField.text = objc.label ?? ""
                self.group2CodeSystem = objc.value ?? ""
                self.getTemplatesResult()
            }
        }
        
        group2DropDown.cancelAction = { [unowned self] in
            group2Arrow.transform = .init(rotationAngle: 0)
        }
        
    }
    
    @objc private func searchAction(){
        getTemplatesResult()
    }
    
}

extension CreateTransactionViewController:UITableViewDelegate,UITableViewDataSource{
    private func setUpTableView(){
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(.init(nibName: "CreateTransactionTableViewCell", bundle: nil), forCellReuseIdentifier: "CreateTransactionTableViewCell")
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return results.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "CreateTransactionTableViewCell", for: indexPath) as! CreateTransactionTableViewCell
        let objc = results[indexPath.row]
        cell.countLabel.text = "\(indexPath.row + 1)"
        cell.titleLabel.text = objc.label
        cell.didSelectedRecord = {
            let vc : ProjectDetailVC = AppDelegate.mainSB.instanceVC()
            ProjectName = self.projects_work_area_title
            vc.ProjectObj = .init(["template_platform_code_system": objc.value ?? ""])
            self.navigationController?.pushViewController(vc, animated: true)
        }
        
        return cell
    }
    
}

// MARK: - API Handling
extension CreateTransactionViewController{
    private func getTemplets(){
        APIController.shard.getTemplets(projects_work_area_id:projects_work_area_id) { data in
            if let status = data.status , status{
                self.templatesNames = data.records ?? []
            }else{
                self.templatesNames.removeAll()
            }
        }
    }
    
    
    private func getGroupType(){
        APIController.shard.getGroupType(projects_work_area_id:projects_work_area_id,templateId: templateId) { data in
            if let status = data.status , status{
                self.groupTypes = data.records ?? []
            }else{
                self.groupTypes.removeAll()
            }
        }
    }
    
    
    private func getGroup1(){
        APIController.shard.getGroup1(projects_work_area_id:projects_work_area_id,templateId: templateId, typeCodeSystem: typeCodeSystem) { data in
            if let status = data.status , status{
                self.group1 = data.records ?? []
            }else{
                self.group1.removeAll()
            }
        }
    }
    
    
    private func getGroup2(){
        APIController.shard.getGroup2(projects_work_area_id:projects_work_area_id,templateId: templateId, typeCodeSystem: typeCodeSystem, group1CodeSystem: group1CodeSystem) { data in
            if let status = data.status , status{
                self.group2 = data.records ?? []
            }else{
                self.group2.removeAll()
            }
        }
    }
    
    
    private func getTemplatesResult(){
        APIController.shard.getTemplatesResult(projects_work_area_id:projects_work_area_id,search_key:searchTextField.text!,templateId: templateId, typeCodeSystem: typeCodeSystem, group1CodeSystem: group1CodeSystem, group2CodeSystem: group2CodeSystem) { data in
            if let status = data.status , status{
                self.results = data.records ?? []
            }else{
                self.results.removeAll()
            }
        }
    }
    
    
}
