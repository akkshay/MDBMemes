//
//  LoginViewController-SetupUI.swift
//  MDBMemes
//
//  Created by Akkshay Khoslaa on 2/24/18.
//  Copyright © 2018 Akkshay Khoslaa. All rights reserved.
//

import Foundation
import UIKit

extension LoginViewController {
    
    func setupBackground() {
        backgroundImageView = UIImageView(frame: view.frame)
        backgroundImageView.image = UIImage(named: "bg")
        backgroundImageView.contentMode = .scaleAspectFill
        view.addSubview(backgroundImageView)
    }
    
    
    func setupNavBar() {
        self.navigationController?.navigationBar.setBackgroundImage(UIImage(), for: .default)
        self.navigationController?.navigationBar.shadowImage = UIImage()
        self.navigationController?.navigationBar.isTranslucent = true
        self.navigationController?.navigationItem.backBarButtonItem?.title = ""
        self.navigationController?.navigationBar.tintColor = UIColor.white
        self.navigationController?.navigationBar.barStyle = .blackTranslucent
    }
    
    func setupLoginButton() {
        facebookButton = UIButton(frame: CGRect(x: 12, y: view.frame.height - 90, width: view.frame.width - 24, height: 60))
        facebookButton.contentMode = .scaleAspectFill
        facebookButton.clipsToBounds = true
        facebookButton.setImage(UIImage(named: "loginbutton"), for: .normal)
        facebookButton.addTarget(self, action: #selector(loginButtonTapped), for: .touchUpInside)
        self.view.addSubview(facebookButton)
        view.bringSubview(toFront: facebookButton)
    }
}
