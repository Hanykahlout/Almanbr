/* 
Copyright (c) 2022 Swift Models Generated from JSON powered by http://www.json4swift.com

Permission is hereby granted, free of charge, to any person obtaining a copy of this software and associated documentation files (the "Software"), to deal in the Software without restriction, including without limitation the rights to use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies of the Software, and to permit persons to whom the Software is furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.

For support, please feel free to contact me at https://www.linkedin.com/in/syedabsar

*/

import Foundation
import ObjectMapper

struct Extra_data : Mappable {
	var employee_number : String?
	var contract_id : String?
	var joining_id : String?
	var contract_start_date : String?
	var contract_end_date : String?
	var total_working_days : Int?
	var employee_active_contract_total_days : Int?
	var employee_active_contract_worked_days : Int?
	var total_remaining_days : Int?
	var contract_yearly_paid_days : String?
	var net_amount : String?
	var working_days : Int?
	var per_day_salary : String?
	var vacation_deserved_paid_days : String?
	var total_detection_days : String?
	var total_deserved_days_after_detection : String?
	var used_vacation_total : String?
	var remaining_vocation_days_after_detection : String?
	var vacation_days : Int?
	var used_paid_vacation_days : String?
	var used_unpaid_vacation_days : String?
	var total_vacation_days_on_contract : Int?
	var total_paid_days : Int?
	var total_unpaid_days : String?
	var vacation_paid_days : String?

	init?(map: Map) {

	}

	mutating func mapping(map: Map) {

		employee_number <- map["employee_number"]
		contract_id <- map["contract_id"]
		joining_id <- map["joining_id"]
		contract_start_date <- map["contract_start_date"]
		contract_end_date <- map["contract_end_date"]
        total_working_days <- map["total_working_days"]
		employee_active_contract_total_days <- map["employee_active_contract_total_days"]
		employee_active_contract_worked_days <- map["employee_active_contract_worked_days"]
        total_remaining_days <- map["total_remaining_days"]
		contract_yearly_paid_days <- map["contract_yearly_paid_days"]
		net_amount <- map["net_amount"]
        working_days <- map["working_days"]
		per_day_salary <- map["per_day_salary"]
		vacation_deserved_paid_days <- map["vacation_deserved_paid_days"]
		total_detection_days <- map["total_detection_days"]
		total_deserved_days_after_detection <- map["total_deserved_days_after_detection"]
		used_vacation_total <- map["used_vacation_total"]
		remaining_vocation_days_after_detection <- map["remaining_vocation_days_after_detection"]
		vacation_days <- map["vacation_days"]
		used_paid_vacation_days <- map["used_paid_vacation_days"]
		used_unpaid_vacation_days <- map["used_unpaid_vacation_days"]
		total_vacation_days_on_contract <- map["total_vacation_days_on_contract"]
        total_paid_days <- map["total_paid_days"]
        total_unpaid_days <- map["total_unpaid_days"]
        vacation_paid_days <- map["vacation_paid_days"]
	}

}
