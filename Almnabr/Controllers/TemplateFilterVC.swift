//
//  TemplateFilterVC.swift
//  Almnabr
//
//  Created by MacBook on 22/01/2022.
//  Copyright © 2022 Samar Akkila. All rights reserved.
//

import UIKit
import DropDown
import SwiftUI

class TemplateFilterVC: UIViewController {

    @IBOutlet weak var viewzone: DropDownView!
    @IBOutlet weak var viewBlocks: DropDownView!
    @IBOutlet weak var viewClusters: DropDownView!
    
    @IBOutlet weak var lblFilter: UILabel!
    @IBOutlet weak var btnSave: UIButton!
    @IBOutlet weak var btnCancel: UIButton!
    
    
    let dropUpmage =  UIImage.fontAwesomeIcon(name: .chevronUp , style: .solid, textColor:  .gray, size: CGSize(width: 40, height: 40))
    
    let dropDownmage =  UIImage.fontAwesomeIcon(name: .chevronDown , style: .solid, textColor:  .gray, size: CGSize(width: 40, height: 40))
    
    var arr_NoData:[String] = ["No items found".localized()]
    var arr_zone:[String] = []
    
    var IsZone:Bool = false
    var IsBlock:Bool = false
    var IsClusters:Bool = false
    
    var Zone:String = ""
    var Block:String = ""
    var Clusters:String = ""
    
    var ZoneId:String = ""
    var BlockId:String = ""
    var ClustersId:String = ""
    
    var arr_Zone :[PhaseObj] = []
    var arr_Block :[PhaseObj] = []
    var arr_Clusters :[PhaseObj] = []
    
    var arr_SelectedZone : [String:Any] = [:]
    var arr_SelectedBlock : [String:Any] = [:]
    var arr_SelectedClusters : [String:Any] = [:]
    
    var delegate: FilterDelegate!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        ConfigGUI()
        get_Zone()
    }
    
    
    func ConfigGUI(){
       
        
        self.btnSave.setTitle("Save".localized(), for: .normal)
        self.btnSave.backgroundColor =  HelperClassSwift.acolor.getUIColor()
        self.btnSave.setTitleColor(.white, for: .normal)
        self.btnSave.setRounded(10)
        
        self.btnCancel.setTitle("Cancel".localized(), for: .normal)
        self.btnCancel.backgroundColor =  HelperClassSwift.acolor.getUIColor()
        self.btnCancel.setTitleColor(.white, for: .normal)
        self.btnCancel.setRounded(10)
        
      
        viewzone.tf_searchTitle.placeholder = "Zone".localized()
        viewBlocks.tf_searchTitle.placeholder = "Blocks".localized()
        viewClusters.tf_searchTitle.placeholder = "Clusters".localized()
        
        viewzone.lbl_searchTitle.text = "Zone".localized()
        viewBlocks.lbl_searchTitle.text = "Blocks".localized()
        viewClusters.lbl_searchTitle.text = "Clusters".localized()
       
        viewzone.btnSearchAction = self.setupzone
        viewBlocks.btnSearchAction = self.setupblocks
        viewClusters.btnSearchAction = self.setupclusters
        
    }
    
    
    func func_dropDown(arr_dataSource:[String],view_drop:UIView,tf_name:UITextField,img_Drop:UIImageView,btn_drop:UIButton,title:String) -> (String,Bool)  {
        //-> String
       var selected_item:String = ""
        var Iscanceled:Bool = false
        //"title".localized()
       //self.img_Drop.image = dropUpmage
        let dropDown = DropDown()
        dropDown.anchorView = view
        dropDown.backgroundColor = .white
        dropDown.cornerRadius = 2.0
        
        dropDown.cancelAction = {
            btn_drop.isHidden = false
            img_Drop.image = self.dropDownmage
            Iscanceled = true
        }
        if arr_dataSource.count == 0 {
            dropDown.dataSource = self.arr_NoData
            dropDown.selectionAction = { [unowned self] (index: Int, item: String) in
                img_Drop.image = dropDownmage
            }
            dropDown.textColor = #colorLiteral(red: 0.8039215803, green: 0.8039215803, blue: 0.8039215803, alpha: 1)
        }else{
            dropDown.dataSource = arr_dataSource
            dropDown.selectionAction = { [unowned self] (index: Int, item: String) in
                
                if item == arr_dataSource[index] {
                    Iscanceled = false
                    if IsZone == true {
                        let Id = arr_Zone[index].phase_id
                        self.get_Blocks(zoneId: Id)
                        selected_item = item
                        self.Zone = item
                        self.ZoneId = Id

                    }else if IsBlock == true{
                        let Id = arr_Block[index].phase_id
                        self.get_clusTers(blockId: Id)
                        selected_item = item
                        self.Block = item
                        self.BlockId = Id
                        
                    } else if IsClusters == true{
                        
                        let Id = arr_Clusters[index].value
                        
                        selected_item = item
                        self.Clusters = item
                        self.ClustersId = Id
                    }
                    
                    btn_drop.isHidden = false
                    img_Drop.image = self.dropDownmage
                    tf_name.text =  item
                    
                }
                
            }
        }
        
        dropDown.direction = .bottom
        dropDown.anchorView = view_drop
        dropDown.bottomOffset = CGPoint(x: 0, y: view_drop.bounds.height)
        dropDown.width = view_drop.bounds.width
        dropDown.show()
        return (selected_item ,Iscanceled )
    }
   
    
    func get_Zone(){
        
        self.showLoadingActivity()
        
        let url = "joYF29rbEi/1/1?phase_parent_id=0"
        APIController.shard.sendRequestGetAuth(urlString: url) { (response) in
            self.hideLoadingActivity()
          
            let status = response["status"] as? Bool
            
            if status == true{
                
                if  let list = response["records"] as? NSArray{
                    self.arr_Zone = []
                    for i in list {
                        let dict = i as? [String:Any]
                        let obj = PhaseObj.init(dict!)
                        self.arr_Zone.append(obj)
                    }
                   
                  
                    self.hideLoadingActivity()
                }
            }
        }
    }
    
    
    func get_Blocks(zoneId:String){
        
        self.showLoadingActivity()
        
        let url = "joYF29rbEi/1/1?phase_parent_id=\(zoneId)"
        APIController.shard.sendRequestGetAuth(urlString: url) { (response) in
            self.hideLoadingActivity()
          
            let status = response["status"] as? Bool
            
            if status == true{
                
                self.arr_Block = []
                if  let list = response["records"] as? NSArray{
                    
                    for i in list {
                        let dict = i as? [String:Any]
                        let obj = PhaseObj.init(dict!)
                        self.arr_Block.append(obj)
                    }
                   
                  
                    self.hideLoadingActivity()
                }
            }
        }
    }
    
    func get_clusTers(blockId:String){
        
        self.showLoadingActivity()
        
        let url = "joYF29rbEi/1/1?phase_parent_id=\(blockId)"
        APIController.shard.sendRequestGetAuth(urlString: url) { (response) in
            self.hideLoadingActivity()
          
            let status = response["status"] as? Bool
            
            if status == true{
                
                if  let list = response["records"] as? NSArray{
                    self.arr_Clusters = []
                    for i in list {
                        let dict = i as? [String:Any]
                        let obj = PhaseObj.init(dict!)
                        self.arr_Clusters.append(obj)
                    }
                   
                  
                    self.hideLoadingActivity()
                }
            }
        }
    }
    

    func setupzone(){
        
        IsZone = true
        IsClusters = false
        IsBlock = false
        
        var arr_dataSource :[String] = []
        for i in arr_Zone{
            arr_dataSource.append(i.label)
        }
        
        let drop = self.func_dropDown(arr_dataSource: arr_dataSource, view_drop: self.viewzone, tf_name: self.viewzone.tf_searchTitle, img_Drop: self.viewzone.img_Drop, btn_drop: self.viewzone.btn_search, title: "test")
        
    }
    
    func setupblocks(){
        
        IsZone = false
        IsClusters = false
        IsBlock = true
        
        var arr_dataSource :[String] = []
        for i in arr_Block{
            arr_dataSource.append(i.label)
        }
        
        let drop = self.func_dropDown(arr_dataSource: arr_dataSource, view_drop: self.viewBlocks, tf_name: self.viewBlocks.tf_searchTitle, img_Drop: self.viewBlocks.img_Drop, btn_drop: self.viewBlocks.btn_search, title: "test")
        
        
    }
    func setupclusters(){
        
        IsZone = false
        IsClusters = true
        IsBlock = false
        
        var arr_dataSource :[String] = []
        for i in arr_Clusters{
            arr_dataSource.append(i.label)
        }
        
        let drop = self.func_dropDown(arr_dataSource: arr_dataSource, view_drop: self.viewClusters, tf_name: self.viewClusters.tf_searchTitle, img_Drop: self.viewClusters.img_Drop, btn_drop: self.viewClusters.btn_search, title: "test")
         
        
    }
    
    
    @IBAction func btnCancel_Click(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func btnSubmit_Click(_ sender: Any) {
        
        if (viewClusters.tf_searchTitle.text == "" ){
            self.showAMessage(withTitle: "Error", message: "missed data")
        }else{
            let zoneObj = ["id":ZoneId,"label":self.Zone]
            let BlockObj = ["id":BlockId,"label":self.Block]
            let ClusterObj = ["id":ClustersId,"label":self.Clusters]
            let obj1 = labelObj(zoneObj)
            let obj2 = labelObj(BlockObj)
            let obj3 = labelObj(ClusterObj)
            
            delegate.passFilter(zone_arr: obj1, Block_arr: obj2, Cluster_arr: obj3)

            self.dismiss(animated: true, completion: nil)
        }
       
    }
    
}
