//
//  SelectedHomeFilterData.swift
//  Almnabr
//
//  Created by Hany Alkahlout on 19/10/2022.
//  Copyright © 2022 Samar Akkila. All rights reserved.
//

import Foundation


struct SelectedHomeFilterData{
    
    var selectedFromDate:Date?
    var selectedToDate:Date?
    var requestNumberTextField:String = ""
    var selectedTemplate:GetTemplateRecord?
    var selectedDivision:GetGroupTypesRecord?
    var selectedGroupType:GetGroupTypesRecord?
    var selectedChapter:GetGroupTypesRecord?
    var platformCodeSystemTextField:String = ""
    var selectedZone:ZonesRecord?
    var selectedBlock:ZonesRecord?
    var selectedCluster:ZonesRecord?
    var byPhasesTextField:String = ""
    var generalNumberTextField:String = ""
    var selectedlevels:[GetGroupTypesRecord] = []
    var selectedResult:[String] = []
    var selectedStatus:String = "final_completed_versions"
    var barCodeTextField:String = ""
    
}
    
