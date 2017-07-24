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
import MMDrawerController


class LoginVC: UIViewController,UITextFieldDelegate {
    
    //-------------------------------------------
    //MARK:- Outlets
    //-------------------------------------------
    @IBOutlet var txtPassword: UITextField!
    @IBOutlet var txtUserName: UITextField!
    
    @IBOutlet var btnLogin: UIButton!
    var objUserModel : UserModel?
    var HUD:MBProgressHUD?
    
    @IBOutlet var aViewLogin: UIView!
    
    
    //-------------------------------------------
    // MARK:- View Life Cycle
    //-------------------------------------------
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.setUpUI()      // Set UI
        
    }
    
  
    //-------------------------------------------
    // MARK:- Set UI
    //-------------------------------------------
    func setUpUI(){

        txtUserName.text = "pratik13"
        txtPassword.text = "global916"

        
        aViewLogin.layer.cornerRadius = 3.0
        aViewLogin.layer.borderWidth = 1.0
        aViewLogin.layer.borderColor = UIColor(red: CGFloat((207.0 / 255.0)), green: CGFloat((207.0 / 255.0)), blue: CGFloat((207.0 / 255.0)), alpha: CGFloat(1)).cgColor
        aViewLogin.layer.masksToBounds = true
        //    btnLogin.layer.cornerRadius = 3.0
        //    btnLogin.layer.borderWidth = 0.0
        //    btnLogin.layer.masksToBounds = true
        
    }
    
    
    //-------------------------------------------
    // MARK:- Button Actions
    //-------------------------------------------
    @IBAction func btnLoginClicked(_ sender: Any) {
        
        guard let username = self.txtUserName.text , username != "" else{
            UIAlertController.showAlertWithOkButton(self, aStrMessage: "Please Enter user name", completion: nil)
            return
        }
        guard let passwors = self.txtPassword.text , passwors != "" else{
            UIAlertController.showAlertWithOkButton(self, aStrMessage: "Please Enter password", completion: nil)
            return
        }
        
        self.checkAccessToken()  // API Calling for Login
    }
    
    //-------------------------------------------
    // MARK:- Function Open Side Menu
    //-------------------------------------------
    func openSideMenu(){
        
        let storyboardHome = UIStoryboard(name: "Dashboard", bundle: nil)
        let storyboardSideMenu = UIStoryboard(name: "SideMenu", bundle: nil)
        
        let leftDrawer = storyboardSideMenu.instantiateViewController(withIdentifier: "LeftDrawerVC")
        
        let centerVC = storyboardHome.instantiateInitialViewController()
        let drawerController = MMDrawerController.init(center: centerVC, leftDrawerViewController: leftDrawer)
        
        drawerController?.shouldStretchDrawer = true
        drawerController?.openDrawerGestureModeMask = .init(rawValue: 2)
        
        drawerController?.setMaximumLeftDrawerWidth((Constant.ScreenSize.SCREEN_WIDTH * 0.9), animated: false, completion: nil)
        drawerController?.restorationIdentifier = "MMDrawer"
        drawerController?.closeDrawerGestureModeMask = .all
        drawerController?.showsShadow = true
        
        self.navigationController?.pushViewController(drawerController!, animated: true)
    }
    
    
    
    //-------------------------------------------
    // MARK:- API Calling Check Access Token
    //-------------------------------------------
    func checkAccessToken() {
        
        var dctPostData = Dictionary<String, String>()
        dctPostData["username"] = txtUserName.text
        dctPostData["password"] = txtPassword.text
        dctPostData["client_id"] = CLIENT_ID
        dctPostData["client_secret"] = CLIENT_SECRET
        dctPostData["grant_type"] = "password"
        
        Webservice.POST(AUTH_TOKEN_API, param: dctPostData, controller: self, header: nil, callSilently: true, successBlock: { responseJson in
            
            if (responseJson["error"].string != nil)
            {
                print("Error")
                UIAlertController.showAlertWithOkButton(self, aStrMessage:"\(responseJson["error_description"])" , completion: nil)
            }
            else
            {
                UtilityUserDefault().setUDObject(ObjectToSave: "\(responseJson["access_token"])" as AnyObject, KeyToSave: "access_token")
                self.getLoginStatus()
            }
        })
        { (eror, isTimeOut) in
            print("Error")
        }
    }

    //-------------------------------------------
    // MARK:- API Calling Login
    //-------------------------------------------
    func getLoginStatus() {
        
        let aStrUrl = ACCOUNT_API + "user"
        let token =  UtilityUserDefault().getUDObject(KeyToReturnValye: "access_token") as! String
        let Auth_header = ["Authorization":token]
        var dctPostData = Dictionary<String, String>()
        dctPostData["username"] = txtUserName.text!
        dctPostData["password"] = txtPassword.text!

        Webservice.POST(aStrUrl, param: dctPostData, controller: self, header: Auth_header, successBlock: { response in

            //            Model Sava Data
            self.objUserModel = UserModel(json: response)
            AppDelegate().appDelegate().userModel = UserModel(json: response)
            
//            print("Model Data is \(String(describing: self.objUserModel))")
//            print("Model Data is \(String(describing: self.objUserModel?.body))")
//            print("Model Name is \(String(describing: "\((self.objUserModel?.body?.username)!)" ))")

            Utility().setUserDefault(ObjectToSave: self.objUserModel?.body?.userId as AnyObject, KeyToSave: "user_id")
            Utility().setUserDefault(ObjectToSave: self.objUserModel?.body?.username as AnyObject, KeyToSave: "user_name")
            
            if( self.objUserModel?.status == true)
            {
                self.openSideMenu()
                

            }else{
                UIAlertController.showAlertWithOkButton(self, aStrMessage: "\((self.objUserModel?.message)!)", completion: nil)
            }
        })
        { (error, TimePot) in

            print("Error")

        }

    }
    
    
    //-------------------------------------------
    // MARK:- TextField Delegate
    //-------------------------------------------
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        
        textField.resignFirstResponder()
        return true
    }
    
}


