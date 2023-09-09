/* 
Copyright (c) 2022 Swift Models Generated from JSON powered by http://www.json4swift.com

Permission is hereby granted, free of charge, to any person obtaining a copy of this software and associated documentation files (the "Software"), to deal in the Software without restriction, including without limitation the rights to use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies of the Software, and to permit persons to whom the Software is furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.

For support, please feel free to contact me at https://www.linkedin.com/in/syedabsar

*/

import Foundation
import ObjectMapper

struct InsuranceRecords : Mappable {
	var insurance_dependent_id : String?
	var employee_number : String?
	var insurance_dependent_name : String?
	var insurance_dependent_number : String?
	var insurance_dependent_type : String?
	var insurance_dependent_ins_no : String?
	var insurance_dependent_reaplationship : String?
	var insurance_dependent_date : String?
	var insurance_dependent_writer : String?
	var insurance_dependent_createddate : String?
	var insurance_dependent_updatedate : String?
	var name : String?

	init?(map: Map) {

	}

	mutating func mapping(map: Map) {

		insurance_dependent_id <- map["insurance_dependent_id"]
		employee_number <- map["employee_number"]
		insurance_dependent_name <- map["insurance_dependent_name"]
		insurance_dependent_number <- map["insurance_dependent_number"]
		insurance_dependent_type <- map["insurance_dependent_type"]
		insurance_dependent_ins_no <- map["insurance_dependent_ins_no"]
		insurance_dependent_reaplationship <- map["insurance_dependent_reaplationship"]
		insurance_dependent_date <- map["insurance_dependent_date"]
		insurance_dependent_writer <- map["insurance_dependent_writer"]
		insurance_dependent_createddate <- map["insurance_dependent_createddate"]
		insurance_dependent_updatedate <- map["insurance_dependent_updatedate"]
		name <- map["name"]
	}

}
