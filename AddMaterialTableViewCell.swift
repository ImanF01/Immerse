//
//  AddMaterialTableViewCell.swift
//  Immerse
//
//  Created by Iman F on 7/19/17.
//  Copyright © 2017 Iman F (group project). All rights reserved.
//

import UIKit

class AddMaterialTableViewCell: UITableViewCell {

    @IBOutlet weak var titleTextField: SkyFloatingLabelTextField!
    @IBOutlet weak var urlTextField: SkyFloatingLabelTextField!
    @IBOutlet weak var descriptionTextView: UITextView!

    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
