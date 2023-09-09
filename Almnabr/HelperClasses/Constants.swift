//
//  Constants.swift
//  Almnabr
//
//  Created by MacBook on 22/09/2021.
//

import Foundation

enum DateSelection {
    case now
    case today
    case tomorrow
    case after2days
}

class Constants{
    
    static let DroidArabicKufi = "DroidArabicKufi"
    static let DroidArabicKufi_Bold = "DroidArabicKufi-Bold"
    
    static let DEFINEUSERINFORMATION = "storeuserinformationin"

    static let DefineOpenAppFromNotification = "OpenAppFromNotification"

    static let kAppLanguageSelect = "AppLanguageKeyToUse"

    
    ///API Starts from here.
    static let getCategory = "categories"
    static let getCategoryPlants = "plants/"
    static let getPlantDetail = "plant/"
    static let getAllPlants = "plants"
    static let getFilter = "filter"
    static let getMapsData = "map"
    static let getgarden = "garden"
    static let getFiltersCategories = "filters/categories"
    
    
    static let jawabCreateTicket = "https://jawab.riyadhenv.gov.sa/api/create_ticket"
    static let share = "https://jawab.riyadhenv.gov.sa/api/share"

    //Color codes starts here
    static let color_main = "193665"
    
    static let color_main_text_bg = "69AB0C"
    static let color_main_text_bg_gray = "9A9A9A"
    static let color_tab_selected = "6BB443"
    static let color_tab_unselected = "8D8D8D"
    
    static let token_api = "6|5CaxhLRMnlHAYgQ0e5wuw80hy6oQjBanwfmv8rJT"
    
    static let googleMapAPIKey = "AIzaSyAIB7x7648C7MsHKY27R80uq9Hc3bNdVTI"
    
    
    static let base_url_debug = "base_url_debug"
    static let base_url = "base_url"
    
    
    
    static let DEFINELOGINSUCCESSTOKEN = "defineloginsuccesstokenin"
    static let DEFINEDEVICETOKEN = "definedevicetokenin"
    
    static let DEFINEFCMDEVICETOKEN = "definefcmdevicetokenin"
    static let DEFINEAPNSDEVICETOKEN = "defineapnsdevicetokenin"
    static let DEFINENOTIFICATIONTIME = "notificationtimein"
    static let DEFINEEVERYDAYNOTIFICATIONATNINEPM = "everydaynotificationatninepmin"
    
    static let DEFINEGOTOCHECKOUTSCREEN = "definegotocheckoutscreen"

    
    static let unAutorizedUser = "Unauthenticated."

    static let show_google_login_button = "showgoogleloginbutton"
    
    
}

