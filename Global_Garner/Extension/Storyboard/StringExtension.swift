//
//  StringExtension.swift
//  Global_Garner
//
//  Created by indianic on 16/08/17.
//  Copyright © 2017 indianic. All rights reserved.
//

import Foundation

extension String {
    
    func isEmail() -> Bool {
        do {
            let regex = try NSRegularExpression(pattern: "^[A-Z0-9._%+-]+@[A-Z0-9.-]+\\.[A-Z]+$", options: NSRegularExpression.Options.caseInsensitive)
            return regex.firstMatch(in: self, options: [], range: NSMakeRange(0, self.characters.count)) != nil
        } catch { return false }
    }
    
}
