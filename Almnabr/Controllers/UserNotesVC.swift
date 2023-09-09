//
//  UserNotesVC.swift
//  Almnabr
//
//  Created by MacBook on 30/03/2022.
//  Copyright © 2022 Samar Akkila. All rights reserved.
//

import UIKit

class UserNotesVC: UIViewController {

@IBOutlet weak var table: UITableView!
@IBOutlet weak var img_nodata: UIImageView!
@IBOutlet weak var viewsearch: UIView!

var profile_obj:ProfileObj?

var SearchKey:String = ""
var pageNumber = 1
var arr_data:[ProfileNoteObj] = []
var allItemDownloaded = false
var params:[String:Any] = [:]

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
    addNavigationBarTitle(navigationTitle: "User Notes".localized())
    UINavigationBar.appearance().backgroundColor = maincolor
}




//MARK: - Config GUI
//------------------------------------------------------
func configGUI() {
    
    
    self.viewsearch.setBorderGrayWidthCorner(1, 20)
    
    table.dataSource = self
    table.delegate = self
    let nib = UINib(nibName: "ProfileNotesTVCell", bundle: nil)
    table.register(nib, forCellReuseIdentifier: "ProfileNotesTVCell")
    
}


func get_data(showLoading: Bool, loadOnly: Bool){
    
    if showLoading {
        self.showLoadingActivity()
    }
    let search:String = SearchKey.replacingOccurrences(of: " ", with: "%20").trim()
    self.params["search_key"] = search
    self.params["id"] = profile_obj?.employee_number
    self.params["branch_id"] = profile_obj?.branch_id
    self.params["search_status"] = ""
 
    
    APIController.shard.sendRequestPostAuth(urlString: "get_my_notes/\(pageNumber)/10", parameters: self.params ) { (response) in
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
                    let obj =  ProfileNoteObj.init(dict!)
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
            self.hideLoadingActivity()
        }
        
        
    }
}


}



extension UserNotesVC: UITableViewDelegate , UITableViewDataSource{

func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return arr_data.count
}

func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    
    let cell = tableView.dequeueReusableCell(withIdentifier: "ProfileNotesTVCell", for: indexPath) as! ProfileNotesTVCell
    
    let obj = arr_data[indexPath.item]
    
    let RemainderDate = "Remainder Date".localized() + ": \(obj.note_remainder_date)"
    let writer = "By".localized() + ": \(obj.name)"
    
    cell.lblDescription.text = obj.note_description
    cell.lblCreatedDate.text = obj.note_created_date
    let Writerattributed: NSAttributedString = writer.attributedStringWithColor(["By".localized()], color: maincolor)
    cell.lblWriter.attributedText = Writerattributed
    
    let RemainderDateattributed: NSAttributedString = RemainderDate.attributedStringWithColor(["Remainder Date".localized()], color: maincolor)
    cell.lblRemainderDate.attributedText = RemainderDateattributed
    
    if obj.show_status == "1" {
        cell.viewStatus.backgroundColor = "32CD32".getUIColor()
    }else{
        cell.viewStatus.backgroundColor = "FF0000".getUIColor()
    }
    
    var link :String = "No"
    if obj.link_with_view_list == "0"{
        link = "No"
    }else{
        link = "Yes"
    }
    let LinkwithLists = "Link with Lists".localized() + ": " + link
    
    let LinkwithListsattributed: NSAttributedString = LinkwithLists.attributedStringWithColor(["Link with Lists".localized()], color: maincolor)
    cell.lblLinkwithLists.attributedText = LinkwithListsattributed
    
    
    
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

