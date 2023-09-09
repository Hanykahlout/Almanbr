/* 
Copyright (c) 2022 Swift Models Generated from JSON powered by http://www.json4swift.com

Permission is hereby granted, free of charge, to any person obtaining a copy of this software and associated documentation files (the "Software"), to deal in the Software without restriction, including without limitation the rights to use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies of the Software, and to permit persons to whom the Software is furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.

For support, please feel free to contact me at https://www.linkedin.com/in/syedabsar

*/

import Foundation
import ObjectMapper

struct ProjectWorkingAreaRecord : Mappable {
	var projects_supervision_id : String?
	var value : String?
	var label : String?
	var projects_work_area_id : String?
	var branch_id : String?
	var customer_id : String?
	var projects_profile_id : String?
	var projects_services_id : String?
	var projects_ps_id : String?
	var projects_quotation_id : String?

	init?(map: Map) {

	}

	mutating func mapping(map: Map) {

		projects_supervision_id <- map["projects_supervision_id"]
		value <- map["value"]
		label <- map["label"]
		projects_work_area_id <- map["projects_work_area_id"]
		branch_id <- map["branch_id"]
		customer_id <- map["customer_id"]
		projects_profile_id <- map["projects_profile_id"]
		projects_services_id <- map["projects_services_id"]
		projects_ps_id <- map["projects_ps_id"]
		projects_quotation_id <- map["projects_quotation_id"]
	}

}
