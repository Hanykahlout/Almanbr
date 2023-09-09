/* 
Copyright (c) 2022 Swift Models Generated from JSON powered by http://www.json4swift.com

Permission is hereby granted, free of charge, to any person obtaining a copy of this software and associated documentation files (the "Software"), to deal in the Software without restriction, including without limitation the rights to use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies of the Software, and to permit persons to whom the Software is furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.

For support, please feel free to contact me at https://www.linkedin.com/in/syedabsar

*/

import Foundation
import ObjectMapper

struct ResultResponse : Mappable {
	var vacation_days : Int?
	var vacation_start_date : String?
	var vacation_end_date : String?
	var paid_days : Int?
	var unpaid_days : Int?
	var paid_amount22 : Int?
	var unpaid_amount : Int?
	var vacation_balance : Int?
    
    var paid_days75: Int?
    var paid_days75_amount: Int?
    var paid_days100: Int?
    var paid_days100_amount: Double?
    var sick_balance: String?
    
 
    
    var finance : [Finance]?

	init?(map: Map) {

	}

	mutating func mapping(map: Map) {

		vacation_days <- map["vacation_days"]
		vacation_start_date <- map["vacation_start_date"]
		vacation_end_date <- map["vacation_end_date"]
		paid_days <- map["paid_days"]
		unpaid_days <- map["unpaid_days"]
		paid_amount22 <- map["paid_amount22"]
		unpaid_amount <- map["unpaid_amount"]
		vacation_balance <- map["vacation_balance"]
        
        paid_days75 <- map["paid_days75"]
        paid_days75_amount <- map["paid_days75_amount"]
        paid_days100 <- map["paid_days100"]
        paid_days100_amount <- map["paid_days100_amount"]
        sick_balance <- map["sick_balance"]
		finance <- map["finance"]
        
	}

}
