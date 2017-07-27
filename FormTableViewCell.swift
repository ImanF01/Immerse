//
//  FormTableViewCell.swift
//  Immerse
//
//  Created by Iman F on 7/25/17.
//  Copyright © 2017 Iman F (group project). All rights reserved.
//

import UIKit
import SkyFloatingLabelTextField

class FormTableViewCell: UITableViewCell {

    @IBOutlet weak var descriptionTextView: UITextView!
    
    @IBOutlet weak var titleTextField: UITextView!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
