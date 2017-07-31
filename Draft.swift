//
//  Draft.swift
//  Immerse
//
//  Created by Iman F on 7/17/17.
//  Copyright © 2017 Iman F (group project). All rights reserved.
//
import UIKit
import Foundation
import FirebaseDatabase
import FirebaseDatabase.FIRDataSnapshot

class Draft {
    var title:String
  //  var thumbnail: UIImage
    var content:String
    var modificationTime = Date()
    var key: String = ""
    var imageURL: String
    
    init(title:String, content:String, key: String, imageURL: String) {
        self.key = key
        self.title = title
        self.content = content
        self.imageURL = imageURL
   //    self.thumbnail = thumnail
        self.modificationTime = Date()
    }
    
    init(title:String, content:String,imageURL: String) {
        self.title = title
        self.content = content
        self.imageURL = imageURL
        self.modificationTime = Date()
    }
    
    init() {
        self.title = ""
        self.content = ""
        self.modificationTime = Date()
        self.imageURL = ""
    }
    
}
