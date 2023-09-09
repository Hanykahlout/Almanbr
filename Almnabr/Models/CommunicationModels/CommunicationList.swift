/* 
Copyright (c) 2022 Swift Models Generated from JSON powered by http://www.json4swift.com

Permission is hereby granted, free of charge, to any person obtaining a copy of this software and associated documentation files (the "Software"), to deal in the Software without restriction, including without limitation the rights to use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies of the Software, and to permit persons to whom the Software is furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.

For support, please feel free to contact me at https://www.linkedin.com/in/syedabsar

*/

import Foundation
import ObjectMapper

struct CommunicationList : Mappable {
	var communication_id : String?
	var transaction_request_id : String?
	var tbv_count : String?
	var communication_types_id : String?
	var transactions_types_id : String?
	var branch_id : String?
	var communication_from : String?
	var communication_to : String?
	var communication_subject : String?
	var communication_user_id_writer : String?
	var file_records_id : String?
	var communication_date_h : String?
	var communication_date_m : String?
	var file_path : String?
	var file_size : String?
	var file_extension : String?
	var tbv_id : String?
	var module_key : String?
	var transaction_key : String?
	var tbv_barcodeData : String?
	var tbv_version : String?
	var tbv_barcodeKey : String?
	var tbv_auth : String?
	var communication_user_name_writer : String?
	var transactions_submitter_user_name : String?
	var communication_from_name : String?
	var communication_to_name : String?
	var communication_types_name : String?
	var transactions_types_name : String?
	var modules_name : String?

	init?(map: Map) {

	}

	mutating func mapping(map: Map) {

		communication_id <- map["communication_id"]
		transaction_request_id <- map["transaction_request_id"]
		tbv_count <- map["tbv_count"]
		communication_types_id <- map["communication_types_id"]
		transactions_types_id <- map["transactions_types_id"]
		branch_id <- map["branch_id"]
		communication_from <- map["communication_from"]
		communication_to <- map["communication_to"]
		communication_subject <- map["communication_subject"]
		communication_user_id_writer <- map["communication_user_id_writer"]
		file_records_id <- map["file_records_id"]
		communication_date_h <- map["communication_date_h"]
		communication_date_m <- map["communication_date_m"]
		file_path <- map["file_path"]
		file_size <- map["file_size"]
		file_extension <- map["file_extension"]
		tbv_id <- map["tbv_id"]
		module_key <- map["module_key"]
		transaction_key <- map["transaction_key"]
		tbv_barcodeData <- map["tbv_barcodeData"]
		tbv_version <- map["tbv_version"]
		tbv_barcodeKey <- map["tbv_barcodeKey"]
		tbv_auth <- map["tbv_auth"]
		communication_user_name_writer <- map["communication_user_name_writer"]
		transactions_submitter_user_name <- map["transactions_submitter_user_name"]
		communication_from_name <- map["communication_from_name"]
		communication_to_name <- map["communication_to_name"]
		communication_types_name <- map["communication_types_name"]
		transactions_types_name <- map["transactions_types_name"]
		modules_name <- map["modules_name"]
	}

}
