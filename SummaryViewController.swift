//
//  SummaryViewController.swift
//  Immerse
//
//  Created by Iman F on 7/24/17.
//  Copyright © 2017 Iman F (group project). All rights reserved.
//

import UIKit
import Hero
import FirebaseDatabase


class SummaryViewController: UIViewController {
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var summaryTextView: UITextView!

    var content: Content?
    var key: String?
    var panGR: UIPanGestureRecognizer!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let ref = Database.database().reference().child("publish").child(User.current.uid).child(key!)
        ref.observeSingleEvent(of: .value, with: { (snapshot) in
            let value = snapshot.value as? [String : Any]
            self.titleLabel.text = value?["title"] as? String
            self.summaryTextView.text = value?["text"] as? String
        })
        
        titleLabel.text = content?.title
        summaryTextView.text = content?.summary
        
        if let content = content {
            let title  = content.title
            titleLabel.heroID = "\(title)_title"
            titleLabel.heroModifiers = [.zPosition(5)]
            summaryTextView.heroID = "\(title)_summary"
            summaryTextView.heroModifiers = [.zPosition(5)]
        }
        
        panGR = UIPanGestureRecognizer(target: self, action: #selector(handlePan(gestureRecognizer:)))
        view.addGestureRecognizer(panGR)
    }
    
    func handlePan(gestureRecognizer:UIPanGestureRecognizer) {
        // calculate the progress based on how far the user moved
        let translation = panGR.translation(in: nil)
        let progress = translation.y / 2 / view.bounds.height
        
        switch panGR.state {
        case .began:
            // begin the transition as normal
            dismiss(animated: true, completion: nil)
        case .changed:
            Hero.shared.update(progress: Double(progress))
            
            // update views' position (limited to only vertical scroll)
            Hero.shared.apply(modifiers: [.position(CGPoint(x:titleLabel.center.x, y:translation.y + summaryTextView.center.y))], to: titleLabel)
            Hero.shared.apply(modifiers: [.position(CGPoint(x:summaryTextView.center.x, y:translation.y + summaryTextView.center.y))], to: summaryTextView)
        default:
            // end or cancel the transition based on the progress and user's touch velocity
            if progress + panGR.velocity(in: nil).y / view.bounds.height > 0.3 {
                Hero.shared.end()
            } else {
                Hero.shared.cancel()
            }
        }
    }
}


