//
//  HelperClassSwift.swift
//  Almnabr
//
//  Created by MacBook on 22/09/2021.
//

import UIKit

enum TaskPriority : String {
    case normal = "Normal"
    case urgent = "Urgent"
    case topUrgent =  "Top Urgent"
}

enum MoveDirection : String {
    case forward = "you moved forward"
    case back = "you moved backwards"
    case left = "you moved to the left"
    case right = "you moved to the right"
}

class HelperClassSwift: NSObject {
    
    static func getUserInformation(key: String) -> String? {
        let defaults = UserDefaults.standard
        if let myString = defaults.string(forKey: key) {
            return myString
        }
        return nil
    }
    
    static func setUserInformationDate(valueDate: Date, key: String) {
        let defaults = UserDefaults.standard
        defaults.set(valueDate, forKey: key)
        defaults.synchronize()
    }
    
    
    static var IsFirstShare  : Bool {
        get {
            let ud = UserDefaults.standard
            return ud.value(forKey: "IsFirstShare") as? Bool ?? true
        }
        set(token) {
            let ud = UserDefaults.standard
            ud.set(token, forKey: "IsFirstShare")
        }
    }

    
    static var IsFirstLunch  : Bool {
        get {
            let ud = UserDefaults.standard
            return ud.value(forKey: "IsFirstLunch") as? Bool ?? true
        }
        set(token) {
            let ud = UserDefaults.standard
            ud.set(token, forKey: "IsFirstLunch")
        }
    }
    
    
    static var UserName  : String {
        get {
            let ud = UserDefaults.standard
            return ud.value(forKey: "UserName") as? String ?? ""
        }
        set(token) {
            let ud = UserDefaults.standard
            ud.set(token, forKey: "UserName")
        }
    }

    
    static var UserEmail  : String {
        get {
            let ud = UserDefaults.standard
            return ud.value(forKey: "UserEmail") as? String ?? ""
        }
        set(token) {
            let ud = UserDefaults.standard
            ud.set(token, forKey: "UserEmail")
        }
    }

    static var UserPassword  : String {
        get {
            let ud = UserDefaults.standard
            return ud.value(forKey: "UserPassword") as? String ?? ""
        }
        set(token) {
            let ud = UserDefaults.standard
            ud.set(token, forKey: "UserPassword")
        }
    }

    
    
    static var UserMobile  : String {
        get {
            let ud = UserDefaults.standard
            return ud.value(forKey: "UserMobile") as? String ?? ""
        }
        set(token) {
            let ud = UserDefaults.standard
            ud.set(token, forKey: "UserMobile")
        }
    }

    
    static var DeviceId  : String {
        get {
            let ud = UserDefaults.standard
            return ud.value(forKey: "DeviceId") as? String ?? ""
        }
        set(token) {
            let ud = UserDefaults.standard
            ud.set(token, forKey: "DeviceId")
        }
    }

   
    static var acolor  : String {
        get {
            let ud = UserDefaults.standard
            return ud.value(forKey: "acolor") as? String ?? ""
        }
        set(token) {
            let ud = UserDefaults.standard
            ud.set(token, forKey: "acolor")
        }
    }
    
    
     static var bcolor  : String {
         get {
             let ud = UserDefaults.standard
             return ud.value(forKey: "bcolor") as? String ?? ""
         }
         set(token) {
             let ud = UserDefaults.standard
             ud.set(token, forKey: "bcolor")
         }
     }
    
    
    static var IsLoadTheme  : Bool {
        get {
            let ud = UserDefaults.standard
            return ud.value(forKey: "IsLoadTheme") as? Bool ?? false
        }
        set(token) {
            let ud = UserDefaults.standard
            ud.set(token, forKey: "IsLoadTheme")
        }
    }
    
    
    
    static var IsLoggedOut  : Bool {
        get {
            let ud = UserDefaults.standard
            return ud.value(forKey: "IsLoggedOut") as? Bool ?? false
        }
        set(token) {
            let ud = UserDefaults.standard
            ud.set(token, forKey: "IsLoggedOut")
        }
    }
    
    
    static func getIsFirstShare(key: Bool) -> Bool? {
        let defaults = UserDefaults.standard
        if defaults.string(forKey: "IsFirstShare") != nil {
            return false
        }
        return nil
    }
    
    static func setIsFirstShare(value: Bool, key: Bool) {
        let defaults = UserDefaults.standard
        defaults.set(value, forKey: "IsFirstShare")
        defaults.synchronize()
    }
    
    
    
    static func setUserInformation(value: String, key: String) {
        let defaults = UserDefaults.standard
        defaults.set(value, forKey: key)
        defaults.synchronize()
    }
    
    static func removeUserInformation(key: String) {
        let defaults = UserDefaults.standard
        defaults.removeObject(forKey: key)
        defaults.synchronize()
    }
    

    
    static func getUserInformationDate(key: String) -> Date? {
        let defaults = UserDefaults.standard
        if let myValue = defaults.object(forKey: key) {
            return myValue as? Date
        }
        return nil
    }
    
    
    static func getColorsArray() -> [UIColor]{
        return ["f16364".getUIColor(), "f58559".getUIColor(), "f9a43e".getUIColor(), "e4c62e".getUIColor(), "67bf74".getUIColor(), "59a2be".getUIColor(), "2093cd".getUIColor(), "ad62a7".getUIColor(), "805781".getUIColor()]
    }
    
    
    static func getRiyadhTimeZoneGMT() -> Date {
        let dateformate = DateFormatter()
        dateformate.timeZone = NSTimeZone(forSecondsFromGMT: 3600 * 3) as TimeZone // GMT+2
        let locale = NSLocale(localeIdentifier: "en_US")
        dateformate.dateFormat = "yyyy-MM-dd hh:mm:ss a"
        dateformate.locale = locale as Locale
        let stringDate = dateformate.string(from: Date())
        
        let dateFormat = DateFormatter()
        dateFormat.dateFormat = "yyyy-MM-dd hh:mm:ss a"
        let locale1 = NSLocale(localeIdentifier: "en_US")
        dateFormat.locale = locale1 as Locale
        dateFormat.timeZone = TimeZone(abbreviation: "UTC")
        let ExpDate = dateFormat.date(from: stringDate)
        return ExpDate!
    }
    
    
    static func getRiyadhTimeZoneNOGMT() -> Date {
        let dateformate = DateFormatter()
        dateformate.timeZone = NSTimeZone(forSecondsFromGMT: 3600 * 3) as TimeZone // GMT+2
        let locale = NSLocale(localeIdentifier: "en_US")
        dateformate.dateFormat = "yyyy-MM-dd hh:mm:ss a"
        dateformate.locale = locale as Locale
        let stringDate = dateformate.string(from: Date())
        
        let dateFormat = DateFormatter()
        dateFormat.dateFormat = "yyyy-MM-dd hh:mm:ss a"
        let locale1 = NSLocale(localeIdentifier: "en_US")
        dateFormat.locale = locale1 as Locale
        dateFormat.timeZone = TimeZone(abbreviation: "UTC")
        let ExpDate = dateFormat.date(from: stringDate)
        return ExpDate!
    }
    
    
    static func getRiyadhTimeZoneGMTAsString() -> String? {
        let dateformate = DateFormatter()
        dateformate.timeZone = NSTimeZone(forSecondsFromGMT: 3600 * 3) as TimeZone // GMT+2
        let locale = NSLocale(localeIdentifier: "en_US")
        dateformate.dateFormat = "yyyy-MM-dd hh:mm:ss a"
        dateformate.locale = locale as Locale
        return dateformate.string(from: Date())
    }
    
    static func getRiyadhTimeZoneGMTAsStringHour() -> String? {
        let dateformate = DateFormatter()
        //[dateformate setTimeZone:[NSTimeZone timeZoneForSecondsFromGMT:3600*3]]; // GMT+2
        let locale = NSLocale(localeIdentifier: "en_US")
        dateformate.dateFormat = "hh:mm a"
        dateformate.locale = locale as Locale
        return dateformate.string(from: Date())
    }
    
    static func getRiyadhTimeZoneGMTAsStringDate() -> String? {
        let dateformate = DateFormatter()
        //[dateformate setTimeZone:[NSTimeZone timeZoneForSecondsFromGMT:3600*3]]; // GMT+2
        let locale = NSLocale(localeIdentifier: "en_US")
        dateformate.dateFormat = "dd MMM yyyy"
        dateformate.locale = locale as Locale
        return dateformate.string(from: Date())
    }
    
    

}
