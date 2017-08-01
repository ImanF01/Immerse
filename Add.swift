//
//  ExtraMaterials.swift
//  Immerse
//
//  Created by Iman F on 7/19/17.
//  Copyright © 2017 Iman F (group project). All rights reserved.
//

import Foundation
import UIKit

struct Add {
    var title: String
    let contentURL: String
    var textView: String
    var key: String = ""
    
    init(title: String, textView: String, contentURL: String, key: String) {
        self.title = title
        self.textView = textView
        self.contentURL = contentURL
        self.key = key
    }
    init(title: String, textView: String, contentURL: String) {
        self.title = title
        self.textView = textView
        self.contentURL = contentURL
    }
}
