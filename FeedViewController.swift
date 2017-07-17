//
//  FollowViewController.swift
//  Immerse
//
//  Created by Iman F on 7/12/17.
//  Copyright © 2017 Iman F (group project). All rights reserved.
//

import UIKit
import XLPagerTabStrip

class FeedViewController: UIViewController, IndicatorInfoProvider {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func indicatorInfo(for pagerTabStripController: PagerTabStripViewController) -> IndicatorInfo {
        return IndicatorInfo(title: "Feed")
    }
    
}
