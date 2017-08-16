//
//  LeftDrawerVC.swift
//  Global_Garner
//
//  Created by indianic on 06/07/17.
//  Copyright © 2017 indianic. All rights reserved.
//

import UIKit

class LeftDrawerVC: UIViewController , UITableViewDelegate,UITableViewDataSource {

    var aryMenuList = [Any]()
//    var objProfile = ProfileVC()
    @IBOutlet var imgProfile: UIButton!
    @IBOutlet var lblUserName: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        aryMenuList = ["Bill Uploads", "Vendor Referrals", "User Referrals", "UPV Cashback", "UPV Orders", "Make MyCart History", "Manage Address", "Wallet", "GG Stats", "Credits", "Know Us", "Contact Us", "Terms and Conditions", "Privacy Policy", "Logout" ,"Conatcts"]

        lblUserName.text =  AppDelegate().appDelegate().userModel?.body?.username
        
//        ProfileVC.getImageUser()
        
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    @IBAction func btnEditImageClicked(_ sender: Any) {
        
        let storyboardDashBoard = UIStoryboard(name: "Profile", bundle: nil)
        let centerVC = storyboardDashBoard.instantiateViewController(withIdentifier: "ProfileVC")
        self.mm_drawerController.centerViewController.navigationController?.pushViewController(centerVC, animated: true)
    }
    
    // MARK: - Tableview DataSource Methods
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 40
        
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return aryMenuList.count
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell:tblCellLeftDrawer = tableView.dequeueReusableCell(withIdentifier: "tblCellLeftDrawer") as! tblCellLeftDrawer
        cell.lblMenuTitle.text = aryMenuList[indexPath.row] as? String
        return cell
    
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        var storyboardDashBoard = UIStoryboard(name: "Dashboard", bundle: nil)
        var aIdentifire = ""
        switch indexPath.row {
        case 0:
            aIdentifire = "GGWalletsVC"
            break
        case 1:
            aIdentifire = "GGStatsVC"
            break
            
        case 2:
            aIdentifire = "GGWalletsVC"
//                let centerVC = storyboardDashBoard.instantiateViewController(withIdentifier: aIdentifire)
//                self.mm_drawerController.setCenterView(centerVC, withCloseAnimation: true, completion: nil)
            break
        case 3:
            aIdentifire = "GGStatsVC"
//            let centerVC = storyboardDashBoard.instantiateViewController(withIdentifier: aIdentifire)
//            self.mm_drawerController.setCenterView(centerVC, withCloseAnimation: true, completion: nil)
            break
        
        case 15 :
                storyboardDashBoard = UIStoryboard(name: "CNContacts", bundle: nil)
                aIdentifire = "ContactsViewController"
        default:
            self.navigationController?.popViewController(animated: true)
            return
            
        }
        
        
        let centerVC = storyboardDashBoard.instantiateViewController(withIdentifier: aIdentifire)
        self.mm_drawerController.centerViewController.navigationController?.pushViewController(centerVC, animated: true)
        

        DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
            self.mm_drawerController?.closeDrawer(animated: false, completion: nil)
        }

    }
    
    

    
}


class tblCellLeftDrawer : UITableViewCell{
    
    @IBOutlet var lblMenuTitle: UILabel!
}
