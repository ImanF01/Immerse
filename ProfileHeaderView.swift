//
//  ProfileHeaderView.swift
//  Immerse
//
//  Created by Iman F on 8/6/17.
//  Copyright © 2017 Iman F (group project). All rights reserved.
//

import UIKit
import FirebaseDatabase

class ProfileHeaderView: UICollectionReusableView {
        
    @IBOutlet weak var usernameLabel: UILabel!
    @IBOutlet weak var numberOfContributions: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
}
