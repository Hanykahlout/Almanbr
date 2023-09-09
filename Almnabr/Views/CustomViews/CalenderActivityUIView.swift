//
//  CalenderActivityUIView.swift
//  Almnabr
//
//  Created by Hany Alkahlout on 24/10/2022.
//  Copyright © 2022 Samar Akkila. All rights reserved.
//

import UIKit

class CalenderActivityUIView: UIView {
    
    @IBOutlet weak var contentView: UIView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var titleArrow: UIImageView!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var tableViewHeight: NSLayoutConstraint!
    var data = [No_settings]()
    var creatViolationAction: ((_ empNumber:String) -> Void)?
    var cancelViolationAction: ((_ empNumber:String) -> Void)?
    var openDetailsViolationAction: ((_ userId:String) -> Void)?
    var weekRatioViolationAction: ((_ empNumber:String) -> Void)?
    var monthRatioViolationAction: ((_ empNumber:String , _ empName:String) -> Void)?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        initlization()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        initlization()
    }
    
    private func initlization(){
        Bundle.main.loadNibNamed("CalenderActivityView", owner: self, options: nil)
        contentView.fixInView(self)
        setUpTableView()
        contentView.addTapGesture {
            self.tableView.isHidden = !self.tableView.isHidden
            self.titleArrow.transform = .init(rotationAngle: self.tableView.isHidden == true ? 0 : .pi)
        }
    }
    
    
    
    
}

extension CalenderActivityUIView:UITableViewDelegate,UITableViewDataSource{
    private func setUpTableView(){
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(.init(nibName: "CalendarActivityTableViewCell", bundle: nil), forCellReuseIdentifier: "CalendarActivityTableViewCell")
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return data.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "CalendarActivityTableViewCell", for: indexPath) as! CalendarActivityTableViewCell
        cell.setData(index: indexPath.row, data: data[indexPath.row])
        cell.creatViolationAction = self.creatViolationAction
        cell.cancelViolationAction = self.cancelViolationAction
        cell.openDetailsViolationAction = self.openDetailsViolationAction
        cell.weekRatioViolationAction = self.weekRatioViolationAction
        cell.monthRatioViolationAction = self.monthRatioViolationAction        
        return cell
    }
}


extension UIView{
    func fixInView(_ container: UIView!) -> Void{
         self.translatesAutoresizingMaskIntoConstraints = false;
         self.frame = container.frame;
         container.addSubview(self);
         NSLayoutConstraint(item: self, attribute: .leading, relatedBy: .equal, toItem: container, attribute: .leading, multiplier: 1.0, constant: 0).isActive = true
         NSLayoutConstraint(item: self, attribute: .trailing, relatedBy: .equal, toItem: container, attribute: .trailing, multiplier: 1.0, constant: 0).isActive = true
         NSLayoutConstraint(item: self, attribute: .top, relatedBy: .equal, toItem: container, attribute: .top, multiplier: 1.0, constant: 0).isActive = true
         NSLayoutConstraint(item: self, attribute: .bottom, relatedBy: .equal, toItem: container, attribute: .bottom, multiplier: 1.0, constant: 0).isActive = true
     }
}
