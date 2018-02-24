//
//  RestAPIClient-Meme.swift
//  MDBMemes
//
//  Created by Akkshay Khoslaa on 2/24/18.
//  Copyright © 2018 Akkshay Khoslaa. All rights reserved.
//

import Foundation
import Alamofire
import SwiftyJSON
import PromiseKit

extension RestAPIClient {
    static func getMeme(id: String) -> Promise<Meme> {
        return Promise { fulfill, reject in
            after(interval: 10).then { _ -> Void in
                reject(RequestTimedOutError.requestTimedOut)
            }
            let endpoint = Constants.apiUrl + "memes?memeId=\(id)"
            Alamofire.request(endpoint).responseJSON().then { response -> Void in
                let json = JSON(response)
                log.info("Response: \(json.description)")
                if let result = json["result"].dictionaryObject {
                    if let meme = Meme(JSON: result) {
                        fulfill(meme)
                    }
                }
                }.catch { error in
                    log.error(error.localizedDescription)
                    reject(error)
            }
        }
    }
    
    static func getMemes() -> Promise<[Meme]> {
        return Promise { fulfill, reject in
            after(interval: 10).then { _ -> Void in
                reject(RequestTimedOutError.requestTimedOut)
            }
            let endpoint = Constants.apiUrl + "memes?recent=true"
            Alamofire.request(endpoint).responseJSON().then { response -> Void in
                let json = JSON(response)
                log.info("Response: \(json.description)")
                if let result = json["result"].array {
                    var memes = [Meme]()
                    for dict in result {
                        if let meme = Meme(JSON: dict.dictionaryObject!) {
                            memes.append(meme)
                        }
                    }
                    fulfill(memes)
                }
                }.catch { error in
                    log.error(error.localizedDescription)
                    reject(error)
            }
        }
    }
    
    static func favoriteMeme(memeId: String, userId: String) -> Promise<Meme> {
        return Promise { fulfill, reject in
            
        }
    }
    

    
}
