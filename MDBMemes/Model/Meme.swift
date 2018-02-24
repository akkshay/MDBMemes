//
//  Meme.swift
//  MDBMemes
//
//  Created by Akkshay Khoslaa on 2/24/18.
//  Copyright © 2018 Akkshay Khoslaa. All rights reserved.
//

import Foundation
import ObjectMapper

class Meme: Mappable {
    
    var memeId: String?
    var posterId: String?
    var imageUrl: String?
    var favoriteIds = [String]()
    var lastUpdated: Date?
    
    required init?(map: Map) {
        
    }
    
    func mapping(map: Map) {
        memeId                          <- map["memeId"]
        posterId                        <- map["posterId"]
        imageUrl                        <- map["imageUrl"]
        favoriteIds                     <- map["favoriteIds"]
        lastUpdated                     <- (map["lastUpdated"], DateTransform())
    }
    
}
