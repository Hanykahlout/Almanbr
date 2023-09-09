//
//  HomeFilterViewController.swift
//  Almnabr
//
//  Created by Hany Alkahlout on 12/10/2022.
//  Copyright © 2022 Samar Akkila. All rights reserved.
//

import UIKit
import Fastis
import DropDown
class HomeFilterViewController: UIViewController {
    
    @IBOutlet weak var dateTextField: UITextField!
    @IBOutlet weak var requestNumberTextField: UITextField!
    @IBOutlet weak var platformCodeSystemTextField: UITextField!
    @IBOutlet weak var byPhasesTextField: UITextField!
    @IBOutlet weak var generalNumberTextField: UITextField!
    @IBOutlet weak var statusTextField: UITextField!
    @IBOutlet weak var barCodeTextField: UITextField!
    
    @IBOutlet weak var noDataTempleteIDLabel: UILabel!
    @IBOutlet weak var noDataDivisionLabel: UILabel!
    @IBOutlet weak var noDataGroupTypeLabel: UILabel!
    @IBOutlet weak var noDataChapterLabel: UILabel!
    @IBOutlet weak var noDataZoneLabel: UILabel!
    @IBOutlet weak var noDataBlocksLabel: UILabel!
    @IBOutlet weak var noDataClustersLabel: UILabel!
    @IBOutlet weak var noSelectionLevelKeyLabel: UILabel!
    @IBOutlet weak var noSelectionResultLabel: UILabel!
    
    @IBOutlet weak var levelKeyCollectionView: UICollectionView!
    @IBOutlet weak var resultCollectionView: UICollectionView!
    
    
    @IBOutlet weak var levelsArrow: UIImageView!
    @IBOutlet weak var statusArrow: UIImageView!
    @IBOutlet weak var resultArrow: UIImageView!
    
    @IBOutlet weak var selectedZoneLabel: UILabel!
    @IBOutlet weak var selectedBlockLabel: UILabel!
    @IBOutlet weak var selectedClusterLabel: UILabel!
    
    @IBOutlet weak var selectedTempleteLable: UILabel!
    @IBOutlet weak var selectedDivisionLabel: UILabel!
    @IBOutlet weak var selectedGroupTypeLabel: UILabel!
    @IBOutlet weak var selectedChapterLabel: UILabel!
    
    @IBOutlet weak var selectedTemplateView: UIView!
    @IBOutlet weak var selectedDivisionView: UIView!
    @IBOutlet weak var selectedGroupTypeView: UIView!
    @IBOutlet weak var selectedChapterView: UIView!
    @IBOutlet weak var selectedZoneView: UIView!
    @IBOutlet weak var selectedBolckView: UIView!
    @IBOutlet weak var selectedClustersView: UIView!
    @IBOutlet weak var levelsView: UIView!
    @IBOutlet weak var resultView: UIView!
    
    
    var projects_work_area_id = ""
    
 
        
    private var levels = [GetGroupTypesRecord]()
    
    private var levelsDropDown = DropDown()
    private var resultDropDown = DropDown()
    private var statuDropDown = DropDown()

    var selecteFilterData:SelectedHomeFilterData?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        initlization()
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        addNavigationBarTitle(navigationTitle: "Advanced Filter")
        navigationController?.setNavigationBarHidden(false, animated: true)
        getLevelKeys()
        if let selecteFilterData = selecteFilterData{
            if let fromData = selecteFilterData.selectedFromDate , let toDate = selecteFilterData.selectedToDate{
                dateTextField.text = "(\(formatedDate(date: fromData)) - \(formatedDate(date: toDate))"
            }
            requestNumberTextField.text = selecteFilterData.requestNumberTextField
            self.checkSelectedTemplate(template: selecteFilterData.selectedTemplate)
            self.checkSelectedDivistion(divistion: selecteFilterData.selectedDivision)
            self.checkSelectedGroupType(groupType: selecteFilterData.selectedGroupType)
            self.checkSelectedChapter(chapter: selecteFilterData.selectedChapter)
            self.platformCodeSystemTextField.text = selecteFilterData.platformCodeSystemTextField
            self.checkSelectedZone(zone: selecteFilterData.selectedZone)
            self.checkSelectedBlock(block: selecteFilterData.selectedBlock)
            self.checkSelectedCluster(cluster: selecteFilterData.selectedCluster)
            self.byPhasesTextField.text = selecteFilterData.byPhasesTextField
            self.generalNumberTextField.text = selecteFilterData.generalNumberTextField
            self.noSelectionLevelKeyLabel.isHidden = !selecteFilterData.selectedlevels.isEmpty
            self.noSelectionResultLabel.isHidden = !selecteFilterData.selectedlevels.isEmpty
            self.statusTextField.text = selecteFilterData.selectedStatus
            self.barCodeTextField.text = selecteFilterData.barCodeTextField
            
        }
    }
    
    
    private func initlization(){
        dateTextField.isEnabled = false
        setUpCollectionView()
        setUpNotificationCenterObserver()
        
        setUpDropDownList()
        levelsView.addTapGesture {
            self.levelsArrow.transform = .init(rotationAngle: .pi)
            self.levelsDropDown.show()
        }
        
        resultView.addTapGesture {
            self.resultArrow.transform = .init(rotationAngle: .pi)
            self.resultDropDown.show()
        }
        
        statusTextField.addTapGesture {
            self.statusArrow.transform = .init(rotationAngle: .pi)
            self.statuDropDown.show()
        }
    }
    
    private func setUpDropDownList(){
        // levelsDropDown
        levelsDropDown.anchorView = levelsView
        levelsDropDown.bottomOffset = CGPoint(x: 0, y:(levelsDropDown.anchorView?.plainView.bounds.height)!)
        levelsDropDown.dataSource = ["No items found"]
        levelsDropDown.selectionAction = { [unowned self] (index: Int, item: String) in
            levelsArrow.transform = .init(rotationAngle: 0)
            if !levels.isEmpty{
                self.noSelectionLevelKeyLabel.isHidden = true
                let objc = levels[index]
                if !(self.selecteFilterData?.selectedlevels.contains(where: {$0.value == objc.value}) ?? true){
                    self.selecteFilterData!.selectedlevels.append(objc)
                    self.levelKeyCollectionView.reloadData()
                }
            }
        }
        
        levelsDropDown.cancelAction = { [unowned self] in
            levelsArrow.transform = .init(rotationAngle: 0)
        }
        
        // resultDropDown
        resultDropDown.anchorView = resultView
        resultDropDown.bottomOffset = CGPoint(x: 0, y:(resultDropDown.anchorView?.plainView.bounds.height)!)
        resultDropDown.dataSource = ["A","B","C","D","OPEN","CLOSE"]
        resultDropDown.selectionAction = { [unowned self] (index: Int, item: String) in
            resultArrow.transform = .init(rotationAngle: 0)
                self.noSelectionResultLabel.isHidden = true
            if !(self.selecteFilterData?.selectedResult.contains(where: {$0 == item}) ?? true){
                    self.selecteFilterData!.selectedResult.append(item)
                    self.resultCollectionView.reloadData()
                }
        }
        
        resultDropDown.cancelAction = { [unowned self] in
            resultArrow.transform = .init(rotationAngle: 0)
        }
        
        // statuDropDown
        statuDropDown.anchorView = statusTextField
        statuDropDown.bottomOffset = CGPoint(x: 0, y:(statuDropDown.anchorView?.plainView.bounds.height)!)
        statuDropDown.dataSource = ["Completed","All Completed Versions","Pending","Duplicated Versions"]
        statuDropDown.selectionAction = { [unowned self] (index: Int, item: String) in
            statusArrow.transform = .init(rotationAngle: 0)
            self.statusTextField.text = item
            switch index{
            case 0:
                self.selecteFilterData?.selectedStatus = "final_completed_versions"
            case 1:
                self.selecteFilterData?.selectedStatus = "all_completed_versions"
            case 2:
                self.selecteFilterData?.selectedStatus = "all_pending_versions"
            case 3 :
                self.selecteFilterData?.selectedStatus = "all_duplicated_versions"
            default:
                break
            }
        }
        statuDropDown.cancelAction = { [unowned self] in
            statusArrow.transform = .init(rotationAngle: 0)
        }
    }
    
    // Selecte Date Form Fastis Calender
    private func chooseDate() {
        let fastisController = FastisController(mode: .range)
        fastisController.title = "Choose range"
        
        fastisController.allowToChooseNilDate = false
        fastisController.shortcuts = [.today]
        fastisController.doneHandler = { resultRange in
            guard let fromDate = resultRange?.fromDate,
                  let toDate = resultRange?.toDate else { return }
            self.selecteFilterData?.selectedFromDate = fromDate
            self.selecteFilterData?.selectedToDate = toDate
            self.dateTextField.text = "(\(self.formatedDate(date: fromDate)) - \(self.formatedDate(date: toDate)))"
        }
        fastisController.present(above: self)
    }
    
    
    
    private func setUpNotificationCenterObserver(){
        
        NotificationCenter.default.addObserver(forName: .init("TemplateFilter1"), object: nil, queue: .main) { notify in
            guard let obj = notify.object as? (GetTemplateRecord?,GetGroupTypesRecord?,GetGroupTypesRecord?,GetGroupTypesRecord?) else { return }
            DispatchQueue.main.async {
                self.checkSelectedTemplate(template: obj.0)
                self.checkSelectedDivistion(divistion: obj.1)
                self.checkSelectedGroupType(groupType: obj.2)
                self.checkSelectedChapter(chapter: obj.3)
            }
        }
        
        NotificationCenter.default.addObserver(forName: .init("TemplateFilter2"), object: nil, queue: .main) { notify in
            guard let obj = notify.object as? (ZonesRecord?,ZonesRecord?,ZonesRecord?) else { return }
            DispatchQueue.main.async {
                self.checkSelectedZone(zone: obj.0)
                self.checkSelectedBlock(block: obj.1)
                self.checkSelectedCluster(cluster: obj.2)
            }
        }
        
    }
    
    
    private func checkSelectedTemplate(template:GetTemplateRecord?){
        if let selectedTemplate = template {
            self.selecteFilterData?.selectedTemplate = selectedTemplate
            self.selectedTempleteLable.text = selectedTemplate.label ?? ""
            self.selectedTemplateView.isHidden = false
            self.noDataTempleteIDLabel.isHidden = true
        }else{
            self.selecteFilterData?.selectedTemplate = nil
            self.selectedTempleteLable.text = "----"
            self.selectedTemplateView.isHidden = true
            self.noDataTempleteIDLabel.isHidden = false
        }
    }
    
    private func checkSelectedDivistion(divistion:GetGroupTypesRecord?){
        if let selectedDivision = divistion {
            self.selecteFilterData?.selectedDivision = selectedDivision
            self.selectedDivisionLabel.text = selectedDivision.label ?? ""
            self.selectedDivisionView.isHidden = false
            self.noDataDivisionLabel.isHidden = true
        }else{
            self.selecteFilterData?.selectedDivision = nil
            self.selectedDivisionLabel.text = "----"
            self.selectedDivisionView.isHidden = true
            self.noDataDivisionLabel.isHidden = false
        }
    }
    
    
    private func checkSelectedGroupType(groupType:GetGroupTypesRecord?){
        if let selectedGroupType = groupType {
            self.selecteFilterData?.selectedGroupType = selectedGroupType
            self.selectedGroupTypeLabel.text = selectedGroupType.label ?? ""
            self.selectedGroupTypeView.isHidden = false
            self.noDataGroupTypeLabel.isHidden = true
        }else{
            self.selecteFilterData?.selectedGroupType = nil
            self.selectedGroupTypeLabel.text = "----"
            self.selectedGroupTypeView.isHidden = true
            self.noDataGroupTypeLabel.isHidden = false
        }
    }
    
    private func checkSelectedChapter(chapter:GetGroupTypesRecord?){
        if let selectedChapter = chapter {
            self.selecteFilterData?.selectedChapter = selectedChapter
            self.selectedChapterLabel.text = selectedChapter.label ?? ""
            self.selectedChapterView.isHidden = false
            self.noDataChapterLabel.isHidden = true
        }else{
            self.selecteFilterData?.selectedChapter = nil
            self.selectedChapterLabel.text = "----"
            self.selectedChapterView.isHidden = true
            self.noDataChapterLabel.isHidden = false
        }
    }
    
    private func checkSelectedZone(zone:ZonesRecord?){
        if let selectedZone = zone{
            self.selecteFilterData?.selectedZone = selectedZone
            self.selectedZoneLabel.text = selectedZone.label ?? ""
            self.selectedZoneView.isHidden = false
            self.noDataZoneLabel.isHidden = true
        }else{
            self.selecteFilterData?.selectedZone = nil
            self.selectedZoneLabel.text = "----"
            self.selectedZoneView.isHidden = true
            self.noDataZoneLabel.isHidden = false
        }
    }
    
    private func checkSelectedBlock(block:ZonesRecord?){
        if let selectedBlock = block{
            self.selecteFilterData?.selectedBlock = selectedBlock
            self.selectedBlockLabel.text = selectedBlock.label ?? ""
            self.selectedBolckView.isHidden = false
            self.noDataBlocksLabel.isHidden = true
        }else{
            self.selecteFilterData?.selectedBlock = nil
            self.selectedBlockLabel.text = "----"
            self.selectedBolckView.isHidden = true
            self.noDataBlocksLabel.isHidden = false
        }
    }
    
    private func checkSelectedCluster(cluster:ZonesRecord?){
        if let selectedCluster = cluster{
            self.selecteFilterData?.selectedCluster = selectedCluster
            self.selectedClusterLabel.text = selectedCluster.label ?? ""
            self.selectedClustersView.isHidden = false
            self.noDataClustersLabel.isHidden = true
        }else{
            self.selecteFilterData?.selectedCluster = nil
            self.selectedClusterLabel.text = "----"
            self.selectedClustersView.isHidden = true
            self.noDataClustersLabel.isHidden = false
        }
    }
    

    @IBAction func dateAction(_ sender: Any) {
        chooseDate()
    }
    
    
    @IBAction func addTemplateFilter1Action(_ sender: Any) {
        let vc = SelectTemplete1ViewController()
        vc.projects_work_area_id = self.projects_work_area_id
        let nav = UINavigationController(rootViewController: vc)
        nav.modalPresentationStyle = .overCurrentContext
        navigationController?.present(nav, animated: true)
    }
    
    
    @IBAction func addTemplateFilter2Action(_ sender: Any) {
        let vc = SelectTemplete2ViewController()
        vc.projects_work_area_id = self.projects_work_area_id
        let nav = UINavigationController(rootViewController: vc)
        nav.modalPresentationStyle = .overCurrentContext
        navigationController?.present(nav, animated: true)
    }
    
    
    @IBAction func resetAction(_ sender: Any) {
        selecteFilterData = .init()
        NotificationCenter.default.post(name: .init("SubmitedFilter"), object: selecteFilterData)
        navigationController?.popViewController(animated: true)
    }
    
    
    @IBAction func saveAction(_ sender: Any) {
        selecteFilterData?.requestNumberTextField = requestNumberTextField.text!
        selecteFilterData?.platformCodeSystemTextField = platformCodeSystemTextField.text!
        selecteFilterData?.byPhasesTextField = byPhasesTextField.text!
        selecteFilterData?.generalNumberTextField = generalNumberTextField.text!
        selecteFilterData?.barCodeTextField = barCodeTextField.text!
        NotificationCenter.default.post(name: .init("SubmitedFilter"), object: selecteFilterData)
        navigationController?.popViewController(animated: true)
    }
    
    
    @IBAction func deleteSelectedTemplate(_ sender: Any) {
        self.selecteFilterData?.selectedTemplate = nil
            self.selectedTempleteLable.text = "----"
            self.selectedTemplateView.isHidden = true
            self.noDataTempleteIDLabel.isHidden = false
    }

    
    @IBAction func deleteSelectedDivison(_ sender: Any) {
        self.selecteFilterData?.selectedDivision = nil
        self.selectedDivisionLabel.text = "----"
        self.selectedDivisionView.isHidden = true
        self.noDataDivisionLabel.isHidden = false
    }
    
    
    @IBAction func deleteSelectedGroupType(_ sender: Any) {
        self.selecteFilterData?.selectedGroupType = nil
        self.selectedGroupTypeLabel.text = "----"
        self.selectedGroupTypeView.isHidden = true
        self.noDataGroupTypeLabel.isHidden = false
    }
    
    
    @IBAction func deleteSelectedChapter(_ sender: Any) {
        self.selecteFilterData?.selectedChapter = nil
        self.selectedChapterLabel.text = "----"
        self.selectedChapterView.isHidden = true
        self.noDataChapterLabel.isHidden = false
    }
    
    
    @IBAction func deleteSelectedZone(_ sender: Any) {
        self.selecteFilterData?.selectedZone = nil
        self.selectedZoneLabel.text = "----"
        self.selectedZoneView.isHidden = true
        self.noDataZoneLabel.isHidden = false
    }
    
    
    @IBAction func deleteSelectedBlock(_ sender: Any) {
        self.selecteFilterData?.selectedBlock = nil
        self.selectedBlockLabel.text = "----"
        self.selectedBolckView.isHidden = true
        self.noDataBlocksLabel.isHidden = false
    }
    
    
    @IBAction func deleteSelectedCluster(_ sender: Any) {
        self.selecteFilterData?.selectedCluster = nil
        self.selectedClusterLabel.text = "----"
        self.selectedClustersView.isHidden = true
        self.noDataClustersLabel.isHidden = false
    }
    
    
}


extension HomeFilterViewController: UICollectionViewDelegate,UICollectionViewDataSource{
    private func setUpCollectionView(){
        
        levelKeyCollectionView.delegate = self
        levelKeyCollectionView.dataSource = self
        levelKeyCollectionView.register(.init(nibName: "UsersCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "UsersCollectionViewCell")
        
        resultCollectionView.delegate = self
        resultCollectionView.dataSource = self
        resultCollectionView.register(.init(nibName: "UsersCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "UsersCollectionViewCell")
    }

    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if collectionView == levelKeyCollectionView{
            return selecteFilterData?.selectedlevels.count ?? 0
        }
        return selecteFilterData?.selectedResult.count ?? 0
    }
    
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        if collectionView == levelKeyCollectionView{
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "UsersCollectionViewCell", for: indexPath) as! UsersCollectionViewCell
            
            cell.delegate = self
            cell.setData(indexPath: indexPath, data: selecteFilterData!.selectedlevels[indexPath.row])
            return cell
        }
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "UsersCollectionViewCell", for: indexPath) as! UsersCollectionViewCell
        cell.type = .statusCollectionView
        cell.delegate = self
        cell.setData(indexPath: indexPath, data: selecteFilterData!.selectedResult[indexPath.row])
        return cell
    }
    
}
// MARK: - CollectionViewCell Delegate

extension HomeFilterViewController: UsersCollectionViewCellDelegate{
    func removeAction(indexPath: IndexPath) {
        selecteFilterData?.selectedlevels.remove(at: indexPath.row)
        levelKeyCollectionView.reloadData()
        self.noSelectionLevelKeyLabel.isHidden = !selecteFilterData!.selectedlevels.isEmpty
    }
    
    func removeAction(type: CollectionType, indexPath: IndexPath) {
        selecteFilterData?.selectedResult.remove(at: indexPath.row)
        resultCollectionView.reloadData()
        self.noSelectionResultLabel.isHidden = !selecteFilterData!.selectedResult.isEmpty
    }
    
}

// MARK: - API Handling

extension HomeFilterViewController{
    private func getLevelKeys(){
        showLoadingActivity()
        APIController.shard.getLevelKeys { data in
            self.hideLoadingActivity()
            if let status = data.status,status{
                self.levels = data.records ?? []
                self.levelsDropDown.dataSource = (data.records ?? []).map{$0.label ?? ""}
            }
        }
    }
}
