//
//  PostService.swift
//  Immerse
//
//  Created by Iman F on 7/30/17.
//  Copyright © 2017 Iman F (group project). All rights reserved.
//

import UIKit
import FirebaseStorage
import FirebaseDatabase

//struct PostService {
//    static func create(for image: UIImage) {
//        let imageRef = StorageReference.newPostImageReference()
//        StorageService.uploadImage(image, at: imageRef) { (downloadURL) in
//            guard let downloadURL = downloadURL else {
//                return
//            }
//            
//            let urlString = downloadURL.absoluteString
//            let aspectHeight = image.aspectHeight
//            create(forURLString: urlString, aspectHeight: aspectHeight)
//        }
//    }
//    private static func create(forURLString urlString: String, aspectHeight: CGFloat) {
//        let currentUser = User.current
//        let post = Post(imageURL: urlString, imageHeight: aspectHeight)
//        let dict = post.dictValue
//        let postRef = Database.database().reference().child("drafts").child(currentUser.uid).child("thumbnail").childByAutoId()
//        postRef.updateChildValues(dict)
//    }
//}