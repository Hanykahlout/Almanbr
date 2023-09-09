/* 
Copyright (c) 2023 Swift Models Generated from JSON powered by http://www.json4swift.com

Permission is hereby granted, free of charge, to any person obtaining a copy of this software and associated documentation files (the "Software"), to deal in the Software without restriction, including without limitation the rights to use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies of the Software, and to permit persons to whom the Software is furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.

For support, please feel free to contact me at https://www.linkedin.com/in/syedabsar

*/

import Foundation
import ObjectMapper

struct CardCostData : Mappable {
    
	var transaction_history_id : String?
	var acc_transaction_history_id : String?
	var unique_reference_number : String?
	var branch_id : String?
	var transaction_request_type : String?
	var transaction_id : String?
	var request_id : String?
	var amount_type : String?
	var finance_id : String?
	var unique_finance_id : String?
	var transaction_history_date : String?
	var account_masters_id : String?
	var cost_center_id : String?
	var cost_center_type : String?
	var debit_amount : String?
	var credit_amount : String?
	var transaction_history_description : String?
	var transaction_history_ref_number : String?
	var transaction_history_notes : String?
	var transaction_history_writer : String?
	var transaction_history_created_date : String?
	var account_full_name : String?
	var cost_center_name : String?
	var account_name : String?
	var cost_name : String?
	var value : String?
	var label : String?
	var amount : String?

	init?(map: Map) {

	}

	mutating func mapping(map: Map) {

		transaction_history_id <- map["transaction_history_id"]
		acc_transaction_history_id <- map["acc_transaction_history_id"]
		unique_reference_number <- map["unique_reference_number"]
		branch_id <- map["branch_id"]
		transaction_request_type <- map["transaction_request_type"]
		transaction_id <- map["transaction_id"]
		request_id <- map["request_id"]
		amount_type <- map["amount_type"]
		finance_id <- map["finance_id"]
		unique_finance_id <- map["unique_finance_id"]
		transaction_history_date <- map["transaction_history_date"]
		account_masters_id <- map["account_masters_id"]
		cost_center_id <- map["cost_center_id"]
		cost_center_type <- map["cost_center_type"]
		debit_amount <- map["debit_amount"]
		credit_amount <- map["credit_amount"]
		transaction_history_description <- map["transaction_history_description"]
		transaction_history_ref_number <- map["transaction_history_ref_number"]
		transaction_history_notes <- map["transaction_history_notes"]
		transaction_history_writer <- map["transaction_history_writer"]
		transaction_history_created_date <- map["transaction_history_created_date"]
		account_full_name <- map["account_full_name"]
		cost_center_name <- map["cost_center_name"]
		account_name <- map["account_name"]
		cost_name <- map["cost_name"]
		value <- map["value"]
		label <- map["label"]
		amount <- map["amount"]
	}

}
