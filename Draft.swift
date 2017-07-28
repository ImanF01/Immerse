//
//  Draft.swift
//  Immerse
//
//  Created by Iman F on 7/17/17.
//  Copyright © 2017 Iman F (group project). All rights reserved.
//

import Foundation
import FirebaseDatabase
import FirebaseDatabase.FIRDataSnapshot

class Draft {
    var title:String
    var content:String
    var modificationTime = Date()
    var key: String = ""
    
    init(title:String, content:String, key: String) {
        self.key = key
        self.title = title
        self.content = content
        self.modificationTime = Date()
    }
    
    init(title:String, content:String) {
        self.title = title
        self.content = content
        self.modificationTime = Date()
    }
    
    init() {
        self.title = ""
        self.content = ""
        self.modificationTime = Date()
    }
    
}
//struct Draft {
//    let title: String!
//    let key: String!
//    let content: String!
//    let addedByUser: String!
//    let modificationTime: Date
//    let itemRef: FIRDatabaseReference?
//    
//    init(content: String, addedbyUser: String, key: String = "", title: String, modificationTime: Date) {
//        self.modificationTime = modificationTime
//        self.key = key
//        self.title = title
//        self.content = content
//        self.itemRef = nil
//        self.addedByUser = addedByUser
//    }
//    
//    init( snapshot: snapshot) {

//        key = snapshot.key
//        itemRef = snapshot.key
//        
//        if let draftContent = snapshot.value["content"] as? String {
//            content = draftContent
//        } else {
//            content = ""
//        }
//        if let draftUser = snapshot.value["addedByUser"] as? String {
//            content = draftUser
//        } else {
//            content = ""
//        }
//        }
//}
