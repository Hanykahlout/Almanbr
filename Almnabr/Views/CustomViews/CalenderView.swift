//
//  CalenderView.swift
//  Almnabr
//
//  Created by Hany Alkahlout on 31/10/2022.
//  Copyright © 2022 Samar Akkila. All rights reserved.
//

import UIKit
import FSCalendar
import SCLAlertView

protocol UICalenderViewDelegate{
    func weekRatioViolationAction(date:String,empNumber:String)
    func monthRatioViolationAction(date:String,empNumber:String,empName:String)
    func goToCreateViolationVC(isCreate:Bool,data:[ViolationRecords])
    
}

class CalenderView: UIView {
    
    @IBOutlet weak var contentStackView: UIStackView!
    @IBOutlet weak var calenderView: FSCalendar!
    
    @IBOutlet weak var selectedDateActivitiesView: UIView!
    @IBOutlet weak var avtivitiesStackView: UIStackView!
    @IBOutlet weak var selectedDateLabel: UILabel!
    
    private var currentCalenderDate = Date()
    private var calenderData = [CalenderActivityLog]()
    var users:[SearchBranchRecords]?
    var delegate: (UICalenderViewDelegate & UIViewController)?
    var isForAllEmployee = false
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        initlization()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        initlization()
    }
    
    private func initlization(){
        Bundle.main.loadNibNamed("CalenderView", owner: self, options: nil)
        contentStackView.fixInView(self)
        setUpCalender()
    }
    
    
    private func setUpCalender(){
        calenderView.delegate = self
        calenderView.locale = .init(identifier: L102Language.currentAppleLanguage())
        
    }

    override func didMoveToSuperview() {
        super.didMoveToSuperview()
        getCalenderData()
    }

    
    private func getYearAndMonth(from date:Date) -> (year:String,month:String){
        let dateFormater = DateFormatter()
        dateFormater.locale = .init(identifier: "en")
        dateFormater.dateFormat = "YYYY"
        let fromYear = dateFormater.string(from: date)
        dateFormater.dateFormat = "MM"
        let fromMonth = dateFormater.string(from: date)
        
        return (year:fromYear , month:fromMonth)
    }
    
    private func formatedDate(date:Date?) ->String{
        let dateFormater = DateFormatter()
        dateFormater.locale = .init(identifier: "en")
        dateFormater.dateFormat = "YYYY/MM/dd"
        return date != nil ? dateFormater.string(from: date!) : ""
    }
    
    private func formatedDate2(date:Date?) ->String{
        let dateFormater = DateFormatter()
        dateFormater.locale = .init(identifier: "en")
        dateFormater.dateFormat = "EEEE, MMMM dd, YYYY"
        return date != nil ? dateFormater.string(from: date!) : ""
    }
    
}


extension CalenderView:FSCalendarDelegate,FSCalendarDelegateAppearance{
    func calendar(_ calendar: FSCalendar, didSelect date: Date, at monthPosition: FSCalendarMonthPosition) {
        let fetchedData = ifThereActivities(on: date)
        self.selectedDateActivitiesView.isHidden = !fetchedData.isThereAnyData
        if fetchedData.isThereAnyData{
            var index = avtivitiesStackView.arrangedSubviews.count - 1
            while index >= 0{
                if index == 0{
                    index = -1
                    continue
                }
                avtivitiesStackView.arrangedSubviews[index].removeFromSuperview()
                index -= 1
            }
            
            if !(fetchedData.data?.no_settings?.isEmpty ?? true){
                let activityView = CalenderActivityUIView(frame: .init())
                activityView.contentView.backgroundColor = UIColor(hexString: "#A6D5FA")
                let data = fetchedData.data?.no_settings ?? []
                activityView.titleLabel.text = "(\(data.count)) No Settings"
                activityView.tableViewHeight.constant = CGFloat(data.count * 200)
                activityView.data = data
                
                activityView.creatViolationAction = { empNumber in
                    
                    self.violationAction(isCreate:true,empNumber: empNumber, date: date)
                }
                
                activityView.cancelViolationAction = { empNumber in
                    
                    self.violationAction(isCreate:false,empNumber: empNumber, date: date)
                }
                
                activityView.openDetailsViolationAction = { userId in
                    self.openDetailsViolation(date: self.formatedDate(date: date), userId: userId)
                }
                
                
                activityView.weekRatioViolationAction = { empNum in
                    self.delegate?.weekRatioViolationAction(date: self.formatedDate(date: date), empNumber: empNum)
                }
                
                activityView.monthRatioViolationAction = { empNumber , empName in
                    self.delegate?.monthRatioViolationAction(date: self.formatedDate(date: date), empNumber: empNumber, empName: empName)
                }
                avtivitiesStackView.addArrangedSubview(activityView)
            }
            
            if !(fetchedData.data?.full_time?.isEmpty ?? true){
                let activityView = CalenderActivityUIView(frame: .init())
                activityView.contentView.backgroundColor = UIColor(hexString: "#A6FAB8")
                let data = fetchedData.data?.full_time ?? []
                activityView.titleLabel.text = "(\(data.count)) Full Time"
                activityView.tableViewHeight.constant = CGFloat(data.count * 200)
                activityView.data = data
                
                activityView.creatViolationAction = { empNumber in
                    
                    self.violationAction(isCreate:true,empNumber: empNumber, date: date)
                }
                
                activityView.cancelViolationAction = { empNumber in
                    
                    self.violationAction(isCreate:false,empNumber: empNumber, date: date)
                }
                
                activityView.openDetailsViolationAction = { userId in
                    self.openDetailsViolation(date: self.formatedDate(date: date), userId: userId)
                }
                
                activityView.weekRatioViolationAction = { empNum in
                    self.delegate?.weekRatioViolationAction(date: self.formatedDate(date: date), empNumber: empNum)
                }
                
                activityView.monthRatioViolationAction = { empNumber , empName in
                    self.delegate?.monthRatioViolationAction(date: self.formatedDate(date: date), empNumber: empNumber, empName: empName)
                }
                avtivitiesStackView.addArrangedSubview(activityView)
            }
            
            
            if !(fetchedData.data?.absent?.isEmpty ?? true){
                let activityView = CalenderActivityUIView(frame: .init())
                activityView.contentView.backgroundColor = UIColor(hexString: "#F5E5C6")
                let data = fetchedData.data?.absent ?? []
                activityView.titleLabel.text = "(\(data.count)) Absent"
                activityView.tableViewHeight.constant = CGFloat(data.count * 200)
                activityView.data = data
                
                activityView.creatViolationAction = { empNumber in
                    
                    self.violationAction(isCreate:true,empNumber: empNumber, date: date)
                }
                
                activityView.cancelViolationAction = { empNumber in
                    
                    self.violationAction(isCreate:false,empNumber: empNumber, date: date)
                }
                
                
                activityView.openDetailsViolationAction = { userId in
                    self.openDetailsViolation(date: self.formatedDate(date: date), userId: userId)
                }
                
                activityView.weekRatioViolationAction = { empNum in
                    self.delegate?.weekRatioViolationAction(date: self.formatedDate(date: date), empNumber: empNum)
                }
                
                activityView.monthRatioViolationAction = { empNumber , empName in
                    self.delegate?.monthRatioViolationAction(date: self.formatedDate(date: date), empNumber: empNumber, empName: empName)
                }
                avtivitiesStackView.addArrangedSubview(activityView)
            }
            
            if !(fetchedData.data?.record_missing?.isEmpty ?? true){
                let activityView = CalenderActivityUIView(frame: .init())
                activityView.contentView.backgroundColor = UIColor(hexString: "#E6E4FB")
                let data = fetchedData.data?.record_missing ?? []
                activityView.titleLabel.text = "(\(data.count)) Record Missing"
                activityView.tableViewHeight.constant = CGFloat(data.count * 200)
                activityView.data = data
                
                activityView.creatViolationAction = { empNumber in
                    
                    self.violationAction(isCreate:true,empNumber: empNumber, date: date)
                }
                
                activityView.cancelViolationAction = { empNumber in
                    
                    self.violationAction(isCreate:false,empNumber: empNumber, date: date)
                }
                
                
                activityView.openDetailsViolationAction = { userId in
                    self.openDetailsViolation(date: self.formatedDate(date: date), userId: userId)
                }
                
                activityView.weekRatioViolationAction = { empNum in
                    self.delegate?.weekRatioViolationAction(date: self.formatedDate(date: date), empNumber: empNum)
                }
                
                activityView.monthRatioViolationAction = { empNumber , empName in
                    self.delegate?.monthRatioViolationAction(date: self.formatedDate(date: date), empNumber: empNumber, empName: empName)
                }
                avtivitiesStackView.addArrangedSubview(activityView)
            }
            
            
            if !(fetchedData.data?.ok?.isEmpty ?? true){
                let activityView = CalenderActivityUIView(frame: .init())
                activityView.contentView.backgroundColor = UIColor(hexString: "#DEEDCB")
                let data = fetchedData.data?.ok ?? []
                activityView.titleLabel.text = "(\(data.count)) Ok"
                activityView.tableViewHeight.constant = CGFloat(data.count * 200)
                activityView.data = data
                activityView.creatViolationAction = { empNumber in
                    
                    self.violationAction(isCreate:true,empNumber: empNumber, date: date)
                }
                
                activityView.cancelViolationAction = { empNumber in
                    
                    self.violationAction(isCreate:false,empNumber: empNumber, date: date)
                }
                
                
                activityView.openDetailsViolationAction = { userId in
                    self.openDetailsViolation(date: self.formatedDate(date: date), userId: userId)
                }
                
                activityView.weekRatioViolationAction = { empNum in
                    self.delegate?.weekRatioViolationAction(date: self.formatedDate(date: date), empNumber: empNum)
                }
                
                activityView.monthRatioViolationAction = { empNumber , empName in
                    self.delegate?.monthRatioViolationAction(date: self.formatedDate(date: date), empNumber: empNumber, empName: empName)
                }
                avtivitiesStackView.addArrangedSubview(activityView)
            }
            
            
            if !(fetchedData.data?.not_ok?.isEmpty ?? true){
                let activityView = CalenderActivityUIView(frame: .init())
                activityView.contentView.backgroundColor = UIColor(hexString: "#FAC8C9")
                let data = fetchedData.data?.not_ok ?? []
                activityView.titleLabel.text = "(\(data.count)) Not Ok"
                activityView.tableViewHeight.constant = CGFloat(data.count * 200)
                activityView.data = data
                
                activityView.creatViolationAction = { empNumber in
                    self.violationAction(isCreate:true,empNumber: empNumber, date: date)
                }
                
                activityView.cancelViolationAction = { empNumber in
                    
                    self.violationAction(isCreate:false,empNumber: empNumber, date: date)
                }
                
                activityView.openDetailsViolationAction = { userId in
                    self.openDetailsViolation(date: self.formatedDate(date: date), userId: userId)
                }
                
                activityView.weekRatioViolationAction = { empNum in
                    self.delegate?.weekRatioViolationAction(date: self.formatedDate(date: date), empNumber: empNum)
                }
                
                activityView.monthRatioViolationAction = { empNumber , empName in
                    self.delegate?.monthRatioViolationAction(date: self.formatedDate(date: date), empNumber: empNumber, empName: empName)
                }
                
                avtivitiesStackView.addArrangedSubview(activityView)
            }
            
            self.selectedDateLabel.text = !self.selectedDateActivitiesView.isHidden ? formatedDate2(date: date) : "----"
        }
    }
    
    private func violationAction(isCreate:Bool,empNumber:String,date:Date){
        let dateData = getTheCurrentAndNextDateString(form: date)
        self.getViolations(isCreate:isCreate,empNumber:empNumber,fromYear: dateData.currentYear, fromMonth: dateData.currentMonth, fromDay: dateData.currentDay, toYear: dateData.nextYear, toMonth: dateData.nextMonth, toDay: dateData.nextDay)
    }
    
    func calendar(_ calendar: FSCalendar, appearance: FSCalendarAppearance, fillDefaultColorFor date: Date) -> UIColor? {
        if formatedDate(date: date) == formatedDate(date: Date()){
            return maincolor
        }
        
        let data = ifThereActivities(on:date)
        if  data.isThereAnyData{
            if !isForAllEmployee{
                if !(data.data?.no_settings?.isEmpty ?? true){
                    return UIColor(hexString: "#A6D5FA")
                }else if !(data.data?.full_time?.isEmpty ?? true){
                    return UIColor(hexString: "#A6FAB8")
                }else if !(data.data?.absent?.isEmpty ?? true){
                    return UIColor(hexString: "#F5E5C6")
                }else if !(data.data?.record_missing?.isEmpty ?? true){
                    return UIColor(hexString: "#E6E4FB")
                }else if !(data.data?.ok?.isEmpty ?? true){
                    return UIColor(hexString: "#DEEDCB")
                }else if !(data.data?.not_ok?.isEmpty ?? true){
                    return UIColor(hexString: "#FAC8C9")
                }
                return .clear
            }
            return .systemGreen
        }
        return .clear
    }
    
    
    private func ifThereActivities(on date:Date) -> (isThereAnyData:Bool,data:CalenderActivityValue?){
        let currentDate = calenderData.filter{$0.date == formatedDate(date: date)}.first
        if let currentDate = currentDate {
            let dateActivities = currentDate.value
            if !(dateActivities?.no_settings?.isEmpty ?? true) ||
                !(dateActivities?.full_time?.isEmpty ?? true) ||
                !(dateActivities?.absent?.isEmpty ?? true) ||
                !(dateActivities?.record_missing?.isEmpty ?? true) ||
                !(dateActivities?.ok?.isEmpty ?? true) ||
                !(dateActivities?.not_ok?.isEmpty ?? true){
                return (isThereAnyData:true,data:dateActivities)
            }
        }
        return (isThereAnyData:false,data:nil)
    }
    
    
    private func getTheCurrentAndNextDateString(form date:Date) -> (currentYear:String,currentMonth:String,currentDay:String,nextYear:String,nextMonth:String,nextDay:String){
        let nextDate = Calendar.current.date(byAdding: .day, value: 1, to: date)!
        let dateFormatter = DateFormatter()
        dateFormatter.locale = .init(identifier: "en")
        dateFormatter.dateFormat = "dd"
        let currentDay = dateFormatter.string(from: date)
        let nextDay = dateFormatter.string(from: nextDate)
        
        dateFormatter.dateFormat = "MM"
        let currentMonth = dateFormatter.string(from: date)
        let nextMonth = dateFormatter.string(from: nextDate)
        
        dateFormatter.dateFormat = "YYYY"
        let currentYear = dateFormatter.string(from: date)
        let nextYear = dateFormatter.string(from: nextDate)
        
        return (currentYear,currentMonth,currentDay,nextYear,nextMonth,nextDay)
    }
    
    
    func calendarCurrentPageDidChange(_ calendar: FSCalendar) {
        currentCalenderDate = calendar.currentPage
        getCalenderData()
    }
    
}


// MARK: API Handling
extension CalenderView{
    func getCalenderData(){
        let data = getYearAndMonth(from: currentCalenderDate)
        let fromYear = data.year
        let fromMonth = data.month
        
        var param:[String:Any] = ["from_year": fromYear,
                                  "from_month": fromMonth,
                                  "from_day":"01",
                                  "to_year": fromYear,
                                  "to_month": fromMonth,
                                  "to_day":"31",
                                  "type": 1
        ]
        
        if !isForAllEmployee{
            param["employee_number[]"] = Auth_User.user_id
        }else{
            if let users = users , !users.isEmpty{
                for index in 0..<users.count{
                    param["employee_number[\(index)]"] = users[index].value ?? ""
                }
            }
        }
        
        self.selectedDateActivitiesView.isHidden = true
        APIController.shard.getCalenderData(param: param) { data in
            if let status = data.status , status{
                self.calenderData = data.data?.log ?? []
                self.calenderView.reloadData()
                
            }
        }
    }
    
    private func getViolations(isCreate:Bool,empNumber:String,fromYear:String,fromMonth:String,fromDay:String,toYear:String,toMonth:String,toDay:String){
        let param:[String:Any] = ["from_year": fromYear,
                                  "from_month": fromMonth,
                                  "from_day": fromDay,
                                  "to_year": fromYear,
                                  "to_month": fromMonth,
                                  "to_day":toDay,
                                  "employee_number[]": empNumber
        ]
        
        showLoadingActivity()
        APIController.shard.getViolations(param: param) { data in
            self.hideLoadingActivity()
            if let status = data.status , status {
                DispatchQueue.main.async {
                    self.delegate?.goToCreateViolationVC(isCreate: isCreate, data: data.records ?? [])
                }
            }else{
                SCLAlertView().showError("error".localized(), subTitle: data.error ?? "")
            }
            
        }
    }
    
    private func openDetailsViolation(date:String,userId:String){
        let body = [
            "date": date,
            "user_id": userId
        ]
        showLoadingActivity()
        APIController.shard.openDetailsViolation(body: body) { data in
            self.hideLoadingActivity()
            if let status = data.status , status{
                // Some thing here
            }else{
                SCLAlertView().showError("error".localized(), subTitle: data.msg ?? "")
            }
        }
    }
    
}

