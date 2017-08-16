//
//  ContactEntry.swift
//  Global_Garner
//
//  Created by indianic on 16/08/17.
//  Copyright © 2017 indianic. All rights reserved.
//

import UIKit
import Foundation
import Contacts

class ContactEntry : NSObject{
    
    var name:String!
    var email:String?
    var phone:String?
    var image:UIImage?
    
    init(name:String, email:String? , phone:String?, image:UIImage?) {
        self.name = name
        self.email = email
        self.phone = phone
        self.image = image
    }
    
    init?(cnContact : CNContact)
    {
        //Name
        if !cnContact.isKeyAvailable(CNContactGivenNameKey) && !cnContact.isKeyAvailable(CNContactFamilyNameKey) { return nil }
        self.name = (cnContact.givenName + " " + cnContact.familyName).trimmingCharacters(in: .whitespaces)
        
        //Image
        self.image = (cnContact.isKeyAvailable(CNContactImageDataKey) && cnContact.imageDataAvailable ) ? UIImage(data: cnContact.imageData!) : nil
        
        //Email
        if cnContact.isKeyAvailable(CNContactEmailAddressesKey) {
            
            for possibleEmail in cnContact.emailAddresses
            {
                let properEmail = possibleEmail.value as String
                if properEmail.isEmail()
                {
                    self.email = properEmail;
                    break
                }
            }
        }
        
        //Phone
        if cnContact.isKeyAvailable(CNContactPhoneNumbersKey)
        {
            if cnContact.phoneNumbers.count > 0
            {
                let phone  = cnContact.phoneNumbers.first?.value
                self.phone = phone?.stringValue
            }
        }
        
        
    }
}
