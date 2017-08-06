//
//  Content.swift
//  Immerse
//
//  Created by Iman F on 7/21/17.
//  Copyright © 2017 Iman F (group project). All rights reserved.
//

import Foundation
import UIKit
import FirebaseDatabase.FIRDataSnapshot

struct Content {

    var title: String
    var summary: String
    var thumbnailURL: String
    var key: String = ""
    
    init(title: String, summary: String, thumbnailURL: String, key: String) {
        self.title = title
        self.summary = summary
        self.thumbnailURL = thumbnailURL
        self.key = key
    }
    
    init() {
        self.title = ""
        self.summary = ""
        self.thumbnailURL = ""
        self.key = ""
    }

    
    
}
