/* 
Copyright (c) 2022 Swift Models Generated from JSON powered by http://www.json4swift.com

Permission is hereby granted, free of charge, to any person obtaining a copy of this software and associated documentation files (the "Software"), to deal in the Software without restriction, including without limitation the rights to use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies of the Software, and to permit persons to whom the Software is furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.

For support, please feel free to contact me at https://www.linkedin.com/in/syedabsar

*/

import Foundation
import ObjectMapper

struct CheckListItemUsersData : Mappable {
	var person_id : String?
	var emp_id : String?
	var user_username : String?
	var profile_image : Bool?
	var firstname_english : String?
	var secondname_english : String?
	var lastname_english : String?
	var firstname_arabic : String?
	var secondname_arabic : String?
	var lastname_arabic : String?

	init?(map: Map) {

	}

	mutating func mapping(map: Map) {

		person_id <- map["person_id"]
		emp_id <- map["emp_id"]
		user_username <- map["user_username"]
		profile_image <- map["profile_image"]
		firstname_english <- map["firstname_english"]
		secondname_english <- map["secondname_english"]
		lastname_english <- map["lastname_english"]
		firstname_arabic <- map["firstname_arabic"]
		secondname_arabic <- map["secondname_arabic"]
		lastname_arabic <- map["lastname_arabic"]
	}

}
