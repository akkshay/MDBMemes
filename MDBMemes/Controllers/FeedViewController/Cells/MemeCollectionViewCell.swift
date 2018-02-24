//
//  MemeCollectionViewCell.swift
//  MDBMemes
//
//  Created by Akkshay Khoslaa on 2/24/18.
//  Copyright © 2018 Akkshay Khoslaa. All rights reserved.
//

import Foundation
import UIKit

protocol MemeCollectionViewCellDelegate {
    func favorite(meme: Meme)
}

class MemeCollectionViewCell: UICollectionViewCell {
    
    var memeImageView: UIImageView!
    var favoriteButton: UIButton!
    var numFavoritesLabel: UILabel!
    
    var meme: Meme!
    var delegate: MemeCollectionViewCellDelegate?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        memeImageView = UIImageView(frame: CGRect(x: 0, y: 0, width: contentView.frame.width, height: 200))
        memeImageView.contentMode = .scaleAspectFill
        memeImageView.clipsToBounds = true
        contentView.addSubview(memeImageView)
        
        favoriteButton = UIButton(frame: CGRect(x: 20, y: memeImageView.frame.maxY + 10, width: 30, height: 30))
        favoriteButton.setTitle("Favorite!", for: .normal)
        favoriteButton.addTarget(self, action: #selector(favoriteButtonTapped(sender:)), for: .touchUpInside)
        contentView.addSubview(favoriteButton)
        
        numFavoritesLabel = UILabel(frame: CGRect(x: favoriteButton.frame.maxX + 30, y: favoriteButton.frame.minY, width: 100, height: favoriteButton.frame.height))
        numFavoritesLabel.font = UIFont(name: "SFUIText-Regular", size: 15)
        contentView.addSubview(numFavoritesLabel)
    }
    
    @objc func favoriteButtonTapped(sender: UIButton) {
        delegate?.favorite(meme: meme)
    }
    
    
    
}
