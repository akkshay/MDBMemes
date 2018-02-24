//
//  User.swift
//  MDBMemes
//
//  Created by Akkshay Khoslaa on 2/24/18.
//  Copyright © 2018 Akkshay Khoslaa. All rights reserved.
//

import Foundation
import ObjectMapper
import PromiseKit

class User: Mappable {
    
    var userId: String?
    var fullName: String?
    var profPicUrl: String?
    var favoriteMemeIds = [String]()
    var lastUpdated: Date?
    
    required init?(map: Map) {
        
    }
    
    func mapping(map: Map) {
        userId                          <- map["userId"]
        fullName                        <- map["fullName"]
        profPicUrl                      <- map["profPicUrl"]
        favoriteMemeIds                 <- map["favoriteMemeIds"]
        lastUpdated                     <- (map["lastUpdated"], DateTransform())
    }
    
    static func get(id: String) -> Promise<User> {
        return RestAPIClient.getUser(id: id)
    }
    
}
