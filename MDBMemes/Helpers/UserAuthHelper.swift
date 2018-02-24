//
//  UserAuthHelper.swift
//  MDBMemes
//
//  Created by Akkshay Khoslaa on 2/24/18.
//  Copyright © 2018 Akkshay Khoslaa. All rights reserved.
//

import Foundation
import FirebaseAuth
import FirebaseDatabase
import PromiseKit

class UserAuthHelper {
    
    static func isUserSetup(user: FirebaseAuth.User?) -> Promise<Bool> {
        return RestAPIClient.userExists(id: user!.uid)
    }
    
    static func signIn(credential: AuthCredential) -> Promise<FirebaseAuth.User> {
        return Promise { fulfill, reject in
            Auth.auth().signIn(with: credential) { (user, error) in
                if error != nil {
                    reject(error!)
                } else {
                    fulfill(user!)
                }
            }
        }
    }
    
    static func signOut() {
        try! Auth.auth().signOut()
    }
    
    static func setupNewUser(user: FirebaseAuth.User?) -> Promise<User> {
        return RestAPIClient.createUser(userId: user!.uid, email: user!.email!, fullName: user!.displayName!, profPicUrl: user!.photoURL!.absoluteString, fbId: user!.providerData[0].uid)
    }
    
    
    
}
