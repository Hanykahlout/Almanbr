//
//  JournalVoucherModel.swift
//  Almnabr
//
//  Created by Hany Alkahlout on 16/02/2023.
//  Copyright © 2023 Samar Akkila. All rights reserved.
//

import Foundation

struct JournalVoucherData{
    var accountCode:SearchBranchRecords?
    var debitAmount:String?
    var creditAmount:String?
    var description:String?
    var costCenter:[(card:SearchBranchRecords?,amount:String)]?
    var referenceNo:String?
    var notes:String?
    
}
