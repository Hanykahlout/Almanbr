/* 
Copyright (c) 2022 Swift Models Generated from JSON powered by http://www.json4swift.com

Permission is hereby granted, free of charge, to any person obtaining a copy of this software and associated documentation files (the "Software"), to deal in the Software without restriction, including without limitation the rights to use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies of the Software, and to permit persons to whom the Software is furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.

For support, please feel free to contact me at https://www.linkedin.com/in/syedabsar

*/

import Foundation
import ObjectMapper

struct TicketRowData : Mappable {
	var ticket_id : String?
	var ticket_no : String?
	var ticket_detalis : String?
	var ticket_type : String?
	var insert_date : String?
	var user_add_id : String?
	var is_delete : String?
	var ticket_old_id : String?
	var ticket_from : String?
	var marge_date : String?
	var marge_user : String?
	var important_id : String?
	var sig_id : String?
	var need_reply : String?
	var date_reply : String?
	var notes : String?
	var time_work : String?
	var end_date : String?
	var user_end : String?
	var ticket_status : String?
	var ticket_hash : String?
	var ref_model : String?
	var ref_id : String?
	var ticket_titel : String?
	var issue_link : String?
	var relat_id : String?
	var end_date_nearly : String?
	var start_date : String?
	var file_detalis : String?
	var group_id : String?
	var count_is_temp : String?
	var ticket_status_name : String?
	var from_ticket_name : String?
	var tikcet_id_new_temp : [String]?
	var group_name : String?
	var is_ticket_admin : Bool?
	var canAddTask : Bool?
	var start_date_format : String?
	var end_date_format : String?
	var date_reply_format : String?

	init?(map: Map) {

	}

	mutating func mapping(map: Map) {

		ticket_id <- map["ticket_id"]
		ticket_no <- map["ticket_no"]
		ticket_detalis <- map["ticket_detalis"]
		ticket_type <- map["ticket_type"]
		insert_date <- map["insert_date"]
		user_add_id <- map["user_add_id"]
		is_delete <- map["is_delete"]
		ticket_old_id <- map["ticket_old_id"]
		ticket_from <- map["ticket_from"]
		marge_date <- map["marge_date"]
		marge_user <- map["marge_user"]
		important_id <- map["important_id"]
		sig_id <- map["sig_id"]
		need_reply <- map["need_reply"]
		date_reply <- map["date_reply"]
		notes <- map["notes"]
		time_work <- map["time_work"]
		end_date <- map["end_date"]
		user_end <- map["user_end"]
		ticket_status <- map["ticket_status"]
		ticket_hash <- map["ticket_hash"]
		ref_model <- map["ref_model"]
		ref_id <- map["ref_id"]
		ticket_titel <- map["ticket_titel"]
		issue_link <- map["issue_link"]
		relat_id <- map["relat_id"]
		end_date_nearly <- map["end_date_nearly"]
		start_date <- map["start_date"]
		file_detalis <- map["file_detalis"]
		group_id <- map["group_id"]
		count_is_temp <- map["count_is_temp"]
		ticket_status_name <- map["ticket_status_name"]
		from_ticket_name <- map["from_ticket_name"]
		tikcet_id_new_temp <- map["tikcet_id_new_temp"]
		group_name <- map["group_name"]
		is_ticket_admin <- map["is_ticket_admin"]
		canAddTask <- map["canAddTask"]
		start_date_format <- map["start_date_format"]
		end_date_format <- map["end_date_format"]
		date_reply_format <- map["date_reply_format"]
	}

}
