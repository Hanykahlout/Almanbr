








import Foundation
import ObjectMapper

struct Attachments : Mappable {
	var en0001 : String?
	var en0001_d : String?
	var id0001 : String?
	var id0001_d : String?
    var ir0001: String?
    var ir0001_d: String?
    
	init?(map: Map) {

	}

	mutating func mapping(map: Map) {
		en0001 <- map["en0001"]
		en0001_d <- map["en0001_d"]
		id0001 <- map["id0001"]
		id0001_d <- map["id0001_d"]
        ir0001 <- map["ir0001"]
        ir0001_d <- map["ir0001_d"]
	}

}

