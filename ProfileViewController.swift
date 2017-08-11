//
//  ProfileViewController.swift
//  Immerse
//
//  Created by Iman F on 7/11/17.
//  Copyright © 2017 Iman F (group project). All rights reserved.
//

import UIKit
import FirebaseDatabase
import Kingfisher
import FirebaseAuth

class ProfileViewController: UIViewController {
    
    var user: User!
    var trashButton: UIButton!
    var content = [Content]()
    var username: String?
    var contributionCount: Int?
    var authHandle: AuthStateDidChangeListenerHandle?
    @IBOutlet weak var collectionView: UICollectionView!
    
    @IBAction func trashButtonTapped(_ sender: Any) {
        let alertController = UIAlertController(title: "Wait", message: "Are you sure you want to delete your contribution?", preferredStyle: UIAlertControllerStyle.alert)
        let cancelAction = UIAlertAction(title: "Cancel", style: UIAlertActionStyle.cancel) { (result : UIAlertAction) -> Void in
            print("Cancel")
        }
        let okAction = UIAlertAction(title: "OK", style: UIAlertActionStyle.default) { (result : UIAlertAction) -> Void in
            print("OK")
            
            if let cell = (sender as AnyObject).superview??.superview as? ProfileContributionCell {
                let indexPath = self.collectionView.indexPath(for: cell)
                
                let deleteRef = Database.database().reference().child("publish").child("posts").child(self.content[(indexPath?.row)!].key)
                let deleteRef2 = Database.database().reference().child("publish").child(User.current.uid).child(self.content[(indexPath?.row)!].key)
                
                deleteRef.setValue(nil)
                deleteRef2.setValue(nil)
                
                self.content.remove(at: (indexPath?.item)!)
                self.collectionView.reloadData()
            }
        }
        let backView = alertController.view.subviews.last?.subviews.last
        backView?.layer.cornerRadius = 10.0
        okAction.setValue(UIColor(red:0.00, green:0.34, blue:0.27, alpha:1.0), forKey: "titleTextColor")
        cancelAction.setValue(UIColor(red:0.00, green:0.34, blue:0.27, alpha:1.0), forKey: "titleTextColor")
        alertController.addAction(cancelAction)
        alertController.addAction(okAction)
        self.present(alertController, animated: true, completion: nil)

     
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        authHandle = Auth.auth().addStateDidChangeListener() { [unowned self] (auth, user) in
            guard user == nil else { return }
            let loginViewController = UIStoryboard.initialViewController(for: .login)
            self.view.window?.rootViewController = loginViewController
            self.view.window?.makeKeyAndVisible()
        }


    }

    @IBAction func logOutTapped(_ sender: Any) {
        let signOutString  = "Log Out"
        let alertController = UIAlertController(title: nil, message: nil, preferredStyle: .actionSheet)
        
        let signOutAction = UIAlertAction(title: signOutString, style: .default) { _ in
            do {
                try Auth.auth().signOut()
                print("log out user")
            } catch let error as NSError {
                assertionFailure("Error signing out: \(error.localizedDescription)")
            }
        }
        alertController.addAction(signOutAction)
        
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
        cancelAction.setValue(UIColor(red:0.00, green:0.34, blue:0.27, alpha:1.0), forKey: "titleTextColor")
        alertController.addAction(cancelAction)
        present(alertController, animated: true)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        let ref = Database.database().reference().child("publish").child(User.current.uid)
        ref.observeSingleEvent(of: .value, with: { (snapshot) in
            guard let snapshot = snapshot.children.allObjects as? [DataSnapshot] else {
                return
            }
            print(snapshot)
            self.content.removeAll()
            
            if snapshot.count > 0 {
                for x in 0...snapshot.count - 1 {
                    let key = snapshot[x].key
                    let snap = snapshot[x].value as! [String: Any]
                    self.contributionCount = snapshot.count
                    if let contribution = self.contributionCount {
                        _ = Database.database().reference().child("users").child(User.current.uid).updateChildValues(["contribution_count" : "\(contribution)"])
                    }
                    let contentArray = Content(title: snap["title"] as! String, summary: snap["text"] as! String, thumbnailURL: snap["thumbnail"] as! String, key: key)
                    self.content.append(contentArray)
                    self.collectionView.reloadData()
                }
            }
        })
    }
}


extension ProfileViewController: UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return content.count
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ProfileContributionCell", for: indexPath) as! ProfileContributionCell
        
        let url = URL(string: content[indexPath.item].thumbnailURL)
        cell.thumbnailImage.kf.setImage(with: url)
        cell.titleLabel.text = content[indexPath.item].title
        self.trashButton = cell.trashButton
        
        return cell

    }
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        guard kind == UICollectionElementKindSectionHeader else {
            fatalError("Unexpected element kind.")
        }
        let headerView = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: "ProfileHeaderView", for: indexPath) as! ProfileHeaderView
        let ref = Database.database().reference().child("users").child(User.current.uid)
        ref.observe(.value, with: { (snapshot) in
            let value = snapshot.value as? [String : Any]
            print("Username = \(String(describing: value?["username"] as? String))")
            self.username = value?["username"] as? String
            headerView.usernameLabel.text = self.username
        })
        if let contribution = self.contributionCount {
            headerView.numberOfContributions.text = "\(String(describing: contribution))"
        }
        return headerView
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: self.collectionView.frame.size.width, height: 200.0)
    }
}
