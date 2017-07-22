//
//  Webservice.swift
//  Global_Garner
//
//  Created by indianic on 22/06/17.
//  Copyright © 2017 indianic. All rights reserved.
//

import Foundation
import Alamofire
import UIKit
import SwiftyJSON
import SystemConfiguration
import MBProgressHUD

class Webservice {
    
    //    let webservice = Webservice()
    
    //check internet utility
    class func isNetworkAvailable() -> Bool {
        
        var zeroAddress = sockaddr_in()
        zeroAddress.sin_len = UInt8(MemoryLayout<sockaddr_in>.size)
        zeroAddress.sin_family = sa_family_t(AF_INET)
        
        guard let defaultRouteReachability = withUnsafePointer(to: &zeroAddress, {
            $0.withMemoryRebound(to: sockaddr.self, capacity: 1) {
                SCNetworkReachabilityCreateWithAddress(nil, $0)
            }
        }) else {
            return false
        }
        
        var flags: SCNetworkReachabilityFlags = []
        if !SCNetworkReachabilityGetFlags(defaultRouteReachability, &flags) {
            return false
        }
        
        let isReachable = flags.contains(.reachable)
        let needsConnection = flags.contains(.connectionRequired)
        
        return (isReachable && !needsConnection)
    }
    
    
    // MARK: - Authorization Token
    func showSessionExpired() {
        
        //        UIAlertController.showAlertWithOkButton(self, aStrMessage: "Session Expired", completion: nil)
        self.logOutFromApp()
    }
    
    
    
    func logOutFromApp() {
        
        UtilityUserDefault().deleteUserDefault(KeyToDelete: USER_MODEL)
        UtilityUserDefault().deleteUserDefault(KeyToDelete: ACCESS_TOKEN)
        UtilityUserDefault().deleteUserDefault(KeyToDelete: REFRESH_TOKEN)
        UtilityUserDefault().deleteUserDefault(KeyToDelete: TOKEN_TYPE)
        UtilityUserDefault().deleteUserDefault(KeyToDelete: EXPIRES_IN)
        
        
        UtilityUserDefault().deleteUserDefault(KeyToDelete:IS_IDENTITY_VERIFIED )
        UtilityUserDefault().deleteUserDefault(KeyToDelete: USERID_GGWALLET )
        UtilityUserDefault().deleteUserDefault(KeyToDelete: USERID_FUEL_CASHBACK )
        UtilityUserDefault().deleteUserDefault(KeyToDelete: USERID_HELP_SWITCH)
        UtilityUserDefault().deleteUserDefault(KeyToDelete: USERID_UPV_CASHBACK)
        UtilityUserDefault().deleteUserDefault(KeyToDelete: USERID_BILLPAY_RECHARGE)
        UtilityUserDefault().deleteUserDefault(KeyToDelete: USERID_BESTSHOPPINGWEBSITES )
        UtilityUserDefault().deleteUserDefault(KeyToDelete: USERID_TRAVEL_HOTEL_BOOKING )
        UtilityUserDefault().deleteUserDefault(KeyToDelete: USERID_GGVENDOR )
        UtilityUserDefault().deleteUserDefault(KeyToDelete: USERID_MEGHABRANDS )
        UtilityUserDefault().deleteUserDefault(KeyToDelete: USERID_ENTERTAINMENT)
        UtilityUserDefault().deleteUserDefault(KeyToDelete: USERID_RESALE)
        UtilityUserDefault().deleteUserDefault(KeyToDelete: USERID_REALESTATE )
        UtilityUserDefault().deleteUserDefault(KeyToDelete: USERID_FOOD)
        UtilityUserDefault().deleteUserDefault(KeyToDelete: USERID_FRANCHISE)
        UtilityUserDefault().deleteUserDefault(KeyToDelete: USERID_FOOD)
        UtilityUserDefault().deleteUserDefault(KeyToDelete: USERID_JOB )
        UtilityUserDefault().deleteUserDefault(KeyToDelete: USERID_MATRIMONIAL )
        UtilityUserDefault().deleteUserDefault(KeyToDelete: USERID_NEWS )
        UtilityUserDefault().deleteUserDefault(KeyToDelete: USERID_SOCIALCAUSES)
        UtilityUserDefault().deleteUserDefault(KeyToDelete: USERID_CROWD_FUNDING)
        UtilityUserDefault().deleteUserDefault(KeyToDelete: CART_DATA)
        
        //pop to Login VC
        
        
    }
    
    
    
}

extension Webservice{
    
    
    //-------------------------------------------------
    //MARK :- API Call POST
    //-------------------------------------------------
    class func POST(_ url: String,
                    param: [String: Any]?,
                    controller: UIViewController,
                    header : [String: String]?,
                    callSilently : Bool = false,
                    successBlock: @escaping (_ response: JSON) -> Void,
                    failureBlock: @escaping (_ error: Error? , _ isTimeOut: Bool) -> Void) {
        
        // Internet is connected
        if isNetworkAvailable() {
        
            if !callSilently {
                MBProgressHUD.showAdded(to: (UIApplication.shared.delegate?.window!)! , animated: true)
            }
            
            Alamofire.request(url, method: .post, parameters: param, encoding: JSONEncoding(options: []), headers: header).responseJSON(completionHandler: { (response) in
                
                if !callSilently{
                    DispatchQueue.main.async {
                        MBProgressHUD.hide(for: ((UIApplication.shared.delegate?.window)!)!, animated: true)
                    }
                }
                
                print("---- POST REQUEST URL RESPONSE : \(url)\n\(response.result)")
                print(response.timeline)
                
                switch response.result {
                case .success:
                    
                    if let aJSON = response.result.value {
                        
                        let json = JSON(aJSON)
                        print("---- POST SUCCESS RESPONSE : \(json)")
                        successBlock(json)
                        
                    }
                    
                case .failure(let error):
                    print(error)
                    if (error as NSError).code == -1001 {
                        // The request timed out error occured. // Code=-1001 "The request timed out."
                        UIAlertController.showAlertWithOkButton(controller, aStrMessage: "The request timed out. Pelase try after again.", completion: nil)
                        failureBlock(error, true)
                    } else {
                        UIAlertController.showAlertWithOkButton(controller, aStrMessage: "Somthin went Wrong", completion: nil)
                        failureBlock(error, false)
                    }
                    break
                }
                
            })
            
        }
        else{
            // Internet is not connected
            UIAlertController.showAlertWithOkButton(controller, aStrMessage: "Internet is not available", completion: nil)
            let aErrorConnection = NSError(domain: "InternetNotAvailable", code: 0456, userInfo: nil)
            failureBlock(aErrorConnection as Error , false)
        }
    }
    
    
    
    //-------------------------------------------------
    //MARK :- API Call GET
    //-------------------------------------------------
    class func GET(_ url: String,
                    param: [String: Any]?,
                    controller: UIViewController,
                    header : [String: String]?,
                    callSilently : Bool = false,
                    successBlock: @escaping (_ response: JSON) -> Void,
                    failureBlock: @escaping (_ error: Error? , _ isTimeOut: Bool) -> Void) {
        
        // Internet is connected
        if isNetworkAvailable() {
            
            if !callSilently {
                MBProgressHUD.showAdded(to: (UIApplication.shared.delegate?.window!)! , animated: true)
            }
            
            Alamofire.request(url, method: .get, parameters: param, encoding: JSONEncoding(options: []), headers: header).responseJSON(completionHandler: { (response) in
                
                
                if !callSilently{
                    DispatchQueue.main.async {
                        MBProgressHUD.hide(for: ((UIApplication.shared.delegate?.window)!)!, animated: true)
                    }
                }
                
                print("---- GET REQUEST URL RESPONSE : \(url)\n\(response.result)")
                print(response.timeline)
                
                switch response.result {
                case .success:

                    if !callSilently{
                        DispatchQueue.main.async {
                            MBProgressHUD.hide(for: ((UIApplication.shared.delegate?.window)!)!, animated: true)
                        }
                    }
                    
                    if let aJSON = response.result.value {
                        
                        let json = JSON(aJSON)
                        print("---- GET SUCCESS RESPONSE : \(json)")
                        successBlock(json)
                        
                    }
                    
                case .failure(let error):
                    print(error)
                    
                    if !callSilently{
                        DispatchQueue.main.async {
                            MBProgressHUD.hide(for: ((UIApplication.shared.delegate?.window)!)!, animated: true)
                        }
                    }
                    
                    if (error as NSError).code == -1001 {
                        // The request timed out error occured. // Code=-1001 "The request timed out."
                        UIAlertController.showAlertWithOkButton(controller, aStrMessage: "The request timed out. Pelase try after again.", completion: nil)
                        failureBlock(error, true)
                    } else {
                        UIAlertController.showAlertWithOkButton(controller, aStrMessage: "Somthin went Wrong", completion: nil)
                        failureBlock(error, false)
                    }
                    break
                }
                
            })
            
        }
        else{
            // Internet is not connected
            UIAlertController.showAlertWithOkButton(controller, aStrMessage: "Internet is not available", completion: nil)
            let aErrorConnection = NSError(domain: "InternetNotAvailable", code: 0456, userInfo: nil)
            failureBlock(aErrorConnection as Error , false)
        }
    }

    
    
}
