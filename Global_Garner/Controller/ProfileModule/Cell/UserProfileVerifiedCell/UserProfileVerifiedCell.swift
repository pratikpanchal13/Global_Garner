//
//  UserProfileVerifiedCell.swift
//  Global_Garner
//
//  Created by indianic on 11/07/17.
//  Copyright © 2017 indianic. All rights reserved.
//

import UIKit

class UserProfileVerifiedCell: UITableViewCell {

    
    @IBOutlet var lblVerified: UILabel!
    
    @IBOutlet var btnVerified: UIButton!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
