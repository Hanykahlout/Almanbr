/* 
Copyright (c) 2022 Swift Models Generated from JSON powered by http://www.json4swift.com

Permission is hereby granted, free of charge, to any person obtaining a copy of this software and associated documentation files (the "Software"), to deal in the Software without restriction, including without limitation the rights to use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies of the Software, and to permit persons to whom the Software is furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.

For support, please feel free to contact me at https://www.linkedin.com/in/syedabsar

*/

import Foundation
import ObjectMapper

struct ProjectRequestsSetting : Mappable {
	var projects_profile_id : String?
	var projects_supervision_id : String?
	var total_construction_cost : String?
	var total_no_of_zones : String?
	var total_no_of_clusters : String?
	var total_no_of_units : String?
	var projects_work_area_id : String?
	var supervision_start_date : String?
	var total_no_of_blocks : String?
	var supervision_expiry_date : String?
	var total_days : String?
	var done_days : String?
	var left_days : String?
	var average_done_days : String?
	var average_left_days : String?
	var late_days : Int?
    

	init?(map: Map) {

	}

	mutating func mapping(map: Map) {

		projects_profile_id <- map["projects_profile_id"]
		projects_supervision_id <- map["projects_supervision_id"]
		total_construction_cost <- map["total_construction_cost"]
		total_no_of_zones <- map["total_no_of_zones"]
		total_no_of_clusters <- map["total_no_of_clusters"]
		total_no_of_units <- map["total_no_of_units"]
		projects_work_area_id <- map["projects_work_area_id"]
		supervision_start_date <- map["supervision_start_date"]
		total_no_of_blocks <- map["total_no_of_blocks"]
		supervision_expiry_date <- map["supervision_expiry_date"]
		total_days <- map["total_days"]
		done_days <- map["done_days"]
		left_days <- map["left_days"]
		average_done_days <- map["average_done_days"]
		average_left_days <- map["average_left_days"]
		late_days <- map["late_days"]
	}

}
