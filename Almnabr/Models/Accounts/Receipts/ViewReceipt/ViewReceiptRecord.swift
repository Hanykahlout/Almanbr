/* 
Copyright (c) 2023 Swift Models Generated from JSON powered by http://www.json4swift.com

Permission is hereby granted, free of charge, to any person obtaining a copy of this software and associated documentation files (the "Software"), to deal in the Software without restriction, including without limitation the rights to use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies of the Software, and to permit persons to whom the Software is furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.

For support, please feel free to contact me at https://www.linkedin.com/in/syedabsar

*/

import Foundation
import ObjectMapper

struct ViewReceiptRecord : Mappable {
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
	var payment_receipt_id : String?
	var rec_pay_unique_code : String?
	var payreceipt_system_code : String?
	var transaction_request_id : String?
	var transaction_key : String?
	var tbv_count : String?
	var payment_receipt_type : String?
	var payment_receipt_date : String?
	var payment_receipt_to_from : String?
	var payment_receipt_mode : String?
	var payment_receipt_debit_account_id : String?
	var payment_receipt_debit_cost_id : String?
	var payment_receipt_credit_account_id : String?
	var payment_receipt_credit_cost_id : String?
	var payment_receipt_amount : String?
	var payment_receipt_document_number : String?
	var payment_receipt_document_date : String?
	var payment_receipt_bank_name : String?
	var payment_receipt_notes : String?
	var payment_receipt_description : String?
	var payment_receipt_attachment : String?
	var payment_receipt_writer : String?
	var payment_receipt_created_date : String?
	var payment_receipt_updated_date : String?
	var branch_name : String?
	var debit_account_name : String?
	var debit_cost_name : String?
	var credit_account_name : String?
	var credit_cost_name : String?
	var debit_account_code : String?
	var debit_cost_code : String?
	var credit_account_code : String?
	var credit_cost_code : String?
	var debit_account : String?
	var debit_cost : String?
	var credit_account : String?
	var file_path : String?
	var credit_cost : String?
	var writer_name : String?
    var debit_costs : [CardCostData]?
    var credit_costs : [CardCostData]?

    
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
		payment_receipt_id <- map["payment_receipt_id"]
		rec_pay_unique_code <- map["rec_pay_unique_code"]
		payreceipt_system_code <- map["payreceipt_system_code"]
		transaction_request_id <- map["transaction_request_id"]
		transaction_key <- map["transaction_key"]
		tbv_count <- map["tbv_count"]
		payment_receipt_type <- map["payment_receipt_type"]
		payment_receipt_date <- map["payment_receipt_date"]
		payment_receipt_to_from <- map["payment_receipt_to_from"]
		payment_receipt_mode <- map["payment_receipt_mode"]
		payment_receipt_debit_account_id <- map["payment_receipt_debit_account_id"]
		payment_receipt_debit_cost_id <- map["payment_receipt_debit_cost_id"]
		payment_receipt_credit_account_id <- map["payment_receipt_credit_account_id"]
		payment_receipt_credit_cost_id <- map["payment_receipt_credit_cost_id"]
		payment_receipt_amount <- map["payment_receipt_amount"]
		payment_receipt_document_number <- map["payment_receipt_document_number"]
		payment_receipt_document_date <- map["payment_receipt_document_date"]
		payment_receipt_bank_name <- map["payment_receipt_bank_name"]
		payment_receipt_notes <- map["payment_receipt_notes"]
		payment_receipt_description <- map["payment_receipt_description"]
		payment_receipt_attachment <- map["payment_receipt_attachment"]
		payment_receipt_writer <- map["payment_receipt_writer"]
		payment_receipt_created_date <- map["payment_receipt_created_date"]
		payment_receipt_updated_date <- map["payment_receipt_updated_date"]
		branch_name <- map["branch_name"]
		debit_account_name <- map["debit_account_name"]
		debit_cost_name <- map["debit_cost_name"]
		credit_account_name <- map["credit_account_name"]
		credit_cost_name <- map["credit_cost_name"]
		debit_account_code <- map["debit_account_code"]
		debit_cost_code <- map["debit_cost_code"]
		credit_account_code <- map["credit_account_code"]
		credit_cost_code <- map["credit_cost_code"]
		debit_account <- map["debit_account"]
		debit_cost <- map["debit_cost"]
		credit_account <- map["credit_account"]
		file_path <- map["file_path"]
		credit_cost <- map["credit_cost"]
        writer_name <- map["writer_name"]
        debit_costs <- map["debit_costs"]
        credit_costs <- map["credit_costs"]
	}

}
