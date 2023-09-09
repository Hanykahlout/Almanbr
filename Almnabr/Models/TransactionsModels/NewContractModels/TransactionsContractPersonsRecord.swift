/* 
Copyright (c) 2022 Swift Models Generated from JSON powered by http://www.json4swift.com

Permission is hereby granted, free of charge, to any person obtaining a copy of this software and associated documentation files (the "Software"), to deal in the Software without restriction, including without limitation the rights to use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies of the Software, and to permit persons to whom the Software is furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.

For support, please feel free to contact me at https://www.linkedin.com/in/syedabsar

*/

import Foundation
import ObjectMapper

struct TransactionsContractPersonsRecord : Mappable {
    
	var transactions_persons_id : String?
	var transaction_request_id : String?
	var user_id : String?
	var user_type_id : String?
	var transaction_persons_type : String?
	var transactions_persons_key1 : String?
	var transactions_persons_val1 : String?
	var transactions_persons_key2 : String?
	var transactions_persons_val2 : String?
	var transactions_persons_key3 : String?
	var transactions_persons_val3 : String?
	var transactions_persons_key4 : String?
	var transactions_persons_val4 : String?
	var transactions_persons_view : String?
	var transactions_persons_view_datetime : String?
	var transactions_persons_view_datetime_lastupdate : String?
	var transactions_persons_send_code_method : String?
	var transactions_persons_send_code_datetime : String?
	var transactions_persons_action_datetime : String?
	var transactions_persons_action_code : String?
	var transactions_persons_action_status : String?
	var transactions_persons_last_step : String?
	var person_name : String?
    
    init?(map: Map) {

	}

	mutating func mapping(map: Map) {

		transactions_persons_id <- map["transactions_persons_id"]
		transaction_request_id <- map["transaction_request_id"]
		user_id <- map["user_id"]
		user_type_id <- map["user_type_id"]
		transaction_persons_type <- map["transaction_persons_type"]
		transactions_persons_key1 <- map["transactions_persons_key1"]
		transactions_persons_val1 <- map["transactions_persons_val1"]
		transactions_persons_key2 <- map["transactions_persons_key2"]
		transactions_persons_val2 <- map["transactions_persons_val2"]
		transactions_persons_key3 <- map["transactions_persons_key3"]
		transactions_persons_val3 <- map["transactions_persons_val3"]
		transactions_persons_key4 <- map["transactions_persons_key4"]
		transactions_persons_val4 <- map["transactions_persons_val4"]
		transactions_persons_view <- map["transactions_persons_view"]
		transactions_persons_view_datetime <- map["transactions_persons_view_datetime"]
		transactions_persons_view_datetime_lastupdate <- map["transactions_persons_view_datetime_lastupdate"]
		transactions_persons_send_code_method <- map["transactions_persons_send_code_method"]
		transactions_persons_send_code_datetime <- map["transactions_persons_send_code_datetime"]
		transactions_persons_action_datetime <- map["transactions_persons_action_datetime"]
		transactions_persons_action_code <- map["transactions_persons_action_code"]
		transactions_persons_action_status <- map["transactions_persons_action_status"]
		transactions_persons_last_step <- map["transactions_persons_last_step"]
		person_name <- map["person_name"]
	}

}
