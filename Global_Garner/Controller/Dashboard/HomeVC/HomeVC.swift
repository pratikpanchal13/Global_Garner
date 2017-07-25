//
//  HomeVC.swift
//  Global_Garner
//
//  Created by indianic on 24/07/17.
//  Copyright © 2017 indianic. All rights reserved.
//

import UIKit
import GoogleMobileAds
import  Alamofire


class HomeVC: UIViewController , UIImagePickerControllerDelegate, UINavigationControllerDelegate , GADBannerViewDelegate ,UITableViewDelegate,UITableViewDataSource {
    
    
    @IBOutlet var view1: UIView!
    @IBOutlet var view2: UIView!
    // MARK: - OutLets
    @IBOutlet var btnProfile: UIButton!
    var imagePicker = UIImagePickerController()

    var arryData = [String]()
    
    @IBOutlet var txtdata: UITextField!
    @IBOutlet var consHeight: NSLayoutConstraint!
    
    @IBOutlet var tblComments: UITableView!
    
    var bannerView: GADBannerView!

    
    // MARK: - View Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        imagePicker.delegate = self
        
        
        self.txtdata.useUnderline(color: UIColor.colorFromCode(12   ), borderWidth: 10.0)
        
        self.APICAll()
    
        
        tblComments.estimatedRowHeight = 44.0
        tblComments.rowHeight = UITableViewAutomaticDimension

        //ADMOBS Add banner
//        bannerView = GADBannerView(adSize: kGADAdSizeFullBanner)
//        self.view.addSubview(bannerView)
//        bannerView.adUnitID = "ca-app-pub-3940256099942544/2934735716"
//        bannerView.rootViewController = self
//        
//        bannerView.load(GADRequest())
        
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
        
        
        
        let storyboardDashBoard = UIStoryboard(name: "Dashboard", bundle: nil)
//        let commentVC = storyboardDashBoard.instantiateViewController(withIdentifier: "CommentVC")
        let commentVC:CommentVC = storyboardDashBoard.instantiateViewController(withIdentifier: "CommentVC") as! CommentVC

        view.addSubview(commentVC.view)
        addChildViewController(commentVC)
        
        
        commentVC.passDataWithIndex = { arrayData in

            print("Data is \(arrayData)")
            self.arryData.append(arrayData as! String)
            self.tblComments.reloadData()
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
extension HomeVC
{
    /// Tells the delegate an ad request loaded an ad.
    func adViewDidReceiveAd(_ bannerView: GADBannerView) {
        print("adViewDidReceiveAd")
    }
    
    /// Tells the delegate an ad request failed.
    func adView(_ bannerView: GADBannerView,
                didFailToReceiveAdWithError error: GADRequestError) {
        print("adView:didFailToReceiveAdWithError: \(error.localizedDescription)")
    }
    
    /// Tells the delegate that a full screen view will be presented in response
    /// to the user clicking on an ad.
    func adViewWillPresentScreen(_ bannerView: GADBannerView) {
        print("adViewWillPresentScreen")
    }
    
    /// Tells the delegate that the full screen view will be dismissed.
    func adViewWillDismissScreen(_ bannerView: GADBannerView) {
        print("adViewWillDismissScreen")
    }
    
    /// Tells the delegate that the full screen view has been dismissed.
    func adViewDidDismissScreen(_ bannerView: GADBannerView) {
        print("adViewDidDismissScreen")
    }
    
    /// Tells the delegate that a user click will open another app (such as
    /// the App Store), backgrounding the current app.
    func adViewWillLeaveApplication(_ bannerView: GADBannerView) {
        print("adViewWillLeaveApplication")
    }
}

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
        cell.lblComment.text = self.arryData[indexPath.row]
        
        return cell
    }
    
}
