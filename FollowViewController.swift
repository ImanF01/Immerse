//
//  FollowViewController.swift
//  Immerse
//
//  Created by Iman F on 7/12/17.
//  Copyright © 2017 Iman F (group project). All rights reserved.
//

import UIKit

class FollowViewController: UIPageViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        print("Follow View Controller Will Appear")
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        print("Follow View Controller Will Disappear")
    }
  
}
