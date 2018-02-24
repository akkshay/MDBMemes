//
//  Meme.swift
//  MDBMemes
//
//  Created by Akkshay Khoslaa on 2/24/18.
//  Copyright © 2018 Akkshay Khoslaa. All rights reserved.
//

import Foundation
import ObjectMapper
import PromiseKit

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
    
    static func get() -> Promise<[Meme]> {
        return RestAPIClient.getMemes()
    }
    
    static func get(ids: [String]) -> Promise<[Meme]> {
        return Promise { fulfill, reject in
            let group = DispatchGroup()
            var memes = [Meme]()
            for id in ids {
                group.enter()
                RestAPIClient.getMeme(id: id).then { meme -> Void in
                    memes.append(meme)
                    group.leave()
                }
            }
            group.notify(queue: DispatchQueue.main, execute: {
                fulfill(memes)
            })
        }
    }
    
    func favorite(userId: String) -> Promise<Meme> {
        return RestAPIClient.favoriteMeme(memeId: memeId!, userId: userId)
    }
    
    
    
}
