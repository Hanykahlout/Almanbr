/* 
Copyright (c) 2023 Swift Models Generated from JSON powered by http://www.json4swift.com

Permission is hereby granted, free of charge, to any person obtaining a copy of this software and associated documentation files (the "Software"), to deal in the Software without restriction, including without limitation the rights to use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies of the Software, and to permit persons to whom the Software is furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.

For support, please feel free to contact me at https://www.linkedin.com/in/syedabsar

*/

import Foundation
import ObjectMapper

struct AccountFinancialRecord : Mappable {
	var finance_id : String?
	var unique_finance_id : String?
	var branch_id : String?
	var finance_start_date : String?
	var finance_end_date : String?
	var finance_status : String?
	var finance_reopen_status : String?
	var clone_status : String?
	var created_date : String?
	var finance_writer : String?
	var value : String?
	var label : String?
	var writer_name : String?

	init?(map: Map) {

	}

	mutating func mapping(map: Map) {

		finance_id <- map["finance_id"]
		unique_finance_id <- map["unique_finance_id"]
		branch_id <- map["branch_id"]
		finance_start_date <- map["finance_start_date"]
		finance_end_date <- map["finance_end_date"]
		finance_status <- map["finance_status"]
		finance_reopen_status <- map["finance_reopen_status"]
		clone_status <- map["clone_status"]
		created_date <- map["created_date"]
		finance_writer <- map["finance_writer"]
		value <- map["value"]
		label <- map["label"]
		writer_name <- map["writer_name"]
	}

}
