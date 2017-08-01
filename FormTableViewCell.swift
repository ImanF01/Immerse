//
//  FormTableViewCell.swift
//  Immerse
//
//  Created by Iman F on 7/25/17.
//  Copyright © 2017 Iman F (group project). All rights reserved.
//

import UIKit
import GrowingTextView


class FormTableViewCell: UITableViewCell {

    @IBOutlet weak var descriptionTextView: GrowingTextView!
    @IBOutlet weak var titleTextView: GrowingTextView!
    @IBOutlet weak var urlLabel: GrowingTextView!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    

}
