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

class Webservice {
    
    //    let webservice = Webservice()
    
    
    func getOauthToken(_ username: String, password: String, success: @escaping (_ responseData: Any) -> Void, failure: @escaping (_ responseData: Any) -> Void) {
        
        if  AppDelegate().appDelegate().showActivityIndicator() == true {
            
            var dctPostData = Dictionary<String, String>()
            dctPostData["username"] = username
            dctPostData["password"] = password
            dctPostData["client_id"] = CLIENT_ID
            dctPostData["client_secret"] = CLIENT_SECRET
            dctPostData["grant_type"] = "password"
            
            Alamofire.request(AUTH_TOKEN_API, method: .post, parameters: dctPostData).responseJSON { response in
                    _ = response.flatMap { json in
                        print("json =\(json)")
                        
                        switch response.result {
                        case .success:
                            print("Validation Successful")
                            AppDelegate().appDelegate().hideActivityIndicator()
                            let statusCode = (response.response?.statusCode) //Get HTTP status code
                            
                            
                            let message : String
                            if let httpStatusCode = response.response?.statusCode {
                                switch(httpStatusCode) {
                                case 400:
                                    message = "Username or password not provided."
                                    break;
                                case 401:
                                    message = "Incorrect password for user"
                                    break;
                                default :
                                    break;
                                }
                                
                            } else {
//                                message = error.localizedDescription
                            }
                            success(json)
                            
                        case .failure(let error):
                            print(error)
                            
                            let statusCode = (response.response?.statusCode) //Get HTTP status code
                            
                            
                            let message : String
                            if let httpStatusCode = response.response?.statusCode {
                                switch(httpStatusCode) {
                                case 400:
                                    message = "Username or password not provided."
                                    break;
                                case 401:
                                    message = "Incorrect password for user"
                                    break;
                                default :
                                    break;
                                }
                                
                            } else {
                                message = error.localizedDescription
                            }
                            failure(error)

                        }
                        
                        
//                        let dictData = json as! Dictionary<String,Any>
                        
//                        if let error = response.result.error {
//                            // got an error while deleting, need to handle it
//                            print("error")
//                            AppDelegate().appDelegate().hideActivityIndicator()
//                            failure(error)
//                            
//                            print(error)
//                        } else {
//                            print("Success")
////                            if (dictData[ACCESS_TOKEN] == nil) && (dictData[REFRESH_TOKEN] == nil)
////                            {
////                                UtilityUserDefault().setUDObject(ObjectToSave: (dictData["ACCESS_TOKEN"])! as AnyObject, KeyToSave: "ACCESS_TOKEN")
////                                UtilityUserDefault().setUDObject(ObjectToSave: (dictData["REFRESH_TOKEN"])! as AnyObject, KeyToSave: "REFRESH_TOKEN")
////                                UtilityUserDefault().setUDObject(ObjectToSave: (dictData["TOKEN_TYPE"])! as AnyObject, KeyToSave: "TOKEN_TYPE")
////                                UtilityUserDefault().setUDObject(ObjectToSave: (dictData["EXPIRES_IN"])! as AnyObject, KeyToSave: "EXPIRES_IN")
////                                
////                                AppDelegate().appDelegate().hideActivityIndicator()
////                            }else{
////                                self.showSessionExpired()
////                            }
//                            AppDelegate().appDelegate().hideActivityIndicator()
//                            success(json)
//
//                        }
                    }
            }
            
        }
        
        
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
