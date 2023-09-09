/* 
Copyright (c) 2022 Swift Models Generated from JSON powered by http://www.json4swift.com

Permission is hereby granted, free of charge, to any person obtaining a copy of this software and associated documentation files (the "Software"), to deal in the Software without restriction, including without limitation the rights to use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies of the Software, and to permit persons to whom the Software is furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.

For support, please feel free to contact me at https://www.linkedin.com/in/syedabsar

*/

import Foundation
import ObjectMapper

struct NoteRecords : Mappable {
	var note_id : String?
	var note_module : String?
	var table_key1 : String?
	var table_value1 : String?
	var table_key2 : String?
	var table_value2 : String?
	var note_description : String?
	var link_with_view_list : String?
	var note_remainder_status : String?
	var note_remainder_date : String?
	var show_status : String?
	var note_writer : String?
	var note_created_date : String?
	var note_updated_date : String?
	var name : String?

	init?(map: Map) {

	}

	mutating func mapping(map: Map) {

		note_id <- map["note_id"]
		note_module <- map["note_module"]
		table_key1 <- map["table_key1"]
		table_value1 <- map["table_value1"]
		table_key2 <- map["table_key2"]
		table_value2 <- map["table_value2"]
		note_description <- map["note_description"]
		link_with_view_list <- map["link_with_view_list"]
		note_remainder_status <- map["note_remainder_status"]
		note_remainder_date <- map["note_remainder_date"]
		show_status <- map["show_status"]
		note_writer <- map["note_writer"]
		note_created_date <- map["note_created_date"]
		note_updated_date <- map["note_updated_date"]
		name <- map["name"]
	}

}
