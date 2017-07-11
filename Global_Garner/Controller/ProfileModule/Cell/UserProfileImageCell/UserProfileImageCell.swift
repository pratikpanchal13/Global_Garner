//
//  UserProfileImageCell.swift
//  Global_Garner
//
//  Created by indianic on 11/07/17.
//  Copyright © 2017 indianic. All rights reserved.
//

import UIKit

class UserProfileImageCell: UITableViewCell {

    
    @IBOutlet var imgProfile: UIImageView!
    @IBOutlet var imgMap: UIImageView!
    @IBOutlet var lblName: UILabel!
    
    @IBOutlet var lblUserAddress: UILabel!
    
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
