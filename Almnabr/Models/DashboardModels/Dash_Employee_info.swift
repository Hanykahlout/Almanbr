/* 
Copyright (c) 2022 Swift Models Generated from JSON powered by http://www.json4swift.com

Permission is hereby granted, free of charge, to any person obtaining a copy of this software and associated documentation files (the "Software"), to deal in the Software without restriction, including without limitation the rights to use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies of the Software, and to permit persons to whom the Software is furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.

For support, please feel free to contact me at https://www.linkedin.com/in/syedabsar

*/

import Foundation
import ObjectMapper

struct Dash_Employee_info : Mappable {
	var e_reference_no : String?
	var quotation_subject : String?
	var employee_number : String?
	var employee_id_number : String?
	var employee_name : String?
	var user_id : String?
	var employee_status : String?
	var employee_writer : String?
	var branch_id : String?
	var signature : String?
	var contract_actual_end_date : String?
	var first_joining_date : String?
	var last_joining_date : String?
	var passport_expiry_date_english : String?
	var membership_expiry_date_english : String?
	var iqama_expiry_date_english : String?
	var vacation_unused_daya : String?
	var mark : String?
	var note_alert : String?
	var total_detection_vocation_days : String?
	var profile_image : Bool?
	var job_title_iqama : String?
	var nationality : String?
	var project_expiry_date : String?
	var project_id : String?
	var passport_number : String?
	var name : String?

	init?(map: Map) {

	}

	mutating func mapping(map: Map) {

		e_reference_no <- map["e_reference_no"]
		quotation_subject <- map["quotation_subject"]
		employee_number <- map["employee_number"]
		employee_id_number <- map["employee_id_number"]
		employee_name <- map["employee_name"]
		user_id <- map["user_id"]
		employee_status <- map["employee_status"]
		employee_writer <- map["employee_writer"]
		branch_id <- map["branch_id"]
		signature <- map["signature"]
		contract_actual_end_date <- map["contract_actual_end_date"]
		first_joining_date <- map["first_joining_date"]
		last_joining_date <- map["last_joining_date"]
		passport_expiry_date_english <- map["passport_expiry_date_english"]
		membership_expiry_date_english <- map["membership_expiry_date_english"]
		iqama_expiry_date_english <- map["iqama_expiry_date_english"]
		vacation_unused_daya <- map["vacation_unused_daya"]
		mark <- map["mark"]
		note_alert <- map["note_alert"]
		total_detection_vocation_days <- map["total_detection_vocation_days"]
		profile_image <- map["profile_image"]
		job_title_iqama <- map["job_title_iqama"]
		nationality <- map["nationality"]
		project_expiry_date <- map["project_expiry_date"]
		project_id <- map["project_id"]
		passport_number <- map["passport_number"]
		name <- map["name"]
	}

}
