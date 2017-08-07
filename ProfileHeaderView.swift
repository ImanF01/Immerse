//
//  ProfileHeaderView.swift
//  Immerse
//
//  Created by Iman F on 8/6/17.
//  Copyright © 2017 Iman F (group project). All rights reserved.
//

import UIKit
import FirebaseDatabase

protocol ProfileHeaderViewDelegate: class {
    func didTapSettingsButton(_ button: UIButton, on headerView: ProfileHeaderView)
}

class ProfileHeaderView: UICollectionReusableView {
        
    @IBOutlet weak var usernameLabel: UILabel!
    @IBOutlet weak var numberOfContributions: UILabel!
    weak var delegate: ProfileHeaderViewDelegate?
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    @IBAction func logOutButtonTapped(_ sender: UIButton) {
        delegate?.didTapSettingsButton(sender, on: self)
    }
}
