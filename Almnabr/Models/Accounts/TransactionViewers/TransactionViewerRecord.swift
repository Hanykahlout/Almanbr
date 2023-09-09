/* 
Copyright (c) 2023 Swift Models Generated from JSON powered by http://www.json4swift.com

Permission is hereby granted, free of charge, to any person obtaining a copy of this software and associated documentation files (the "Software"), to deal in the Software without restriction, including without limitation the rights to use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies of the Software, and to permit persons to whom the Software is furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.

For support, please feel free to contact me at https://www.linkedin.com/in/syedabsar

*/

import Foundation
import ObjectMapper

struct TransactionViewerRecord : Mappable {
	var transaction_id : String?
	var transaction_uuid : String?
	var branch_id : String?
	var finance_id : String?
	var unique_finance_id : String?
	var module_key : String?
	var private_key : String?
	var private_value : String?
	var transaction_type : String?
	var transaction_listing : String?
	var transaction_date : String?
	var transaction_writer : String?
	var transaction_created_date : String?
	var transaction_updated_date : String?
	var additional_voucher_no : String?
	var transaction_amount : String?
	var finance_reopen_status : String?
	var transaction_previous_amount : String?
	var request_id : String?
	var writer_name : String?
	var no_of_records : String?
	var total_debit : String?
	var total_credit : String?

	init?(map: Map) {

	}

	mutating func mapping(map: Map) {

		transaction_id <- map["transaction_id"]
		transaction_uuid <- map["transaction_uuid"]
		branch_id <- map["branch_id"]
		finance_id <- map["finance_id"]
		unique_finance_id <- map["unique_finance_id"]
		module_key <- map["module_key"]
		private_key <- map["private_key"]
		private_value <- map["private_value"]
		transaction_type <- map["transaction_type"]
		transaction_listing <- map["transaction_listing"]
		transaction_date <- map["transaction_date"]
		transaction_writer <- map["transaction_writer"]
		transaction_created_date <- map["transaction_created_date"]
		transaction_updated_date <- map["transaction_updated_date"]
		additional_voucher_no <- map["additional_voucher_no"]
		transaction_amount <- map["transaction_amount"]
		finance_reopen_status <- map["finance_reopen_status"]
		transaction_previous_amount <- map["transaction_previous_amount"]
		request_id <- map["request_id"]
		writer_name <- map["writer_name"]
		no_of_records <- map["no_of_records"]
		total_debit <- map["total_debit"]
		total_credit <- map["total_credit"]
	}

}
