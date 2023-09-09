/* 
Copyright (c) 2022 Swift Models Generated from JSON powered by http://www.json4swift.com

Permission is hereby granted, free of charge, to any person obtaining a copy of this software and associated documentation files (the "Software"), to deal in the Software without restriction, including without limitation the rights to use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies of the Software, and to permit persons to whom the Software is furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.

For support, please feel free to contact me at https://www.linkedin.com/in/syedabsar

*/

import Foundation
import ObjectMapper

struct LicencesGetResponse : Mappable {
	var licence_req_id : String?
	var employee_number : String?
	var licence_list_id : String?
	var setting_id : String?
	var position_id : String?
	var licence_number : String?
	var licence_issue_date_english : String?
	var licence_issue_date_arabic : String?
	var licence_expiry_date_english : String?
	var licence_expiry_date_arabic : String?
	var licence_list_writer : String?
	var licence_createddatetime : String?
	var licence_updateddatetime : String?
	var licence_name : String?

	init?(map: Map) {

	}

	mutating func mapping(map: Map) {

		licence_req_id <- map["licence_req_id"]
		employee_number <- map["employee_number"]
		licence_list_id <- map["licence_list_id"]
		setting_id <- map["setting_id"]
		position_id <- map["position_id"]
		licence_number <- map["licence_number"]
		licence_issue_date_english <- map["licence_issue_date_english"]
		licence_issue_date_arabic <- map["licence_issue_date_arabic"]
		licence_expiry_date_english <- map["licence_expiry_date_english"]
		licence_expiry_date_arabic <- map["licence_expiry_date_arabic"]
		licence_list_writer <- map["licence_list_writer"]
		licence_createddatetime <- map["licence_createddatetime"]
		licence_updateddatetime <- map["licence_updateddatetime"]
		licence_name <- map["licence_name"]
	}

}
