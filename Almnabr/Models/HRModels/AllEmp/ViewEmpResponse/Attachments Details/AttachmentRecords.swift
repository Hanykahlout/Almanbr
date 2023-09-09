/* 
Copyright (c) 2022 Swift Models Generated from JSON powered by http://www.json4swift.com

Permission is hereby granted, free of charge, to any person obtaining a copy of this software and associated documentation files (the "Software"), to deal in the Software without restriction, including without limitation the rights to use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies of the Software, and to permit persons to whom the Software is furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.

For support, please feel free to contact me at https://www.linkedin.com/in/syedabsar

*/

import Foundation
import ObjectMapper

struct AttachmentRecords : Mappable {
	var file_records_id : String?
	var module_key : String?
	var level_keys : String?
	var file_path : String?
	var file_size : String?
	var file_extension : String?
	var file_name_en : String?
	var file_name_ar : String?
	var user_id_writer : String?
	var created_datetime : String?
	var attachment_link : String?
	var file_name : String?
	var type_name : String?
	var key_code : String?
	var writer : String?

	init?(map: Map) {

	}

	mutating func mapping(map: Map) {

		file_records_id <- map["file_records_id"]
		module_key <- map["module_key"]
		level_keys <- map["level_keys"]
		file_path <- map["file_path"]
		file_size <- map["file_size"]
		file_extension <- map["file_extension"]
		file_name_en <- map["file_name_en"]
		file_name_ar <- map["file_name_ar"]
		user_id_writer <- map["user_id_writer"]
		created_datetime <- map["created_datetime"]
		attachment_link <- map["attachment_link"]
		file_name <- map["file_name"]
		type_name <- map["type_name"]
		key_code <- map["key_code"]
		writer <- map["writer"]
	}

}
