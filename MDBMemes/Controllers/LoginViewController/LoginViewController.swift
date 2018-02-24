//
//  LoginViewController.swift
//  MDBMemes
//
//  Created by Akkshay Khoslaa on 2/24/18.
//  Copyright © 2018 Akkshay Khoslaa. All rights reserved.
//

import UIKit
import FirebaseDatabase
import FirebaseAuth
import FBSDKCoreKit
import FBSDKLoginKit
import PromiseKit

class LoginViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    func loginWithFacebook() -> Promise<AuthCredential> {
        return Promise { fulfill, reject in
            let loginManager = FBSDKLoginManager()
            loginManager.logOut()
            loginManager.logIn(withReadPermissions: ["public_profile", "email", "user_friends"], from: self, handler: { (result, error) -> Void in
                if error != nil {
                    reject(error!)
                } else if result!.isCancelled {
                    reject(NSError.cancelledError())
                } else {
                    let credential = FacebookAuthProvider.credential(withAccessToken: FBSDKAccessToken.current().tokenString)
                    fulfill(credential)
                }
            })
        }
    }


}
