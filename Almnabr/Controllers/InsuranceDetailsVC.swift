//
//  InsuranceDetailsVC.swift
//  Almnabr
//
//  Created by MacBook on 30/03/2022.
//  Copyright © 2022 Samar Akkila. All rights reserved.
//

import UIKit
import DropDown

class InsuranceDetailsVC: UIViewController {

    @IBOutlet weak var lblInsuranceNumber: UILabel!
    @IBOutlet weak var lblInsuranceDate: UILabel!
    @IBOutlet weak var lblInsuranceTypeClass: UILabel!
    
    @IBOutlet weak var table: UITableView!
    @IBOutlet weak var img_nodata: UIImageView!
    @IBOutlet weak var viewsearch: UIView!
    
    @IBOutlet weak var lblsearchRelationship: UILabel!
    @IBOutlet weak var viewsearchRelationship: UIView!
    @IBOutlet weak var imgDropRelationship: UIImageView!
    
    var profile_obj:ProfileObj?
    
    var searchStatus:String = ""
    var SearchKey:String = ""
    var SearchFilter:String = ""
    var pageNumber = 1
    var arr_data:[InsuranceObj] = []
    var allItemDownloaded = false
    var params:[String:Any] = [:]
    
    var arr_Filter:[String] = ["All".localized(),"Spouse".localized(),"Son".localized(),"Daugther".localized(),"Others".localized()]
    var arr_value: [String] = ["", "1","2","3","4"]
    var arr_NoData:[String] = ["No items found".localized()]
    
    let dropUpmage =  UIImage.fontAwesomeIcon(name: .chevronUp , style: .solid, textColor:  .gray, size: CGSize(width: 40, height: 40))
    let dropDownmage =  UIImage.fontAwesomeIcon(name: .chevronDown , style: .solid, textColor:  .gray, size: CGSize(width: 40, height: 40))
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        configNavigation()
        configGUI()
        get_data(showLoading: true, loadOnly: true)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        // Hide the Navigation Bar
        self.navigationController?.setNavigationBarHidden(false, animated: true)
    }
    
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        // Show the Navigation Bar
        self.navigationController?.setNavigationBarHidden(false, animated: true)
    }
    
    // MARK: - Config Navigation
    func configNavigation() {
        
        _ = self.navigationController?.preferredStatusBarStyle
        self.view.backgroundColor = maincolor //F0F4F8
        //navigationController?.navigationBar.barTintColor = .buttonBackgroundColor()
        navigationController?.navigationBar.barTintColor = maincolor
       addNavigationBarTitle(navigationTitle: "Insurance Details".localized())
        UINavigationBar.appearance().backgroundColor = maincolor
    }


    
    
    //MARK: - Config GUI
    //------------------------------------------------------
    func configGUI() {
       
        
        let Number = "Insurance Number".localized() +  ": \(profile_obj?.insurance_number ?? "---") "
        let Date =  "Insurance Date".localized() + ": \(profile_obj?.insurance_date ?? "---") "
        let TypeClass = "Insurance Type Class".localized() + ": \(profile_obj?.insurance_type_class ?? "---")"
       
        
        let Numberattribute: NSAttributedString = Number.attributedStringWithColor(["Insurance Number"], color: maincolor)
        self.lblInsuranceNumber.attributedText = Numberattribute
        
        let Dateattribute: NSAttributedString = Date.attributedStringWithColor(["Insurance Date"], color: maincolor)
        self.lblInsuranceDate.attributedText = Dateattribute
        
        let TypeClassattribute: NSAttributedString = TypeClass.attributedStringWithColor(["Insurance Type Class"], color: maincolor)
        self.lblInsuranceTypeClass.attributedText = TypeClassattribute
       
        self.viewsearch.setBorderGrayWidthCorner(1, 20)
        self.viewsearchRelationship.setBorderGrayWidthCorner(1, 20)
        
        self.lblsearchRelationship.text = "All"
        
        table.dataSource = self
        table.delegate = self
        let nib = UINib(nibName: "InsuranceTVCell", bundle: nil)
        table.register(nib, forCellReuseIdentifier: "InsuranceTVCell")
      
        
        
        //InsuranceTVCell
    }
    
    
    func get_data(showLoading: Bool, loadOnly: Bool){
        
        if showLoading {
            self.showLoadingActivity()
        }
        let search:String = SearchKey.replacingOccurrences(of: " ", with: "%20").trim()
        self.params["search_key"] = search
        self.params["employee_id_number"] = profile_obj?.employee_id_number
        self.params["id"] = profile_obj?.employee_number
        self.params["branch_id"] = profile_obj?.branch_id
        self.params["searchStatus"] = SearchFilter
        
                                       
        APIController.shard.sendRequestPostAuth(urlString: "my_dependents/\(pageNumber)/10", parameters: self.params ) { (response) in
            self.hideLoadingActivity()
            
            if self.pageNumber == 1 {
                self.arr_data.removeAll()
            }
            let status = response["status"] as? Bool
            if loadOnly {
                self.table.reloadData()
            }
            
            
            let page = response["page"] as? [String:Any]
            if status == true{
                if  let records = response["records"] as? NSArray{
                    for i in records {
                        let dict = i as? [String:Any]
                        let obj = InsuranceObj.init(dict!)
                        self.arr_data.append(obj)
                    }
                    let pageObj = PageObj(page!)
                  
                    if pageObj.total_pages > self.pageNumber {
                        self.allItemDownloaded = false
                    }else{
                        self.allItemDownloaded = true
                    }
                    if records.count == 0 {
                        self.img_nodata.isHidden = false
                    }else{
                        self.img_nodata.isHidden = true
                    }
                    self.table.reloadData()
                   
                    self.hideLoadingActivity()
                }
                
            }else{
                self.img_nodata.isHidden = false
                self.hideLoadingActivity()
            }
            
            
        }
    }
    
    
    
    @IBAction func btnSearchRelationShip_Click(_ sender: Any) {
        
      
        self.imgDropRelationship.image = dropUpmage
        
        let dropDown = DropDown()
        dropDown.anchorView = view
        dropDown.backgroundColor = .white
        dropDown.cornerRadius = 2.0
        
        dropDown.dataSource = self.arr_Filter
        dropDown.selectionAction = { [unowned self] (index: Int, item: String) in
            
            if item == self.arr_Filter[index] {
                self.lblsearchRelationship.text =  item
                let i =  self.arr_value[index]
                self.SearchFilter = i
                self.imgDropRelationship.image = dropDownmage
                get_data(showLoading: true, loadOnly: true)
            }
            
        }
        dropDown.direction = .bottom
        dropDown.anchorView = viewsearchRelationship
        dropDown.bottomOffset = CGPoint(x: 0, y: viewsearchRelationship.bounds.height)
        dropDown.width = viewsearchRelationship.bounds.width
        dropDown.show()
    }
    
    
    
    
}



extension InsuranceDetailsVC: UITableViewDelegate , UITableViewDataSource{
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return arr_data.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "InsuranceTVCell", for: indexPath) as! InsuranceTVCell
        
        let obj = arr_data[indexPath.item]
      
        
        let Name = "Name".localized() + ": \(obj.insurance_dependent_name)"
        let Id = "Id".localized() + ": \(obj.insurance_dependent_number)"
        let InsuranceNumber = "Number".localized() + ": \(obj.insurance_dependent_ins_no)"
       // let InsuranceRelationship = "Relationship".localized() + ": \(obj.insurance_dependent_reaplationship)"
        let InsuranceDate = "Date".localized() + ": \(obj.insurance_dependent_date)"
        let OnUpdate = "On Updated".localized() + ": \(obj.insurance_dependent_updatedate)"
      
        //if obj.insurance_dependent_reaplationship ==
     
        var relation :String = ""
        if let index = arr_value.firstIndex(of: obj.insurance_dependent_reaplationship ) {
            relation = self.arr_Filter[index]
        }
        let InsuranceRelationship = "Relationship".localized() + ": \(relation)"
       
        
        let Nameattribute: NSAttributedString = Name.attributedStringWithColor(["Name"], color: maincolor)
        cell.lblDependentName.attributedText = Nameattribute
        
        let Idattribute: NSAttributedString = Id.attributedStringWithColor(["Id"], color: maincolor)
        cell.lblDependentID.attributedText = Idattribute
        
        let Numberattribute: NSAttributedString = InsuranceNumber.attributedStringWithColor(["Number"], color: maincolor)
        cell.lblInsuranceNumber.attributedText = Numberattribute
        
        let Relationshipattribute: NSAttributedString = InsuranceRelationship.attributedStringWithColor(["Relationship"], color: maincolor)
        cell.lblInsuranceRelationship.attributedText = Relationshipattribute
        
        let Dateattribute: NSAttributedString = InsuranceDate.attributedStringWithColor(["Date"], color: maincolor)
        cell.lblInsuranceDate.attributedText = Dateattribute
        
        let OnUpdateattribute: NSAttributedString = OnUpdate.attributedStringWithColor(["On Updated"], color: maincolor)
        cell.lblOnUpdate.attributedText = OnUpdateattribute

        
        cell.lblDate.text = obj.insurance_dependent_createddate
        
        let writer = "By".localized() + ": \(obj.name)"
        
        let Writerattributed: NSAttributedString = writer.attributedStringWithColor(["By".localized()], color: maincolor)
        cell.lblWriter.attributedText = Writerattributed
        
        
        
        return cell
        
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
//                let obj = arr_data[indexPath.item]
//                let vc:ProjectDetailsVC = AppDelegate.mainSB.instanceVC()
//                vc.title =  self.title
//                vc.Object = obj
//                vc.MenuObj = self.MenuObj
//                vc.StrSubMenue =  self.StrSubMenue
//                vc.StrMenue = self.StrMenue
//        self.navigationController?.pushViewController(vc, animated: true)
//                _ =  panel?.center(vc)
    }
    
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        if tableView.tag == 0 {
            
            
            print(indexPath.section)
            if indexPath.row   == arr_data.count - 1  {
                    updateNextSet()
                    print("next step")
                
            }
      }
      }
    
        func updateNextSet(){
               print("On Completetion")
            if !allItemDownloaded {
                pageNumber = pageNumber + 1
                get_data(showLoading: false, loadOnly: true)
            }
       }
}
   
