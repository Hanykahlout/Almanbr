/* 
Copyright (c) 2023 Swift Models Generated from JSON powered by http://www.json4swift.com

Permission is hereby granted, free of charge, to any person obtaining a copy of this software and associated documentation files (the "Software"), to deal in the Software without restriction, including without limitation the rights to use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies of the Software, and to permit persons to whom the Software is furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.

For support, please feel free to contact me at https://www.linkedin.com/in/syedabsar

*/

import Foundation
import ObjectMapper

struct StatementAccountsRecord : Mappable {
	var transaction_request_type : String?
	var branch_id : String?
	var classVal : String?
	var request_id : String?
	var transaction_number : String?
	var reference_number : String?
	var transaction_date : String?
	var description : String?
	var debit : String?
	var credit : String?
	var balance : String?
	var status : String?

	init?(map: Map) {

	}

	mutating func mapping(map: Map) {

		transaction_request_type <- map["transaction_request_type"]
		branch_id <- map["branch_id"]
        classVal <- map["class"]
		request_id <- map["request_id"]
		transaction_number <- map["transaction_number"]
		reference_number <- map["reference_number"]
		transaction_date <- map["transaction_date"]
		description <- map["description"]
		debit <- map["debit"]
		credit <- map["credit"]
		balance <- map["balance"]
		status <- map["status"]
	}

}
