/* 
Copyright (c) 2022 Swift Models Generated from JSON powered by http://www.json4swift.com

Permission is hereby granted, free of charge, to any person obtaining a copy of this software and associated documentation files (the "Software"), to deal in the Software without restriction, including without limitation the rights to use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies of the Software, and to permit persons to whom the Software is furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.

For support, please feel free to contact me at https://www.linkedin.com/in/syedabsar

*/

import Foundation
import ObjectMapper

struct Wir_data : Mappable {
	var total_pending_request : String?
	var total_complete_requests : String?
	var total_requests : Int?
	var total_result : String?
	var total_accepted_result_A : String?
	var total_accepted_result_B : String?
	var total_rejected_result_C : String?
	var total_rejected_result_D : String?
	var total_accepted_requests : String?
	var total_rejected_requests : String?
	var total_accepted_result : Int?
	var total_rejected_result : Int?

	init?(map: Map) {

	}

	mutating func mapping(map: Map) {

		total_pending_request <- map["total_pending_request"]
		total_complete_requests <- map["total_complete_requests"]
		total_requests <- map["total_requests"]
		total_result <- map["total_result"]
		total_accepted_result_A <- map["total_accepted_result_A"]
		total_accepted_result_B <- map["total_accepted_result_B"]
		total_rejected_result_C <- map["total_rejected_result_C"]
		total_rejected_result_D <- map["total_rejected_result_D"]
		total_accepted_requests <- map["total_accepted_requests"]
		total_rejected_requests <- map["total_rejected_requests"]
		total_accepted_result <- map["total_accepted_result"]
		total_rejected_result <- map["total_rejected_result"]
	}

}