//
//  Utility.swift
//  Global_Garner
//
//  Created by indianic on 21/06/17.
//  Copyright © 2017 indianic. All rights reserved.
//

import UIKit
import MobileCoreServices
import SystemConfiguration
import Photos

class Utility: NSObject ,UIPickerViewDelegate,UIPickerViewDataSource, UIImagePickerControllerDelegate,UINavigationControllerDelegate, UIActionSheetDelegate {
    
    // MARK:singleton sharedInstance
    static let sharedInstance = Utility()
    
    //Picker
    typealias pickerCompletionBlock = (_ picker:AnyObject?, _ buttonIndex : Int,_ firstindex:Int) ->Void
    var pickerType :String?
    var datePicker : UIDatePicker?
    var simplePicker : UIPickerView?
    var pickerDataSource : NSMutableArray?
    var pickerBlock : pickerCompletionBlock?
    var pickerSelectedIndex :Int = 0
    // // //  //  //
    
    //Camera Picker
    typealias openCameraCallBackBlock = (_ selectedImage : UIImage?) ->Void
    var cameraCallBackBlock :openCameraCallBackBlock?
    var cameraController : UIViewController?
    
    //MARK: Picker
    
    func addPicker(_ controller:UIViewController,onTextField:UITextField,typePicker:String,pickerArray:[String], setMaxDate : Bool = false, withCompletionBlock:@escaping pickerCompletionBlock)  {
        
        pickerType = typePicker
        onTextField.tintColor = UIColor.clear
        
        let keyboardDateToolbar = UIToolbar.init(frame: CGRect(x: 0, y: 0, width: controller.view.bounds.size.width, height: 44))
        keyboardDateToolbar.barTintColor = UIColor.darkGray
        //        (R: 49.0, G: 171.0, B: 81.0, Alpha: 1.0)
        
        let flexSpace = UIBarButtonItem.init(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
        
        let done = UIBarButtonItem.init(title: "Done", style: .done, target: self, action:  #selector(pickerDone))
        done.tintColor = UIColor.white
        
        let cancel = UIBarButtonItem.init(title: "Cancel", style: .done, target: self, action:  #selector(pickerCancel))
        cancel.tintColor = UIColor.white
        
        keyboardDateToolbar.setItems([cancel,flexSpace,done], animated: true)
        onTextField.inputAccessoryView = keyboardDateToolbar
        
        if typePicker == "Date" {
            
            datePicker = UIDatePicker.init()
            datePicker!.backgroundColor = UIColor.white
            datePicker!.datePickerMode = .date
            
            let dateFormatter = DateFormatter.init()
            dateFormatter.dateFormat = "dd/MM/yyyy"
            
            if setMaxDate {
                datePicker!.maximumDate = Date()
            }
            
            if let date = dateFormatter.date(from: onTextField.text!)
            {
                datePicker?.date = date
            }
            onTextField.inputView = datePicker
            
        } else if typePicker == "Time" {
            
            datePicker = UIDatePicker.init()
            datePicker!.backgroundColor = UIColor.white
            datePicker!.datePickerMode = .time
            datePicker!.date = Date()
            
            onTextField.inputView = datePicker
            
        } else {
            
            pickerDataSource = NSMutableArray.init(array: pickerArray)
            simplePicker = UIPickerView.init()
            simplePicker!.backgroundColor = UIColor.white
            simplePicker!.delegate = self
            simplePicker!.dataSource = self
            
            if let index = pickerArray.index(of: onTextField.text!) {
                simplePicker!.selectRow(index, inComponent: 0, animated: true)
            }
            onTextField.inputView = simplePicker
        }
        
        pickerBlock = withCompletionBlock
        onTextField.becomeFirstResponder()
    }
    
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int{
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        if (pickerDataSource != nil) {
            return pickerDataSource!.count;
        }
        return 0
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return pickerDataSource![row] as? String
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int){
        
        pickerSelectedIndex = row
    }
    
    func pickerDone()
    {
        print(pickerBlock)
        if pickerType == "Date" {
            
            pickerBlock!(datePicker!,1,0)
        } else if pickerType == "Time"  {
            pickerBlock!(datePicker!,1,0)
        } else {
            pickerBlock!(simplePicker!,1,pickerSelectedIndex)
        }
    }
    
    func pickerCancel()
    {
        pickerBlock!(nil,0,0)
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
    
    //MARK: Date To String
    
    func convertDateFormater() -> String
    {
        let aDate = NSDate()
        let dateFormatter = DateFormatter()
        
        dateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
        dateFormatter.timeZone = NSTimeZone(name: "UTC") as TimeZone!
        
        let timeStamp = dateFormatter.string(from: aDate as Date)
        
        return timeStamp
    }
    
    
    func getTimeComponentFomDateString(_ receivedDate: NSString) -> NSString!{
        
        let calendar = Calendar.current as Calendar
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
        dateFormatter.timeZone = TimeZone(abbreviation: "UTC")
        
        
        let aDate = Date()
        let timeStamp = dateFormatter.string(from: aDate as Date)
        
        let date1 = dateFormatter.date(from: receivedDate as String) as NSDate!
        let date2 = dateFormatter.date(from: timeStamp) as NSDate!
        
        let date11 = date1 as! Date
        let date22 = date2 as! Date
        
        var flags = Set<Calendar.Component>([.year])
        var components = calendar.dateComponents(flags, from: date11, to: date22)
        
        if components.year! > 0 {
            let aTime = "\(components.year!) years"
            return aTime as String as NSString
        }
        
        flags =  Set<Calendar.Component>([.month])
        components = calendar.dateComponents(flags, from: date11, to: date22)
        
        if components.month! > 0 {
            let aTime = "\(components.month!) months"
            return aTime as String as NSString
        }
        
        flags =  Set<Calendar.Component>([.day])
        components = calendar.dateComponents(flags, from: date11, to: date22)
        
        
        if components.day! > 0 {
            let aTime = "\(components.day!) days"
            return aTime as String as NSString
        }
        
        flags =  Set<Calendar.Component>([.hour])
        components = calendar.dateComponents(flags, from: date11, to: date22)
        
        if components.hour! > 0 {
            let aTime = "\(components.hour!) hours"
            return aTime as String as NSString
        }
        
        flags =  Set<Calendar.Component>([.minute])
        components = calendar.dateComponents(flags, from: date11, to: date22)
        
        if components.minute! > 0 {
            let aTime = "\(components.minute!) minutes"
            return aTime as String as NSString
        }
        
        flags =  Set<Calendar.Component>([.second])
        components = calendar.dateComponents(flags, from: date11, to: date22)
        
        if components.second! > 0 {
            let aTime = "\(components.second!) seconds"
            return aTime as String as NSString
        }
        
        let aTime = ""
        return aTime as String as NSString
        
    }
    
    func getTimeStampComponentFomDateString(_ receivedDate: NSString) -> NSString!{
        
        let calendar = Calendar.current as Calendar
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
        dateFormatter.timeZone = TimeZone.init(abbreviation: "UTC")
        
        let aDate = Date()
        
        let timeStamp = dateFormatter.string(from: aDate as Date)
        
        let date1 = dateFormatter.date(from: receivedDate as String) as NSDate!
        let date2 = dateFormatter.date(from: timeStamp) as NSDate!
        
        let date11 = date1 as! Date
        let date22 = date2 as! Date
        
        var flags = Set<Calendar.Component>([.year])
        var components = calendar.dateComponents(flags, from: date11, to: date22)
        
        if components.year! > 0 {
            let aTime = "\(components.year!) years"
            return aTime as String as NSString
        }
        
        flags =  Set<Calendar.Component>([.month])
        components = calendar.dateComponents(flags, from: date11, to: date22)
        
        if components.month! > 0 {
            let aTime = "\(components.month!) months"
            return aTime as String as NSString
        }
        
        flags =  Set<Calendar.Component>([.day])
        components = calendar.dateComponents(flags, from: date11, to: date22)
        
        
        if components.day! > 0 {
            let aTime = "\(components.day!) days"
            return aTime as String as NSString
        }
        
        flags =  Set<Calendar.Component>([.hour])
        components = calendar.dateComponents(flags, from: date11, to: date22)
        
        if components.hour! > 0 {
            let aTime = "\(components.hour!) hours"
            return aTime as String as NSString
        }
        
        flags =  Set<Calendar.Component>([.minute])
        components = calendar.dateComponents(flags, from: date11, to: date22)
        
        if components.minute! > 0 {
            let aTime = "\(components.minute!) minutes"
            return aTime as String as NSString
        }
        
        flags =  Set<Calendar.Component>([.second])
        components = calendar.dateComponents(flags, from: date11, to: date22)
        
        if components.second! > 0 {
            let aTime = "\(components.second!) seconds"
            return aTime as String as NSString
        }
        
        let aTime = ""
        return aTime as String as NSString
        
    }
    
    func getTimeStampDenominationComponentFomDateString(_ receivedDate: NSString) -> NSString!{
        
        let calendar = Calendar.current as Calendar
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
        dateFormatter.timeZone = TimeZone.init(abbreviation: "UTC")
        
        let aDate = Date()
        
        let timeStamp = dateFormatter.string(from: aDate as Date)
        let date1 = dateFormatter.date(from: receivedDate as String) as NSDate!
        let date2 = dateFormatter.date(from: timeStamp) as NSDate!
        
        let date11 = date1 as! Date
        let date22 = date2 as! Date
        
        var flags = Set<Calendar.Component>([.year])
        var components = calendar.dateComponents(flags, from: date11, to: date22)
        
        if components.year! > 0 {
            let aTime = "\(components.year!) y"
            return aTime as String as NSString
        }
        
        flags =  Set<Calendar.Component>([.month])
        components = calendar.dateComponents(flags, from: date11, to: date22)
        
        if components.month! > 0 {
            let aTime = "\(components.month!) m"
            return aTime as String as NSString
        }
        
        flags =  Set<Calendar.Component>([.day])
        components = calendar.dateComponents(flags, from: date11, to: date22)
        
        
        if components.day! > 0 {
            let aTime = "\(components.day!) d"
            return aTime as String as NSString
        }
        
        flags =  Set<Calendar.Component>([.hour])
        components = calendar.dateComponents(flags, from: date11, to: date22)
        
        if components.hour! > 0 {
            let aTime = "\(components.hour!) hr"
            return aTime as String as NSString
        }
        
        flags =  Set<Calendar.Component>([.minute])
        components = calendar.dateComponents(flags, from: date11, to: date22)
        
        if components.minute! > 0 {
            let aTime = "\(components.minute!) min"
            return aTime as String as NSString
        }
        
        flags =  Set<Calendar.Component>([.second])
        components = calendar.dateComponents(flags, from: date11, to: date22)
        
        if components.second! > 0 {
            let aTime = "\(components.second!) sec"
            return aTime as String as NSString
        }
        
        let aTime = ""
        return aTime as String as NSString
        
    }
    
    
    func getDateFromString(_ date : String , dateFormat : String) -> Date {
        
        let dateFormatter  = DateFormatter()
        dateFormatter.dateFormat = dateFormat
        dateFormatter.timeZone = TimeZone(identifier: "UTC")
        dateFormatter.locale = Locale(identifier: "en_US_POSIX")
        return dateFormatter.date(from: date)!
        
    }
    
    func getTimeFromString(_ time : String) -> Date {
        
        let dateFormatter  = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd hh:mm:ss"
        dateFormatter.timeZone = TimeZone(identifier: "UTC")
        dateFormatter.locale = Locale(identifier: "en_US_POSIX")
        
        let tempDate = "2010-01-01 \(time):00"
        
        return dateFormatter.date(from: tempDate)!
        
    }
    
    func getStringFromDate(_ format : String , date : Date) -> String {
        
        let dateFormatter  = DateFormatter()
        dateFormatter.dateFormat = format
        //        dateFormatter.timeZone = TimeZone(identifier: "UTC")
        dateFormatter.locale = Locale(identifier: "en_US_POSIX")
        
        return dateFormatter.string(from: date)
    }
    
    func getStringFromUTCDate(_ format : String , date : Date) -> String {
        
        let dateFormatter  = DateFormatter()
        dateFormatter.dateFormat = format
        dateFormatter.timeZone = TimeZone(identifier: "UTC")
        //        dateFormatter.locale = Locale(identifier: "en_US_POSIX")
        
        return dateFormatter.string(from: date)
    }
    
    func getYearFromDate(_ date : Date) -> Int {
        
        let units: Set<Calendar.Component> = [.hour, .day, .month, .year]
        let components = Calendar.current.dateComponents(units, from: date)
        
        let year =  components.year
        
        return year!
    }
    
    
    //MARK: Store any details to User Defaults
    
    func setUserDefault(ObjectToSave : AnyObject?  , KeyToSave : String)
    {
        let defaults = UserDefaults.standard
        
        if (ObjectToSave != nil)
        {
            defaults.set(ObjectToSave, forKey: KeyToSave)
        }
        
        UserDefaults.standard.synchronize()
    }
    
    func getUserDefault(KeyToReturnValye : String) -> AnyObject?
    {
        let defaults = UserDefaults.standard
        
        if let name = defaults.value(forKey: KeyToReturnValye)
        {
            return name as AnyObject?
        }
        return nil
    }
    
    func deleteUserDefault( KeyToDelete : String)
    {
        let defaults = UserDefaults.standard
        defaults.removeObject(forKey: KeyToDelete)
        UserDefaults.standard.synchronize()
    }
    
//    //check internet utility
//    func isNetworkAvailable() -> Bool {
//        
//        var zeroAddress = sockaddr_in()
//        zeroAddress.sin_len = UInt8(MemoryLayout<sockaddr_in>.size)
//        zeroAddress.sin_family = sa_family_t(AF_INET)
//        
//        guard let defaultRouteReachability = withUnsafePointer(to: &zeroAddress, {
//            $0.withMemoryRebound(to: sockaddr.self, capacity: 1) {
//                SCNetworkReachabilityCreateWithAddress(nil, $0)
//            }
//        }) else {
//            return false
//        }
//        
//        var flags: SCNetworkReachabilityFlags = []
//        if !SCNetworkReachabilityGetFlags(defaultRouteReachability, &flags) {
//            return false
//        }
//        
//        let isReachable = flags.contains(.reachable)
//        let needsConnection = flags.contains(.connectionRequired)
//        
//        return (isReachable && !needsConnection)
//    }
    
    //===================
    // Set Notification
    //===================
    
    
}
