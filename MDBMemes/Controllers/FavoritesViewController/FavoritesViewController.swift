//
//  FavoritesViewController.swift
//  MDBMemes
//
//  Created by Akkshay Khoslaa on 2/24/18.
//  Copyright © 2018 Akkshay Khoslaa. All rights reserved.
//

import UIKit
import PromiseKit
import FirebaseAuth

class FavoritesViewController: UIViewController {
    
    var collectionView: UICollectionView!
    var memes = [Meme]()

    override func viewDidLoad() {
        super.viewDidLoad()

        setupCollectionView()
    }

    func loadFavorites() {
        let userId = Auth.auth().currentUser?.uid
        firstly {
            return User.get(id: userId!)
        }.then { user in
            return Meme.get(ids: user.favoriteMemeIds)
        }.then { Void in
            DispatchQueue.main.async {
                self.collectionView.reloadData()
            }
        }
    }

}
