//
//  ProfileVC.swift
//  Global_Garner
//
//  Created by indianic on 11/07/17.
//  Copyright © 2017 indianic. All rights reserved.
//

import UIKit
import Alamofire
import SDWebImage

class ProfileVC: UIViewController,UITableViewDelegate,UITableViewDataSource {
    
    // MARK: - Outlets
    @IBOutlet var tblProfile: UITableView!
    var dictDatUserProfile = [String:Any]()
    var userImage:String = ""
    
    // MARK: - View Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        tblProfile.rowHeight = UITableViewAutomaticDimension
        tblProfile.estimatedRowHeight = 100
        
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        
        
        self.APIGetUserProfileDetails()     // API CALL User Details
        
        
        self.getUserProfileImage()          //API Call GET Image
        
    }
    @IBAction func btnBackClicked(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func btnEditClicked(_ sender: Any) {
        
        //        let st:UIStoryboard = UIStoryboard(name: "Profile", bundle: nil)
        //        let editProfileVC = st.instantiateViewController(withIdentifier: "EditProfileVC") as! EditProfileVC
        //        self.navigationController?.pushViewController(EditProfileVC, animated: true)
        //
        
        let storyboardDashBoard = UIStoryboard(name: "Profile", bundle: nil)
        let centerVC = storyboardDashBoard.instantiateViewController(withIdentifier: "EditProfileVC") as! EditProfileVC
        centerVC.userImage = self.userImage
        centerVC.getUserProfileDict = dictDatUserProfile
        self.navigationController?.pushViewController(centerVC, animated: true)
        
        
    }
    
    // MARK: - Tableview DataSource
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return (section == 0) ? 1 : 3
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if indexPath.section == 0 {
            
            let cell:UserProfileImageCell = tableView.dequeueReusableCell(withIdentifier: "UserProfileImageCell") as! UserProfileImageCell
            cell.selectionStyle = UITableViewCellSelectionStyle.none
            cell.imgProfile.sd_setImage(with: URL(string:self.userImage), placeholderImage:UIImage(named: "PlaceHolder"))
            cell.imgProfile.layer.cornerRadius = cell.imgProfile.frame.size.width/2
            cell.imgProfile.clipsToBounds = true
            cell.lblUserAddress.text    = self.dictDatUserProfile["city"] as? String
            cell.lblName.text           = self.dictDatUserProfile["username"] as? String
            return cell
            
            
        }else{
            
            if indexPath.row == 0 {
                let cell:UserProfileMobileCell = tableView.dequeueReusableCell(withIdentifier: "UserProfileMobileCell") as! UserProfileMobileCell
                cell.lblMobileNumber?.text = self.dictDatUserProfile["mobile"] as? String
                return cell
            }
            else if indexPath.row == 1
            {
                let cell:UserProfileOtherInfoCell = tableView.dequeueReusableCell(withIdentifier: "UserProfileOtherInfoCell") as!  UserProfileOtherInfoCell
                cell.lblEmail.text      = self.dictDatUserProfile["email"] as? String
                cell.lblGender.text     = self.dictDatUserProfile["gender"] as? String
                cell.lblDOB.text        = self.dictDatUserProfile["dob"] as? String
                return cell
            }
            else{
                let cell:UserProfileVerifiedCell = tableView.dequeueReusableCell(withIdentifier: "UserProfileVerifiedCell") as!  UserProfileVerifiedCell
                cell.lblVerified.text   = self.dictDatUserProfile["verified_through"] as? String
                return cell
            }
            
        }
        
    }
    
}

// API CALL
extension ProfileVC
{
    
    func APIGetUserProfileDetails()
    {
        let token =  UtilityUserDefault().getUDObject(KeyToReturnValye: "access_token") as! String
        let Auth_header = ["Authorization":token,
                           "Content-Type": "application/json"]
        
//        let PROFILE_API = "https://accounts.globalgarner.in/api/users/20895"
        
        let userID = "\(String(describing: (Utility().getUserDefault(KeyToReturnValye: "user_id"))!))"


        let url = BASE_API + "users/" + "\(userID)"
        
        Webservice.GET(url, param: nil, controller: self, header: Auth_header, callSilently: true, successBlock: { jsonResponse in
            
            if jsonResponse["status"].boolValue == true{
                
                let dctData = jsonResponse["body"].dictionaryObject
                self.dictDatUserProfile = dctData!
                self.tblProfile.reloadData()
            }else
            {
                print("No Data Found")

            }
            
        }) { (error, isTimeout) in
            print("Error")
            
        }
    }
    
    
    func getUserProfileImage()
    {
        
        let userID = "\(String(describing: (Utility().getUserDefault(KeyToReturnValye: "user_id"))!))"
//        let url = "https://accounts.globalgarner.in/api/user/get-avatar-url?sso_user_id=20895&size=170x170"
        
        let url = BASE_API + "user/" + "get-avatar-url?" + "sso_user_id=\(userID)&" + "size=170x170"
        
        let token =  UtilityUserDefault().getUDObject(KeyToReturnValye: "access_token") as! String
        let Auth_header = ["Authorization":token,
                           "Content-Type": "application/json"]
        
        Webservice.POST(url, param: nil, controller: self, header: Auth_header, callSilently: true, successBlock: { responseJson in
            
            if(responseJson["status"].boolValue == true)
            {
                self.userImage = responseJson["url"].string!
                self.tblProfile.reloadData()
                print("Model Data is \(String(describing: "\((self.userImage))"   ))")
                
            }
            else
            {
                print("No Data Found")
                
            }
            
        }) { (error, isTimeOut) in
            print("Error")
        }
        
    }
    
    
}

