//
//  FilterInfo.swift
//  Almnabr
//
//  Created by Hany Alkahlout on 07/06/2022.
//  Copyright © 2022 Samar Akkila. All rights reserved.
//

import Foundation

struct FilterInfo{
    var lang_iqama:String
    var lang_passport:String
    var lang_membership:String
    var lang_contract:String
    var selectedNationality:[SearchBranchRecords]
    var selectedProjectNameEnglish:[FilterGetRecords2]
    var selectedBranch:[SearchBranchRecords]
    var selectedPositions:[SelectionInfo]
    var selectedStatus: [SelectionInfo]
    var selectedNationalityType: SelectionInfo?
    var passportNumber: String
    var idNumber: String
    var employeeName: String
}
