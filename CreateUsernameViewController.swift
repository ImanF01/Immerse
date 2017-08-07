//
//  CreateUsernameViewController.swift
//  Immerse
//
//  Created by Iman F on 7/11/17.
//  Copyright © 2017 Iman F (group project). All rights reserved.
//

import UIKit
import FirebaseAuth
import FirebaseDatabase
import SkyFloatingLabelTextField

class CreateUsernameViewController: UIViewController {
    

    @IBOutlet weak var usernameTextField: SkyFloatingLabelTextField!
    @IBOutlet weak var nextButton: UIButton!
    @IBAction func nextButtonTapped(_ sender: UIButton) {
            guard let firUser = Auth.auth().currentUser,
                let username = usernameTextField.text,
                !username.isEmpty else { return }
            
            UserService.create(firUser, username: username) { (user) in
                guard let user = user else
                {
                    return
                }
                
                User.setCurrent(user, writeToUserDefaults: true)
                
                let initialViewController = UIStoryboard.initialViewController(for: .main)
                self.view.window?.rootViewController = initialViewController
                self.view.window?.makeKeyAndVisible()
                
            }
    }
    override func viewDidLoad() {
        super.viewDidLoad()
      //  let usernameTextField = SkyFloatingLabelTextField(frame: CGRectMake(10, 10, 200, 45))
        usernameTextField.placeholder = "username"
        usernameTextField.title = "Your username"
        self.hideKeyboard()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    override func hideKeyboard()
    {
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(
            target: self,
            action: #selector(UIViewController.dismissKeyboard))
        
        view.addGestureRecognizer(tap)
    }
    
    override func dismissKeyboard()
    {
        view.endEditing(true)
    }
    
}
