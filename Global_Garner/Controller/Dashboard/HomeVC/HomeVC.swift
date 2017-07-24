//
//  HomeVC.swift
//  Global_Garner
//
//  Created by indianic on 24/07/17.
//  Copyright © 2017 indianic. All rights reserved.
//

import UIKit

class HomeVC: UIViewController , UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    
    @IBOutlet var view1: UIView!
    @IBOutlet var view2: UIView!
    // MARK: - OutLets
    @IBOutlet var btnProfile: UIButton!
    var imagePicker = UIImagePickerController()
    
    @IBOutlet var txtdata: UITextField!
    @IBOutlet var consHeight: NSLayoutConstraint!
    
    // MARK: - View Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        imagePicker.delegate = self
        
        self.txtdata.useUnderline(color: UIColor.colorFromCode(12   ), borderWidth: 10.0)
        
        
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
        
        let storyboardDashBoard = UIStoryboard(name: "Profile", bundle: nil)
        let centerVC = storyboardDashBoard.instantiateViewController(withIdentifier: "ProfileVC")
        self.mm_drawerController.centerViewController.navigationController?.pushViewController(centerVC, animated: true)
    }
    
    
    
}
