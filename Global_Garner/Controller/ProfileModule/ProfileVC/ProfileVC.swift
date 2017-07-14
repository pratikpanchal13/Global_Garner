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
    var dictDatUserProfile = NSDictionary()
    var userImage:String = ""
    
    // MARK: - View Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        tblProfile.rowHeight = UITableViewAutomaticDimension
        tblProfile.estimatedRowHeight = 100
        
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.APIGetUserProfile()
        self.getUserProfileImage()
        
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
    
    func APIGetUserProfile()
    {
        let token =  UtilityUserDefault().getUDObject(KeyToReturnValye: "access_token") as! String
        let Auth_header = ["Authorization":token,
                           "Content-Type": "application/json"]
        
        print("Token-> \(token)")
        //        let url = "https://accounts.globalgarner.in/api/users/9006"
        
        Alamofire.request(PROFILE_API, method: .get, parameters: nil, encoding: JSONEncoding(options: []), headers: Auth_header).responseJSON { (response) in
            
            switch(response.result) {
            case .success(_):
                
                if let data = response.result.value{
                    print(response.result.value)
                    
                    if let dctMain = data as? NSDictionary { // Check 3
                        print("Dictionary received")
                        
                        let status:Bool = dctMain["status"] as! Bool
                        
                        if(status == true)
                        {
                            self.dictDatUserProfile = dctMain["body"] as! NSDictionary
                            self.tblProfile.reloadData()
                            
                            print("Model Data is \(String(describing: "\((self.dictDatUserProfile["email"])!)"   ))")
                            
                        }
                        else
                        {
                            print("No Data Found")
                            
                        }
                        
                    }
                }
                
                break
                
            case .failure(_):
                print(response.result.error)
                break
                
            }
        }
    }
    
    
    func getUserProfileImage()
    {
        
        let url = "https://accounts.globalgarner.in/api/user/get-avatar-url?sso_user_id=9006&size=170x170"
        
        let token =  UtilityUserDefault().getUDObject(KeyToReturnValye: "access_token") as! String
        let Auth_header = ["Authorization":token,
                           "Content-Type": "application/json"]
        
        Alamofire.request(url, method: .post, parameters: nil, encoding: JSONEncoding(options: []), headers: Auth_header).responseJSON { (response) in
            
            
            switch (response.result){
                
            case .success(_):
                if let data = response.result.value
                {
                    if let dct = data as? NSDictionary { // Check 3
                        
                        print("Data is \(dct)")
                        
                        let status:Bool = dct["status"] as! Bool
                        
                        if(status == true)
                        {
                            self.userImage = dct["url"] as! String
                            self.tblProfile.reloadData()
                            
                            print("Model Data is \(String(describing: "\((self.userImage))"   ))")
                            
                        }
                        else
                        {
                            print("No Data Found")
                            
                        }
                        
                        
                    }
                }
                break
            case .failure(_):
                break
                
            }
        }
    }
    

}

