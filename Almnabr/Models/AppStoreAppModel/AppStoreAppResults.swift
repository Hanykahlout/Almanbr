/* 
Copyright (c) 2022 Swift Models Generated from JSON powered by http://www.json4swift.com

Permission is hereby granted, free of charge, to any person obtaining a copy of this software and associated documentation files (the "Software"), to deal in the Software without restriction, including without limitation the rights to use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies of the Software, and to permit persons to whom the Software is furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.

For support, please feel free to contact me at https://www.linkedin.com/in/syedabsar

*/

import Foundation
import ObjectMapper

struct AppStoreAppResults : Mappable {
	var screenshotUrls : [String]?
	var ipadScreenshotUrls : [String]?
	var appletvScreenshotUrls : [String]?
	var artworkUrl60 : String?
	var artworkUrl512 : String?
	var artworkUrl100 : String?
	var artistViewUrl : String?
	var isGameCenterEnabled : Bool?
	var advisories : [String]?
	var features : [String]?
	var supportedDevices : [String]?
	var kind : String?
	var currency : String?
	var minimumOsVersion : String?
	var trackCensoredName : String?
	var languageCodesISO2A : [String]?
	var fileSizeBytes : String?
	var formattedPrice : String?
	var contentAdvisoryRating : String?
	var averageUserRatingForCurrentVersion : Int?
	var userRatingCountForCurrentVersion : Int?
	var averageUserRating : Int?
	var trackViewUrl : String?
	var trackContentRating : String?
	var releaseNotes : String?
	var isVppDeviceBasedLicensingEnabled : Bool?
	var primaryGenreName : String?
	var primaryGenreId : Int?
	var genreIds : [String]?
	var bundleId : String?
	var releaseDate : String?
	var sellerName : String?
	var trackId : Int?
	var trackName : String?
	var currentVersionReleaseDate : String?
	var description : String?
	var artistId : Int?
	var artistName : String?
	var genres : [String]?
	var price : Double?
	var version : String?
	var wrapperType : String?
	var userRatingCount : Int?

	init?(map: Map) {

	}

	mutating func mapping(map: Map) {

		screenshotUrls <- map["screenshotUrls"]
		ipadScreenshotUrls <- map["ipadScreenshotUrls"]
		appletvScreenshotUrls <- map["appletvScreenshotUrls"]
		artworkUrl60 <- map["artworkUrl60"]
		artworkUrl512 <- map["artworkUrl512"]
		artworkUrl100 <- map["artworkUrl100"]
		artistViewUrl <- map["artistViewUrl"]
		isGameCenterEnabled <- map["isGameCenterEnabled"]
		advisories <- map["advisories"]
		features <- map["features"]
		supportedDevices <- map["supportedDevices"]
		kind <- map["kind"]
		currency <- map["currency"]
		minimumOsVersion <- map["minimumOsVersion"]
		trackCensoredName <- map["trackCensoredName"]
		languageCodesISO2A <- map["languageCodesISO2A"]
		fileSizeBytes <- map["fileSizeBytes"]
		formattedPrice <- map["formattedPrice"]
		contentAdvisoryRating <- map["contentAdvisoryRating"]
		averageUserRatingForCurrentVersion <- map["averageUserRatingForCurrentVersion"]
		userRatingCountForCurrentVersion <- map["userRatingCountForCurrentVersion"]
		averageUserRating <- map["averageUserRating"]
		trackViewUrl <- map["trackViewUrl"]
		trackContentRating <- map["trackContentRating"]
		releaseNotes <- map["releaseNotes"]
		isVppDeviceBasedLicensingEnabled <- map["isVppDeviceBasedLicensingEnabled"]
		primaryGenreName <- map["primaryGenreName"]
		primaryGenreId <- map["primaryGenreId"]
		genreIds <- map["genreIds"]
		bundleId <- map["bundleId"]
		releaseDate <- map["releaseDate"]
		sellerName <- map["sellerName"]
		trackId <- map["trackId"]
		trackName <- map["trackName"]
		currentVersionReleaseDate <- map["currentVersionReleaseDate"]
		description <- map["description"]
		artistId <- map["artistId"]
		artistName <- map["artistName"]
		genres <- map["genres"]
		price <- map["price"]
		version <- map["version"]
		wrapperType <- map["wrapperType"]
		userRatingCount <- map["userRatingCount"]
	}

}
