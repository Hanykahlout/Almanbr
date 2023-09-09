/* 
Copyright (c) 2022 Swift Models Generated from JSON powered by http://www.json4swift.com

Permission is hereby granted, free of charge, to any person obtaining a copy of this software and associated documentation files (the "Software"), to deal in the Software without restriction, including without limitation the rights to use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies of the Software, and to permit persons to whom the Software is furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.

For support, please feel free to contact me at https://www.linkedin.com/in/syedabsar

*/

import Foundation
import ObjectMapper

struct ViolationRecords : Mappable {
	var id : String?
	var employee_number : String?
	var violation_date : String?
	var violation_status : String?
	var violation_id : String?
	var punishment_id : String?
	var cancel_note : String?
	var canceled_at : String?
	var prepared_at : String?
	var completed_at : String?
	var employee_name : String?
	var violation_ar : String?
	var violation_en : String?

	init?(map: Map) {

	}

	mutating func mapping(map: Map) {

		id <- map["id"]
		employee_number <- map["employee_number"]
		violation_date <- map["violation_date"]
		violation_status <- map["violation_status"]
		violation_id <- map["violation_id"]
		punishment_id <- map["punishment_id"]
		cancel_note <- map["cancel_note"]
		canceled_at <- map["canceled_at"]
		prepared_at <- map["prepared_at"]
		completed_at <- map["completed_at"]
		employee_name <- map["employee_name"]
		violation_ar <- map["violation_ar"]
		violation_en <- map["violation_en"]
	}

}
