//
//  SelectTemplete1ViewController.swift
//  Almnabr
//
//  Created by Hany Alkahlout on 12/10/2022.
//  Copyright © 2022 Samar Akkila. All rights reserved.
//

import UIKit
import DropDown

class SelectTemplete1ViewController: UIViewController {

    @IBOutlet weak var templateIDTextField: UITextField!
    @IBOutlet weak var divisionTextField: UITextField!
    @IBOutlet weak var groupTypeTextField: UITextField!
    @IBOutlet weak var chapterTextField: UITextField!

    @IBOutlet weak var templateIDArrow: UIImageView!
    @IBOutlet weak var divisionArrow: UIImageView!
    @IBOutlet weak var groupTypeArrow: UIImageView!
    @IBOutlet weak var chapterArrow: UIImageView!
    
    private var templatesNames = [GetTemplateRecord]()
    private var divisions = [GetGroupTypesRecord]()
    private var groupTypes = [GetGroupTypesRecord]()
    private var chapters = [GetGroupTypesRecord]()
    
    var projects_work_area_id = ""
    private var selectedTemplate:GetTemplateRecord?
    private var required_type = ""
    private var selectedDivisions:GetGroupTypesRecord?
    private var selectedGroupType:GetGroupTypesRecord?
    private var selectedChapter:GetGroupTypesRecord?
    
    private let templatesNamesDropDown = DropDown()
    private let divisionsDropDown = DropDown()
    private let groupTypesDropDown = DropDown()
    private let chaptersDropDown = DropDown()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        initlization()
        // Do any additional setup after loading the view.
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        getTemplets()
    }
    
    
    private func initlization(){
        templateIDTextField.addTapGesture {
            self.templateIDArrow.transform = .init(rotationAngle: .pi)
            self.templatesNamesDropDown.show()
        }
        divisionTextField.addTapGesture {
            self.divisionArrow.transform = .init(rotationAngle: .pi)
            self.divisionsDropDown.show()
        }
        groupTypeTextField.addTapGesture {
            self.groupTypeArrow.transform = .init(rotationAngle: .pi)
            self.groupTypesDropDown.show()
        }
        chapterTextField.addTapGesture {
            self.chapterArrow.transform = .init(rotationAngle: .pi)
            self.chaptersDropDown.show()
        }
        
        setUpDropDown()
    }
    
    private func setUpDropDown(){
        // templateNameDropDown
        templatesNamesDropDown.anchorView = templateIDTextField
        templatesNamesDropDown.bottomOffset = CGPoint(x: 0, y:(templatesNamesDropDown.anchorView?.plainView.bounds.height)!)
        templatesNamesDropDown.dataSource = ["No items found"]
        templatesNamesDropDown.selectionAction = { [unowned self] (index: Int, item: String) in
            templateIDArrow.transform = .init(rotationAngle: 0)
            if !templatesNames.isEmpty{
                let objc = templatesNames[index]
                self.templateIDTextField.text = objc.label
                self.selectedTemplate = objc
                self.required_type = "group1"
                self.getDivision()
            }
        }
        
        templatesNamesDropDown.cancelAction = { [unowned self] in
            templateIDArrow.transform = .init(rotationAngle: 0)
        }
        
        
        // divisionsDropDown
        divisionsDropDown.anchorView = divisionTextField
        divisionsDropDown.bottomOffset = CGPoint(x: 0, y:(divisionsDropDown.anchorView?.plainView.bounds.height)!)
        divisionsDropDown.dataSource = ["No items found"]
        divisionsDropDown.selectionAction = { [unowned self] (index: Int, item: String) in
            divisionArrow.transform = .init(rotationAngle: 0)
            if !divisions.isEmpty{
                let objc = divisions[index]
                self.divisionTextField.text = objc.label
                self.required_type = "type"
                self.selectedDivisions = objc
                self.getGroupTypes()
            }
        }
        
        divisionsDropDown.cancelAction = { [unowned self] in
            divisionArrow.transform = .init(rotationAngle: 0)
        }
        
        
        
        // groupTypesDropDown
        groupTypesDropDown.anchorView = groupTypeTextField
        groupTypesDropDown.bottomOffset = CGPoint(x: 0, y:(groupTypesDropDown.anchorView?.plainView.bounds.height)!)
        groupTypesDropDown.dataSource = ["No items found"]
        groupTypesDropDown.selectionAction = { [unowned self] (index: Int, item: String) in
            groupTypeArrow.transform = .init(rotationAngle: 0)
            if !groupTypes.isEmpty{
                let objc = groupTypes[index]
                self.groupTypeTextField.text = objc.label
                self.required_type = "group2"
                self.selectedGroupType = objc
                self.getChapters()
            }
        }
        
        groupTypesDropDown.cancelAction = { [unowned self] in
            groupTypeArrow.transform = .init(rotationAngle: 0)
        }
        
        
        
        // chaptersDropDown
        chaptersDropDown.anchorView = chapterTextField
        chaptersDropDown.bottomOffset = CGPoint(x: 0, y:(chaptersDropDown.anchorView?.plainView.bounds.height)!)
        chaptersDropDown.dataSource = ["No items found"]
        chaptersDropDown.selectionAction = { [unowned self] (index: Int, item: String) in
            chapterArrow.transform = .init(rotationAngle: 0)
            if !chapters.isEmpty{
                let objc = chapters[index]
                self.chapterTextField.text = objc.label
                self.selectedChapter = objc
            }
        }
        
        chaptersDropDown.cancelAction = { [unowned self] in
            chapterArrow.transform = .init(rotationAngle: 0)
        }
        
    }
    

    @IBAction func saveAction(_ sender: Any) {
        NotificationCenter.default.post(name: .init("TemplateFilter1"), object: (selectedTemplate,selectedDivisions,selectedGroupType,selectedChapter))
        navigationController?.dismiss(animated: true)
    }
    
    
    @IBAction func closeAction(_ sender: Any) {
        navigationController?.dismiss(animated: true)
    }
    
    
    
}
// MARK: - API Handling
extension SelectTemplete1ViewController{
    private func getTemplets(){
        APIController.shard.getTemplets(projects_work_area_id:projects_work_area_id) { data in
            if let status = data.status , status{
                self.templatesNames = data.records ?? []
                self.templatesNamesDropDown.dataSource = (data.records ?? []).map{$0.label ?? ""}
            }else{
                self.templatesNames.removeAll()
            }
        }
    }
    
    private func getDivision(){
        APIController.shard.getDivision(projects_work_area_id:projects_work_area_id,templateId: selectedTemplate?.value ?? "", required_type: required_type, group1: "",type: "") { data in
            if let status = data.status , status{
                self.divisions = data.records ?? []
                self.divisionsDropDown.dataSource = (data.records ?? []).map{$0.label ?? ""}
            }else{
                self.divisions.removeAll()
            }
        }
    }
    
    private func getGroupTypes(){
        APIController.shard.getDivision(projects_work_area_id:projects_work_area_id,templateId: selectedTemplate?.value ?? "", required_type: required_type, group1: selectedDivisions?.value ?? "" ,type: selectedGroupType?.value ?? "") { data in
            if let status = data.status , status{
                self.groupTypes = data.records ?? []
                self.groupTypesDropDown.dataSource = (data.records ?? []).map{$0.label ?? ""}
            }else{
                self.groupTypes.removeAll()
            }
        }
    }
    
    private func getChapters(){
        APIController.shard.getDivision(projects_work_area_id:projects_work_area_id,templateId: selectedTemplate?.value ?? "", required_type: required_type, group1: selectedDivisions?.value ?? "" ,type: selectedGroupType?.value ?? "") { data in
            if let status = data.status , status{
                self.chapters = data.records ?? []
                self.chaptersDropDown.dataSource = (data.records ?? []).map{$0.label ?? ""}
            }else{
                self.chapters.removeAll()
            }
        }
    }
    
    
    
}
