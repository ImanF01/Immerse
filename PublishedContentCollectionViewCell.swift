//
//  PublishedContentCollectionViewCell.swift
//  Immerse
//
//  Created by Iman F on 7/21/17.
//  Copyright © 2017 Iman F (group project). All rights reserved.
//

import UIKit
import Hero

class PublishedContentCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    
    var draft: Draft? {
        didSet {
            guard let draft = draft else { return }
            let title = draft.title
            
            titleLabel.text = title
            titleLabel.heroID = "\(title)title"
            titleLabel.heroModifiers = [.zPosition(4)]
        }
    }
}
