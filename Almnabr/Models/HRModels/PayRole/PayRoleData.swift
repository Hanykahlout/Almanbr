/* 
Copyright (c) 2022 Swift Models Generated from JSON powered by http://www.json4swift.com

Permission is hereby granted, free of charge, to any person obtaining a copy of this software and associated documentation files (the "Software"), to deal in the Software without restriction, including without limitation the rights to use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies of the Software, and to permit persons to whom the Software is furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.

For support, please feel free to contact me at https://www.linkedin.com/in/syedabsar

*/

import Foundation
import ObjectMapper

struct PayRoleData : Mappable {
	var human_resource_salaries_id : String?
	var salary_form_id : String?
	var transaction_request_id : String?
	var number_of_employees : String?
	var number_of_success_employees : String?
	var number_of_failed_employees : String?
	var failed_employees : String?
	var number_of_error_employees : String?
	var error_employees : String?
	var total_amount : String?
	var file_record_id : String?
	var subject : String?
	var salary_year : String?
	var salary_month : String?
	var transaction_request_last_step : String?

	init?(map: Map) {

	}

	mutating func mapping(map: Map) {

		human_resource_salaries_id <- map["human_resource_salaries_id"]
		salary_form_id <- map["salary_form_id"]
		transaction_request_id <- map["transaction_request_id"]
		number_of_employees <- map["number_of_employees"]
		number_of_success_employees <- map["number_of_success_employees"]
		number_of_failed_employees <- map["number_of_failed_employees"]
		failed_employees <- map["failed_employees"]
		number_of_error_employees <- map["number_of_error_employees"]
		error_employees <- map["error_employees"]
		total_amount <- map["total_amount"]
		file_record_id <- map["file_record_id"]
		subject <- map["subject"]
		salary_year <- map["salary_year"]
		salary_month <- map["salary_month"]
		transaction_request_last_step <- map["transaction_request_last_step"]
	}

}
