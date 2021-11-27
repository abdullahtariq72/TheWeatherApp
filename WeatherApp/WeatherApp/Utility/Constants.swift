//
//  Constants.swift
//  WeatherApp
//
//  Created by Abdullah Tariq on 11/26/21.
//

import Foundation
import UIKit

struct K {
    
    
    
    static let CELSIUS = "celsius"
    static let FARENHEIT = "farenheit"
    static let LOADING_KEY = "loading..."
    static let ALERT = "Alert"
    static let OK = "OK"
    
    static let NUM_DAYS_TEXTFIELD_VALIDATION = "Enter number of days upto two digits"

    static let ERROR = "Error"
    static let ARE_YOU_SURE = "Are you sure?"
    static let SUCCESS = "Success"
    static let API_BASE_URL_TYPE = "APIBaseURLType"
    static let DEVICE_TOKEN = "deviceToken"
    static let KFCM_TOKEN = "fcmToken"
    static let CANCEL_TEXT = "Cancel"
    static let SETTINGS_TEXT = "Settings"
    static let NOTIFICATION_COUNT_KEY = "NOTIFICATION_COUNT"
    static let NAME_KEY = "name"
    static let IMAGE_URL = "imageUrl"
    static let TEXT = "text"
    static let TYPE_KEY = "type"
    static let TYPE_ID_KEY = "typeId"
    static let DATA = "data"
    static let IS_READ = "isRead"
    static let SENDER_ID = "senderId"
    static let LATITUDE = "latitude"
    static let LONGITUDE = "longitude"
    static let EGIFT_CARD_MODEL = "eGiftCardModel"
    static let NOTIFICATION_USERINFO = "notificationUserInfo"
    static let TRUE = "true"
    static let FALSE = "false"
    static let SELECTED_MY_CARDS_TAB = "selectedMyCardsTab"
    static let IS_CONNECTED = "isConnected"
    static let IS_DARK_THEME_KEY = "isDarkTheme"
    static let PROFILE_PICTURE = "profilePicture"
    static let THUMBNAIL_KEY = "thumbnail"
    static let FILE_KEY = "file"
}

struct UserDefaultKeys {
    static let isUserLogin = "isUserLogin"
    static let USER_DEFAULT = UserDefaults.standard
}



struct Storyboards {
    static let MAIN = UIStoryboard(name: "Main", bundle: nil)
    static let POPUPS = UIStoryboard(name: "Popups", bundle: nil)
    static let SETTINGS = UIStoryboard(name: "Settings", bundle: nil)
}

struct NIBs {
    static let Weather = "WeatherTableCell"
}

struct TableCells {
    static let Weather = WeatherTableViewCell()
}

struct Indentifiers {
    static let WeatherCell = "weatherTableViewCell_id"
}

struct Controllers {
    static let SPLASH = "SplashViewController"
    static let DASHBOARD = "DashboardViewController"
}

struct DateFormats {
    static let yyyyMMdd = "yyyy/MM/dd"
    static let MMMMdyyyy = "MMMM d, yyyy"
    static let MMMddyyyy = "MMM dd, yyyy"
    static let MMyy = "MM/yy"
    static let yyyy_MM_dd = "yyyy-MM-dd"
    static let EMMMdyyyy = "E, MMM d, yyyy"
    static let MMMdyyyy = "MMM d, yyyy"
    static let MMMd = "MMM d"
    static let dMMMMyyy = "d MMMM yyyy"
    static let mm_dd_yyyy = "MM-dd-yyyy"
    static let TIME_FORMAT = "h:mm a"
    static let yyyy_MM_dd_T_HH_mm = "yyyy-MM-dd'T'HH:mm"
    static let DATE_TIME_FORMAT = "yyyy-MM-dd'T'HH:mm:ss"
    static let MY_CARDS_DATE_FORMAT = "MMM dd, yyyy - hh:mm a"
    static let EN_US_POSIX = Locale(identifier: "en_US_POSIX")
    static let UTC_TIME_ZONE = TimeZone(abbreviation: "UTC")
}




struct Alerts {
    
}



struct Colors {
    
    static let LIGHTGRAY_COLOR = #colorLiteral(red: 0.9215686275, green: 0.9137254902, blue: 0.9137254902, alpha: 1)
    static let WHITE_GRAY_COLOR = #colorLiteral(red: 0.9803921569, green: 0.9764705882, blue: 0.9803921569, alpha: 1)
    static let APP_BLUE_COLOR = #colorLiteral(red: 0.1333333333, green: 0.5098039216, blue: 0.9294117647, alpha: 1)
    static let TABBAR_GRAY_COLOR = #colorLiteral(red: 0.2901960784, green: 0.2901960784, blue: 0.2901960784, alpha: 1)
    static let WHITE_COLOR = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
    static let GRAY_COLOR = #colorLiteral(red: 0.7647058824, green: 0.7647058824, blue: 0.7647058824, alpha: 1)
    static let DARK_GREY = #colorLiteral(red: 0.4235294118, green: 0.4235294118, blue: 0.4235294118, alpha: 1)
    static let BLACK_COLOR = #colorLiteral(red: 0.2, green: 0.2, blue: 0.2, alpha: 1)
    
    static let FULL_BLACK_COLOR = #colorLiteral(red: 0.2, green: 0.2, blue: 0.2, alpha: 1)
    static let BORDER_COLOR = #colorLiteral(red: 0.7450980392, green: 0.7450980392, blue: 0.7450980392, alpha: 1)

    static let BROWN_COLOR = #colorLiteral(red: 0.5176470588, green: 0.2196078431, blue: 0, alpha: 1)
    static let ORANGE_COLOR = #colorLiteral(red: 1, green: 0.4235294118, blue: 0, alpha: 1)
    static let GOLDEN_COLORS = #colorLiteral(red: 0.9725490196, green: 0.6274509804, blue: 0.1411764706, alpha: 1)
    static let YELLOW_COLOR = #colorLiteral(red: 0.9921568627, green: 0.768627451, blue: 0.2156862745, alpha: 1)
    static let LIGHT_YELLOW_COLOR = #colorLiteral(red: 1, green: 0.8274509804, blue: 0.4392156863, alpha: 1)
    static let CHARDON_COLOR = #colorLiteral(red: 1, green: 0.9215686275, blue: 0.8666666667, alpha: 1)
    static let BLUE_COLOR = #colorLiteral(red: 0.1098039216, green: 0.2274509804, blue: 0.462745098, alpha: 1)

    static let RED_COLOR = #colorLiteral(red: 0.7098039216, green: 0.1921568627, blue: 0.2431372549, alpha: 1)
    static let LIGHT_RED_COLOR = #colorLiteral(red: 0.9882352941, green: 0.3294117647, blue: 0.3294117647, alpha: 1)
    static let GREEN_COLOR = #colorLiteral(red: 0, green: 0.7333333333, blue: 0.2549019608, alpha: 1)
    static let SKY_BLUE_COLOR = #colorLiteral(red: 0.3137254902, green: 0.9254901961, blue: 0.9333333333, alpha: 1)
    static let YELLOW_ORANGE_COLOR = #colorLiteral(red: 1, green: 0.7215686275, blue: 0.5176470588, alpha: 1)
    static let DARK_YELLOW_COLOR = #colorLiteral(red: 0, green: 0.4170854986, blue: 0.5711632371, alpha: 1)
    static let GRAPH_COLOR = #colorLiteral(red: 0.3960784314, green: 0.462745098, blue: 1, alpha: 1)
    static let LIGHT_GRAY_COLOR = #colorLiteral(red: 0.8666666667, green: 0.8784313725, blue: 0.8941176471, alpha: 1)

}
