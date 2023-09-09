/* 
Copyright (c) 2022 Swift Models Generated from JSON powered by http://www.json4swift.com

Permission is hereby granted, free of charge, to any person obtaining a copy of this software and associated documentation files (the "Software"), to deal in the Software without restriction, including without limitation the rights to use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies of the Software, and to permit persons to whom the Software is furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.

For support, please feel free to contact me at https://www.linkedin.com/in/syedabsar

*/

import Foundation
import ObjectMapper

struct LoanFormResponse : Mappable {
	var status : Bool?
	var transactions_request : Transactions_request?
	var transactions_date : Transactions_date?
	var transactions_notes : Transactions_notes?
	var transactions_records : Transactions_records?
	var transactions_submitter : Transactions_submitter?
	var transactions_barcode_version : Transactions_barcode_version?
	var transactions_persons : Transactions_persons?
	var transactions_buttons : Transactions_buttons?
	var form_hrln1_data : Form_hrln1_data?
	var hrln1_installments : [Hrln1_installments]?
	var steps : Steps?
	var last_request_step : String?
    var error : String?
    
	init?(map: Map) {

	}

	mutating func mapping(map: Map) {

		status <- map["status"]
		transactions_request <- map["transactions_request"]
		transactions_date <- map["transactions_date"]
		transactions_notes <- map["transactions_notes"]
		transactions_records <- map["transactions_records"]
		transactions_submitter <- map["transactions_submitter"]
		transactions_barcode_version <- map["transactions_barcode_version"]
		transactions_persons <- map["transactions_persons"]
		transactions_buttons <- map["transactions_buttons"]
		form_hrln1_data <- map["form_hrln1_data"]
		hrln1_installments <- map["hrln1_installments"]
		steps <- map["steps"]
		last_request_step <- map["last_request_step"]
        error <- map["error"]
	}

}
