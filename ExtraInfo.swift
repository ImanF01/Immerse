//
//  ExtraInfo.swift
//  Immerse
//
//  Created by Iman F on 8/6/17.
//  Copyright © 2017 Iman F (group project). All rights reserved.
//

import Foundation

struct ExtraInfo {
    
    var title: String?
    var url: String?
    var description: String?
    var key: String?
    
    init(title: String, url: String, description: String, key: String) {
        self.title = title
        self.url = url
        self.description = description
        self.key = key
    }
    
    init(title: String, url: String, description: String) {
        self.title = title
        self.url = url
        self.description = description
    }
}
