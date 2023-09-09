


import Foundation
import ObjectMapper

struct StatementAccountsData<T:Mappable> : Mappable {
	var status : Bool?
	var records : [T]?

	init?(map: Map) {

	}

	mutating func mapping(map: Map) {

		status <- map["status"]
		records <- map["records"]
	}

}
