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
//    var index: IndexPath!
    var authHandle: AuthStateDidChangeListenerHandle?
    @IBOutlet weak var collectionView: UICollectionView!
    
    @IBAction func trashButtonTapped(_ sender: Any) {
//        let buttonPosition:CGPoint = (sender as AnyObject).convertPoint((sender as AnyObject).bounds.origin, toView: self.collectionView)
//        let indexPath = self.collectionView.indexPathForItem(at: buttonPosition)
       
        let alertController = UIAlertController(title: "Wait", message: "Are you sure you want to delete your contribution?", preferredStyle: UIAlertControllerStyle.alert)
        let cancelAction = UIAlertAction(title: "Cancel", style: UIAlertActionStyle.cancel) { (result : UIAlertAction) -> Void in
            print("Cancel")
        }
        let okAction = UIAlertAction(title: "OK", style: UIAlertActionStyle.default) { (result : UIAlertAction) -> Void in
            print("OK")
            if let cell = (sender as AnyObject).superview??.superview as? ProfileContributionCell {
                let indexPath = self.collectionView.indexPath(for: cell)
        
                self.content.remove(at: (indexPath?.item)!)
                self.collectionView.reloadData()
            }
        }
        alertController.addAction(cancelAction)
        alertController.addAction(okAction)
        self.present(alertController, animated: true, completion: nil)

     
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        let ref = Database.database().reference().child("users").child(User.current.uid)
        ref.observeSingleEvent(of: .value, with: { (snapshot) in
            let value = snapshot.value as? [String : Any]
            self.username = value?["username"] as? String
        })
        
        authHandle = Auth.auth().addStateDidChangeListener() { [unowned self] (auth, user) in
            guard user == nil else { return }
            let loginViewController = UIStoryboard.initialViewController(for: .login)
            self.view.window?.rootViewController = loginViewController
            self.view.window?.makeKeyAndVisible()
        }


    }

    @IBAction func logOutTapped(_ sender: Any) {
        let alertController = UIAlertController(title: nil, message: nil, preferredStyle: .actionSheet)
        
        let signOutAction = UIAlertAction(title: "Sign Out", style: .default) { _ in
            do {
                try Auth.auth().signOut()
                print("log out user")
            } catch let error as NSError {
                assertionFailure("Error signing out: \(error.localizedDescription)")
            }
        }
        alertController.addAction(signOutAction)
        
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
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


extension ProfileViewController: UICollectionViewDataSource, UICollectionViewDelegate {
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
        headerView.usernameLabel.text = self.username
        if let contribution = self.contributionCount {
            headerView.numberOfContributions.text = "\(String(describing: contribution))"
        }
        return headerView
    }
//    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
//        print(indexPath)
//        
//        self.index = indexPath
//    }
}
