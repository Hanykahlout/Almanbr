//
//  TeamUserVC.swift
//  Almnabr
//
//  Created by MacBook on 19/10/2021.
//  Copyright © 2021 Samar Akkila. All rights reserved.
//

import UIKit
import DPLocalization
import FontAwesome_swift
import DropDown

class TeamUserVC: UIViewController {

    
    @IBOutlet weak var lblPosition: UILabel!
    
    @IBOutlet weak var viewPosition: UIView!
    
    @IBOutlet weak var btnPosition: UIButton!
    
    @IBOutlet weak var imgDropPosition: UIImageView!
    
    @IBOutlet weak var mainView: UIView!
    @IBOutlet weak var table: UITableView!
    @IBOutlet weak var searchBar: UISearchBar!
    
    @IBOutlet weak var viewsearch: UIView!
    @IBOutlet weak var img_nodata: UIImageView!
    @IBOutlet weak var tableHeightConstraint:NSLayoutConstraint!
    
    
    var StrTitle:String = ""
    var StrSubMenue:String = ""
    var StrPosition:String = ""
    var SearchKey:String = ""
    
   
    var pageNumber = 1
    var total:Int = 0
    var allItemDownloaded = false
    var MenuObj:MenuObj?
    var SubMenuObj:MenuObj?
    var arr_data:[projectQuotObj] = []
    var arr_Position:[ModuleObj] = []
    var arr_PositionLabel:[String] = []
    var arr_NoData:[String] = ["No items found".localized()]
    
    let dropUpmage =  UIImage.fontAwesomeIcon(name: .chevronUp , style: .solid, textColor:  .gray, size: CGSize(width: 40, height: 40))
    
    let dropDownmage =  UIImage.fontAwesomeIcon(name: .chevronDown , style: .solid, textColor:  .gray, size: CGSize(width: 40, height: 40))
    
    override public func viewDidLoad() {
        super.viewDidLoad()
        
        configGUI()
        get_TeamUsers_data(showLoading: true, loadOnly: true)
        get_Position()
       
        
        
        
    }
    
    
    func configNavigation() {
        _ = self.navigationController?.preferredStatusBarStyle
        self.view.backgroundColor = "FFFFFF".getUIColor() //F0F4F8
        navigationController?.navigationBar.barTintColor = .red
        
        addNavigationBarTitle(navigationTitle: StrTitle)
    }
    
    func configGUI() {
        
        
       
        //self.viewPosition.setBorderGray()
        self.viewPosition.setBorderGrayWidthCorner(1, 20)
        self.lblPosition.text =  "txt_Position".localized()
        self.lblPosition.font = .kufiRegularFont(ofSize: 15)
        
        
        
        btnPosition.isHidden = true
      
        //self.mainView.setBorderGray()
        
        
        self.img_nodata.isHidden = false
        searchBar.delegate = self
        
        self.imgDropPosition.image = dropDownmage
        
        table.dataSource = self
        table.delegate = self
        let nib = UINib(nibName: "TeamUserTVCell", bundle: nil)
        table.register(nib, forCellReuseIdentifier: "TeamUserTVCell")
       
        
    }
    
    func get_TeamUsers_data(showLoading: Bool, loadOnly: Bool){
        
        if showLoading {
            self.showLoadingActivity()
        }
        let search:String = SearchKey.replacingOccurrences(of: " ", with: "%20").trim()
        
        APIController.shard.sendRequestGetAuth(urlString: "PMypAe3X1IuW3jx/\(projects_profile_id)/\(projects_work_area_id)/\(pageNumber)/10?searchKey=\(search)&positions=\(StrPosition)" ) { (response) in
            
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
                        let obj = projectQuotObj.init(dict!)
                        self.arr_data.append(obj)
                    }
                    
                    let pageObj = PageObj(page!)
                    
                  
                    if self.arr_data.count == 0 {
                        self.img_nodata.isHidden = false
                    }else{
                        self.img_nodata.isHidden = true
                    }
                    
                    if pageObj.total_pages > self.pageNumber {
                        self.allItemDownloaded = false
                    }else{
                        self.allItemDownloaded = true
                    }
                    self.table.reloadData()
                   
                    self.hideLoadingActivity()
                }
                
            }else{
                self.hideLoadingActivity()
                self.img_nodata.isHidden = false
            }
            
            
        }
        
     
        
    }
    
    
    func get_Position(){
        
        self.showLoadingActivity()
        APIController.shard.sendRequestGetAuth(urlString: "/366484fd45" ) { (response) in
            
            
            let status = response["status"] as? Bool
            if status == true{
                if  let list = response["records"] as? NSArray{
                    for i in list {
                        let dict = i as? [String:Any]
                        let obj = ModuleObj.init(dict!)
                        self.arr_Position.append(obj)
                        
                        self.arr_PositionLabel.append(obj.label)
                      
                        
                    }
                    self.hideLoadingActivity()
                }
            }
            self.hideLoadingActivity()
            
        }
    }
    
 
    
    @IBAction func btnPosition_Click(_ sender: Any) {
        
        self.imgDropPosition.image = dropUpmage
        let vc :PickerVC = AppDelegate.mainSB.instanceVC()
        vc.arr_data =  arr_PositionLabel
        vc.isModalInPresentation = true
        vc.modalPresentationStyle = .overFullScreen
        vc.definesPresentationContext = true
        vc.delegate = {name , index in
            if name == self.arr_PositionLabel[index] {
                self.lblPosition.text =  name
                let i =  self.arr_Position[index]
                self.StrPosition = i.value
                self.btnPosition.isHidden = false
                self.imgDropPosition.image = self.dropDownmage
                self.get_TeamUsers_data(showLoading: true, loadOnly: true)
              
            }
        }
        self.present(vc, animated: true, completion: nil)
        
    }
    
    
    @IBAction func btnPositionDelete_Click(_ sender: Any) {
        self.lblPosition.text = "txt_Position".localized()
        self.btnPosition.isHidden = true
        self.StrPosition = ""
        get_TeamUsers_data(showLoading: true, loadOnly: true)
    }
    
}


extension TeamUserVC: UITableViewDelegate , UITableViewDataSource{
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return arr_data.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "TeamUserTVCell", for: indexPath) as! TeamUserTVCell
        
        let obj = arr_data[indexPath.item]
        
        let Name =  "\(obj.label)"
        let Title = "Title".localized() + ":  \(obj.teamtitle)"
        let Positions = "\(obj.position)"
        let Role = "Role".localized() + "  \(obj.project_user_group_mention_key)"
        let writer = "By".localized() + ":  \(obj.writer)"
        let Date = "\(obj.project_user_group_created_datetime)"
        
        let maincolor = "#1A3665".getUIColor()
        
      
        cell.lblName.text = Name
        cell.lblPosition.text = Positions
        cell.lblWriter.text = writer
        cell.lblDate.text = Date
        
        
        let Titleattribute: NSAttributedString = Title.attributedStringWithColor(["Title"], color: maincolor)
        cell.lblTitle.attributedText = Titleattribute
        
        
        let Roleattributed: NSAttributedString = Role.attributedStringWithColor(["Role".localized()], color: maincolor)
        cell.lblRole.attributedText = Roleattributed
        
        let writerattributed: NSAttributedString = writer.attributedStringWithColor(["writer".localized()], color: maincolor)
        cell.lblWriter.attributedText = writerattributed
        
        cell.viewBack.setRounded(12)
        
        return cell
        
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
            get_TeamUsers_data(showLoading: false, loadOnly: false)
        }
    }
}


extension TeamUserVC:UISearchBarDelegate {
    
    
    func searchBarTextDidEndEditing(_ searchBar: UISearchBar) {
       self.SearchKey = searchBar.text!
        get_TeamUsers_data(showLoading: false, loadOnly: false)
    }

    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        //searchBar.resignFirstResponder()
        self.SearchKey = searchBar.text!
         get_TeamUsers_data(showLoading: false, loadOnly: false)
        searchBar.resignFirstResponder()
    }
    
    
}
