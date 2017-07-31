//
//  StorageReference+Post.swift
//  Immerse
//
//  Created by Iman F on 7/30/17.
//  Copyright © 2017 Iman F (group project). All rights reserved.
//

import Foundation
import FirebaseStorage

extension StorageReference {
    static let dateFormatter = ISO8601DateFormatter()
    
    static func newPostImageReference() -> StorageReference {
        let uid = User.current.uid
        let timestamp = dateFormatter.string(from: Date())
        
        return Storage.storage().reference().child("posts/\(uid)/\(timestamp).jpg")
    }
}
