//
//  Extensions.swift
//  Almnabr
//
//  Created by MacBook on 22/09/2021.
//  Copyright © 2021 Samar Akkila. All rights reserved.
//

import Foundation
import DPLocalization

extension Date {
    func asStringHHmmss() -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.locale = Locale(identifier: "en_US_POSIX")

        dateFormatter.dateFormat = "HH:mm:ss"
        
        dateFormatter.timeZone = TimeZone(abbreviation: "UTC")
        return dateFormatter.string(from: self)
    }
    
    func asStringHHmmssNOUTC() -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.locale = Locale(identifier: "en_US_POSIX")

        dateFormatter.dateFormat = "HH:mm:ss"
        return dateFormatter.string(from: self)
    }
    
    func asStringyyyMMMdd() -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.locale = Locale(identifier: "en_US_POSIX")
        dateFormatter.dateFormat = "dd MMM yyyy" //"yyyy-MM-dd"
        dateFormatter.timeZone = TimeZone(abbreviation: "UTC")
        return dateFormatter.string(from: self)
    }
    
    func asStringyyyMMdd() -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.locale = Locale(identifier: "en_US_POSIX")
        dateFormatter.dateFormat = "yyyy-MM-dd"
        dateFormatter.timeZone = TimeZone(abbreviation: "UTC")
        return dateFormatter.string(from: self)
    }
    
    func asStringyyymmddforhistorical() -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.locale = Locale(identifier: "en_US_POSIX")

        dateFormatter.dateFormat = "yyyy-MM-dd"
        dateFormatter.timeZone = TimeZone(abbreviation: "UTC")
        return dateFormatter.string(from: self)
    }
    
    func asStringyyyMMddNOUTC() -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.locale = Locale(identifier: "en_US_POSIX")

        dateFormatter.dateFormat = "MM/dd/yyyy"
        return dateFormatter.string(from: self)
    }
    
    func asStringWithFormat(formatString: String) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = formatString
        dateFormatter.timeZone = TimeZone(abbreviation: "UTC")
        return dateFormatter.string(from: self)
    }
    
    func asStringWithFormatNoUTC(formatString: String) -> String {
        let dateFormatter = DateFormatter()
        //dateFormatter.locale = Locale(identifier: "en_US_POSIX")
        dateFormatter.dateFormat = formatString
       
        if L102Language.currentAppleLanguage() == "ar" {
            dateFormatter.locale = Locale(identifier: "ar_EG")
            //print("printar")
        } else {
            dateFormatter.locale = Locale(identifier: "en_US")
            dateFormatter.amSymbol = "am"
            dateFormatter.pmSymbol = "pm"
        }
        
        
        
        return dateFormatter.string(from: self)
    }
    
    func isTimeStampCurrent(startTime: Date, endTime: Date)->Bool{
      print("\(self) - \(startTime) - \(endTime)")
        
        if self >= startTime &&
            self <= endTime
        {
            return true
        }
        
        
        return false
    }

    
    
    func asStringHHmm() -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.locale = Locale(identifier: "en_US_POSIX")
        dateFormatter.dateFormat = "hh:mm a"
        dateFormatter.timeZone = TimeZone(abbreviation: "UTC")
        return dateFormatter.string(from: self)
    }
    
    func asStringHHmmNoUTC() -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "HH:mm"
        return dateFormatter.string(from: self)
    }
    
    
    func asStringtoHome() -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy MM dd HH mm"
        return dateFormatter.string(from: self)
    }
    
    func asStringtoMap() -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.locale = Locale(identifier: "en_US_POSIX")
        dateFormatter.dateFormat = "dd-MM-yy hh a"
        dateFormatter.amSymbol = "am"
        dateFormatter.pmSymbol = "pm"
        dateFormatter.timeZone = TimeZone(abbreviation: "UTC")
        return dateFormatter.string(from: self)
    }
    
    
    
    func asStringhhmma() -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "hh:mm a"
        dateFormatter.timeZone = TimeZone(abbreviation: "UTC")
        return dateFormatter.string(from: self)
    }
    
    func asStringhhmmaNoUTC() -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "hh:mm a"
        return dateFormatter.string(from: self)
    }
    
    func asStringDateOnlyNoUTC() -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd-MM-yyyy"
        return dateFormatter.string(from: self)
        
        
        
    }
    
    func asStringDateOnlyNoUTCForGoogleMap() -> String {
        let dateFormatter = DateFormatter()
        //dateFormatter.locale = Locale(identifier: "en_US_POSIX")
        dateFormatter.dateFormat = "dd MMM yyyy   hh a"
        
        if L102Language.currentAppleLanguage() == "ar" {
            dateFormatter.locale = Locale(identifier: "ar_EG")
            //print("printar")
        } else {
            dateFormatter.locale = Locale(identifier: "en_US")
            dateFormatter.amSymbol = "am"
            dateFormatter.pmSymbol = "pm"
        }

        dateFormatter.timeZone = TimeZone(abbreviation: "UTC")
        return dateFormatter.string(from: self)
    }
    
    func asStringDateOnlyNoUTCHome() -> String {
        let dateFormatter = DateFormatter()
        //dateFormatter.locale = Locale(identifier: "en_US_POSIX")
        
        if L102Language.currentAppleLanguage() == "ar" {
            dateFormatter.locale = Locale(identifier: "ar_EG")
            //print("printar")
        } else {
            dateFormatter.locale = Locale(identifier: "en_US")
        }
        
        
        dateFormatter.dateFormat = "dd MMM yyyy"
        dateFormatter.timeZone = TimeZone(abbreviation: "UTC")
        return dateFormatter.string(from: self)
    }
    
    func asStringDateOnlyUTC() -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.locale = Locale(identifier: "en_US_POSIX")
        dateFormatter.dateFormat = "yyyy-MM-dd"
        dateFormatter.timeZone = TimeZone(abbreviation: "UTC")
        return dateFormatter.string(from: self)
    }
    
    func adding(months: Int) -> Date? {
        let calendar = Calendar(identifier: .gregorian)
        
        var components = DateComponents()
        components.calendar = calendar
        components.timeZone = TimeZone(secondsFromGMT: 0)
        components.month = months
        
        return calendar.date(byAdding: components, to: self)
    }
    
    func addingDay(day: Int) -> Date? {
        let calendar = Calendar(identifier: .gregorian)
        
        var components = DateComponents()
        components.calendar = calendar
        components.timeZone = TimeZone(secondsFromGMT: 0)
        components.day = day
        
        return calendar.date(byAdding: components, to: self)
    }
    
    func addingMinutes(minutes: Int) -> Date {
        return Calendar.current.date(byAdding: .minute, value: minutes, to: self)!
    }
    
    
    func asUTCDate() -> Date {
        let dateFormatter = DateFormatter()
        //2018-12-12 13:42:19 +0000
        dateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
        //dateFormatter.timeZone = TimeZone(abbreviation: "UTC")
        let dateString = dateFormatter.string(from: self)
        let dateFormatter1 = DateFormatter()
        dateFormatter1.dateFormat = "yyyy-MM-dd HH:mm:ss"
        dateFormatter1.timeZone = TimeZone(abbreviation: "UTC")
        return dateFormatter1.date(from: dateString)!
    }
    
    
    
    
     
}






import UIKit
import AVFoundation
import Photos

protocol ImagePickerDelegate {
    func imagePickerDelegate(canUseCamera accessIsAllowed:Bool, delegatedForm: ImagePicker)
    func imagePickerDelegate(canUseGallery accessIsAllowed:Bool, delegatedForm: ImagePicker)
    func imagePickerDelegate(didSelect image: UIImage, imageName:String, delegatedForm: ImagePicker)
    func imagePickerDelegate(didCancel delegatedForm: ImagePicker)
}

extension ImagePickerDelegate {
    func imagePickerDelegate(canUseCamera accessIsAllowed:Bool, delegatedForm: ImagePicker) {}
    func imagePickerDelegate(canUseGallery accessIsAllowed:Bool, delegatedForm: ImagePicker) {}
}

class ImagePicker: NSObject {
    
    var controller = UIImagePickerController()
    var selectedImage: UIImage?
    var delegate: ImagePickerDelegate? = nil
    
    override init() {
        super.init()
        controller.sourceType = .photoLibrary
        controller.delegate = self
    }
    
    func dismiss() {
        controller.dismiss(animated: true, completion: nil)
    }
}

extension ImagePicker {
    
    func cameraAsscessRequest() {
        if AVCaptureDevice.authorizationStatus(for: AVMediaType.video) ==  AVAuthorizationStatus.authorized {
            delegate?.imagePickerDelegate(canUseCamera: true, delegatedForm: self)
        } else {
            AVCaptureDevice.requestAccess(for: AVMediaType.video) { granted -> Void in
                self.delegate?.imagePickerDelegate(canUseCamera: granted, delegatedForm: self)
            }
        }
    }
    
    func galleryAsscessRequest() {
        PHPhotoLibrary.requestAuthorization { [weak self] result in
            if let _self = self {
                var access = false
                if result == .authorized {
                    access = true
                }
                _self.delegate?.imagePickerDelegate(canUseGallery: access, delegatedForm: _self)
            }
        }
    }
}

extension ImagePicker: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        let imageName = "img_\(Date().timeIntervalSince1970)"
        if let image = info[UIImagePickerController.InfoKey.editedImage] as? UIImage {
            delegate?.imagePickerDelegate(didSelect: image, imageName: imageName,  delegatedForm: self)
        }
        else if let image = info[UIImagePickerController.InfoKey.originalImage] as? UIImage {
            delegate?.imagePickerDelegate(didSelect: image, imageName: imageName, delegatedForm: self)
        } else{
            print("Something went wrong")
        }
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        delegate?.imagePickerDelegate(didCancel: self)
    }
    
}




import Foundation
extension Notification.Name {
    static let favChangeFromHomeScreen = Notification.Name("favChangeFromHomeScreen")
    static let favChangeFromFavScreen = Notification.Name("favChangeFromFavScreen")
    static let favChangeFromDetailScreen = Notification.Name("favChangeFromDetailScreen")
    static let favLanguage = Notification.Name("favLanguage")
}




import Foundation
import UIKit
extension String {
    
    
    var withoutHtmlTags: String {
        return self.replacingOccurrences(of: "<[^>]+>", with: "", options:
        .regularExpression, range: nil).replacingOccurrences(of: "&[^;]+;", with:
        "", options:.regularExpression, range: nil)
    }
    
    func trim() -> String {
          return self.trimmingCharacters(in: CharacterSet.whitespacesAndNewlines)
    }
    
    func toDouble() -> Double? {
        return NumberFormatter().number(from: self)?.doubleValue
    }
    
    var numberValue:NSNumber? {
        let formatter = NumberFormatter()
        formatter.numberStyle = .decimal
        return formatter.number(from: self)
    }
    
    func isValidEmail() -> Bool {
        // here, `try!` will always succeed because the pattern is valid
        let regex = try! NSRegularExpression(pattern: "^[a-zA-Z0-9.!#$%&'*+/=?^_`{|}~-]+@[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,61}[a-zA-Z0-9])?(?:\\.[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,61}[a-zA-Z0-9])?)*$", options: .caseInsensitive)
        return regex.firstMatch(in: self, options: [], range: NSRange(location: 0, length: count)) != nil
    }
    


    
    
    func height(withConstrainedWidth width: CGFloat, font: UIFont) -> CGFloat {
        let constraintRect = CGSize(width: width, height: .greatestFiniteMagnitude)
        let boundingBox = self.boundingRect(with: constraintRect, options: .usesLineFragmentOrigin, attributes: [.font:font], context: nil)
        return ceil(boundingBox.height)
    }
    
    func width(withConstrainedHeight height: CGFloat, font: UIFont) -> CGFloat {
        let constraintRect = CGSize(width: .greatestFiniteMagnitude, height: height)
        let boundingBox = self.boundingRect(with: constraintRect, options: .usesLineFragmentOrigin, attributes: [.font:font], context: nil)
        
        return ceil(boundingBox.width)
    }
    
    
    func SizeOf_String( font: UIFont) -> CGSize {
        let fontAttribute = [NSAttributedString.Key.font: font]
        let size = self.size(withAttributes: fontAttribute)  // for Single Line
        return size;
    }
    
    func getLocalizedString(keyString: String) -> String {
        if keyString.count == 0 {
            return ""
        }
       return keyString
    }
    
   

   
    
    func localized(withComment comment: String? = nil) -> String {
        
  
       return NSLocalizedString(self, tableName: nil, bundle: Bundle.main, value: "", comment: "")
    }
    
    func getUIColor() -> UIColor {
        return UIColor.init(hexString: self)
    }
    
    public var replacedArabicDigitsWithEnglish: String {
        var str = self
        let map = ["٠": "0",
                   "١": "1",
                   "٢": "2",
                   "٣": "3",
                   "٤": "4",
                   "٥": "5",
                   "٦": "6",
                   "٧": "7",
                   "٨": "8",
                   "٩": "9"]
        map.forEach { str = str.replacingOccurrences(of: $0, with: $1) }
        return str
    }
    
    
    public var convertToDate: Date {
        let dateFormatter = DateFormatter()
        dateFormatter.locale = Locale(identifier: "en_US_POSIX")
        dateFormatter.dateFormat = "yyyy-MM-dd" //Your date format
        dateFormatter.timeZone = TimeZone(abbreviation: "UTC")
        
        guard let date = dateFormatter.date(from: self) else {
            fatalError()
        }
        return date
    }
    
    public var convertToDateOnly: String {
        let dateFormatter = DateFormatter()
        dateFormatter.locale = Locale(identifier: "en_US_POSIX")
        dateFormatter.dateFormat = "yyyy-MM-dd" //Your date format
        dateFormatter.timeZone = TimeZone(abbreviation: "UTC") //Current time zone
        //according to date format your date string
        guard let date = dateFormatter.date(from: self) else {
            fatalError()
        }
        
        let dateFormatter1 = DateFormatter()
        dateFormatter1.locale = Locale(identifier: "en_US_POSIX")
        dateFormatter1.dateFormat = "yyyy-MM-dd" //Your date format
        
        let dateString = dateFormatter1.string(from: date)
        return dateString
    }
    
    public var convertStringToDate: Date {
        let dateFormatter = DateFormatter()
        dateFormatter.locale = Locale(identifier: "en_US_POSIX")
        dateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss" //Your date format
        dateFormatter.timeZone = TimeZone(abbreviation: "UTC")
        guard let date = dateFormatter.date(from: self) else {
            fatalError()
        }
        
        return date.addingTimeInterval(1 * 60 * 85)
    }
    
    public var convertStringToDateWithUTC: Date {
        let dateFormatter = DateFormatter()
        dateFormatter.locale = Locale(identifier: "en_US")
        dateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss" //Your date format //2019-09-05 00:00:00
        dateFormatter.timeZone = TimeZone(abbreviation: "UTC")
        guard let date = dateFormatter.date(from: self) else {
            fatalError()
        }
        
        return date
    }
    
    public var convertToDateWithTimeZone: Date {
        let dateFormatter = DateFormatter()
        dateFormatter.locale = Locale(identifier: "en_US_POSIX")
        dateFormatter.dateFormat = "yyyyMMddHH" //Your date format
        dateFormatter.timeZone = TimeZone(abbreviation: "UTC") //Current time zone
        //according to date format your date string
        guard let date = dateFormatter.date(from: self) else {
            fatalError()
        }
        return date
    }
    
    
    public var convertToDateWithTimeZoneToString: String {
        let dateFormatter = DateFormatter()
        dateFormatter.locale = Locale(identifier: "en_US_POSIX")
        dateFormatter.dateFormat = "yyyy-MM-dd" //Your date format
        dateFormatter.timeZone = TimeZone(abbreviation: "UTC") //Current time zone
        //according to date format your date string
        guard let date = dateFormatter.date(from: self) else {
            fatalError()
        }
        let dateFormatter1 = DateFormatter()
        dateFormatter1.locale = Locale(identifier: "en_US_POSIX")
        dateFormatter1.dateFormat = "dd MMM yyyy" //Your date format
        
        let dateString = dateFormatter1.string(from: date)
        return dateString
    }
    
    public var convertToDateWithAMPM: Date {
        let dateFormatter = DateFormatter()
        dateFormatter.locale = Locale(identifier: "en_US_POSIX")
        dateFormatter.dateFormat = "yyyy:MM:dd hh:mm a" //Your date format
        //dateFormatter.timeZone = TimeZone.autoupdatingCurrent
        dateFormatter.timeZone = TimeZone(abbreviation: "UTC") //Current time zone
        //according to date format your date string
        guard let date = dateFormatter.date(from: self) else {
            fatalError()
        }
        return date
    }
    
    func hasTopNotch() -> Bool {
        if #available(iOS 11.0, tvOS 11.0, *) {
            // with notch: 44.0 on iPhone X, XS, XS Max, XR.
            // without notch: 20.0 on iPhone 8 on iOS 12+.
            return UIApplication.shared.delegate?.window??.safeAreaInsets.top ?? 0 > 20
        }
        return false
    }
    
    public var convertOnlyTimeToDate: Date {
        let dateFormatter = DateFormatter()
        dateFormatter.locale = Locale(identifier: "en_US_POSIX")
        dateFormatter.dateFormat = "yyyy:MM:dd HH:mm:ss" //Your date format
        dateFormatter.timeZone = TimeZone.autoupdatingCurrent
        dateFormatter.timeZone = TimeZone(abbreviation: "UTC") //Current time zone
        //according to date format your date string
        guard let date = dateFormatter.date(from: self) else {
            fatalError()
        }
        return date
    }
    
    public var convertOnlyTimeToDateMap: Date {
        let dateFormatter = DateFormatter()
        dateFormatter.locale = Locale(identifier: "en_US_POSIX")
        dateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss" //Your date format
        dateFormatter.timeZone = TimeZone.autoupdatingCurrent
        dateFormatter.timeZone = TimeZone(abbreviation: "UTC") //Current time zone
        //according to date format your date string
        guard let date = dateFormatter.date(from: self) else {
            fatalError()
        }
        return date
    }
    
    func lineSpaced(_ spacing: CGFloat) -> NSAttributedString {
        let paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.lineSpacing = spacing
        let attributedString = NSAttributedString(string: self, attributes: [NSAttributedString.Key.paragraphStyle: paragraphStyle])
        return attributedString
    }
    
    
    
    
    public var convertTimeToString: String {
        let dateFormatter = DateFormatter()
        dateFormatter.locale = Locale(identifier: "en_US_POSIX")
        dateFormatter.dateFormat = "HH:mm:ss" //Your date format
        // dateFormatter.timeZone = TimeZone.autoupdatingCurrent
        //dateFormatter.timeZone = TimeZone(abbreviation: "UTC") //Current time zone
        //according to date format your date string
        guard let date = dateFormatter.date(from: self) else {
            fatalError()
        }
        
        let dateFormatter1 = DateFormatter()
        dateFormatter1.locale = Locale(identifier: "en_US_POSIX")
        dateFormatter1.dateFormat = "hh:mm a" //Your date format
        
        let dateString = dateFormatter1.string(from: date)
        return dateString
    }
    
    
    public var convertTimeToStringHHmm: String {
        let dateFormatter = DateFormatter()
        dateFormatter.locale = Locale(identifier: "en_US_POSIX")
        dateFormatter.dateFormat = "HH:mm:ss" //Your date format
        guard let date = dateFormatter.date(from: self) else {
            fatalError()
        }
        
        let dateFormatter1 = DateFormatter()
        dateFormatter1.locale = Locale(identifier: "en_US_POSIX")
        dateFormatter1.dateFormat = "HH:mm" //Your date format
        
        let dateString = dateFormatter1.string(from: date)
        return dateString
    }
    
    public var convertTimeToStringhhmma: String {
        let dateFormatter = DateFormatter()
        dateFormatter.locale = Locale(identifier: "en_US_POSIX")
        dateFormatter.dateFormat = "HH:mm:ss" //Your date format
        guard let date = dateFormatter.date(from: self) else {
            fatalError()
        }
        
        let dateFormatter1 = DateFormatter()
        dateFormatter1.locale = Locale(identifier: "en_US_POSIX")
        dateFormatter1.dateFormat = "hh:mm a" //Your date format
        
        let dateString = dateFormatter1.string(from: date)
        return dateString
    }
    
    
    public var convertTimeAmToStringHHmm: String {
        print(self)
        let dateFormatter = DateFormatter()
        dateFormatter.locale = Locale(identifier: "en_US")
        dateFormatter.dateFormat = "yyyy:MM:dd hh:ss a" //Your date format
        guard let date = dateFormatter.date(from: self) else {
            fatalError()
        }
        
        let dateFormatter1 = DateFormatter()
        dateFormatter1.locale = Locale(identifier: "en_US")
        dateFormatter1.dateFormat = "HH:ss" //Your date format
        
        let dateString = dateFormatter1.string(from: date)
        print(dateString)
        return dateString
    }
    
    
    public var convertTimeAmToStringhhmma: String {
        print(self)
        let dateFormatter = DateFormatter()
        dateFormatter.locale = Locale(identifier: "en_US")
        dateFormatter.dateFormat = "yyyy:MM:dd hh:ss a" //Your date format
        
        guard let date = dateFormatter.date(from: self) else {
            fatalError()
        }
        
        let dateFormatter1 = DateFormatter()
        dateFormatter1.locale = Locale(identifier: "en_US")
        dateFormatter1.dateFormat = "hh:ss a" //Your date format
        
        let dateString = dateFormatter1.string(from: date)
        print(dateString)
        return dateString
    }
    
    
    //this method used in the airquality app
    public var convertStringToDateWithOutExtraDateEnglish: Date {
        let dateFormatter = DateFormatter()
        dateFormatter.locale = Locale(identifier: "en_US")
        dateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss" //Your date format
        //dateFormatter.timeZone = TimeZone(abbreviation: "GMT")
        guard let date = dateFormatter.date(from: self) else {
            fatalError()
        }
        return date
    }
    
    public var convertDateToString: Date {
        let dateFormatter = DateFormatter()
        dateFormatter.locale = Locale(identifier: "en_US")
        dateFormatter.dateFormat = "yyyy-MM-dd hh:mm a" //Your date format
        //dateFormatter.timeZone = TimeZone(abbreviation: "GMT")
        guard let date = dateFormatter.date(from: self) else {
            fatalError()
        }
        return date
    }
    
    public var convertToDateWithTimeZoneToStringForForecast: String {
        let dateFormatter = DateFormatter()
        dateFormatter.locale = Locale(identifier: "en_US_POSIX")
        dateFormatter.dateFormat = "yyyyMMddHHmmss" //Your date format
        dateFormatter.timeZone = TimeZone(abbreviation: "UTC") //Current time zone
        //according to date format your date string
        guard let date = dateFormatter.date(from: self) else {
            fatalError()
        }
        let dateFormatter1 = DateFormatter()
        
        dateFormatter1.dateFormat = "dd MMM yyyy   hh a" //Your date format

        if L102Language.currentAppleLanguage()  == "ar" {
            dateFormatter1.locale = Locale(identifier: "ar_EG")
        } else {
            dateFormatter1.locale = Locale(identifier: "en_US")
            dateFormatter1.amSymbol = "am"
            dateFormatter1.pmSymbol = "pm"
        }
        
        let dateString = dateFormatter1.string(from: date)
        return dateString
    }
    
    public var convertDateToHome: String {
        let dateFormatter = DateFormatter()
        dateFormatter.locale = Locale(identifier: "en_US")
        dateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss" //Your date format
        guard let date = dateFormatter.date(from: self) else {
            fatalError()
        }
        
        let dateFormatter1 = DateFormatter()
        dateFormatter1.dateFormat = "dd MMM yyyy  hh a"
        if L102Language.currentAppleLanguage() == "ar" {
            dateFormatter1.locale = Locale(identifier: "ar_EG")
           
        } else {
            dateFormatter1.locale = Locale(identifier: "en_US")
            dateFormatter1.amSymbol = "am"
            dateFormatter1.pmSymbol = "pm"
        }
        
        
        let dateString = dateFormatter1.string(from: date)
        print(dateString)
        return dateString
    }
    
    public var convertDateToHoursOnlyHome: String {
        let dateFormatter = DateFormatter()
        dateFormatter.locale = Locale(identifier: "en_US_POSIX")
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ssZ" //Your date format
        //dateFormatter.timeZone = TimeZone(abbreviation: "UTC")
        guard let date = dateFormatter.date(from: self) else {
            fatalError()
        }
        let dateFormatter1 = DateFormatter()
        //dateFormatter1.locale = Locale(identifier: "en_US_POSIX")
        dateFormatter1.dateFormat = "hh:mm a" //Your date format
        //dateFormatter1.amSymbol = "am"
        //dateFormatter1.pmSymbol = "pm"
        
        if L102Language.currentAppleLanguage() == "ar" {
            dateFormatter1.locale = Locale(identifier: "ar_EG")
            print("printar")
        } else {
            dateFormatter1.locale = Locale(identifier: "en_US")
            dateFormatter1.amSymbol = "am"
            dateFormatter1.pmSymbol = "pm"
        }
        
        
        dateFormatter1.timeZone = TimeZone(abbreviation: "UTC")
        let dateString = dateFormatter1.string(from: date)
        
        return dateString
    }
    
    public var convertDateToDateOnlyHome: Date {
        let dateFormatter = DateFormatter()
        dateFormatter.locale = Locale(identifier: "en_US_POSIX")
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ssZ" //Your date format
        dateFormatter.timeZone = TimeZone(abbreviation: "UTC")
        guard let date = dateFormatter.date(from: self) else {
            fatalError()
        }
        return date
    }
    
    func getCleanedURL() -> URL? {
       guard self.isEmpty == false else {
           return nil
       }
       if let url = URL(string: self) {
           return url
       } else {
           if let urlEscapedString = self.addingPercentEncoding(withAllowedCharacters: CharacterSet.urlQueryAllowed) , let escapedURL = URL(string: urlEscapedString){
               return escapedURL
           }
       }
       return nil
    }
}



import Foundation
extension UIApplication {
    
    
    var isKeyboardPresented: Bool {
        if let keyboardWindowClass = NSClassFromString("UIRemoteKeyboardWindow"),
            self.windows.contains(where: { $0.isKind(of: keyboardWindowClass) }) {
            return true
        } else {
            return false
        }
    }
    
   
    
    
class func topViewController(controller: UIViewController? = UIApplication.shared.keyWindow?.rootViewController) -> UIViewController? {
    if let navigationController = controller as? UINavigationController {
        return topViewController(controller: navigationController.visibleViewController)
    }
    if let tabController = controller as? UITabBarController {
        if let selected = tabController.selectedViewController {
            return topViewController(controller: selected)
        }
    }
    if let presented = controller?.presentedViewController {
        return topViewController(controller: presented)
    }
    return controller
}
    
}





import Foundation
import UIKit

extension UIButton
{
    func applyGradient(colors: [CGColor])
    {
        let gradientLayer = CAGradientLayer()
        gradientLayer.colors = colors
        gradientLayer.locations = [0.0,1.0]
        gradientLayer.startPoint = CGPoint(x: 0.0, y:0.5)
        gradientLayer.endPoint = CGPoint(x: 0.5, y: 1.0)
        gradientLayer.frame = self.bounds
        self.layer.insertSublayer(gradientLayer, at: 0)
    }
    
    func dropShadow(color: UIColor, opacity: Float = 0.5, offSet: CGSize, shadowRadius: CGFloat = 1, scale: Bool = true, cornerRadius: CGFloat, fillColor: UIColor) {
        let shadowLayer = CAShapeLayer()
        shadowLayer.path = UIBezierPath(roundedRect: bounds, cornerRadius: cornerRadius).cgPath
        shadowLayer.fillColor = fillColor.cgColor
        shadowLayer.shadowColor = color.cgColor
        shadowLayer.shadowPath = shadowLayer.path
        shadowLayer.shadowOffset = offSet
        shadowLayer.shadowOpacity = opacity
        shadowLayer.shadowRadius = shadowRadius
        layer.insertSublayer(shadowLayer, at: 0)
    }

    
    func setUnderLine(stringValue: String) {
        let attriSignUp = [
            NSAttributedString.Key.font : UIFont.boldSystemFont(ofSize: 14),
            NSAttributedString.Key.foregroundColor : UIColor.buttonBackgroundColor(),
            NSAttributedString.Key.underlineStyle : 1] as [NSAttributedString.Key : Any]
        self.setTitleColor(.buttonBackgroundColor(), for: .normal)
        let attributeSignUp = NSMutableAttributedString(string: stringValue.localized(),
                                                        attributes: attriSignUp)
        self.setAttributedTitle(attributeSignUp, for: .normal)
    }
    
    func setUnderLine(stringValue: String, withTextSize: CGFloat) {
        let attriSignUp = [
            NSAttributedString.Key.font : UIFont(name: "DroidArabicKufi", size: withTextSize)!,
            NSAttributedString.Key.foregroundColor : UIColor.buttonBackgroundColor(),
            NSAttributedString.Key.underlineStyle : 1] as [NSAttributedString.Key : Any]
        self.setTitleColor(.buttonUnderLineBackgroundColor(), for: .normal)
        let attributeSignUp = NSMutableAttributedString(string: stringValue.localized(),
                                                        attributes: attriSignUp)
        self.setAttributedTitle(attributeSignUp, for: .normal)
    }
    
    func maskButtonByRoundingCorners(_ masks:UIRectCorner, withRadii radii:CGSize = CGSize(width: 10, height: 10)) {
        let rounded = UIBezierPath(roundedRect: self.bounds, byRoundingCorners: masks, cornerRadii: radii)
        
        let shape = CAShapeLayer()
        shape.path = rounded.cgPath
        
        self.layer.mask = shape
    }
    
    func roundedCorners(top: Bool){
        let corners:UIRectCorner = (top ? [.topLeft , .topRight] : [.bottomRight , .bottomLeft])
        let maskPAth1 = UIBezierPath(roundedRect: self.bounds,
                                     byRoundingCorners: corners,
                                     cornerRadii:CGSize(width:8.0, height:8.0))
        let maskLayer1 = CAShapeLayer()
        maskLayer1.frame = self.bounds
        maskLayer1.path = maskPAth1.cgPath
        self.layer.mask = maskLayer1
    }
    
    func roundCorners(top: Bool , radius: CGFloat) {
        let corners:UIRectCorner = (top ? [.topLeft , .topRight] : [.bottomRight , .bottomLeft])
        let path = UIBezierPath(roundedRect: self.bounds, byRoundingCorners: corners, cornerRadii: CGSize(width: radius, height: radius))
        let mask = CAShapeLayer()
        let rect = self.bounds
        mask.frame = rect
        mask.path = path.cgPath
        self.layer.mask = mask
    }
    
    
    
       
}



import Foundation
import UIKit

extension UIColor {
    
    convenience init(hexString: String) {
        let hex = hexString.trimmingCharacters(in: CharacterSet.alphanumerics.inverted)
        var int = UInt32()
        Scanner(string: hex).scanHexInt32(&int)
        let a, r, g, b: UInt32
        switch hex.count {
        case 3: // RGB (12-bit)
            (a, r, g, b) = (255, (int >> 8) * 17, (int >> 4 & 0xF) * 17, (int & 0xF) * 17)
        case 6: // RGB (24-bit)
            (a, r, g, b) = (255, int >> 16, int >> 8 & 0xFF, int & 0xFF)
        case 8: // ARGB (32-bit)
            (a, r, g, b) = (int >> 24, int >> 16 & 0xFF, int >> 8 & 0xFF, int & 0xFF)
        default:
            (a, r, g, b) = (1, 1, 1, 0)
        }
        self.init(red: CGFloat(r) / 255, green: CGFloat(g) / 255, blue: CGFloat(b) / 255, alpha: CGFloat(a) / 255)
    }
    
    public class func yellowMainColor() -> UIColor {
        return UIColor(hexString: "#fbcc34")
    }
    
    public class func colorBackGround() -> UIColor {
        return UIColor(hexString: "#f3f3f3")
    }
    
    public class func buttonBackgroundColor() -> UIColor {
        return UIColor(hexString: "#193665")
    }
    
    public class func buttonUnderLineBackgroundColor() -> UIColor {
        return UIColor(hexString: "#8B9194")
    }
    
    public class func colorPrimary() -> UIColor {
        return UIColor(hexString: "#FFFFFF")
    }
    
    public class func iconsColor() -> UIColor {
        return UIColor(hexString: "#2196F3")
    }
    public class func primaryDark() -> UIColor {
        return UIColor(hexString: "#1976D2")
    }
    
    public class func colorPrimaryText() -> UIColor {
        return UIColor(hexString: "#212121")
    }
    
    
    public class func colorSecondaryText() -> UIColor {
        return UIColor(hexString: "#757575")
    }
    
    public class func colorPSText() -> UIColor {
        return UIColor(hexString: "#474e52")
    }
    
    public class func colorError() -> UIColor {
        return UIColor(hexString: "#FF5149")
    }
    
    public class func buttonNormalColor() -> UIColor {
        return UIColor.iconsColor()
    }
    
    public class func lightPrimaryColor() -> UIColor {
        return UIColor(hexString: "#BBDEFB")
    }
    
    public class func buttonPressedColor() -> UIColor {
        return UIColor.lightPrimaryColor()
    }
    
    public class func textLightColor() -> UIColor {
        return UIColor.white
    }
    
    
    public class func colorBackground() -> UIColor {
        return UIColor(hexString: "#f3f3f4")
    }
    
    public class func colorTransparentTint() -> UIColor {
        return colorSecondaryText().withAlphaComponent(0.5)
    }
    
    public class func colorActivityIndicator() -> UIColor {
        return colorPrimary()
    }
    
    public class func colorDivider() -> UIColor {
        return lightGray.withAlphaComponent(0.5)
    }
    
    public class func colorDarkBackground() -> UIColor {
        return UIColor.init(white: 0.92, alpha: 1)
    }
    
    
    open class var colotTint: UIColor {
        get {
            return UIColor.black
        }
    }
}



import Foundation
import UIKit

extension UIFont {
    private static func customFont(name: String, size: CGFloat) -> UIFont {
        let font = UIFont(name: name, size: size)
        assert(font != nil, "Can't load font: \(name)")
        return font ?? UIFont.systemFont(ofSize: size)
    }
    
    static func kufiBoldFont(ofSize size: CGFloat) -> UIFont {
        return customFont(name: "DroidArabicKufi-Bold", size: size)
    }
    
    static func kufiRegularFont(ofSize size: CGFloat) -> UIFont {
        return customFont(name: "DroidArabicKufi", size: size)
    }
}




import Foundation
import UIKit
import ImageIO

extension UIImageView {

    public func loadGif(name: String) {
        DispatchQueue.global().async {
            let image = UIImage.gif(name: name)
            DispatchQueue.main.async {
                self.image = image
            }
        }
    }
    
    @available(iOS 9.0, *)
    public func loadGif(asset: String) {
        DispatchQueue.global().async {
            let image = UIImage.gif(asset: asset)
            DispatchQueue.main.async {
                self.image = image
            }
        }
    }
}

extension UIImage {

    
    
    public class func gif(data: Data) -> UIImage? {
        // Create source from data
        guard let source = CGImageSourceCreateWithData(data as CFData, nil) else {
            print("SwiftGif: Source for the image does not exist")
            return nil
        }

        return UIImage.animatedImageWithSource(source)
    }
    
    
    
    public class func gif(name: String) -> UIImage? {
        // Check for existance of gif
        guard let bundleURL = Bundle.main
          .url(forResource: name, withExtension: "gif") else {
            print("SwiftGif: This image named \"\(name)\" does not exist")
            return nil
        }

        // Validate data
        guard let imageData = try? Data(contentsOf: bundleURL) else {
            print("SwiftGif: Cannot turn image named \"\(name)\" into NSData")
            return nil
        }

        return gif(data: imageData)
    }
    
    @available(iOS 9.0, *)
    public class func gif(asset: String) -> UIImage? {
        // Create source from assets catalog
        guard let dataAsset = NSDataAsset(name: asset) else {
            print("SwiftGif: Cannot turn image named \"\(asset)\" into NSDataAsset")
            return nil
        }

        return gif(data: dataAsset.data)
    }
    
    
    
    internal class func gcdForArray(_ array: [Int]) -> Int {
        if array.isEmpty {
            return 1
        }

        var gcd = array[0]

        for val in array {
            gcd = UIImage.gcdForPair(val, gcd)
        }

        return gcd
    }
    
    
    internal class func gcdForPair(_ lhs: Int?, _ rhs: Int?) -> Int {
        var lhs = lhs
        var rhs = rhs
        // Check if one of them is nil
        if rhs == nil || lhs == nil {
            if rhs != nil {
                return rhs!
            } else if lhs != nil {
                return lhs!
            } else {
                return 0
            }
        }

        // Swap for modulo
        if lhs! < rhs! {
            let ctp = lhs
            lhs = rhs
            rhs = ctp
        }

        // Get greatest common divisor
        var rest: Int
        while true {
            rest = lhs! % rhs!

            if rest == 0 {
                return rhs! // Found it
            } else {
                lhs = rhs
                rhs = rest
            }
        }
    }

    internal class func animatedImageWithSource(_ source: CGImageSource) -> UIImage? {
        let count = CGImageSourceGetCount(source)
        var images = [CGImage]()
        var delays = [Int]()

        // Fill arrays
        for index in 0..<count {
            // Add image
            if let image = CGImageSourceCreateImageAtIndex(source, index, nil) {
                images.append(image)
            }

            // At it's delay in cs
            let delaySeconds = UIImage.delayForImageAtIndex(Int(index),
                source: source)
            delays.append(Int(delaySeconds * 1000.0)) // Seconds to ms
        }

        // Calculate full duration
        let duration: Int = {
            var sum = 0

            for val: Int in delays {
                sum += val
            }

            return sum
            }()

        // Get frames
        let gcd = gcdForArray(delays)
        var frames = [UIImage]()

        var frame: UIImage
        var frameCount: Int
        for index in 0..<count {
            frame = UIImage(cgImage: images[Int(index)])
            frameCount = Int(delays[Int(index)] / gcd)

            for _ in 0..<frameCount {
                frames.append(frame)
            }
        }

        // Heyhey
        let animation = UIImage.animatedImage(with: frames,
            duration: Double(duration) / 1000.0)

        return animation
    }

    
    internal class func delayForImageAtIndex(_ index: Int, source: CGImageSource!) -> Double {
        var delay = 0.1

        // Get dictionaries
        let cfProperties = CGImageSourceCopyPropertiesAtIndex(source, index, nil)
        let gifPropertiesPointer = UnsafeMutablePointer<UnsafeRawPointer?>.allocate(capacity: 0)
        defer {
            gifPropertiesPointer.deallocate()
        }
        let unsafePointer = Unmanaged.passUnretained(kCGImagePropertyGIFDictionary).toOpaque()
        if CFDictionaryGetValueIfPresent(cfProperties, unsafePointer, gifPropertiesPointer) == false {
            return delay
        }

        let gifProperties: CFDictionary = unsafeBitCast(gifPropertiesPointer.pointee, to: CFDictionary.self)

        // Get delay time
        var delayObject: AnyObject = unsafeBitCast(
            CFDictionaryGetValue(gifProperties,
                Unmanaged.passUnretained(kCGImagePropertyGIFUnclampedDelayTime).toOpaque()),
            to: AnyObject.self)
        if delayObject.doubleValue == 0 {
            delayObject = unsafeBitCast(CFDictionaryGetValue(gifProperties,
                Unmanaged.passUnretained(kCGImagePropertyGIFDelayTime).toOpaque()), to: AnyObject.self)
        }

        if let delayObject = delayObject as? Double, delayObject > 0 {
            delay = delayObject
        } else {
            delay = 0.008 // Make sure they're not too fast
        }

        return delay
    }

    
    
    func alpha(_ value:CGFloat) -> UIImage {
        UIGraphicsBeginImageContextWithOptions(size, false, scale)
        draw(at: CGPoint.zero, blendMode: .normal, alpha: value)
        let newImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return newImage!
    }
    
    
    convenience init?(color: UIColor, size: CGSize = CGSize(width: 1, height: 1)) {
        let rect = CGRect(origin: .zero, size: size)
        UIGraphicsBeginImageContextWithOptions(rect.size, false, 0.0)
        color.setFill()
        UIRectFill(rect)
        let image = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        
        guard let cgImage = image?.cgImage else { return nil }
        self.init(cgImage: cgImage)
    }
    
    func rotate(radians: Float) -> UIImage? {
        var newSize = CGRect(origin: CGPoint.zero, size: self.size).applying(CGAffineTransform(rotationAngle: CGFloat(radians))).size
        // Trim off the extremely small float value to prevent core graphics from rounding it up
        newSize.width = floor(newSize.width)
        newSize.height = floor(newSize.height)
        
        UIGraphicsBeginImageContextWithOptions(newSize, true, self.scale)
        let context = UIGraphicsGetCurrentContext()!
        
        // Move origin to middle
        context.translateBy(x: newSize.width/2, y: newSize.height/2)
        // Rotate around middle
        context.rotate(by: CGFloat(radians))
        // Draw the image at its center
        self.draw(in: CGRect(x: -self.size.width/2, y: -self.size.height/2, width: self.size.width, height: self.size.height))
        
        let newImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        
        return newImage
    }
    
    func resized(withPercentage percentage: CGFloat) -> UIImage? {
        let canvasSize = CGSize(width: size.width * percentage, height: size.height * percentage)
        UIGraphicsBeginImageContextWithOptions(canvasSize, false, scale)
        defer { UIGraphicsEndImageContext() }
        draw(in: CGRect(origin: .zero, size: canvasSize))
        return UIGraphicsGetImageFromCurrentImageContext()
    }
    func resized(toWidth width: CGFloat) -> UIImage? {
        let canvasSize = CGSize(width: width, height: CGFloat(ceil(width/size.width * size.height)))
        UIGraphicsBeginImageContextWithOptions(canvasSize, false, scale)
        defer { UIGraphicsEndImageContext() }
        draw(in: CGRect(origin: .zero, size: canvasSize))
        return UIGraphicsGetImageFromCurrentImageContext()
    }
    
    
   func maskWithColor( color:UIColor) -> UIImage {

         UIGraphicsBeginImageContextWithOptions(self.size, false, UIScreen.main.scale)
         let context = UIGraphicsGetCurrentContext()!

         color.setFill()

         context.translateBy(x: 0, y: self.size.height)
         context.scaleBy(x: 1.0, y: -1.0)

         let rect = CGRect(x: 0.0, y: 0.0, width: self.size.width, height: self.size.height)
         context.draw(self.cgImage!, in: rect)

         context.setBlendMode(CGBlendMode.sourceIn)
         context.addRect(rect)
         context.drawPath(using: CGPathDrawingMode.fill)

         let coloredImage = UIGraphicsGetImageFromCurrentImageContext()
         UIGraphicsEndImageContext()

         return coloredImage!
    }
    
    
    public enum DataUnits: String {
           case byte, kilobyte, megabyte, gigabyte
       }

       func getSizeIn(_ type: DataUnits)-> String {

           guard let data = self.pngData() else {
               return ""
           }

           var size: Double = 0.0

           switch type {
           case .byte:
               size = Double(data.count)
           case .kilobyte:
               size = Double(data.count) / 1024
           case .megabyte:
               size = Double(data.count) / 1024 / 1024
           case .gigabyte:
               size = Double(data.count) / 1024 / 1024 / 1024
           }

           return String(format: "%.2f", size)
       }
}





import Foundation


//extension UIImageView {
//    func downloadUserProfileImage(urlString: String?) {
//        self.kf.indicatorType = .activity
//        if  urlString != nil {
//            let url = URL(string: urlString!)!
//            let placeHolderImage = UIImage(named: "icon_user_default")
//            let processor = RoundCornerImageProcessor(cornerRadius: self.frame.size.width / 2)
//
//            //let processor = BlurImageProcessor(blurRadius: 4) >> RoundCornerImageProcessor(cornerRadius: 20)
//            //[.processor(processor)]
//            
//            let resource = ImageResource(downloadURL: url, cacheKey: urlString!)
//            
//            self.kf.setImage(with: resource, placeholder: placeHolderImage, options: [.processor(processor)], progressBlock: { receivedSize, totalSize in
//               
//                
//            })
////            { (image, error, cacheType, imageUrl) in
////
////            }
//        } else {
//            
//            let placeHolderImage = UIImage(named: "icon_user_default")
//            self.image = placeHolderImage!
//        }
//    }
//    
//    
//    func downloadImageWithoutPlaceHolder(urlString: String?, withColor: UIColor?) {
//        
//        self.kf.indicatorType = .activity
//        if  urlString != nil && urlString!.count > 0 {
//            let urlS = urlString?.replacingOccurrences(of: "thumbnail/", with: "")
//            var urlStr : String = urlS!.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)!
//            
//            
//            if urlStr.contains("http://") || urlStr.contains("https://") {
//                
//            } else {
//                urlStr = "\(APIManager.serverURL)/storage/\(urlStr)"
//            }
//            
//            
//            let url = URL(string: urlStr)!
//
//            
//            //let url = URL(string: urlString!)!
//            
//            if withColor != nil {
//                //let processor = TintImageProcessor(tint: withColor!)
//                //let processor = BlurImageProcessor(blurRadius: 4) >> RoundCornerImageProcessor(cornerRadius: 20)
//                //[.processor(processor)]
//                self.kf.setImage(with: url, placeholder: nil, options: nil, progressBlock: { receivedSize, totalSize in
//                    //let percentage = (Float(receivedSize) / Float(totalSize)) * 100.0
//                    
//                })
////                { (image, error, cacheType, imageUrl) in
////                    self.image = image?.maskWithColor(color: withColor!)
////                }
//                
//                
//            } else {
//
//                self.kf.setImage(with: url, placeholder: nil, options: nil, progressBlock: { receivedSize, totalSize in
//                    //let percentage = (Float(receivedSize) / Float(totalSize)) * 100.0
//                    
//                })
////                { (image, error, cacheType, imageUrl) in
////
////                }
//            }
//           
//        } else {
//            self.backgroundColor = .white
//        }
//    }
//    
//    
//    func downloadSaloonImage(urlString: String?) {
//        self.kf.indicatorType = .activity
//        if  urlString != nil {
//            let url = URL(string: urlString!)!
//            let placeHolderImage = UIImage(named: "icon_registration")
//            self.kf.setImage(with: url, placeholder: placeHolderImage, options: nil, progressBlock: { receivedSize, totalSize in
//                let percentage = (Float(receivedSize) / Float(totalSize)) * 100.0
//                print("downloading progress: \(percentage)%")
//            })
////            { (image, error, cacheType, imageUrl) in
////
////            }
//        } else {
//            let placeHolderImage = UIImage(named: "icon_registration")
//            self.image = placeHolderImage!
//        }
//    }
//    
//    
//    func downloadSaloonImageWithColor(urlString: String?, tintColor: String) {
//        self.kf.indicatorType = .activity
//        if  urlString != nil {
//            let url = URL(string: urlString!)!
//            let placeHolderImage = UIImage(named: "icon_registration")
//            let processor = OverlayImageProcessor(overlay: tintColor.getUIColor(), fraction: 0.0)
//            self.kf.setImage(with: url, placeholder: placeHolderImage, options:[.processor(processor)], progressBlock: { receivedSize, totalSize in
//                let percentage = (Float(receivedSize) / Float(totalSize)) * 100.0
//                print("downloading progress: \(percentage)%")
//            })
////            { (image, error, cacheType, imageUrl) in
////
////            }
//        } else {
//            let placeHolderImage = UIImage(named: "icon_registration")
//            self.image = placeHolderImage!
//        }
//    }
//    
//    func downloadUserProfileImage(urlString: String?, placeHolderImageString: String) {
//        self.kf.indicatorType = .activity
//        if  urlString != nil {
//            let url = URL(string: urlString!)!
//            let placeHolderImage = UIImage(named: placeHolderImageString)
//            
//            self.kf.setImage(with: url, placeholder: placeHolderImage, options: nil, progressBlock: { receivedSize, totalSize in
//                let percentage = (Float(receivedSize) / Float(totalSize)) * 100.0
//                print("downloading progress: \(percentage)%")
//            })
////            { (image, error, cacheType, imageUrl) in
////
////            }
//        } else {
//            let placeHolderImage = UIImage(named: placeHolderImageString)
//            self.image = placeHolderImage!
//        }
//    }
//    
//    
//    
//    func downloadSaloonImageWithColorPlaceHolder(urlString: String?, placeHolderColor: String) {
//        self.kf.indicatorType = .activity
//        let placeHolderImage = UIImage.init(color: placeHolderColor.getUIColor())
//
//        if  urlString != nil {
//            let url = URL(string: urlString!)!
//            self.kf.setImage(with: url, placeholder: placeHolderImage, options: nil, progressBlock: { receivedSize, totalSize in
//                let percentage = (Float(receivedSize) / Float(totalSize)) * 100.0
//                print("downloading progress: \(percentage)%")
//            })
////            { (image, error, cacheType, imageUrl) in
////
////            }
//        } else {
//            self.image = placeHolderImage!
//        }
//    }
//    
//    
//    func roundCorners(_ corners:UIRectCorner, radius: CGFloat) {
//        let path = UIBezierPath(roundedRect: self.bounds, byRoundingCorners: corners, cornerRadii: CGSize(width: radius, height: radius))
//        let mask = CAShapeLayer()
//        mask.path = path.cgPath
//        self.layer.mask = mask
//    }
//}



import Foundation
extension UILabel {

    // MARK: - spacingValue is spacing that you need
    func addInterlineSpacing(spacingValue: CGFloat = 2) {

        // MARK: - Check if there's any text
        guard let textString = text else { return }

        // MARK: - Create "NSMutableAttributedString" with your text
        let attributedString = NSMutableAttributedString(string: textString)

        // MARK: - Create instance of "NSMutableParagraphStyle"
        let paragraphStyle = NSMutableParagraphStyle()

        // MARK: - Actually adding spacing we need to ParagraphStyle
        paragraphStyle.lineHeightMultiple = spacingValue

        // MARK: - Adding ParagraphStyle to your attributed String
        attributedString.addAttribute(
            .paragraphStyle,
            value: paragraphStyle,
            range: NSRange(location: 0, length: attributedString.length
        ))

        // MARK: - Assign string that you've modified to current attributed Text
        attributedText = attributedString
    }

    func setFontAndcolor(stringValue: String, coloredValue: String, withTextSize: CGFloat  , color:UIColor) {
        let attritext = [
            
            NSAttributedString.Key.font : UIFont(name: "DroidArabicKufi-Bold", size: withTextSize)!,
            NSAttributedString.Key.foregroundColor : color] as [NSAttributedString.Key : Any]
        
        let attritext1 = [
            
            NSAttributedString.Key.font : UIFont(name: "DroidArabicKufi", size: withTextSize)!,
            NSAttributedString.Key.foregroundColor : "#717889".getUIColor()] as [NSAttributedString.Key : Any]
        
        
        let attributeString = NSMutableAttributedString(string: coloredValue.localized(),
                                                        attributes: attritext)
        
        let attributeString1 = NSMutableAttributedString(string: stringValue,
                                                        attributes: attritext1)
        
        attributeString.append(attributeString1)
        self.attributedText = attributeString
    }
}





import Foundation
import UIKit
extension UINavigationController {
    open override var preferredStatusBarStyle: UIStatusBarStyle {
        return topViewController?.preferredStatusBarStyle ?? .default
    }
}





import Foundation
extension UIPageViewController {
    var isPagingEnabled: Bool {
        get {
            var isEnabled: Bool = true
            for view in view.subviews {
                if let subView = view as? UIScrollView {
                    isEnabled = subView.isScrollEnabled
                }
            }
            return isEnabled
        }
        set {
            for view in view.subviews {
                if let subView = view as? UIScrollView {
                    subView.isScrollEnabled = newValue
                }
            }
        }
    }
}






import Foundation
import UIKit

extension UITableView {
    func indexPath(for view: UIView) -> IndexPath? {
        let location = view.convert(CGPoint.zero, to: self)
        return self.indexPathForRow(at: location)
    }
    
    func scrollToBottom(isAnimated:Bool = true){

         DispatchQueue.main.async {
             let indexPath = IndexPath(
                 row: self.numberOfRows(inSection:  self.numberOfSections-1) - 1,
                 section: self.numberOfSections - 1)
             if self.hasRowAtIndexPath(indexPath: indexPath) {
                 self.scrollToRow(at: indexPath, at: .bottom, animated: isAnimated)
             }
         }
     }
    
    func hasRowAtIndexPath(indexPath: IndexPath) -> Bool {
          return indexPath.section < self.numberOfSections && indexPath.row < self.numberOfRows(inSection: indexPath.section)
      }
    
    
    func scrollToTop(animated: Bool) {
        DispatchQueue.main.async {
            let indexPath = IndexPath(row: 0, section: 0)
            self.scrollToRow(at: indexPath, at: .top, animated: animated)
        }
    }
}






import Foundation
import UIKit

extension UITextField {
    
    func setLeftPaddingPoints(_ amount:CGFloat){
        let paddingView = UIView(frame: CGRect(x: 0, y: 0, width: amount, height: self.frame.size.height))
        self.leftView = paddingView
        self.leftViewMode = .always
    }
    
    func setRightPaddingPoints(_ amount:CGFloat) {
        let paddingView = UIView(frame: CGRect(x: 0, y: 0, width: amount, height: self.frame.size.height))
        self.rightView = paddingView
        self.rightViewMode = .always
    }
    
    func setLeftRightPaddingPoints(_ leftAmount:CGFloat, _ rightAmount:CGFloat) {
        let paddingViewLeft = UIView(frame: CGRect(x: 0, y: 0, width: leftAmount, height: self.frame.size.height))
        self.leftView = paddingViewLeft
        self.leftViewMode = .always
        
        let paddingViewRight = UIView(frame: CGRect(x: 0, y: 0, width: rightAmount, height: self.frame.size.height))
        self.rightView = paddingViewRight
        self.rightViewMode = .always
    }
}






import Foundation
import UIKit

extension UIView {
    

    func setBorderGrayWidthCorner(_ borderWidth:CGFloat,_ radius:CGFloat) {
        self.layer.borderColor = #colorLiteral(red: 0.8537729979, green: 0.8537931442, blue: 0.8537823558, alpha: 1)
        self.layer.borderWidth = borderWidth
       // let radius = self.frame.height / 2
        self.layer.cornerRadius = radius
        self.layer.masksToBounds = true
    }
    
    func setBorderColorWidthCorner(_ borderWidth:CGFloat,_ radius:CGFloat , color:UIColor) {
        self.layer.borderColor = color.cgColor
        self.layer.borderWidth = borderWidth
       // let radius = self.frame.height / 2
        self.layer.cornerRadius = radius
        self.layer.masksToBounds = true
    }
    
    
    func setBorderGray() {
        self.layer.borderColor = #colorLiteral(red: 0.8537729979, green: 0.8537931442, blue: 0.8537823558, alpha: 1)
        self.layer.borderWidth = 1
        //self.layer.cornerRadius = 4
        self.layer.masksToBounds = true
    }
    
    func setBorderGrayWidth(_ borderWidth:CGFloat) {
        self.layer.borderColor = #colorLiteral(red: 0.8537729979, green: 0.8537931442, blue: 0.8537823558, alpha: 1)
        self.layer.borderWidth = borderWidth
        let radius = self.frame.height / 2
        self.layer.masksToBounds = true
    }
    
    func setBorderWithColor(_ borderColor:UIColor) {
        self.layer.borderColor = borderColor.cgColor
        self.layer.borderWidth = 1
        //let radius = self.frame.height / 2
        self.layer.masksToBounds = true
    }
    
    func setBorderGrayNoCorner() {
        self.layer.borderColor = #colorLiteral(red: 0.8537729979, green: 0.8537931442, blue: 0.8537823558, alpha: 1)
        self.layer.borderWidth = 1
    }
    
        func setRounded() {
            let radius = self.frame.height / 2
            self.layer.cornerRadius = radius
            self.layer.masksToBounds = true
        }
        
        func setRounded(_ radius:CGFloat) {
            self.layer.cornerRadius = radius
            self.layer.masksToBounds = true
        }
        

    func setcorner(){
    self.layer.borderColor = #colorLiteral(red: 0.8537729979, green: 0.8537931442, blue: 0.8537823558, alpha: 1)
    self.layer.borderWidth = 1
    self.layer.cornerRadius = 4
    let radius = self.frame.height / 2
    self.layer.masksToBounds = true
    }
    
    //Start Rotating view
    func startRotating(duration: Double = 1) {
        let kAnimationKey = "rotation"
        
        if self.layer.animation(forKey: kAnimationKey) == nil {
            let animate = CABasicAnimation(keyPath: "transform.rotation")
            animate.duration = duration
            animate.repeatCount = Float.infinity
            
            animate.fromValue = Float(Double.pi * 2.0)
            animate.toValue = 0.0
            self.layer.add(animate, forKey: kAnimationKey)
        }
    }
    
    //Stop rotating view
    func stopRotating() {
        let kAnimationKey = "rotation"
        
        if self.layer.animation(forKey: kAnimationKey) != nil {
            self.layer.removeAnimation(forKey: kAnimationKey)
        }
    }
    
    func applyShadow(radius:CGFloat) {
        self.layer.cornerRadius = radius
        self.layer.masksToBounds = true
        self.layer.shadowRadius = 4.0
        self.layer.shadowOpacity = 0.30
        self.layer.borderColor = #colorLiteral(red: 0.8537729979, green: 0.8537931442, blue: 0.8537823558, alpha: 1)
        self.layer.shadowOffset = CGSize(width: 0, height: 5)
       // let radius = self.frame.height / 2
       
       
    }
    
    
    func dropShadowView(color: UIColor, opacity: Float = 0.5, offSet: CGSize, shadowRadius: CGFloat = 1, scale: Bool = true, cornerRadius: CGFloat, fillColor: UIColor) {
        let shadowLayer = CAShapeLayer()
        shadowLayer.path = UIBezierPath(roundedRect: bounds, cornerRadius: cornerRadius).cgPath
        shadowLayer.fillColor = fillColor.cgColor
        shadowLayer.shadowColor = color.cgColor
        shadowLayer.shadowPath = shadowLayer.path
        shadowLayer.shadowOffset = offSet
        shadowLayer.shadowOpacity = opacity
        shadowLayer.shadowRadius = shadowRadius
        layer.insertSublayer(shadowLayer, at: 0)
    }

    func bindToKeyboard(){
        NotificationCenter.default.addObserver(self, selector: #selector(UIView.keyboardWillChange(notification:)), name: UIResponder.keyboardWillChangeFrameNotification, object: nil)
    }

    func unbindToKeyboard(){
        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillChangeFrameNotification, object: nil)
    }
    @objc
    func keyboardWillChange(notification: Notification) {
        let duration = notification.userInfo![UIResponder.keyboardAnimationDurationUserInfoKey] as! Double
        let curve = notification.userInfo![UIResponder.keyboardAnimationCurveUserInfoKey] as! UInt
        let curFrame = (notification.userInfo![UIResponder.keyboardFrameBeginUserInfoKey] as! NSValue).cgRectValue
        let targetFrame = (notification.userInfo![UIResponder.keyboardFrameEndUserInfoKey] as! NSValue).cgRectValue
        let deltaY = targetFrame.origin.y - curFrame.origin.y

        UIView.animateKeyframes(withDuration: duration, delay: 0.0, options: UIView.KeyframeAnimationOptions(rawValue: curve), animations: {
            self.frame.origin.y+=deltaY

        },completion: nil)

    }
    
    
    enum UIViewFadeStyle {
        case bottom
        case top
        case left
        case right
        
        case vertical
        case horizontal
    }
    
    func fadeView(style: UIViewFadeStyle = .bottom, percentage: Double = 0.07, withColor: UIColor) {
        let gradient = CAGradientLayer()
        gradient.frame = bounds
        gradient.colors = [UIColor.black.cgColor, UIColor.clear.cgColor]
        
        let startLocation = percentage
        let endLocation = 1 - percentage
        
        switch style {
        case .bottom:
            gradient.startPoint = CGPoint(x: 0.5, y: endLocation)
            gradient.endPoint = CGPoint(x: 0.5, y: 1)
        case .top:
            gradient.startPoint = CGPoint(x: 0.5, y: startLocation)
            gradient.endPoint = CGPoint(x: 0.5, y: 0.0)
        case .vertical:
            gradient.startPoint = CGPoint(x: 0.5, y: 0.0)
            gradient.endPoint = CGPoint(x: 0.5, y: 1.0)
            gradient.colors = [UIColor.clear.cgColor, UIColor.black.cgColor, UIColor.black.cgColor, UIColor.clear.cgColor]
            gradient.locations = [0.0, startLocation, endLocation, 1.0] as [NSNumber]
            
        case .left:
            gradient.startPoint = CGPoint(x: startLocation, y: 0.5)
            gradient.endPoint = CGPoint(x: 0.0, y: 0.5)
        case .right:
            gradient.startPoint = CGPoint(x: endLocation, y: 0.5)
            gradient.endPoint = CGPoint(x: 1, y: 0.5)
        case .horizontal:
            gradient.startPoint = CGPoint(x: 0.0, y: 0.5)
            gradient.endPoint = CGPoint(x: 1.0, y: 0.5)
            gradient.colors = [UIColor.clear.cgColor, UIColor.black.cgColor, UIColor.black.cgColor, UIColor.clear.cgColor]
            gradient.locations = [0.0, startLocation, endLocation, 1.0] as [NSNumber]
        }
        
        layer.mask = gradient
    }

    
}

extension URL {
    static func createFolder(folderName: String) -> URL? {
        let fileManager = FileManager.default
        // Get document directory for device, this should succeed
        if let documentDirectory = fileManager.urls(for: .documentDirectory,
                                                    in: .userDomainMask).first {
            // Construct a URL with desired folder name
            let folderURL = documentDirectory.appendingPathComponent(folderName)
            // If folder URL does not exist, create it
            if !fileManager.fileExists(atPath: folderURL.path) {
                do {
                    // Attempt to create folder
                    try fileManager.createDirectory(atPath: folderURL.path,
                                                    withIntermediateDirectories: true,
                                                    attributes: nil)
                } catch {
                    // Creation failed. Print error & return nil
                    print(error.localizedDescription)
                    return nil
                }
            }
            // Folder either exists, or was created. Return URL
            return folderURL
        }
        // Will only be called if document directory not found
        return nil
    }
    
    
    func valueOf(_ queryParamaterName: String) -> String? {
        guard let url = URLComponents(string: self.absoluteString) else { return nil }
        return url.queryItems?.first(where: { $0.name == queryParamaterName })?.value
    }
}






import Foundation
extension UIScrollView {

    // Scroll to a specific view so that it's top is at the top our scrollview
    func scrollToView(view:UIView, animated: Bool) {
        if let origin = view.superview {
            // Get the Y position of your child view
            let childStartPoint = origin.convert(view.frame.origin, to: self)
            // Scroll to a rectangle starting at the Y of your subview, with a height of the scrollview
            self.scrollRectToVisible(CGRect(x:0, y:childStartPoint.y,width: 1,height: self.frame.height), animated: animated)
        }
    }

//    // Bonus: Scroll to top
//    func scrollToTop(animated: Bool) {
//        let topOffset = CGPoint(x: 0, y: -contentInset.top)
//        setContentOffset(topOffset, animated: animated)
//    }
//
//    // Bonus: Scroll to bottom
//    func scrollToBottom() {
//        let bottomOffset = CGPoint(x: 0, y: contentSize.height - bounds.size.height + contentInset.bottom)
//        if(bottomOffset.y > 0) {
//            setContentOffset(bottomOffset, animated: true)
//        }
//    }

}




import Foundation
extension UICollectionView {
    func indexPath(for view: UIView) -> IndexPath? {
        let location = view.convert(CGPoint.zero, to: self)
        return self.indexPathForItem(at: location)
    }
    
    func dequeueCVCell<T: UICollectionViewCell>(indexPath:IndexPath) -> T {
        guard let cell = dequeueReusableCell(withReuseIdentifier: String(describing: T.self), for: indexPath) as? T else {
            fatalError("Could not locate viewcontroller with with identifier \(String(describing: T.self)) in storyboard.")
        }
        return cell
    }
    
    func registerCell(id: String) {
        self.register(UINib(nibName: id, bundle: nil), forCellWithReuseIdentifier: id)
    }
}




import Foundation
extension UICollectionViewCell {
    /// This is a workaround method for self sizing collection view cells which stopped working for iOS 12
    func setupSelfSizingForiOS12(contentView: UIView) {
        contentView.translatesAutoresizingMaskIntoConstraints = false
        let leftConstraint = contentView.leftAnchor.constraint(equalTo: leftAnchor)
        let rightConstraint = contentView.rightAnchor.constraint(equalTo: rightAnchor)
        let topConstraint = contentView.topAnchor.constraint(equalTo: topAnchor)
        let bottomConstraint = contentView.bottomAnchor.constraint(equalTo: bottomAnchor)
        NSLayoutConstraint.activate([leftConstraint, rightConstraint, topConstraint, bottomConstraint])
    }
}


extension UIStoryboard {
func instanceVC<T: UIViewController>() -> T {
    guard let vc = instantiateViewController(withIdentifier: String(describing: T.self)) as? T else {
        fatalError("Could not locate viewcontroller with with identifier \(String(describing: T.self)) in storyboard.")
    }
    return vc
    }}

extension UIApplication {
    static var window: UIWindow? {
            if #available(iOS 13, *) {
                return UIApplication.shared.windows.first { $0.isKeyWindow }
            } else {
                return UIApplication.shared.keyWindow
            }
        }
}
extension String {
    func attributedStringWithColor(_ strings: [String], color: UIColor, characterSpacing: UInt? = nil) -> NSAttributedString {
        let attributedString = NSMutableAttributedString(string: self)
        for string in strings {
            let range = (self as NSString).range(of: string)
            attributedString.addAttribute(NSAttributedString.Key.foregroundColor, value: color, range: range)
        }

        guard let characterSpacing = characterSpacing else {return attributedString}


        
        attributedString.addAttribute(NSAttributedString.Key.kern, value: characterSpacing, range: NSRange(location: 0, length: attributedString.length))

        return attributedString
    }
}


extension NSMutableAttributedString {

    func setColorForText(textForAttribute: String, withColor color: UIColor) {
        let range: NSRange = self.mutableString.range(of: textForAttribute, options: .caseInsensitive)

        // Swift 4.2 and above
        self.addAttribute(NSAttributedString.Key.foregroundColor, value: color, range: range)

        // Swift 4.1 and below
        self.addAttribute(NSAttributedString.Key.foregroundColor, value: color, range: range)
    }

}

extension CALayer {
  func applySketchShadow(
    color: UIColor = .black,
    alpha: Float = 0.5,
    x: CGFloat = 0,
    y: CGFloat = 2,
    blur: CGFloat = 4,
    spread: CGFloat = 0)
  {
    masksToBounds = false
    shadowColor = color.cgColor
    shadowOpacity = alpha
    shadowOffset = CGSize(width: x, height: y)
    shadowRadius = blur / 2.0
    if spread == 0 {
      shadowPath = nil
    } else {
      let dx = -spread
      let rect = bounds.insetBy(dx: dx, dy: dx)
      shadowPath = UIBezierPath(rect: rect).cgPath
    }
  }
}
