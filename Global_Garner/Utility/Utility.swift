//
//  Utility.swift
//  Global_Garner
//
//  Created by indianic on 21/06/17.
//  Copyright © 2017 indianic. All rights reserved.
//

import Foundation


import UIKit
import Photos
import SystemConfiguration
import MobileCoreServices
import Alamofire

class Utility: NSObject, UIImagePickerControllerDelegate,UINavigationControllerDelegate, UIActionSheetDelegate {
    
    //Camera Picker
    typealias openCameraCallBackBlock = (_ selectedImage : UIImage?) ->Void
    var cameraCallBackBlock :openCameraCallBackBlock?
    var cameraController : UIViewController?
    
    static let sharedInstance = Utility()
    
    typealias JSResponseBlock = (_ response : Any?) -> Void
    var responceController : JSResponseBlock?
    
    
    func hexStringToUIColor (_ hex:String) -> UIColor {
        var cString:String = hex.trimmingCharacters(in: CharacterSet.whitespacesAndNewlines as CharacterSet).uppercased()
        
        if (cString.hasPrefix("#")) {
            cString = cString.substring(from: cString.characters.index(cString.startIndex, offsetBy: 1))
        }
        
        if ((cString.characters.count) != 6) {
            return UIColor.gray
        }
        
        var rgbValue:UInt32 = 0
        Scanner(string: cString).scanHexInt32(&rgbValue)
        
        return UIColor(
            red: CGFloat((rgbValue & 0xFF0000) >> 16) / 255.0,
            green: CGFloat((rgbValue & 0x00FF00) >> 8) / 255.0,
            blue: CGFloat(rgbValue & 0x0000FF) / 255.0,
            alpha: CGFloat(1.0)
        )
    }
    
    func openCameraInController(_ controller:UIViewController, position : CGRect? ,completionBlock:@escaping openCameraCallBackBlock)
    {
        cameraCallBackBlock = completionBlock
        cameraController = controller
        
        UIAlertController.showActionsheetForImagePicker(cameraController!, position: position!, aStrMessage: nil) { (index, strTitle) in
            if index == 1{
                
                if !UIImagePickerController.isSourceTypeAvailable(UIImagePickerControllerSourceType.camera){
                    
                    UIAlertController.showAlertWithOkButton(self.cameraController!, aStrMessage: "Camera not available.", completion: nil)
                }
                else{
                    
                    let authStatus = AVCaptureDevice.authorizationStatus(forMediaType: AVMediaTypeVideo)
                    if (authStatus == .authorized){
                        self.openPickerWithCamera(true)
                    }else if (authStatus == .notDetermined){
                        
                        print("Camera access not determined. Ask for permission.")
                        AVCaptureDevice.requestAccess(forMediaType: AVMediaTypeVideo, completionHandler: { (granted) in
                            if(granted)
                            {
                                self.openPickerWithCamera(true)
                            }
                        })
                    }else if (authStatus == .restricted){
                        
                        UIAlertController.showAlertWithOkButton(self.cameraController!, aStrMessage: "You've been restricted from using the camera on this device. Please contact the device owner so they can give you access.", completion: nil)
                        
                    }else{
                        
                        UIAlertController.showAlert(self.cameraController!, aStrMessage: "It looks like your privacy settings are preventing us from accessing your camera. Goto Setting ->Camera: turn on.", style: .alert, aCancelBtn: "Cancel", aDistrutiveBtn: nil, otherButtonArr: ["OK"], completion: { (index, strTitle) in
                            
                            if index == 0{
                                
                                UIApplication.shared.openURL(NSURL(string: UIApplicationOpenSettingsURLString)! as URL)
                            }
                        })
                    }
                }
            }else if index == 0{
                
                let authorizationStatus = PHPhotoLibrary.authorizationStatus()
                
                if (authorizationStatus == .authorized) {
                    // Access has been granted.
                    self.openPickerWithCamera(false)
                }else if (authorizationStatus == .restricted) {
                    // Restricted access - normally won't happen.
                    
                    UIAlertController.showAlertWithOkButton(self.cameraController!, aStrMessage: "You've been restricted from using the photos on this device. Please contact the device owner so they can give you access.", completion: nil)
                    
                }else if (authorizationStatus == .notDetermined) {
                    
                    // Access has not been determined.
                    PHPhotoLibrary.requestAuthorization({ (status) in
                        if (status == .authorized) {
                            // Access has been granted.
                            self.openPickerWithCamera(false)
                        }else {
                            // Access has been denied.
                        }
                    })
                }else{
                    UIAlertController.showAlert(self.cameraController!, aStrMessage: "It looks like your privacy settings are preventing us from accessing your photos. Goto Setting ->Photos: turn on.", style: .alert, aCancelBtn: "Cancel", aDistrutiveBtn: nil, otherButtonArr: ["OK"], completion: { (index, strTitle) in
                        
                        if index == 0{
                            
                            UIApplication.shared.openURL(NSURL(string: UIApplicationOpenSettingsURLString)! as URL)
                        }
                    })
                }
            }
        }
    }
    
    func openPickerWithCamera(_ isopenCamera:Bool) {
        
        let captureImg = UIImagePickerController()
        captureImg.delegate = self
        if(isopenCamera){
            captureImg.sourceType = UIImagePickerControllerSourceType.camera
        }else{
            captureImg.sourceType = UIImagePickerControllerSourceType.photoLibrary
        }
        captureImg.mediaTypes = [kUTTypeImage as String]
        captureImg.allowsEditing = true
        cameraController?.present(captureImg, animated: true, completion: nil)
    }
    
    // MARK: - UIImagePicker Controller Delegate
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]){
        
        if let img = info[UIImagePickerControllerEditedImage] as? UIImage{
            
            if (cameraCallBackBlock != nil){
                
                cameraCallBackBlock!(img)
            }
        }
        
        picker.dismiss(animated: true, completion: nil)
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController){
        
        if (cameraCallBackBlock != nil){
            
            cameraCallBackBlock!(nil)
        }
        picker.dismiss(animated: true, completion: nil)
    }
    
    //Compress image
    func compressImageData(_ aImg: UIImage) -> UIImage {
        
        //Compress Image
        var compression: CGFloat = 1.0
        let maxCompression: CGFloat = 0.1
        let maxFileSize: Int = 500 * 1024
        var imageData: Data? = UIImageJPEGRepresentation(aImg, compression)
        while (imageData?.count)! > maxFileSize && compression > maxCompression {
            compression -= 0.1
            imageData =  UIImageJPEGRepresentation(aImg, compression)
        }
        
        return UIImage(data: imageData!)!
    }
    
    
    //label Create
    func createLabel(aRect : CGRect, aStr : String, aTextColor : UIColor) ->UILabel {
        let lbl:UILabel = UILabel()
        lbl.backgroundColor = UIColor.clear
        lbl.text = aStr
        lbl.frame = aRect
        lbl.textColor = aTextColor
        lbl.textAlignment = .center
        lbl.isHidden = true
        
        return lbl
    }
    
    //check internet utility
    func isNetworkAvailable() -> Bool {
        
        var zeroAddress = sockaddr_in()
        zeroAddress.sin_len = UInt8(MemoryLayout<sockaddr_in>.size)
        zeroAddress.sin_family = sa_family_t(AF_INET)
        
        guard let defaultRouteReachability = withUnsafePointer(to: &zeroAddress, {
            $0.withMemoryRebound(to: sockaddr.self, capacity: 1) {
                SCNetworkReachabilityCreateWithAddress(nil, $0)
            }
        }) else {
            return false
        }
        
        var flags: SCNetworkReachabilityFlags = []
        if !SCNetworkReachabilityGetFlags(defaultRouteReachability, &flags) {
            return false
        }
        
        let isReachable = flags.contains(.reachable)
        let needsConnection = flags.contains(.connectionRequired)
        
        return (isReachable && !needsConnection)
    }
    
    
    //webservice
    func postWebservice(url : String, parameter : [String : String],completionBlock:@escaping JSResponseBlock){
        self.responceController = completionBlock
        
        if AppDelegate().appDelegate().showActivityIndicator() == true {
//            let aStrUrl = "\(serviceBaseUrl)\(url)"
            let aStrUrl = ""

            var aParam : [String : String] = parameter
            //aParam["user_id"] = "139" //AppDelegate().appDelegate().loginModel?.data[0].usersId
            print("param =\(aStrUrl)")
            
            let aUrl = URL(string: aStrUrl)
            
            Alamofire.request(aUrl!, method: .post, parameters: aParam)
                .responseJSON { response in
                    print("param =\(response)")
                    
                    _ = response.flatMap { json in
                        
                        if (self.responceController != nil){
                            AppDelegate().appDelegate().hideActivityIndicator()
                            self.responceController!(json)
                        }
                        
                    }
            }
        }else
        {
            if (self.responceController != nil){
                AppDelegate().appDelegate().hideActivityIndicator()
                self.responceController!(nil)
            }
        }
        
        
    }
    
    func changeDateFormat(_ date : String) -> String {
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss SSS"
        //        dateFormatter.timeZone = NSTimeZone(name: "UTC") as TimeZone!
        
        guard let date = dateFormatter.date(from: date) else {
            assert(false, "no date from string")
            return ""
        }
        //"12/03/2017"
        dateFormatter.dateFormat = "dd/MM/yyyy"
        //        dateFormatter.timeZone = NSTimeZone(name: "UTC") as TimeZone!
        let timeStamp = dateFormatter.string(from: date)
        
        return timeStamp
    }
    
    
    //check special character
    
    //func checkPassValidation(aStr : String) -> Bool {
    //
    //    var lowerCaseLetter: Bool = false
    //    var upperCaseLetter: Bool = false
    //    var digit: Bool = false
    //    var specialCharacter: Bool = false
    //
    //    var asciiValue: Int = 0
    //
    //
    //    var input = "The quick BroWn fOX jumpS Over tHe lazY DOg"
    //    var inputArray = Array(input)
    //    character in inputArray
    //    do {
    //        var strLower: var = "[a-z]"
    //    }
    //
    //
    //}
    
    //    func checkPassValidation(aStr : String) -> Bool {
    //        var aBool : Bool = false
    //        var characterSet:NSCharacterSet = NSCharacterSet(charactersIn: "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLKMNOPQRSTUVWXYZ0123456789")
    //        if (aStr.rangeOfCharacterFrom(characterSet.invertedSet).location == NSNotFound){
    //            print("No special characters")
    //            return false
    //        }
    //
    //        return true
    //    }
    
}




