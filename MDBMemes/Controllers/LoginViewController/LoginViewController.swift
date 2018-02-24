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
    var backgroundImageView: UIImageView!
    var facebookButton: UIButton!
    var progressView: ProgressView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        UIApplication.shared.statusBarStyle = .lightContent
        
        setupNavBar()
        setupBackground()
        setupLoginButton()
        
        progressView = ProgressView()
        
    }
  

    @objc func loginButtonTapped() {
        progressView.show(inView: (navigationController?.view)!)
        firstly {
            return loginWithFacebook()
        }.then { credential in
            return UserAuthHelper.signIn(credential: credential)
        }.then { user in
            return UserAuthHelper.isUserSetup(user: user)
        }.then { isSetup -> Void in
            if isSetup {
                self.loginUser()
            } else {
                self.signupUser()
            }
        }.catch(policy: .allErrors) { error in
            if error.isCancelledError {
                log.info("User cancelled login")
                self.progressView.hideAfter(delay: 0, completion: nil)
            } else {
                log.error("Error during login: \(error.localizedDescription)")
                self.displayBasicAlert(title: "Unable to Sign In", message: error.localizedDescription)
            }
        }
    }
    
    func signupUser() {
        DispatchQueue.main.async {
            self.progressView.displayMessage(text: "Signing Up...")
        }
        firstly {
            return UserAuthHelper.setupNewUser(user: Auth.auth().currentUser)
        }.then { _ -> Void in
            DispatchQueue.main.async {
                self.progressView.hideAfter(delay: 0.75, completion: {
                    self.performSegue(withIdentifier: "toMain", sender: self)
                })
            }
        }.catch { error -> Void in
            log.error("Error during signup: \(error.localizedDescription)")
            self.displayBasicAlert(title: "Unable to Sign Up", message: error.localizedDescription)
        }
    }
    
    func loginUser() {
        DispatchQueue.main.async {
            self.progressView.displayMessage(text: "Logging In...")
            self.progressView.hideAfter(delay: 1.25, completion: {
                self.performSegue(withIdentifier: "toMain", sender: self)
            })
        }
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


extension UIViewController {
    func displayBasicAlert(title: String, message: String) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: UIAlertControllerStyle.alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        self.present(alert, animated: true, completion: nil)
    }
}
