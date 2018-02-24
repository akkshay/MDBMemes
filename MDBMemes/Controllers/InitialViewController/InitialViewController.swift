//
//  InitialViewController.swift
//  MDBMemes
//
//  Created by Akkshay Khoslaa on 2/24/18.
//  Copyright © 2018 Akkshay Khoslaa. All rights reserved.
//

import UIKit
import FirebaseAuth

class InitialViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

    }

    override func viewDidAppear(_ animated: Bool) {
        if Auth.auth().currentUser?.uid != nil {
            self.performSegue(withIdentifier: "toMain", sender: self)
        } else {
            self.performSegue(withIdentifier: "toLogin", sender: self)
        }
    }


}
