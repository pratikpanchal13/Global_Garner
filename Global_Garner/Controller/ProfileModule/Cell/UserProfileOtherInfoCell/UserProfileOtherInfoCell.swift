//
//  UserProfileOtherInfoCell.swift
//  Global_Garner
//
//  Created by indianic on 11/07/17.
//  Copyright © 2017 indianic. All rights reserved.
//

import UIKit

class UserProfileOtherInfoCell: UITableViewCell {

    
 
    @IBOutlet var lblEmail: UILabel!
    
    @IBOutlet var lblDOB: UILabel!
    @IBOutlet var lblGender: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
