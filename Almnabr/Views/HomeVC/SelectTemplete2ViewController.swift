//
//  SelectTemplete2ViewController.swift
//  Almnabr
//
//  Created by Hany Alkahlout on 12/10/2022.
//  Copyright © 2022 Samar Akkila. All rights reserved.
//

import UIKit
import DropDown

class SelectTemplete2ViewController: UIViewController {

    @IBOutlet weak var zoneTextField: UITextField!
    @IBOutlet weak var blocksTextField: UITextField!
    @IBOutlet weak var clustersTextField: UITextField!
    
    
    @IBOutlet weak var zoneArrow: UIImageView!
    @IBOutlet weak var blocksArrow: UIImageView!
    @IBOutlet weak var clustersArrow: UIImageView!
    
    private var zones = [ZonesRecord]()
    private var blocks = [ZonesRecord]()
    private var clusters = [ZonesRecord]()
    
    private var zonesDropDown = DropDown()
    private var blocksDropDown = DropDown()
    private var clustersDropDown = DropDown()
        
    private var selectedZone:ZonesRecord?
    private var selectedBlocks:ZonesRecord?
    private var selectedClusters:ZonesRecord?
    
    
    var projects_work_area_id = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()

        initlization()

    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(true, animated: true)
        getZones()
    }
    
    
    private func initlization(){
        zoneTextField.addTapGesture {
            self.zoneArrow.transform = .init(rotationAngle: .pi)
            self.zonesDropDown.show()
        }
        blocksTextField.addTapGesture {
            self.blocksArrow.transform = .init(rotationAngle: .pi)
            self.blocksDropDown.show()
        }
        clustersTextField.addTapGesture {
            self.clustersArrow.transform = .init(rotationAngle: .pi)
            self.clustersDropDown.show()
        }
        setUpDropDownLists()
    }
    
    
    
    private func setUpDropDownLists(){
        // zonesDropDown
        zonesDropDown.anchorView = zoneTextField
        zonesDropDown.bottomOffset = CGPoint(x: 0, y:(zonesDropDown.anchorView?.plainView.bounds.height)!)
        zonesDropDown.dataSource = ["No items found"]
        zonesDropDown.selectionAction = { [unowned self] (index: Int, item: String) in
            zoneArrow.transform = .init(rotationAngle: 0)
            if !zones.isEmpty{
                let objc = zones[index]
                self.zoneTextField.text = objc.label
                self.selectedZone = objc
                self.getBlocks()
            }
        }
        
        zonesDropDown.cancelAction = { [unowned self] in
            zoneArrow.transform = .init(rotationAngle: 0)
        }
        
        // blocksDropDown
        blocksDropDown.anchorView = blocksTextField
        blocksDropDown.bottomOffset = CGPoint(x: 0, y:(blocksDropDown.anchorView?.plainView.bounds.height)!)
        blocksDropDown.dataSource = ["No items found"]
        blocksDropDown.selectionAction = { [unowned self] (index: Int, item: String) in
            blocksArrow.transform = .init(rotationAngle: 0)
            if !blocks.isEmpty{
                let objc = blocks[index]
                self.blocksTextField.text = objc.label
                self.selectedBlocks = objc
                self.getClusters()
            }
        }
        
        blocksDropDown.cancelAction = { [unowned self] in
            blocksArrow.transform = .init(rotationAngle: 0)
        }
        
        // clustersDropDown
        clustersDropDown.anchorView = clustersTextField
        clustersDropDown.bottomOffset = CGPoint(x: 0, y:(clustersDropDown.anchorView?.plainView.bounds.height)!)
        clustersDropDown.dataSource = ["No items found"]
        clustersDropDown.selectionAction = { [unowned self] (index: Int, item: String) in
            clustersArrow.transform = .init(rotationAngle: 0)
            if !clusters.isEmpty{
                let objc = clusters[index]
                self.clustersTextField.text = objc.label
                self.selectedClusters = objc
            }
        }
        
        clustersDropDown.cancelAction = { [unowned self] in
            clustersArrow.transform = .init(rotationAngle: 0)
        }

    }

    
    @IBAction func closeAction(_ sender: Any) {
        navigationController?.dismiss(animated: true)
    }
    
    @IBAction func saveAction(_ sender: Any) {
        NotificationCenter.default.post(name: .init("TemplateFilter2"), object: (selectedZone,selectedBlocks,selectedClusters))
        navigationController?.dismiss(animated: true)
    }
    
    
    

}
// MARK: APIHandling
extension SelectTemplete2ViewController{
    private func getZones(){
        showLoadingActivity()
        APIController.shard.getZones(phase_parent_id: "0", projects_work_area_id: projects_work_area_id) { data in
            self.hideLoadingActivity()
            if let status = data.status , status{
                self.zones = data.records ?? []
                self.zonesDropDown.dataSource = (data.records ?? []).map{$0.label ?? ""}
            }
        }
    }
    
    private func getBlocks(){
        showLoadingActivity()
        APIController.shard.getZones(phase_parent_id: selectedZone?.id ?? "", projects_work_area_id: projects_work_area_id) { data in
            self.hideLoadingActivity()
            if let status = data.status , status{
                self.blocks = data.records ?? []
                self.blocksDropDown.dataSource = (data.records ?? []).map{$0.label ?? ""}
            }
        }
    }
    
    private func getClusters(){
        showLoadingActivity()
        APIController.shard.getZones(phase_parent_id: selectedBlocks?.id ?? "", projects_work_area_id: projects_work_area_id) { data in
            self.hideLoadingActivity()
            if let status = data.status , status{
                self.clusters = data.records ?? []
                self.clustersDropDown.dataSource = (data.records ?? []).map{$0.label ?? ""}
            }
        }
    }
    
}
