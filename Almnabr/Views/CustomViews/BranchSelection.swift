//
//  BranchSelection.swift
//  Almnabr
//
//  Created by Hany Alkahlout on 08/01/2023.
//  Copyright © 2023 Samar Akkila. All rights reserved.
//

import UIKit
import DropDown
import SCLAlertView

class BranchSelection: UIView {
    @IBOutlet weak var mainView: UIView!
    
    @IBOutlet weak var optionsTextrField: UITextField!
    @IBOutlet weak var optionsArrow: UIImageView!
    @IBOutlet weak var financialYearTextField: UITextField!
    
    @IBOutlet weak var financialYearArrow: UIImageView!
    @IBOutlet weak var financialYearView: UIView!
    
    private let optionsDropDown = DropDown()
    private var options = [AccountOptionsRecord]()
    
    private var financialYearDropDown = DropDown()
    private var financialYears = [AccountFinancialRecord]()
    
    var withFinancialYearSelection = true
    var selecetdfinancialYear: String?
    var selecetdBranchId: String?
    var branchSelectionAction : ((_ selectedBranch:String)->Void)?
    var financialYearSelectionAction : ((_ selectedYear:String)->Void)?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        initialization()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        initialization()
    }
    
    private func initialization(){
        Bundle.main.loadNibNamed("BranchSelection", owner: self, options: nil)
        mainView.fixInView(self)
        setUpDropDown()
        getOptions()
    }
    
    private func setUpDropDown(){
        //        optionsDropDown
        optionsDropDown.anchorView = optionsTextrField
        optionsDropDown.bottomOffset = CGPoint(x: 0, y:(optionsDropDown.anchorView?.plainView.bounds.height)!)
        
        optionsDropDown.selectionAction = { [unowned self] (index: Int, item: String) in
            optionsArrow.transform = .init(rotationAngle: 0)
            if index == 0{
                self.optionsTextrField.text = item
                branchSelectionAction?("")
                financialYearView.isHidden = true
            }else{
                let objc = options[index - 1]
                branchSelectionAction?(objc.id ?? "")
                self.optionsTextrField.text = objc.title ?? ""
                if withFinancialYearSelection{
                    financialYearView.isHidden = false
                    getAccountFinancialOptions(branch_id: objc.id ?? "")
                }
            }
        }
        
        optionsDropDown.cancelAction = { [unowned self] in
            optionsArrow.transform = .init(rotationAngle: .pi)
        }
        
        optionsTextrField.addTapGesture {
            self.optionsArrow.transform = .init(rotationAngle: .pi)
            self.optionsDropDown.show()
        }
        
        // financialYearDropDown
        financialYearDropDown.anchorView = financialYearTextField
        financialYearDropDown.bottomOffset = CGPoint(x: 0, y:(financialYearDropDown.anchorView?.plainView.bounds.height)!)
        
        financialYearDropDown.selectionAction = { [unowned self] (index: Int, item: String) in
            financialYearArrow.transform = .init(rotationAngle: 0)
            
            if index == 0{
                self.financialYearTextField.text = item
                financialYearSelectionAction?("")
            }else{
                let objc = financialYears[index - 1]
                financialYearSelectionAction?(objc.value ?? "")
                self.financialYearTextField.text = objc.label ?? ""
            }
        }
        
        financialYearDropDown.cancelAction = { [unowned self] in
            financialYearArrow.transform = .init(rotationAngle: .pi)
        }
        
        financialYearTextField.addTapGesture {
            self.financialYearArrow.transform = .init(rotationAngle: .pi)
            self.financialYearDropDown.show()
        }
    }
    
    
}


// MARK: - API Handling
extension BranchSelection{
    private func getOptions(){
        APIController.shard.getAccountSettingsOptions { data in
            if let status = data.status,status{
                let apiOptions = data.records ?? []
                self.options = apiOptions
                self.optionsDropDown.dataSource.append("Choose Option")
                self.optionsDropDown.dataSource.append(contentsOf: apiOptions.map{$0.title ?? ""})
                
                if let selecetdBranchId = self.selecetdBranchId{
                    let selectedIndex = (self.options.firstIndex(where: {$0.id == selecetdBranchId}) ?? 0)
//                    self.optionsDropDown.selectRow(at: selectedIndex + 1 )
                    self.branchSelectionAction?(selecetdBranchId)
                    self.optionsTextrField.text = self.options[selectedIndex].title ?? ""
                    if self.withFinancialYearSelection{
                        self.financialYearView.isHidden = false
                        self.getAccountFinancialOptions(branch_id: self.options[selectedIndex].id ?? "")
                    }
                }
            }else{
                SCLAlertView().showError("error".localized(), subTitle: data.error ?? "There is an unknow error!!")
            }
        }
    }
    
    
    private func getAccountFinancialOptions(branch_id:String){
        APIController.shard.getAccountFinancialOptions(branch_id: branch_id) { data in
            DispatchQueue.main.async{
                if let status = data.status,status{
                    let records = data.records ?? []
                    self.financialYears = records
                    self.financialYearDropDown.dataSource = ["Financial Year"]
                    self.financialYearDropDown.dataSource.append(contentsOf: self.financialYears.map{$0.label ?? ""})
                    
                    if let selecetdfinancialYear = self.selecetdfinancialYear {
                        let selectedIndex = (self.financialYears.firstIndex(where: {$0.value == selecetdfinancialYear}) ?? 0)
                        let objc = self.financialYears[selectedIndex]
                        self.financialYearSelectionAction?(objc.value ?? "")
                        self.financialYearTextField.text = objc.label ?? ""
                    }
                }
            }
        }
    }
    
    
    
}




