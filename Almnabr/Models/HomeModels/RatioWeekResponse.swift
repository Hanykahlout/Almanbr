

import Foundation
import ObjectMapper

struct RatioWeekResponse : Mappable {
	var status : Bool?
	var data : [RatioWeekData]?
    var ratio_month : String?
	init?(map: Map) {

	}

	mutating func mapping(map: Map) {

		status <- map["status"]
		data <- map["data"]
        ratio_month <- map["ratio_month"]
	}

}
