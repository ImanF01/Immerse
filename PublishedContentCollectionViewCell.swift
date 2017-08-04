//
//  PublishedContentCollectionViewCell.swift
//  Immerse
//
//  Created by Iman F on 7/21/17.
//  Copyright © 2017 Iman F (group project). All rights reserved.
//

import UIKit
import Hero
import Kingfisher

class PublishedContentCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    
    var content: Content? {
        didSet {
            guard let content = content else { return }
            let title = content.title
            
            titleLabel.text = title
            titleLabel.heroID = "\(title)_title"
            titleLabel.heroModifiers = [.zPosition(4)]
            let url = URL(string: content.thumbnailURL)
            imageView.kf.setImage(with: url)
            imageView.heroID = "\(title)_image"
            imageView.heroModifiers = [.zPosition(2)]
        }
    }

    }
