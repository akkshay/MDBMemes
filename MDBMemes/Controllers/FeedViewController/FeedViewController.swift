//
//  FeedViewController.swift
//  MDBMemes
//
//  Created by Akkshay Khoslaa on 2/24/18.
//  Copyright © 2018 Akkshay Khoslaa. All rights reserved.
//

import UIKit
import PromiseKit

class FeedViewController: UIViewController {
    
    var collectionView: UICollectionView!
    var memes = [Meme]()

    override func viewDidLoad() {
        super.viewDidLoad()

        setupCollectionView()
    }
    
    func loadMemes() {
        firstly {
            return Meme.get()
        }.then { retrievedMemes in
            self.memes = retrievedMemes
        }.then {
            DispatchQueue.main.async {
                self.collectionView.reloadData()
            }
        }
    }


}
