//
//  ExtraInfoTableViewCell.swift
//  Immerse
//
//  Created by Iman F on 8/6/17.
//  Copyright © 2017 Iman F (group project). All rights reserved.
//

import UIKit

class ExtraInfoTableViewCell: UITableViewCell {

    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var urlLabel: UITextView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
