//
//  LoginVC.swift
//  Global_Garner
//
//  Created by indianic on 21/06/17.
//  Copyright © 2017 indianic. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON



class LoginVC: UIViewController {
    
    @IBOutlet var txtPassword: UITextField!
    @IBOutlet var txtUserName: UITextField!
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        txtUserName.text = "vikasaroy"
        txtPassword.text = "global916"
        // Do any additional setup after loading the view.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    /*
     // MARK: - Navigation
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
     // Get the new view controller using segue.destinationViewController.
     // Pass the selected object to the new view controller.
     }
     */
    
    @IBAction func btnLoginClicked(_ sender: Any) {
        self.checkAccessToken()
    }
    
    func convertToDictionary(text: String) -> [String: Any]? {
        if let data = text.data(using: .utf8) {
            do {
                return try JSONSerialization.jsonObject(with: data, options: []) as? [String: Any]
            } catch {
                print(error.localizedDescription)
            }
        }
        return nil
    }
    
    func checkAccessToken() {
        
        Webservice().getOauthToken(txtUserName.text!, password: txtPassword.text!, success: { (_  responseData: Any) in
            print("response is \(responseData)")
            
            
            
            let dictData = responseData as! Dictionary<String,Any>
            
            UtilityUserDefault().setUDObject(ObjectToSave: (dictData["access_token"])! as AnyObject, KeyToSave: "access_token")

            self.getLoginStatus()
            
            
            
        }) { (_ responseData:Any) in
            //
            print("error is \(responseData)")
            
        }

    }
    
    func getLoginStatus() {
        
        if  AppDelegate().appDelegate().showActivityIndicator() == true {
            
            let token =  UtilityUserDefault().getUDObject(KeyToReturnValye: "access_token") as! String
            
            let Auth_header    = ["Authorization":token]
            
            var dctPostData = Dictionary<String, String>()
            dctPostData["username"] = txtUserName.text!
            dctPostData["password"] = txtPassword.text!
            
            let aStrUrl = ACCOUNT_API + "user"
            
            //aParam["user_id"] = "139" //AppDelegate().appDelegate().loginModel?.data[0].usersId
            print("param =\(aStrUrl)")
            
            
            
            Alamofire.request(aStrUrl, method: .post, parameters: dctPostData,headers:Auth_header)
                .responseJSON { response in
                    _ = response.flatMap { json in
                        print("json =\(json)")
                        
                        if let error = response.result.error {
                            // got an error while deleting, need to handle it
                            print("error")
                            AppDelegate().appDelegate().hideActivityIndicator()
                            
                            print(error)
                        } else {
                            print("Success")
                            AppDelegate().appDelegate().hideActivityIndicator()
                            //                            success(json)
                    }
                }
            }
        }
    }
    
}
