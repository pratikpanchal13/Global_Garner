//
//  EditProfileVC.swift
//  Global_Garner
//
//  Created by indianic on 11/07/17.
//  Copyright © 2017 indianic. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON

class EditProfileVC: UIViewController,UIImagePickerControllerDelegate, UINavigationControllerDelegate {

    
    // MARK: - Outlets
    @IBOutlet var imgProfile: UIImageView!
    @IBOutlet var txtFirstName: UITextField!
    @IBOutlet var txtLastName: UITextField!
    @IBOutlet var btnDOB: UIButton!
    @IBOutlet var btnGendor: UIButton!
    @IBOutlet var txtPinCode: UITextField!
    
    let imagePicker = UIImagePickerController()

    // MARK: - View Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        imagePicker.delegate = self
        
        self.imgProfile.layer.cornerRadius = self.imgProfile.frame.size.width / 2
        self.imgProfile.clipsToBounds = true

        // Do any additional setup after loading the view.
    }



    // MARK: - Button Action Event
    @IBAction func btnDOBClicked(_ sender: Any) {
    }
    
    @IBAction func btnGendorClicked(_ sender: Any) {
    }
    @IBAction func btnUpdateImageClicked(_ sender: Any) {
        imagePicker.allowsEditing = true
        imagePicker.isEditing = true
        imagePicker.sourceType = .photoLibrary
        present(imagePicker, animated: true, completion: nil)
    }
    @IBAction func btnEditProfileClicked(_ sender: Any) {
    }
}

// MARK: - ImagePicker Darasource & Delegate

extension EditProfileVC
{
    // MARK: - ImagePicker Delegate
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        
        if let pickedImage = info[UIImagePickerControllerEditedImage] as? UIImage {
            imgProfile.image = pickedImage
            self.imageUpload()
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

}

// MARK: - Image Upload

extension EditProfileVC{

    // Image Uploading
    func imageUpload()
    {

        let token =  UtilityUserDefault().getUDObject(KeyToReturnValye: "access_token") as! String
        let Auth_header = ["Authorization":token,
                           "Content-Type": "application/json"]
        
        let imgData = UIImageJPEGRepresentation(imgProfile.image!, 100)!
        let aUrlStr = "https://accounts.globalgarner.in/api/users/update-avatar"
        let aUrl = URL(string: aUrlStr)
        
        var aParameter = Dictionary<String, String>()
        aParameter["sso_user_id"] = "9006"

        Alamofire.upload(multipartFormData: { (multipartFormData) in
        
            //Image
            multipartFormData.append(imgData, withName: "avatar", fileName: "a.jpg", mimeType: "image/jpeg")
            
            for (key, value) in aParameter {
                multipartFormData.append(value.data(using: String.Encoding.utf8)!, withName: key)
            }
        }, to:aUrl!,headers:Auth_header) { (result) in
                                    print(result)

            switch result {
             case .success(let upload, _, _):
                upload.uploadProgress(closure: { (progress) in
                    //Print progress
                    print("Progress\(progress)")
                    
                })
                
                upload.responseJSON { response in
                    if response.result.value != nil
                    {
                        print(response.result.value!)
                    
                        if let data = response.result.value{
                            
                            let dct = data as! NSDictionary
                            
                            let status:Bool = dct["status"] as! Bool
                            
                            if(status == true)
                            {
                                self.navigationController?.popViewController(animated: true)
                            }
                        }
                       
                    }
                }
            case .failure(let encodingError):
                print(encodingError)
                break
            }
            
        }
    }
    
 }
