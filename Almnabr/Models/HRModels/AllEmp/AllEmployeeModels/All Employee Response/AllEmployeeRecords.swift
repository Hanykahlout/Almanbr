/* 
Copyright (c) 2022 Swift Models Generated from JSON powered by http://www.json4swift.com

Permission is hereby granted, free of charge, to any person obtaining a copy of this software and associated documentation files (the "Software"), to deal in the Software without restriction, including without limitation the rights to use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies of the Software, and to permit persons to whom the Software is furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.

For support, please feel free to contact me at https://www.linkedin.com/in/syedabsar

*/

import Foundation
import ObjectMapper

struct AllEmployeeRecords : Mappable {
	var e_reference_no : String?
	var employee_number : String?
	var employee_id_number : String?
	var employee_name : String?
	var employee_status : String?
	var employee_writer : String?
	var branch_id : String?
	var signature : String?
	var mark : String?
	var user_id : String?
	var note_alert : String?
	var profile_image : String?
	var job_title_iqama : String?
	var contract_start_date_english : String?
	var contract_end_date_english : String?
	var nationality : String?
	var project_expiry_date : String?
	var project_id : String?
	var passport_number : String?
	var name : String?

	init?(map: Map) {

	}

	mutating func mapping(map: Map) {

		e_reference_no <- map["e_reference_no"]
		employee_number <- map["employee_number"]
		employee_id_number <- map["employee_id_number"]
		employee_name <- map["employee_name"]
		employee_status <- map["employee_status"]
		employee_writer <- map["employee_writer"]
		branch_id <- map["branch_id"]
		signature <- map["signature"]
		mark <- map["mark"]
		user_id <- map["user_id"]
		note_alert <- map["note_alert"]
		profile_image <- map["profile_image"]
		job_title_iqama <- map["job_title_iqama"]
		contract_start_date_english <- map["contract_start_date_english"]
		contract_end_date_english <- map["contract_end_date_english"]
		nationality <- map["nationality"]
		project_expiry_date <- map["project_expiry_date"]
		project_id <- map["project_id"]
		passport_number <- map["passport_number"]
		name <- map["name"]
	}

}
