/* 
Copyright (c) 2022 Swift Models Generated from JSON powered by http://www.json4swift.com

Permission is hereby granted, free of charge, to any person obtaining a copy of this software and associated documentation files (the "Software"), to deal in the Software without restriction, including without limitation the rights to use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies of the Software, and to permit persons to whom the Software is furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.

For support, please feel free to contact me at https://www.linkedin.com/in/syedabsar

*/

import Foundation
import ObjectMapper

struct Form_ovr1_records : Mappable {
	var form_ovr_record_id : String?
	var transaction_request_id : String?
	var overtime_date_english : String?
	var overtime_date_arabic : String?
	var overtime_hours : String?
	var overtime_amount : String?

	init?(map: Map) {

	}

	mutating func mapping(map: Map) {

		form_ovr_record_id <- map["form_ovr_record_id"]
		transaction_request_id <- map["transaction_request_id"]
		overtime_date_english <- map["overtime_date_english"]
		overtime_date_arabic <- map["overtime_date_arabic"]
		overtime_hours <- map["overtime_hours"]
		overtime_amount <- map["overtime_amount"]
	}

}