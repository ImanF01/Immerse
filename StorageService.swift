//
//  StorageService.swift
//  Immerse
//
//  Created by Iman F on 7/30/17.
//  Copyright © 2017 Iman F (group project). All rights reserved.
//

import Foundation
import FirebaseStorage
import UIKit

struct StorageService {
    static func uploadImage(_ image: UIImage, at reference: StorageReference, completion: @escaping (URL?) -> Void) {
        guard let imageData = UIImageJPEGRepresentation(image,0.05) else {
            return completion(nil)
        }
        reference.putData(imageData,metadata: nil, completion: { (metadata, error) in
            if let error = error {
                assertionFailure(error.localizedDescription)
                return completion(nil)
            }
            completion(metadata?.downloadURL())
        })
    }

}
