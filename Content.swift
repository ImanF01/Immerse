//
//  Content.swift
//  Immerse
//
//  Created by Iman F on 7/21/17.
//  Copyright © 2017 Iman F (group project). All rights reserved.
//

import Foundation
import UIKit

struct Content {
    
    var draft: Draft?
    var title: String
    var summary: String
    var image: UIImage
    let uid: String
    
    init(title: String, summary: String, image: UIImage, uid: String) {
        self.title = (draft?.title)!
        self.summary = (draft?.content)!
        self.image = image
        self.uid = uid 
    }
    
}
