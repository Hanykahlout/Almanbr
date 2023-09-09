/* 
Copyright (c) 2023 Swift Models Generated from JSON powered by http://www.json4swift.com

Permission is hereby granted, free of charge, to any person obtaining a copy of this software and associated documentation files (the "Software"), to deal in the Software without restriction, including without limitation the rights to use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies of the Software, and to permit persons to whom the Software is furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.

For support, please feel free to contact me at https://www.linkedin.com/in/syedabsar

*/

import Foundation
import ObjectMapper

struct InvoiceSettingsRecord : Mappable {
	var branch_name : String?
	var payment_mode_name : String?
	var invoice_setting_id : String?
	var invoice_type : String?
	var branch_id : String?
	var finance_id : String?
	var payment_mode : String?
	var customer_accounts : String?
	var income_accounts : String?
	var expanse_accounts : String?
	var advance_accounts : String?
	var discount_accounts : String?
	var invoice_setting_writer : String?
	var invoice_created_datetime : String?
	var invoice_updated_datetime : String?
	var name : String?

	init?(map: Map) {

	}

	mutating func mapping(map: Map) {

		branch_name <- map["branch_name"]
		payment_mode_name <- map["payment_mode_name"]
		invoice_setting_id <- map["invoice_setting_id"]
		invoice_type <- map["invoice_type"]
		branch_id <- map["branch_id"]
		finance_id <- map["finance_id"]
		payment_mode <- map["payment_mode"]
		customer_accounts <- map["customer_accounts"]
		income_accounts <- map["income_accounts"]
		expanse_accounts <- map["expanse_accounts"]
		advance_accounts <- map["advance_accounts"]
		discount_accounts <- map["discount_accounts"]
		invoice_setting_writer <- map["invoice_setting_writer"]
		invoice_created_datetime <- map["invoice_created_datetime"]
		invoice_updated_datetime <- map["invoice_updated_datetime"]
		name <- map["name"]
	}

}
