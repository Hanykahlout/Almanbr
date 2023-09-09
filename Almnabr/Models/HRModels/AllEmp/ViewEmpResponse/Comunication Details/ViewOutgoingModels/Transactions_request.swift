/* 
Copyright (c) 2022 Swift Models Generated from JSON powered by http://www.json4swift.com

Permission is hereby granted, free of charge, to any person obtaining a copy of this software and associated documentation files (the "Software"), to deal in the Software without restriction, including without limitation the rights to use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies of the Software, and to permit persons to whom the Software is furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.

For support, please feel free to contact me at https://www.linkedin.com/in/syedabsar

*/

import Foundation
import ObjectMapper

struct Transactions_request : Mappable {
    
	var transaction_request_id : String?
	var branch_id : String?
	var transaction_key : String?
	var module_key : String?
	var transaction_from : String?
	var transaction_to : String?
	var lang_key : String?
	var transactions_types_id : String?
	var transaction_request_description : String?
	var transaction_request_user_id_writer : String?
	var transaction_request_type_of_approval : String?
	var transaction_request_last_step : String?
	var transactions_type_name : String?
	var transactions_name : String?
	var module_name : String?
	var language_name : String?
	var tbv_barcodeData : String?
	var created_name : String?
	var created_date : String?
	var submitted_name : String?
	var submitted_date : String?
	var transaction_request_status : String?
	var transaction_from_name : String?
	var transaction_to_name : String?
	var view_link : String?
    
	init?(map: Map) {

	}

	mutating func mapping(map: Map) {

		transaction_request_id <- map["transaction_request_id"]
		branch_id <- map["branch_id"]
		transaction_key <- map["transaction_key"]
		module_key <- map["module_key"]
		transaction_from <- map["transaction_from"]
		transaction_to <- map["transaction_to"]
		lang_key <- map["lang_key"]
		transactions_types_id <- map["transactions_types_id"]
		transaction_request_description <- map["transaction_request_description"]
		transaction_request_user_id_writer <- map["transaction_request_user_id_writer"]
		transaction_request_type_of_approval <- map["transaction_request_type_of_approval"]
		transaction_request_last_step <- map["transaction_request_last_step"]
		transactions_type_name <- map["transactions_type_name"]
		transactions_name <- map["transactions_name"]
		module_name <- map["module_name"]
		language_name <- map["language_name"]
		tbv_barcodeData <- map["tbv_barcodeData"]
		created_name <- map["created_name"]
		created_date <- map["created_date"]
		submitted_name <- map["submitted_name"]
		submitted_date <- map["submitted_date"]
		transaction_request_status <- map["transaction_request_status"]
		transaction_from_name <- map["transaction_from_name"]
		transaction_to_name <- map["transaction_to_name"]
		view_link <- map["view_link"]
	}

}
