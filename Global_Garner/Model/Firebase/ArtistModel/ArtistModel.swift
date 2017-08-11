//
//  ArtistModel.swift
//  Global_Garner
//
//  Created by indianic on 11/08/17.
//  Copyright © 2017 indianic. All rights reserved.
//

import Foundation



class ArtistModel {
    
    var id: String?
    var name: String?
    var genre: String?
    
    init(id: String?, name: String?, genre: String?){
        self.id = id
        self.name = name
        self.genre = genre
    }
}
