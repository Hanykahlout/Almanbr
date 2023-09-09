/* 
Copyright (c) 2022 Swift Models Generated from JSON powered by http://www.json4swift.com

Permission is hereby granted, free of charge, to any person obtaining a copy of this software and associated documentation files (the "Software"), to deal in the Software without restriction, including without limitation the rights to use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies of the Software, and to permit persons to whom the Software is furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.

For support, please feel free to contact me at https://www.linkedin.com/in/syedabsar

*/

import Foundation
import ObjectMapper

struct C1FormRecords : Mappable {
	var form_c1_data_id : String?
	var transaction_key : String?
	var transaction_request_id : String?
	var subject : String?
	var content : String?
	var attachment : String?
	var transaction_from : String?
	var transaction_to : String?
	var transaction_from_name : String?
	var transaction_to_name : String?

	init?(map: Map) {

	}

	mutating func mapping(map: Map) {

		form_c1_data_id <- map["form_c1_data_id"]
		transaction_key <- map["transaction_key"]
		transaction_request_id <- map["transaction_request_id"]
		subject <- map["subject"]
		content <- map["content"]
		attachment <- map["attachment"]
		transaction_from <- map["transaction_from"]
		transaction_to <- map["transaction_to"]
		transaction_from_name <- map["transaction_from_name"]
		transaction_to_name <- map["transaction_to_name"]
	}

}
