/* 
Copyright (c) 2023 Swift Models Generated from JSON powered by http://www.json4swift.com

Permission is hereby granted, free of charge, to any person obtaining a copy of this software and associated documentation files (the "Software"), to deal in the Software without restriction, including without limitation the rights to use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies of the Software, and to permit persons to whom the Software is furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.

For support, please feel free to contact me at https://www.linkedin.com/in/syedabsar

*/

import Foundation
import ObjectMapper

struct ReceiptRecord : Mappable {
	var finance_reopen_status : String?
	var transaction_previous_amount : String?
	var file_path : String?
	var rec_pay_unique_code : String?
	var payreceipt_system_code : String?
	var transaction_request_id : String?
	var transaction_key : String?
	var tbv_count : String?
	var transaction_id : String?
	var branch_id : String?
	var payment_receipt_id : String?
	var payment_receipt_date : String?
	var payment_receipt_to_from : String?
	var payment_receipt_amount : String?
	var payment_receipt_attachment : String?
	var payment_receipt_created_date : String?
	var finance_id : String?
	var writer_name : String?

	init?(map: Map) {

	}

	mutating func mapping(map: Map) {

		finance_reopen_status <- map["finance_reopen_status"]
		transaction_previous_amount <- map["transaction_previous_amount"]
		file_path <- map["file_path"]
		rec_pay_unique_code <- map["rec_pay_unique_code"]
		payreceipt_system_code <- map["payreceipt_system_code"]
		transaction_request_id <- map["transaction_request_id"]
		transaction_key <- map["transaction_key"]
		tbv_count <- map["tbv_count"]
		transaction_id <- map["transaction_id"]
		branch_id <- map["branch_id"]
		payment_receipt_id <- map["payment_receipt_id"]
		payment_receipt_date <- map["payment_receipt_date"]
		payment_receipt_to_from <- map["payment_receipt_to_from"]
		payment_receipt_amount <- map["payment_receipt_amount"]
		payment_receipt_attachment <- map["payment_receipt_attachment"]
		payment_receipt_created_date <- map["payment_receipt_created_date"]
		finance_id <- map["finance_id"]
		writer_name <- map["writer_name"]
	}

}
