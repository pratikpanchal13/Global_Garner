//
//  HomeVC.swift
//  Global_Garner
//
//  Created by indianic on 24/07/17.
//  Copyright © 2017 indianic. All rights reserved.
//

import UIKit
import Alamofire
import FirebaseDatabase

class HomeVC: UIViewController , UIImagePickerControllerDelegate, UINavigationControllerDelegate  ,UITableViewDelegate,UITableViewDataSource {
    
    
    @IBOutlet var view1: UIView!
    @IBOutlet var view2: UIView!
    // MARK: - OutLets
    @IBOutlet var btnProfile: UIButton!
    var imagePicker = UIImagePickerController()

    var arryData = [NSMutableDictionary]()
    
    @IBOutlet var txtdata: UITextField!
    @IBOutlet var consHeight: NSLayoutConstraint!
    
    @IBOutlet var tblComments: UITableView!
    
    
    // FireBase variables
    var ref: DatabaseReference?
    
    var dataBaseHandel:DatabaseHandle?
    
    

    
    // MARK: - View Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        //***************************** | FireBase |***********************************
        //1______________ Create Database Reference ______________
        
        ref = Database.database().reference()
        
        //2______________ Get Data From FireBasse ______________
    
        dataBaseHandel = ref?.child("Comments").observe(.childAdded, with: { (snapshot) in
            
            let post = snapshot.value as? NSMutableDictionary
            
            post?["comment_id"] = snapshot.key
            
            if let postData = post{
                self.arryData.append(post!)
                self.tblComments.reloadData()
//                Utility().animateCells(tableView: self.tblComments)
            }
            
        })
        
        
        dataBaseHandel = ref?.child("Comments").observe(.childRemoved, with: { (snapshot) in
            
            let post = snapshot.value as? NSMutableDictionary
            
            print("Deleted Data",  post?["Comment"])
            
            
            
            
//            if let postData = post{
////                self.arryData.append(post!)
//                self.tblComments.reloadData()
//                //                Utility().animateCells(tableView: self.tblComments)
//            }
            
        })
        
        
        //********************************************************************************
        
        imagePicker.delegate = self
        
        
        
        self.APICAll()
    
        
        tblComments.estimatedRowHeight = 44.0
        tblComments.rowHeight = UITableViewAutomaticDimension
        
        
    }
    
   
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func btnSIdeMenuClicked(_ sender: Any) {
        //        [[APPDEL container] toggleLeftSideMenuCompletion:nil];
        
        //        AppDelegate().container?.toggleLeftSideMenuCompletion({
        //
        //            AppDelegate().container?.shadow
        //
        //        })
        
        self.mm_drawerController?.toggle(.left, animated: true, completion: nil)
        
        
    }
    @IBAction func btnProfileClicked(_ sender: Any) {
        
        //        imagePicker.allowsEditing = true
        //        imagePicker.isEditing = true
        //        imagePicker.sourceType = .photoLibrary
        //        present(imagePicker, animated: true, completion: nil)
        //
        //
        //Dynamic
        //        let frame = self.view.convert(self.view.frame, from: self.view.superview!)
        
        //        Utility.sharedInstance.imagePickerController(self, didFinishPickingMediaWithInfo: { (img) in
        //            if img != nil {
        ////                imagePicker  = img
        //                self.btnProfile.setImage(img, for: .normal)
        //
        //            }
        //        })
        
    }
    
    // MARK: - ImagePicker Delegate
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        
        if let pickedImage = info[UIImagePickerControllerEditedImage] as? UIImage {
            btnProfile.setImage(pickedImage, for: .normal)
        }
        
        
        /*
         
         Swift Dictionary named “info”.
         We have to unpack it from there with a key asking for what media information we want.
         We just want the image, so that is what we ask for.  For reference, the available options are:
         
         UIImagePickerControllerMediaType
         UIImagePickerControllerOriginalImage
         UIImagePickerControllerEditedImage
         UIImagePickerControllerCropRect
         UIImagePickerControllerMediaURL
         UIImagePickerControllerReferenceURL
         UIImagePickerControllerMediaMetadata
         
         */
        dismiss(animated: true, completion: nil)
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        dismiss(animated: true, completion:nil)
    }
    @IBAction func btnLogout(_ sender: UIButton) {
        
        //        let storyboardDashBoard = UIStoryboard(name: "Profile", bundle: nil)
        //        let centerVC = storyboardDashBoard.instantiateViewController(withIdentifier: "ProfileVC")
        //        self.mm_drawerController.centerViewController.navigationController?.pushViewController(centerVC, animated: true)
        //
        
        
//        Utility().animateCells(tableView: self.tblComments)
//        tblComments.reloadData()

        
        
        let storyboardDashBoard = UIStoryboard(name: "Dashboard", bundle: nil)
//        let commentVC = storyboardDashBoard.instantiateViewController(withIdentifier: "CommentVC")
        let commentVC:CommentVC = storyboardDashBoard.instantiateViewController(withIdentifier: "CommentVC") as! CommentVC

        view.addSubview(commentVC.view)
        addChildViewController(commentVC)

        
        
        
        commentVC.passDataWithIndex = { dctComment in

            print("Data is \(dctComment)")
        
            let dctData = dctComment as! [String : Any]
            
            //Fire Base Add data
//            self.ref?.child("Comments").childByAutoId().setValue(arrayData)
            
            let aDicMutChat = NSMutableDictionary()
            aDicMutChat.setValue(dctData["Comment"], forKey: "Comment")
            aDicMutChat.setValue(dctData["Ratting"], forKey: "Ratting")
            aDicMutChat.setValue("unread", forKey: "Status")

            self.ref?.child("Comments").childByAutoId().setValue(aDicMutChat) { (snapShot, FIRDatabaseReference) in


            }
            
            
//            self.arryData.append(arrayData as! String)

            
            self.tblComments.reloadData()
//            Utility().animateCells(tableView: self.tblComments)
        }
        
        
        commentVC.view?.frame = CGRect(x: commentVC.view.frame.origin.x, y: +commentVC.view.frame.size.height, width: commentVC.view.frame.size.width, height: commentVC.view.frame.size.height)
        
        UIView.animate(withDuration: 0.5, delay: 0, options: .curveEaseInOut, animations: {
            //
            commentVC.view.frame = CGRect(x: commentVC.view.frame.origin.x, y: 0, width: commentVC.view.frame.size.width, height: commentVC.view.frame.size.height)
            
        }) { (isFinshed) in
            //
        }
        
    }
 
    
}


//MARK:- ADMOBS Delegate
//extension HomeVC
//{
//    /// Tells the delegate an ad request loaded an ad.
//    func adViewDidReceiveAd(_ bannerView: GADBannerView) {
//        print("adViewDidReceiveAd")
//    }
//    
//    /// Tells the delegate an ad request failed.
//    func adView(_ bannerView: GADBannerView,
//                didFailToReceiveAdWithError error: GADRequestError) {
//        print("adView:didFailToReceiveAdWithError: \(error.localizedDescription)")
//    }
//    
//    /// Tells the delegate that a full screen view will be presented in response
//    /// to the user clicking on an ad.
//    func adViewWillPresentScreen(_ bannerView: GADBannerView) {
//        print("adViewWillPresentScreen")
//    }
//    
//    /// Tells the delegate that the full screen view will be dismissed.
//    func adViewWillDismissScreen(_ bannerView: GADBannerView) {
//        print("adViewWillDismissScreen")
//    }
//    
//    /// Tells the delegate that the full screen view has been dismissed.
//    func adViewDidDismissScreen(_ bannerView: GADBannerView) {
//        print("adViewDidDismissScreen")
//    }
//    
//    /// Tells the delegate that a user click will open another app (such as
//    /// the App Store), backgrounding the current app.
//    func adViewWillLeaveApplication(_ bannerView: GADBannerView) {
//        print("adViewWillLeaveApplication")
//    }
//}

extension HomeVC
{
    func APICAll()
    {
        Alamofire.request("url", method: .put, parameters: nil, encoding: JSONEncoding(options: []), headers: nil).response { (response) in
            // Response is
            print("\(response)")
        }
    }
}



extension HomeVC
{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.arryData.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell:cellComment = tableView.dequeueReusableCell(withIdentifier: "cellComment") as! cellComment
        
        let dict = self.arryData[indexPath.row] as NSDictionary
        
        cell.lblComment.text = dict["Comment"] as? String
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if (editingStyle == UITableViewCellEditingStyle.delete) {
            // handle delete (by removing the data from your array and updating the tableview)
            print("Deleted is Clicked \(indexPath.row)")
            
            let dict = self.arryData[indexPath.row]
            
            // delete data from firebase
            
            let profile = ref?.child("Comments").child(dict["comment_id"] as! String)
            
        
            if let pr = profile{
                
                pr.removeValue(completionBlock: { (error, ref) in
                    print(error)
                    print(ref)
                    self.arryData.remove(at: indexPath.row)
                    self.tblComments.reloadData()
                })
            
                
            }

        }
    }
}


extension HomeVC{
    
    func GCDExample(){
        
        DispatchQueue.global().async {
            // Back ground Thread
            
            DispatchQueue.main.async(execute: { 
                
                // Main Queue UI Update
            })
        }
        
    }
    
}
