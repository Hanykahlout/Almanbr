//
//  ReceiptCostCenterResponse.swift
//  Almnabr
//
//  Created by Hany Alkahlout on 19/02/2023.
//  Copyright © 2023 Samar Akkila. All rights reserved.
//

import Foundation
import ObjectMapper

struct ReceiptCostCenterResponse : Mappable {
    var status : Bool?
    var records : [CardCostData]?
    var error: String?
    init?(map: Map) {

    }

    mutating func mapping(map: Map) {

        status <- map["status"]
        records <- map["records"]
        error <- map["error"]

    }

}
