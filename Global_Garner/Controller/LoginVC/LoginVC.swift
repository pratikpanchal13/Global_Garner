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
import MBProgressHUD
import SDWebImage
import SwiftGifOrigin



class LoginVC: UIViewController {
    
    //MARK:- Outlets
    @IBOutlet var txtPassword: UITextField!
    @IBOutlet var txtUserName: UITextField!
    
    @IBOutlet var btnLogin: UIButton!
    var objUserModel : UserModel?
    var HUD:MBProgressHUD?
    
    @IBOutlet var aViewLogin: UIView!
    // MARK:- View Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.setUpUI()
        
        
        txtUserName.text = ""
        txtPassword.text = ""
        // Do any additional setup after loading the view.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    func setUpUI(){
        
    aViewLogin.layer.cornerRadius = 3.0
    aViewLogin.layer.borderWidth = 1.0
    aViewLogin.layer.borderColor = UIColor(red: CGFloat((207.0 / 255.0)), green: CGFloat((207.0 / 255.0)), blue: CGFloat((207.0 / 255.0)), alpha: CGFloat(1)).cgColor
    aViewLogin.layer.masksToBounds = true
//    btnLogin.layer.cornerRadius = 3.0
//    btnLogin.layer.borderWidth = 0.0
//    btnLogin.layer.masksToBounds = true
        
    }
    
    // MARK:- Button Actions
    @IBAction func btnLoginClicked(_ sender: Any) {
        self.checkAccessToken()
    }
    
    
    func checkAccessToken() {
        
        Webservice().getOauthToken(txtUserName.text!, password: txtPassword.text!, success: { (_  responseData: Any) in

            let dictData = responseData as! Dictionary<String,Any>
            
//            UtilityUserDefault().setUDObject(ObjectToSave: (dictData["access_token"])! as AnyObject, KeyToSave: "access_token")
            
            self.getLoginStatus()
            
        }) { (_ responseData:Any) in
            //
            print("error is \(responseData)")
            
        }

    }

    func getLoginStatus() {
        
        if  AppDelegate().appDelegate().showActivityIndicator() == true {
        
            let token =  UtilityUserDefault().getUDObject(KeyToReturnValye: "access_token") as! String
            let Auth_header = ["Authorization":token]
            var dctPostData = Dictionary<String, String>()
            dctPostData["username"] = txtUserName.text!
            dctPostData["password"] = txtPassword.text!
            
            let aStrUrl = ACCOUNT_API + "user"
            
            Alamofire.request(aStrUrl, method: .post, parameters: dctPostData,headers:Auth_header)
                .responseJSON { response in
                    _ = response.flatMap { json in
                        print("json =\(json)")
                        
                        if let error = response.result.error {
                            // got an error while deleting, need to handle it
                            print("error")
//                            AppDelegate().appDelegate().hideActivityIndicator()
                            
                            print(error)
                        } else {
                            print("Success")
                            AppDelegate().appDelegate().hideActivityIndicator()

                            
                            //Model Sava Data
                            self.objUserModel = UserModel(object: json)
//                            print("Model Data is \(String(describing: self.objUserModel))")
//                            print("Model Data is \(String(describing: self.objUserModel?.body))")
//                            print("Model Name is \(String(describing: "\((self.objUserModel?.body?.username)!)" ))")
                            
                            if( self.objUserModel?.status == true)
                            {
                                let storyboard = UIStoryboard(storyboard: .Home)
                                let homeVC: HomeVC = storyboard.instantiateViewController()
                                self.navigationController?.pushViewController(homeVC, animated: true)

                            }else{

                                print(self.objUserModel?.message!)
                            }

//                            //Using Dictioanry
//                            if let dctMain = json as? NSDictionary { // Check 3
//                                print("Dictionary received")
//                                
//                                let status:Int = dctMain["status"] as! Int
//                                
//                                if(status == 1)
//                                {
//                                    let dct = dctMain["body"] as! NSDictionary
//                                    
//                                    print("Model Data is \(String(describing: "\((dct["username"])!)"   ))")
//                                    let storyboard = UIStoryboard(storyboard: .Home)
//                                    let homeVC: HomeVC = storyboard.instantiateViewController()
//                                    self.navigationController?.pushViewController(homeVC, animated: true)
//                                }
//                                else
//                                {
//                                    
//                                }
////                                print("Model Data is \(String(describing: "\((dctMain["body"])!)"))")
//                                
//                                
//                               
//                                
//
//                            }
                            
                            

                    }
                }
            }
        }
    }
    
}


