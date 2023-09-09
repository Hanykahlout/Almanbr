/* 
Copyright (c) 2022 Swift Models Generated from JSON powered by http://www.json4swift.com

Permission is hereby granted, free of charge, to any person obtaining a copy of this software and associated documentation files (the "Software"), to deal in the Software without restriction, including without limitation the rights to use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies of the Software, and to permit persons to whom the Software is furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.

For support, please feel free to contact me at https://www.linkedin.com/in/syedabsar

*/

import Foundation
import ObjectMapper

struct Hrln1_installments : Mappable {
	var data_id : String?
	var transaction_request_id : String?
	var amount : String?
	var due_month : String?
	var due_year : String?
	var overdyed_half_salary : String?
	var final_conditional_salary : String?

	init?(map: Map) {

	}

	mutating func mapping(map: Map) {

		data_id <- map["data_id"]
		transaction_request_id <- map["transaction_request_id"]
		amount <- map["amount"]
		due_month <- map["due_month"]
		due_year <- map["due_year"]
		overdyed_half_salary <- map["overdyed_half_salary"]
		final_conditional_salary <- map["final_conditional_salary"]
	}

}