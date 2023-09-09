/* 
Copyright (c) 2023 Swift Models Generated from JSON powered by http://www.json4swift.com

Permission is hereby granted, free of charge, to any person obtaining a copy of this software and associated documentation files (the "Software"), to deal in the Software without restriction, including without limitation the rights to use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies of the Software, and to permit persons to whom the Software is furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.

For support, please feel free to contact me at https://www.linkedin.com/in/syedabsar

*/

import Foundation
import ObjectMapper

struct AccountMastersRecord : Mappable {
	var currencylabel : String?
	var accountlabel : String?
	var balancelabel : String?
	var account_masters_id : String?
	var finance_id : String?
	var branch_id : String?
	var user_type_id : String?
	var account_masters_parent : String?
	var account_masters_name_en : String?
	var account_masters_name_ar : String?
	var account_masters_support : String?
	var account_masters_code : String?
	var account_masters_type : String?
	var account_masters_balance_sheet_id : String?
	var account_masters_currency_id : String?
	var cost_center_support : String?
	var account_masters_cost_center_id : String?
	var opening_balance : String?
	var opening_balance_type : String?
	var account_vat_number : String?
	var hold_account_from_transaction : String?
	var set_profit_loss_account : String?
	var account_masters_writer : String?
	var account_masters_created_datetime : String?
	var account_masters_updated_datetime : String?
	var account_masters_parent_old : String?
	var branch_name : String?
	var currencyvalue : String?
	var accountvalue : String?
	var balancevalue : String?
	var account_masters_parent_code : String?
	var account_masters_parent_id : String?
	var writer_name : String?
	var id : String?
	var name : String?
	var folder : Bool?
	var children : [AccountMastersRecord]?

	init?(map: Map) {

	}

	mutating func mapping(map: Map) {

		currencylabel <- map["currencylabel"]
		accountlabel <- map["accountlabel"]
		balancelabel <- map["balancelabel"]
		account_masters_id <- map["account_masters_id"]
		finance_id <- map["finance_id"]
		branch_id <- map["branch_id"]
		user_type_id <- map["user_type_id"]
		account_masters_parent <- map["account_masters_parent"]
		account_masters_name_en <- map["account_masters_name_en"]
		account_masters_name_ar <- map["account_masters_name_ar"]
		account_masters_support <- map["account_masters_support"]
		account_masters_code <- map["account_masters_code"]
		account_masters_type <- map["account_masters_type"]
		account_masters_balance_sheet_id <- map["account_masters_balance_sheet_id"]
		account_masters_currency_id <- map["account_masters_currency_id"]
		cost_center_support <- map["cost_center_support"]
		account_masters_cost_center_id <- map["account_masters_cost_center_id"]
		opening_balance <- map["opening_balance"]
		opening_balance_type <- map["opening_balance_type"]
		account_vat_number <- map["account_vat_number"]
		hold_account_from_transaction <- map["hold_account_from_transaction"]
		set_profit_loss_account <- map["set_profit_loss_account"]
		account_masters_writer <- map["account_masters_writer"]
		account_masters_created_datetime <- map["account_masters_created_datetime"]
		account_masters_updated_datetime <- map["account_masters_updated_datetime"]
		account_masters_parent_old <- map["account_masters_parent_old"]
		branch_name <- map["branch_name"]
		currencyvalue <- map["currencyvalue"]
		accountvalue <- map["accountvalue"]
		balancevalue <- map["balancevalue"]
		account_masters_parent_code <- map["account_masters_parent_code"]
		account_masters_parent_id <- map["account_masters_parent_id"]
		writer_name <- map["writer_name"]
		id <- map["id"]
		name <- map["name"]
		folder <- map["folder"]
		children <- map["children"]
	}

}
