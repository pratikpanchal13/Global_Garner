//
//  UtilityUserDefault.swift
//  Global_Garner
//
//  Created by indianic on 23/06/17.
//  Copyright © 2017 indianic. All rights reserved.
//

import Foundation
class UtilityUserDefault
{
    // MARK:- Set UserDefault For Object
    func setUDObject(ObjectToSave : AnyObject?  , KeyToSave : String)
    {
        let defaults = UserDefaults.standard
        
        if (ObjectToSave != nil)
        {
            
            defaults.set(ObjectToSave, forKey: KeyToSave)
        }
        
        UserDefaults.standard.synchronize()
    }
    
    // MARK:- Get UserDefault For Object
    func getUDObject(KeyToReturnValye : String) -> AnyObject?
    {
        let defaults = UserDefaults.standard
        
        if let name = defaults.value(forKey: KeyToReturnValye)
        {
            return name as AnyObject?
        }
        return nil
    }
    
    // MARK:- Delete UserDefault
    func deleteUserDefault( KeyToDelete : String)
    {
        let defaults = UserDefaults.standard
        defaults.removeObject(forKey: KeyToDelete)
        UserDefaults.standard.synchronize()
    }
    
    
    // MARK:- Set UserDefault For BOOL
    func setUDBool(_ newValue: Bool, key: String = #function) {
        UserDefaults.standard.set(newValue, forKey: key)
        UserDefaults.standard.synchronize()
    }
    
    // MARK:- Get UserDefault For BOOL
    func getUDBool(key: String = #function) -> Bool {
        return UserDefaults.standard.bool(forKey: key)
        
    }
    
    
    
    
    
}
