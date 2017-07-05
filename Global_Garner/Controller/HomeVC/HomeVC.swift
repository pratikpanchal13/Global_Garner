//
//  HomeVC.swift
//  Global_Garner
//
//  Created by indianic on 03/07/17.
//  Copyright © 2017 indianic. All rights reserved.
//

import UIKit

class HomeVC: UIViewController , UIImagePickerControllerDelegate, UINavigationControllerDelegate {

   
    // MARK: - OutLets
    @IBOutlet var btnProfile: UIButton!
    let imagePicker = UIImagePickerController()
    
    
   // MARK: - View Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        imagePicker.delegate = self
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func btnProfileClicked(_ sender: Any) {
        
        imagePicker.allowsEditing = true
        imagePicker.isEditing = true
        
        
        imagePicker.sourceType = .photoLibrary
        
        present(imagePicker, animated: true, completion: nil)

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

 

}
