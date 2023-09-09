/* 
Copyright (c) 2023 Swift Models Generated from JSON powered by http://www.json4swift.com

Permission is hereby granted, free of charge, to any person obtaining a copy of this software and associated documentation files (the "Software"), to deal in the Software without restriction, including without limitation the rights to use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies of the Software, and to permit persons to whom the Software is furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.

For support, please feel free to contact me at https://www.linkedin.com/in/syedabsar

*/

import Foundation
import ObjectMapper

struct SellingInvoiceRecord : Mappable {
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
	var invoice_id : String?
	var invoice_unique_code : String?
	var invoice_system_code : String?
	var invoice_type : String?
	var invoice_date : String?
	var process_type : String?
	var invoice_tax_exambed : String?
	var invoice_tax_refund : String?
	var invoice_tax_pay_supplier : String?
	var invoice_payment_mode : String?
	var invoice_credit_days : String?
	var invoice_credit_date : String?
	var invoice_address_to : String?
	var invoice_vat_tax_id : String?
	var invoice_ref_number : String?
	var invoice_instruction_remarks : String?
	var invoice_to_account_id : String?
	var invoice_to_cost_center_id : String?
	var invoice_income_expanse_account_id : String?
	var invoice_income_expanse_cost_id : String?
	var invoice_cash_advance_amount : String?
	var invoice_cash_advance_account_id : String?
	var invoice_cash_advance_cost_center_id : String?
	var invoice_tax_account_id : String?
	var invoice_tax_cost_center_id : String?
	var invoice_grand_total : String?
	var invoice_item_discount_amount : String?
	var invoice_global_discount_percent : String?
	var invoice_global_discount_amount : String?
	var invoice_item_tax_amount : String?
	var invoice_global_tax_id : String?
	var invoice_global_tax_amount : String?
	var invoice_net_total : String?
	var invoice_roundoff_amount : String?
	var invoice_writer : String?
	var invoice_created_date : String?
	var invoice_update_date : String?
	var branch_name : String?
	var payment_name : String?
	var key : String?
	var writer_name : String?
	var customer_account : String?
	var customer_cost : String?
	var income_expense_account : String?
	var income_expense_cost : String?
	var tax_account : String?
	var tax_cost : String?
	var advance_account : String?
	var advance_cost : String?
	var global_tax_name : String?
	var global_tax_value : String?

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
		invoice_id <- map["invoice_id"]
		invoice_unique_code <- map["invoice_unique_code"]
		invoice_system_code <- map["invoice_system_code"]
		invoice_type <- map["invoice_type"]
		invoice_date <- map["invoice_date"]
		process_type <- map["process_type"]
		invoice_tax_exambed <- map["invoice_tax_exambed"]
		invoice_tax_refund <- map["invoice_tax_refund"]
		invoice_tax_pay_supplier <- map["invoice_tax_pay_supplier"]
		invoice_payment_mode <- map["invoice_payment_mode"]
		invoice_credit_days <- map["invoice_credit_days"]
		invoice_credit_date <- map["invoice_credit_date"]
		invoice_address_to <- map["invoice_address_to"]
		invoice_vat_tax_id <- map["invoice_vat_tax_id"]
		invoice_ref_number <- map["invoice_ref_number"]
		invoice_instruction_remarks <- map["invoice_instruction_remarks"]
		invoice_to_account_id <- map["invoice_to_account_id"]
		invoice_to_cost_center_id <- map["invoice_to_cost_center_id"]
		invoice_income_expanse_account_id <- map["invoice_income_expanse_account_id"]
		invoice_income_expanse_cost_id <- map["invoice_income_expanse_cost_id"]
		invoice_cash_advance_amount <- map["invoice_cash_advance_amount"]
		invoice_cash_advance_account_id <- map["invoice_cash_advance_account_id"]
		invoice_cash_advance_cost_center_id <- map["invoice_cash_advance_cost_center_id"]
		invoice_tax_account_id <- map["invoice_tax_account_id"]
		invoice_tax_cost_center_id <- map["invoice_tax_cost_center_id"]
		invoice_grand_total <- map["invoice_grand_total"]
		invoice_item_discount_amount <- map["invoice_item_discount_amount"]
		invoice_global_discount_percent <- map["invoice_global_discount_percent"]
		invoice_global_discount_amount <- map["invoice_global_discount_amount"]
		invoice_item_tax_amount <- map["invoice_item_tax_amount"]
		invoice_global_tax_id <- map["invoice_global_tax_id"]
		invoice_global_tax_amount <- map["invoice_global_tax_amount"]
		invoice_net_total <- map["invoice_net_total"]
		invoice_roundoff_amount <- map["invoice_roundoff_amount"]
		invoice_writer <- map["invoice_writer"]
		invoice_created_date <- map["invoice_created_date"]
		invoice_update_date <- map["invoice_update_date"]
		branch_name <- map["branch_name"]
		payment_name <- map["payment_name"]
		key <- map["key"]
		writer_name <- map["writer_name"]
		customer_account <- map["customer_account"]
		customer_cost <- map["customer_cost"]
		income_expense_account <- map["income_expense_account"]
		income_expense_cost <- map["income_expense_cost"]
		tax_account <- map["tax_account"]
		tax_cost <- map["tax_cost"]
		advance_account <- map["advance_account"]
		advance_cost <- map["advance_cost"]
		global_tax_name <- map["global_tax_name"]
		global_tax_value <- map["global_tax_value"]
	}

}
