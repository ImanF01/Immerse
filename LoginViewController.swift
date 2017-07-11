//
//  LoginViewController.swift
//  Immerse
//
//  Created by Iman F on 7/10/17.
//  Copyright © 2017 Iman F (group project). All rights reserved.
//

import UIKit
import FirebaseAuth
import FirebaseAuthUI
import FirebaseGoogleAuthUI
import FirebaseDatabase
typealias FIRUser = FirebaseAuth.User

class LoginViewController: UIViewController {
    let user: FIRUser? = Auth.auth().currentUser
   // let data: Any? = snapshot.value
    @IBOutlet weak var loginButton: UIButton!
    @IBAction func loginButtonTapped(_ sender: UIButton) {
        guard let authUI = FUIAuth.defaultAuthUI()
            else { return }
        
        authUI.delegate = self
        let providers: [FUIAuthProvider] = [FUIGoogleAuth()]
        authUI.providers = providers
        
        let authViewController = authUI.authViewController()
        present(authViewController, animated: true)
    }
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}
    extension LoginViewController: FUIAuthDelegate {
        func authUI(_ authUI: FUIAuth, didSignInWith user: FIRUser?, error: Error?) {
            if let error = error {
                assertionFailure("Error signing in: \(error.localizedDescription)")
                return
            }
            guard let user = user
                else { return }
            let userRef = Database.database().reference().child("users").child(user.uid)
            userRef.observeSingleEvent(of: .value, with: { (snapshot) in
                if let user = User(snapshot: snapshot) {
                    print("Welcome back, \(user.username).")
                } else {
                    print("New user!")
                }
            })
        }
}

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */


