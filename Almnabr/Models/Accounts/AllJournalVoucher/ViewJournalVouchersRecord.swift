/* 
Copyright (c) 2023 Swift Models Generated from JSON powered by http://www.json4swift.com

Permission is hereby granted, free of charge, to any person obtaining a copy of this software and associated documentation files (the "Software"), to deal in the Software without restriction, including without limitation the rights to use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies of the Software, and to permit persons to whom the Software is furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.

For support, please feel free to contact me at https://www.linkedin.com/in/syedabsar

*/

import Foundation
import ObjectMapper

struct ViewJournalVouchersRecord : Mappable {
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
	var finance_start_date : String?
	var finance_end_date : String?
	var journal_voucher_id : String?
	var journal_unique_code : String?
	var journal_system_code : String?
	var operation_type : String?
	var journal_voucher_date : String?
	var journal_voucher_credit_total : String?
	var journal_voucher_debit_total : String?
	var journal_voucher_no_of_records : String?
	var journal_voucher_writer : String?
	var journal_voucher_created_date : String?
	var journal_voucher_updated_date : String?
	var additional_voucher_noj : String?
	var branch_name : String?
	var writer_name : String?

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
		finance_start_date <- map["finance_start_date"]
		finance_end_date <- map["finance_end_date"]
		journal_voucher_id <- map["journal_voucher_id"]
		journal_unique_code <- map["journal_unique_code"]
		journal_system_code <- map["journal_system_code"]
		operation_type <- map["operation_type"]
		journal_voucher_date <- map["journal_voucher_date"]
		journal_voucher_credit_total <- map["journal_voucher_credit_total"]
		journal_voucher_debit_total <- map["journal_voucher_debit_total"]
		journal_voucher_no_of_records <- map["journal_voucher_no_of_records"]
		journal_voucher_writer <- map["journal_voucher_writer"]
		journal_voucher_created_date <- map["journal_voucher_created_date"]
		journal_voucher_updated_date <- map["journal_voucher_updated_date"]
		additional_voucher_noj <- map["additional_voucher_noj"]
		branch_name <- map["branch_name"]
		writer_name <- map["writer_name"]
	}

}
