//
//  Constant.swift
//  Global_Garner
//
//  Created by indianic on 22/06/17.
//  Copyright © 2017 indianic. All rights reserved.
//

import Foundation
import UIKit

let APP_NAME =  "Global Garner"
let CLIENT_ID = "33UvsIdFbe2RKdZWeCOHfir/paf/t2/8kCrBuXhHacM="
let CLIENT_SECRET = "Wl1IVn7UvzYm2zZWXN5xKpt6/5QAu1UxCaoVWZjgo74="

let AUTH_TOKEN_API = "https://accounts.globalgarner.in/oauth/token"

let ACCOUNT_API = "https://accounts.globalgarner.in/api/"
let PROFILE_API = "https://accounts.globalgarner.in/api/users/9006"



let ACCESS_TOKEN = "access_token"
let REFRESH_TOKEN = "refresh_token"
let TOKEN_TYPE = "token_type"
let EXPIRES_IN = "expires_in"




// USER DEFAULTS
let USERID_GGWALLET = "USERID_GGWALLET"
let USERID_FUEL_CASHBACK = "USERID_FUEL_CASHBACK"
let USERID_HELP_SWITCH = "USERID_HELP_SWITCH"
let USERID_UPV_CASHBACK = "USERID_UPV_CASHBACK"
let USERID_BILLPAY_RECHARGE = "USERID_BILLPAY_RECHARGE"
let USERID_BESTSHOPPINGWEBSITES = "USERID_BESTSHOPPINGWEBSITES"
let USERID_TRAVEL_HOTEL_BOOKING = "USERID_TRAVEL_HOTEL_BOOKING"
let USERID_GGVENDOR = "USERID_GGVENDOR"
let USERID_MEGHABRANDS = "USERID_MEGHABRANDS"
let USERID_ENTERTAINMENT = "USERID_ENTERTAINMENT"
let USERID_RESALE = "USERID_RESALE"
let USERID_REALESTATE = "USERID_REALESTATE"
let USERID_FRANCHISE = "USERID_FRANCHISE"
let USERID_FOOD = "USERID_FOOD"
let USERID_JOB = "USERID_JOB"
let USERID_MATRIMONIAL = "USERID_MATRIMONIAL"
let USERID_NEWS = "USERID_NEWS"
let USERID_SOCIALCAUSES = "USERID_SOCIALCAUSES"
let USERID_CROWD_FUNDING = "USERID_CROWD_FUNDING"



// USER MODEL
let USER_MODEL = "USER_MODEL"
let USER_ID = "USER_ID"
let USER_NAME = "USER_NAME"
let USER_MOBILE = "USER_MOBILE"
let USER_EMAIL = "USER_EMAIL"
let USER_AADHAAR = "USER_AADHAAR"
let USER_PAN = "USER_PAN"
let USER_FNAME = "USER_FNAME"
let USER_MNAME = "USER_MNAME"
let USER_LNAME = "USER_LNAME"
let USER_GENDER = "USER_GENDER"
let USER_DOB = "USER_DOB"
let USER_HOUSENO = "USER_HOUSENO"
let USER_STREET = "USER_STREET"
let USER_LANDMARK = "USER_LANDMARK"
let USER_LOCALITY = "USER_LOCALITY"
let USER_CITY = "USER_CITY"
let USER_STATE = "USER_STATE"
let USER_COUNTRY = "USER_COUNTRY"
let USER_PINCODE = "USER_PINCODE"
let USER_HASAGREED = "USER_HASAGREED"
let USER_ISACTIVE = "USER_ISACTIVE"
let USER_LATITUDE = "USER_LATITUDE"
let USER_LONGITUDE = "USER_LONGITUDE"
let USER_PLACESID = "USER_PLACESID"
let IS_IDENTITY_VERIFIED = "IS_IDENTITY_VERIFIED"
let USER_OPTIN_OUT = "USER_OPTIN_OUT"
let USER_RANGE_TIME = "USER_RANGE_TIME"


let LATITUDE = "LATITUDE"
let LONGITUDE = "LONGITUDE"
let HOME_SLIDER = "HOME_SLIDER"
let HOME_CATEGORY = "HOME_CATEGORY"
let AFFILIATE_DATA = "AFFILIATE_DATA"
let CART_DATA = "CART_DATA"


struct Constant {

    struct StorybaordName {
        // New Storyboard
        let LOGIN_STORYBOARD = "Login"
        let BILLPAY_STORYBOARD = "BillPay"
        let BESTSHOPPING_STORYBOARD = "BestShoppingSites"
        let TRAVELHOTEL_STORYBOARD = "TravelHotel"
        let VENDOR_STORYBOARD = "Vendor"
        let MEGABRANDS_STORYBOARD = "MegaBrands"
        let ENTERTAINMENT_STORYBOARD = "Entertainment"
        let RESALE_STORYBOARD = "Resale"
        let REALESTATE_STORYBOARD = "RealEstate"
        let FRANCHISE_STORYBOARD = "Franchise"
        let FOOD_STORYBOARD = "Franchise"
        let JOBS_STORYBOARD = "Jobs"
        let MATRIMONIAL_STORYBOARD = "Matrimonial"
        let NEWS_STORYBOARD = "News"
        let SOCIALCAUSES_STORYBOARD = "SocialCauses"
        let CROWDFUNDING_STORYBOARD = "CrowdFunding"
        let RELATIONS_STORYBOARD = "Relations"
        let GGWALLET_STORYBOARD = "GGWallet"
        let FUELCASHBACK_STORYBOARD = "FuelCashback"
    }
    
    struct setFonts {
        
        //  Font
        let OPENSANS_REGULAR = "OpenSans"
        let OPENSANS_BOLD = "OpenSans-Bold"
        let OPENSANS_SEMIBOLD = "OpenSans-Semibold"
        let OPENSANS_EXTRABOLD = "OpenSans-Extrabold"
        let OPENSANS_LIGHT = "OpenSans-Light"
        // Macros for Color
        let COLOR_NAVIGATION = UIColor(red: CGFloat(40.0 / 255.0), green: CGFloat(117.0 / 255.0), blue: CGFloat(240.0 / 255.0), alpha: CGFloat(1.0))
        let COLOR_YELLOW = UIColor(red: CGFloat(253.0 / 255.0), green: CGFloat(183.0 / 255.0), blue: CGFloat(0.0 / 255.0), alpha: CGFloat(1.0))
        let COLOR_LINE = UIColor(red: CGFloat(220.0 / 255.0), green: CGFloat(219.0 / 255.0), blue: CGFloat(217.0 / 255.0), alpha: CGFloat(1.0))
        let COLOR_PLACEHOLDER = UIColor(red: CGFloat(123.0 / 255.0), green: CGFloat(176.0 / 255.0), blue: CGFloat(247.0 / 255.0), alpha: CGFloat(1.0))
        let COLOR_BG = UIColor(red: CGFloat(242.0 / 255.0), green: CGFloat(245.0 / 255.0), blue: CGFloat(246.0 / 255.0), alpha: CGFloat(1.0))
        let COLOR_SEGMENT_BG = UIColor(red: CGFloat(204.0 / 255.0), green: CGFloat(214.0 / 255.0), blue: CGFloat(221.0 / 255.0), alpha: CGFloat(1.0))
        let COLOR_TAB_ICON = UIColor(red: CGFloat(63.0 / 255.0), green: CGFloat(86.0 / 255.0), blue: CGFloat(98.0 / 255.0), alpha: CGFloat(1.0))
        let COLOR_DARK_TEXT = UIColor(red: CGFloat(63.0 / 255.0), green: CGFloat(86.0 / 255.0), blue: CGFloat(98.0 / 255.0), alpha: CGFloat(1.0))

    }
    
    struct ScreenSize
    {
        static let SCREEN_WIDTH         = UIScreen.main.bounds.size.width
        static let SCREEN_HEIGHT        = UIScreen.main.bounds.size.height
        static let SCREEN_MAX_LENGTH    = max(ScreenSize.SCREEN_WIDTH, ScreenSize.SCREEN_HEIGHT)
        static let SCREEN_MIN_LENGTH    = min(ScreenSize.SCREEN_WIDTH, ScreenSize.SCREEN_HEIGHT)
    }
    
    struct DeviceType
    {
        static let IS_IPHONE_4_OR_LESS  = UIDevice.current.userInterfaceIdiom == .phone && ScreenSize.SCREEN_MAX_LENGTH < 568.0
        static let IS_IPHONE_5          = UIDevice.current.userInterfaceIdiom == .phone && ScreenSize.SCREEN_MAX_LENGTH == 568.0
        static let IS_IPHONE_6          = UIDevice.current.userInterfaceIdiom == .phone && ScreenSize.SCREEN_MAX_LENGTH == 667.0
        static let IS_IPHONE_6P         = UIDevice.current.userInterfaceIdiom == .phone && ScreenSize.SCREEN_MAX_LENGTH == 736.0
        static let IS_IPAD              = UIDevice.current.userInterfaceIdiom == .pad && ScreenSize.SCREEN_MAX_LENGTH == 1024.0
        static let IS_IPAD_PRO          = UIDevice.current.userInterfaceIdiom == .pad && ScreenSize.SCREEN_MAX_LENGTH == 1366.0
    }
}
