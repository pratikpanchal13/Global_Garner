//
//  UITextField+customeTextField.swift
//  Global Garner
//
//  Created by Indianic on 04/04/17.
//  Copyright © 2017 Indianic Infotech Pvt. Ltd. All rights reserved.
//

import UIKit

extension UITextField {
    
    //-----------------------------------------------
    //MARK:- Left Padding
    //-----------------------------------------------
    func setLeftPaddingPoints(_ amount:CGFloat){
        let paddingView = UIView(frame: CGRect(x: 0, y: 0, width: amount, height: self.frame.size.height))
        self.leftView = paddingView
        self.leftViewMode = .always
    }
    
    //-----------------------------------------------
    //MARK:- Right Padding
    //-----------------------------------------------
    func setRightPaddingPoints(_ amount:CGFloat) {
        let paddingView = UIView(frame: CGRect(x: 0, y: 0, width: amount, height: self.frame.size.height))
        self.rightView = paddingView
        self.rightViewMode = .always
    }
    
    
    //-----------------------------------------------
    //MARK:- Under Line
    //-----------------------------------------------
    func useUnderline(color:UIColor ,borderWidth : CGFloat) {
        let border = CALayer()
        //        let borderWidth = CGFloat(1.0)
        border.borderColor = color.cgColor
        border.frame = CGRect(origin: CGPoint(x: 0,y :self.frame.size.height - borderWidth), size: CGSize(width: self.frame.size.width, height: self.frame.size.height))
        border.borderWidth = borderWidth
        self.layer.addSublayer(border)
        self.layer.masksToBounds = true
    }
    
    //-----------------------------------------------
    //MARK:- Validation
    //-----------------------------------------------
    func isTextFieldBlank() -> Bool {
        let strText = self.text
        if self.isEmptyString(strText!) {
            self.becomeFirstResponder()
            return true
        }
        return false
    }
    
    func isEmptyString(_ strText: String) -> Bool {
        
        let tempText = strText.trimmingCharacters(in: CharacterSet.whitespaces)
        if tempText.isEmpty {
            return true
        }
        return false
    }
    
    func isValidEmail() -> Bool {
        
        
        let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,}"
        let emailTest = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
        let result = emailTest.evaluate(with: self.text)
        
        if !result {
            self.becomeFirstResponder()
        }
        return result
    }
    
    
    func isValidPhoneNumber() -> Bool {
        
        let numberRegEx = "[+]?[(]?[0-9]{3}[)]?[-\\s]?[0-9]{3}[-\\s]?[0-9]{4,9}"
        let numberPred = NSPredicate(format: "SELF MATCHES %@", numberRegEx)
        let result =  numberPred.evaluate(with: self.text)
        
        if !result {
            self.becomeFirstResponder()
        }
        return result
    }
    
    
    // Password must contain 6 characr or more
    func isValidPassword() -> Bool {
        let strText = self.text!
        if  self.isEmptyString(strText) {
            self.becomeFirstResponder()
            return false
        }
        else if strText.characters.count >= 6 {
            return true
        }
        self.becomeFirstResponder()
        return false
    }
    
    
    
    var count:Int {
        get{
            return self.text?.characters.count ?? 0
        }
        
    }

    
    
}
