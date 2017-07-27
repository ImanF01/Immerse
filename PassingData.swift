//
//  PassingData.swift
//  Immerse
//
//  Created by Iman F on 7/27/17.
//  Copyright © 2017 Iman F (group project). All rights reserved.
//

import Foundation

class PassingData: NSObject {
    var publishedContent = PublishedContentCollectionViewCell()
    
    var stringPassed = ""
//    var displayDraftText = ""
    var titleText = ""
    
    func passingText() -> String {
        titleText = stringPassed
        return titleText
    }

}
