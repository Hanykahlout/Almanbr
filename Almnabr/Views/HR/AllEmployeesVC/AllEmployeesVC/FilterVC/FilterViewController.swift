//
//  FitlerVC.swift
//  Almnabr
//
//  Created by Hany Alkahlout on 06/06/2022.
//  Copyright © 2022 Samar Akkila. All rights reserved.
//

import UIKit
import DropDown
import Fastis


class FilterViewController: UIViewController {
    

    @IBOutlet weak var backButton: UIButton!
    
    @IBOutlet weak var lang_nationality_typeView: UIView!
    @IBOutlet weak var lang_nationality_typeLabel: UILabel!
    
    
    @IBOutlet weak var nationalityView: UIView!
    @IBOutlet weak var nationalityLabel: UILabel!
    @IBOutlet weak var nationalityCollectionView: UICollectionView!
    
    
    @IBOutlet weak var projectNameEnglishView: UIView!
    @IBOutlet weak var projectNameEnglishLabel: UILabel!
    @IBOutlet weak var projectNameEnglishCollectionView: UICollectionView!
    
    
    @IBOutlet weak var branchView: UIView!
    @IBOutlet weak var branchLabel: UILabel!
    @IBOutlet weak var branchCollectionView: UICollectionView!
    
    
    @IBOutlet weak var positionsView: UIView!
    @IBOutlet weak var positionsLabel: UILabel!
    @IBOutlet weak var positionsCollectionView: UICollectionView!
    
    
    @IBOutlet weak var statusView: UIView!
    @IBOutlet weak var statusLabel: UILabel!
    @IBOutlet weak var statusCollectionView: UICollectionView!
    
    
    @IBOutlet weak var lang_iqama_expiry_dateTextFiled: UITextField!
    @IBOutlet weak var lang_passport_expiry_dateTextField: UITextField!
    @IBOutlet weak var lang_membership_expiry_dateTextField: UITextField!
    @IBOutlet weak var lang_contract_expiry_dateTextField: UITextField!
    
    
    @IBOutlet weak var employeeNameTextField: UITextField!
    @IBOutlet weak var passportNumberTextField: UITextField!
    @IBOutlet weak var idNumberTextField: UITextField!
    
    @IBOutlet weak var lang_nationality_typeArrow: UIImageView!
    @IBOutlet weak var nationalityArrow: UIImageView!
    @IBOutlet weak var projectNameEnglishArrow: UIImageView!
    @IBOutlet weak var branchArrow: UIImageView!
    @IBOutlet weak var positionsArrow: UIImageView!
    @IBOutlet weak var statusArrow: UIImageView!
    
     
    private var lang_nationalityDropDown = DropDown()
    private var nationalityDropDown = DropDown()
    private var projectNameEnglishDropDown = DropDown()
    private var branchDropDown = DropDown()
    private var positionsDropDown = DropDown()
    private var statusDropDown = DropDown()
    
    private var lang_nationalityData = [SelectionInfo]()
    private var nationalityData = [SearchBranchRecords]()
    private var projectNameEnglishData = [FilterGetRecords2]()
    private var branchData = [SearchBranchRecords]()
    private var positionsData = [SelectionInfo]()
    private var statusData = [SelectionInfo]()
    
    private var selectedNationalityType:SelectionInfo?
    private var selectedNationality = [SearchBranchRecords]()
    private var selectedProjectNameEnglish = [FilterGetRecords2]()
    private var selectedBranch = [SearchBranchRecords]()
    private var selectedPositions = [SelectionInfo]()
    private var selectedStatus = [SelectionInfo]()
    
    private let fastisController = FastisController(mode: .range)
    private let datePicker: UIDatePicker = UIDatePicker()
    private var textFiledType:TextFiledType!
    
    public var filterInfo:FilterInfo?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        initlization()
    }
    
    
    private func initlization(){
        if L102Language.currentAppleLanguage() == "ar" {
            backButton.transform = .init(rotationAngle: .pi)
        }
        
        setUpCollectionView()
        setUpViews()
        setUpDatePicker()
        setUpDropDownLists()
        getFilterData()
        getFilterData2()
        getFilterData3()
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        if let filterInfo = filterInfo{
            lang_iqama_expiry_dateTextFiled.text! = filterInfo.lang_iqama
            lang_passport_expiry_dateTextField.text! = filterInfo.lang_passport
            lang_membership_expiry_dateTextField.text! = filterInfo.lang_membership
            lang_contract_expiry_dateTextField.text! = filterInfo.lang_contract
            employeeNameTextField.text! = filterInfo.employeeName
            passportNumberTextField.text! = filterInfo.passportNumber
            idNumberTextField.text! = filterInfo.idNumber
            
            
            selectedNationality = filterInfo.selectedNationality
            nationalityCollectionView.reloadData()
            if !selectedNationality.isEmpty{
                nationalityLabel.isHidden = true
            }
            
            
            selectedProjectNameEnglish = filterInfo.selectedProjectNameEnglish
            projectNameEnglishCollectionView.reloadData()
            if !selectedProjectNameEnglish.isEmpty {
                projectNameEnglishLabel.isHidden = true
            }
            
            
            
            selectedBranch = filterInfo.selectedBranch
            branchCollectionView.reloadData()
            if !selectedBranch.isEmpty{
                branchLabel.isHidden = true
            }
            
            
            selectedPositions = filterInfo.selectedPositions
            positionsCollectionView.reloadData()
            if !selectedPositions.isEmpty{
                positionsLabel.isHidden = true
            }
            
            
            selectedStatus = filterInfo.selectedStatus
            statusCollectionView.reloadData()
            if !selectedStatus.isEmpty{
                statusLabel.isHidden = true
            }
            
            selectedNationalityType = filterInfo.selectedNationalityType
            lang_nationality_typeLabel.text = L102Language.currentAppleLanguage() == "ar" ? selectedNationalityType?.name_arabic ?? "" : selectedNationalityType?.name_english ?? ""
        }
    }
    
    private func setUpDatePicker(){
        
        fastisController.title = "Choose Range".localized()
        fastisController.allowToChooseNilDate = true
        fastisController.shortcuts = [.today, .lastWeek]
        fastisController.doneHandler = { resultRange in
            if let resultRange = resultRange {
                let rangeString = "\(self.formatedDate(date: resultRange.fromDate)) - \(self.formatedDate(date: resultRange.toDate))"
                switch self.textFiledType{
                case .lang_iqama:
                    self.lang_iqama_expiry_dateTextFiled.text = rangeString
                case .lang_passport:
                    self.lang_passport_expiry_dateTextField.text = rangeString
                case .lang_membership:
                    self.lang_membership_expiry_dateTextField.text = rangeString
                case .lang_contract:
                    self.lang_contract_expiry_dateTextField.text = rangeString
                default:
                    break
                }
            }
        }
        
        lang_iqama_expiry_dateTextFiled.isEnabled = false
        lang_passport_expiry_dateTextField.isEnabled = false
        lang_membership_expiry_dateTextField.isEnabled = false
        lang_contract_expiry_dateTextField.isEnabled = false
        
    }
    
    
    private func setUpViews(){
        lang_nationality_typeView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(langAction)))
        nationalityView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(nationalityAction)))
        projectNameEnglishView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(projectAction)))
        branchView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(branchAction)))
        positionsView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(positionsAction)))
        statusView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(statusAction)))
        
    }
    
    
    private func setUpDropDownLists(){
        // lang_nationalityDropDown
        lang_nationalityDropDown.anchorView = lang_nationality_typeView
        lang_nationalityDropDown.bottomOffset = CGPoint(x: 0, y:(lang_nationalityDropDown.anchorView?.plainView.bounds.height)!)
        
        lang_nationalityDropDown.selectionAction = { [unowned self] (index: Int, item: String) in
            lang_nationality_typeArrow.transform = .init(rotationAngle: 0)
            self.lang_nationality_typeLabel.text = item
            self.selectedNationalityType = lang_nationalityData[index]
            nationalityView.isHidden = self.selectedNationalityType?.id == "saudi"
            
        }
        
        lang_nationalityDropDown.cancelAction = { [unowned self] in
            lang_nationality_typeArrow.transform = .init(rotationAngle: 0)
        }
        
        // nationalityDropDown
        nationalityDropDown.anchorView = nationalityView
        nationalityDropDown.bottomOffset = CGPoint(x: 0, y:(nationalityDropDown.anchorView?.plainView.bounds.height)!)
        
        nationalityDropDown.selectionAction = { [unowned self] (index: Int, item: String) in
            nationalityArrow.transform = .init(rotationAngle: 0)
            self.nationalityLabel.isHidden = true
            let selectedItem = nationalityData[index]
            if !selectedNationality.contains(where:{$0.value == selectedItem.value}){
                self.selectedNationality.append(selectedItem)
                self.nationalityCollectionView.reloadData()
            }
            
        }
        
        nationalityDropDown.cancelAction = { [unowned self] in
            nationalityArrow.transform = .init(rotationAngle: 0)
        }
        
        // projectNameEnglishDropDown
        projectNameEnglishDropDown.anchorView = projectNameEnglishView
        projectNameEnglishDropDown.bottomOffset = CGPoint(x: 0, y:(projectNameEnglishDropDown.anchorView?.plainView.bounds.height)!)
        
        projectNameEnglishDropDown.selectionAction = { [unowned self] (index: Int, item: String) in
            projectNameEnglishArrow.transform = .init(rotationAngle: 0)
            self.projectNameEnglishLabel.isHidden = true
            let selectedItem = projectNameEnglishData[index]
            if !selectedProjectNameEnglish.contains(where:{$0.id == selectedItem.id}){
                selectedProjectNameEnglish.append(selectedItem)
                projectNameEnglishCollectionView.reloadData()
            }
            
        }
        
        projectNameEnglishDropDown.cancelAction = { [unowned self] in
            self.projectNameEnglishArrow.transform = .init(rotationAngle: 0)
        }
        
        
        // branchDropDown
        branchDropDown.anchorView = branchView
        branchDropDown.bottomOffset = CGPoint(x: 0, y:(branchDropDown.anchorView?.plainView.bounds.height)!)
        
        branchDropDown.selectionAction = { [unowned self] (index: Int, item: String) in
            branchArrow.transform = .init(rotationAngle: 0)
            self.branchLabel.isHidden = true
            let selectedItem = branchData[index]
            if !selectedBranch.contains(where: { $0.value == selectedItem.value}){
                self.selectedBranch.append(selectedItem)
                self.branchCollectionView.reloadData()
            }
        }
        
        branchDropDown.cancelAction = { [unowned self] in
            self.branchArrow.transform = .init(rotationAngle: 0)
        }
        
        // positionsDropDown
        positionsDropDown.anchorView = positionsView
        positionsDropDown.bottomOffset = CGPoint(x: 0, y:(positionsDropDown.anchorView?.plainView.bounds.height)!)
        
        positionsDropDown.selectionAction = { [unowned self] (index: Int, item: String) in
            positionsArrow.transform = .init(rotationAngle: 0)
            self.positionsLabel.isHidden = true
            let selectedItem = positionsData[index]
            if !selectedPositions.contains(where: { $0.id == selectedItem.id}){
                self.selectedPositions.append(selectedItem)
                self.positionsCollectionView.reloadData()
            }
            
        }
        
        positionsDropDown.cancelAction = { [unowned self] in
            positionsArrow.transform = .init(rotationAngle: 0)
        }
        
        
        // statusDropDown
        statusDropDown.anchorView = statusView
        statusDropDown.bottomOffset = CGPoint(x: 0, y:(statusDropDown.anchorView?.plainView.bounds.height)!)
        
        statusDropDown.selectionAction = { [unowned self] (index: Int, item: String) in
            statusArrow.transform = .init(rotationAngle: 0)
            self.statusLabel.isHidden = true
            let selectedItem = statusData[index]
            if !selectedStatus.contains(where: { $0.id == selectedItem.id}){
                self.selectedStatus.append(selectedItem)
                self.statusCollectionView.reloadData()
            }
            
        }
        
        statusDropDown.cancelAction = { [unowned self] in
            statusArrow.transform = .init(rotationAngle: 0)
        }
        
        
    }
    
    private func filterAction(body:[String:Any],filterInfo:FilterInfo?){
        let data:[Any?] = [body,filterInfo]
        NotificationCenter.default.post(name: NSNotification.Name("FilterAction"), object: data )
        navigationController?.popViewController(animated: true)
    }
    
    
    @objc private func datePickerAction(datePicker:UIDatePicker){
        lang_iqama_expiry_dateTextFiled.text = formatedDate(date: datePicker.date)
    }
    
    
    @objc private func langAction(){
        lang_nationalityDropDown.show()
    }
    @objc private func nationalityAction(){
        nationalityDropDown.show()
    }
    @objc private func projectAction(){
        projectNameEnglishDropDown.show()
    }
    @objc private func branchAction(){
        branchDropDown.show()
    }
    @objc private func positionsAction(){
        positionsDropDown.show()
    }
    @objc private func statusAction(){
        statusDropDown.show()
    }
    
    
    @IBAction func lang_iqama_expiry_dateAction(_ sender: Any) {
        textFiledType = .lang_iqama
        fastisController.present(above: self)
    }
    
    
    @IBAction func lang_passport_expiry_dateAction(_ sender: Any) {
        textFiledType = .lang_passport
        fastisController.present(above: self)
    }
    
    @IBAction func lang_membership_expiry_dateAction(_ sender: Any) {
        textFiledType = .lang_membership
        fastisController.present(above: self)
    }
    
    @IBAction func lang_contract_expiry_dateAction(_ sender: Any) {
        textFiledType = .lang_contract
        fastisController.present(above: self)
    }
    
    
    @IBAction func resetAction(_ sender: Any) {
        filterAction(body:[:],filterInfo:nil)
    }
    
    @IBAction func saveAction(_ sender: Any) {
        
        var body:[String:Any] = [:]

        let employeeName = employeeNameTextField.text!
        let passportNumber = passportNumberTextField.text!
        let idNumber = idNumberTextField.text!

        
        let lang_iqama_expiry_date = (lang_iqama_expiry_dateTextFiled.text!).components(separatedBy: " - ")
        let lang_passport_expiry_date = (lang_passport_expiry_dateTextField.text!).components(separatedBy: " - ")
        let lang_membership_expiry_date = (lang_membership_expiry_dateTextField.text!).components(separatedBy: " - ")
        let lang_contract_expiry_date = (lang_contract_expiry_dateTextField.text!).components(separatedBy: " - ")
      
        if !nationalityView.isHidden{
            for index in 0..<selectedNationality.count{
                body["nationality[\(index)]"] = selectedNationality[index].value ?? ""
            }
        }
        
        for index in 0..<selectedProjectNameEnglish.count{
            body["project_id[\(index)]"] = selectedProjectNameEnglish[index].id ?? ""
        }
        
        for index in 0..<selectedBranch.count{
            body["branch_id[\(index)]"] = selectedBranch[index].value ?? ""
        }
        
        for index in 0..<selectedPositions.count{
            body["position[\(index)]"] = selectedPositions[index].id ?? ""
        }
        
        for index in 0..<selectedStatus.count{
            body["employee_status[\(index)]"] = selectedStatus[index].id ?? ""
        }

        
        if let selectedNationalityType = selectedNationalityType,let id = selectedNationalityType.id{
            body["nationality_type[]"] = id
        }


        if !passportNumber.isEmpty{
            body["national_id"] = passportNumber
        }
        
        
        if !idNumber.isEmpty{
            body["employee_id"] = idNumber
        }
        
        
        if !employeeName.isEmpty{
            body["employee_name"] = employeeName
        }
        
        
        if !lang_iqama_expiry_dateTextFiled.text!.isEmpty{
            body["iqama_expiry_date_from"] = lang_iqama_expiry_date.first ?? ""
            body["iqama_expiry_date_to"] = lang_iqama_expiry_date.last ?? ""
        }
        
        
        if !lang_passport_expiry_dateTextField.text!.isEmpty{
            body["passport_expiry_date_from"] = lang_passport_expiry_date.first ?? ""
            body["passport_expiry_date_to"] = lang_passport_expiry_date.last ?? ""
        }
        
        if !lang_membership_expiry_dateTextField.text!.isEmpty{
            body["membership_expiry_date_from"] = lang_membership_expiry_date.first ?? ""
            body["membership_expiry_date_to"] = lang_membership_expiry_date.last ?? ""
        }
        
        if !lang_contract_expiry_dateTextField.text!.isEmpty{
            body["contract_expiry_date_from"] = lang_contract_expiry_date.first ?? ""
            body["contract_expiry_date_to"] = lang_contract_expiry_date.last ?? ""
        }
        
        let filterInfo = FilterInfo(lang_iqama: lang_iqama_expiry_dateTextFiled.text!, lang_passport: lang_passport_expiry_dateTextField.text!, lang_membership: lang_membership_expiry_dateTextField.text!, lang_contract: lang_contract_expiry_dateTextField.text!, selectedNationality: selectedNationality, selectedProjectNameEnglish: selectedProjectNameEnglish, selectedBranch: selectedBranch, selectedPositions: selectedPositions, selectedStatus: selectedStatus, selectedNationalityType: selectedNationalityType, passportNumber: passportNumber, idNumber: idNumber, employeeName: employeeName)
        
        filterAction(body:body,filterInfo:filterInfo)
    }
    
    
    
    @IBAction func backAction(_ sender: Any) {
        navigationController?.popViewController(animated: true)
    }
    
    
    
}

extension FilterViewController:UICollectionViewDelegate,UICollectionViewDataSource{
    private func setUpCollectionView(){
        nationalityCollectionView.delegate = self
        nationalityCollectionView.dataSource = self
        nationalityCollectionView.register(.init(nibName: "UsersCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "UsersCollectionViewCell")
        
        projectNameEnglishCollectionView.delegate = self
        projectNameEnglishCollectionView.dataSource = self
        projectNameEnglishCollectionView.register(.init(nibName: "UsersCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "UsersCollectionViewCell")
        
        branchCollectionView.delegate = self
        branchCollectionView.dataSource = self
        branchCollectionView.register(.init(nibName: "UsersCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "UsersCollectionViewCell")
        
        positionsCollectionView.delegate = self
        positionsCollectionView.dataSource = self
        positionsCollectionView.register(.init(nibName: "UsersCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "UsersCollectionViewCell")
        
        statusCollectionView.delegate = self
        statusCollectionView.dataSource = self
        statusCollectionView.register(.init(nibName: "UsersCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "UsersCollectionViewCell")
        
    }
    
    
    
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        switch collectionView{
        case nationalityCollectionView:
            return selectedNationality.count
        case projectNameEnglishCollectionView:
            return selectedProjectNameEnglish.count
        case branchCollectionView:
            return selectedBranch.count
        case positionsCollectionView:
            return selectedPositions.count
        case statusCollectionView:
            return selectedStatus.count
        default:
            return 0
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "UsersCollectionViewCell", for: indexPath) as! UsersCollectionViewCell
        cell.delegate = self
        switch collectionView{
        case nationalityCollectionView:
            cell.setData(type:.nationalityCollectionView,data: selectedNationality[indexPath.row], indexPath: indexPath)
        case projectNameEnglishCollectionView:
            cell.setData(type:.projectNameEnglishCollectionView,data: selectedProjectNameEnglish[indexPath.row], indexPath: indexPath)
        case branchCollectionView:
            cell.setData(type:.branchCollectionView,data: selectedBranch[indexPath.row], indexPath: indexPath)
        case positionsCollectionView:
            cell.setData(type:.positionsCollectionView,data: selectedPositions[indexPath.row], indexPath: indexPath)
        case statusCollectionView:
            cell.setData(type:.statusCollectionView,data: selectedStatus[indexPath.row], indexPath: indexPath)
        default:
            break
        }
        return cell
    }
    
    
}
// MARK: - Handling API Request

extension FilterViewController{
    
    private func getFilterData(){
        showLoadingActivity()
        APIController.shard.getFilterData { data in
            DispatchQueue.main.async {
                self.hideLoadingActivity()
                if let status = data.status,status{
                    
                    self.lang_nationalityData = data.records?.nationality_types ?? []
                    self.positionsData = data.records?.positions ?? []
                    self.statusData = data.records?.employee_statuses ?? []
                    
                    
                    self.lang_nationalityDropDown.dataSource = (data.records?.nationality_types ?? []).map{L102Language.currentAppleLanguage() == "ar"  ? $0.name_arabic ?? "" : $0.name_english ?? ""}
                    self.positionsDropDown.dataSource = (data.records?.positions ?? []).map{L102Language.currentAppleLanguage() == "ar"  ? $0.name_arabic ?? "" : $0.name_english ?? ""}
                    self.statusDropDown.dataSource = (data.records?.employee_statuses ?? []).map{L102Language.currentAppleLanguage() == "ar"  ? $0.name_arabic ?? "" : $0.name_english ?? ""}
                }
            }
        }
    }
    
    private func getFilterData2(){
        showLoadingActivity()
        APIController.shard.getFilterData2 { data in
            self.hideLoadingActivity()
            if let status = data.status,status{
                self.branchData = data.branches ?? []
                self.branchDropDown.dataSource = (data.branches ?? []).map{$0.label ?? ""}
                
                self.nationalityData = data.countries ?? []
                self.nationalityDropDown.dataSource = (data.countries ?? []).map{$0.label ?? ""}
            }
        }
    }
    
    private func getFilterData3(){
        showLoadingActivity()
        APIController.shard.getFilterData3 { data in
            self.hideLoadingActivity()
            if let status = data.status, status{
                self.projectNameEnglishData = data.records ?? []
                self.projectNameEnglishDropDown.dataSource = (data.records ?? []).map{$0.quotation_subject ?? ""}
            }
        }
    }
    
}


// MARK: - Cell Delegate

extension FilterViewController:UsersCollectionViewCellDelegate{
    
    func removeAction(type: CollectionType, indexPath: IndexPath) {
        switch type {
        case .nationalityCollectionView:
            selectedNationality.remove(at: indexPath.row)
            nationalityCollectionView.reloadData()
            if selectedNationality.isEmpty {
                nationalityLabel.isHidden = false
            }
        case .projectNameEnglishCollectionView:
            selectedProjectNameEnglish.remove(at: indexPath.row)
            projectNameEnglishCollectionView.reloadData()
            if selectedProjectNameEnglish.isEmpty {
                projectNameEnglishLabel.isHidden = false
            }
        case .branchCollectionView:
            selectedBranch.remove(at: indexPath.row)
            branchCollectionView.reloadData()
            if selectedBranch.isEmpty {
                branchLabel.isHidden = false
            }
        case .positionsCollectionView:
            selectedPositions.remove(at: indexPath.row)
            positionsCollectionView.reloadData()
            if selectedPositions.isEmpty {
                positionsLabel.isHidden = false
            }
        case .statusCollectionView:
            selectedStatus.remove(at: indexPath.row)
            statusCollectionView.reloadData()
            if selectedStatus.isEmpty {
                statusLabel.isHidden = false
            }
        }
    }
}

enum CollectionType{
    case nationalityCollectionView ,
         projectNameEnglishCollectionView ,
         branchCollectionView ,
         positionsCollectionView ,
         statusCollectionView
}

enum TextFiledType{
    case lang_iqama,
    lang_passport,
    lang_membership,
    lang_contract
}

