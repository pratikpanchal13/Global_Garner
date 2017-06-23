//
//  Webservice.swift
//  Global_Garner
//
//  Created by indianic on 22/06/17.
//  Copyright © 2017 indianic. All rights reserved.
//

import Foundation
import Alamofire

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
            
            Alamofire.request(AUTH_TOKEN_API, method: .post, parameters: dctPostData)
                .responseJSON { response in
                    _ = response.flatMap { json in
                        print("json =\(json)")

                        
                        if let error = response.result.error {
                            // got an error while deleting, need to handle it
                            print("error")
                            AppDelegate().appDelegate().hideActivityIndicator()
                            failure(error)

                            print(error)
                        } else {
                            print("Success")
                            AppDelegate().appDelegate().hideActivityIndicator()
                            success(json)

                        }
                        
                        
//                        if !json {
//                            if json[ACCESS_TOKEN] && json[REFRESH_TOKEN] {
//                                DEFAULTS[ACCESS_TOKEN] = responseData[ACCESS_TOKEN]
//                                DEFAULTS[REFRESH_TOKEN] = responseData[REFRESH_TOKEN]
//                                DEFAULTS[TOKEN_TYPE] = responseData[TOKEN_TYPE]
//                                DEFAULTS[EXPIRES_IN] = "\(responseData[EXPIRES_IN])"
//                                DEFAULTS.synchronize()
//                            }
//                            else {
//                                showSessionExpired()
//                            }
//                            success(responseData)
//                        }
//                        else {
//                            print("Else Error")
//                            failure(nil)
//                        }
                        
                    }
            }
        }

        
//        SHARED_WS.getAccessToken(dctPostData, api: AUTH_TOKEN_API, method: POST_METHOD, success: {(_ responseData: Any) -> Void in
//            if responseData != nil {
//                if responseData[ACCESS_TOKEN] && responseData[REFRESH_TOKEN] {
//                    DEFAULTS[ACCESS_TOKEN] = responseData[ACCESS_TOKEN]
//                    DEFAULTS[REFRESH_TOKEN] = responseData[REFRESH_TOKEN]
//                    DEFAULTS[TOKEN_TYPE] = responseData[TOKEN_TYPE]
//                    DEFAULTS[EXPIRES_IN] = "\(responseData[EXPIRES_IN])"
//                    DEFAULTS.synchronize()
//                }
//                else {
//                    self.showSessionExpired()
//                }
//                success(responseData)
//            }
//            else {
//                print("Else Error")
//                failure(nil)
//            }
//        }, failure: {(_ request: Any, _ response: Any) -> Void in
//            if (request as? ASIFormDataRequest)?.responseStatusCode == 401 {
//                failure(response)
//            }
//        })
    }
    
    
}
