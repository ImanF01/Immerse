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

class ProfileViewController: UIViewController {
    var user: User!
    var content = [Content]()
    var username: String?
    var contributionCount: Int?
    @IBOutlet weak var collectionView: UICollectionView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let ref = Database.database().reference().child("users").child(User.current.uid)
        ref.observeSingleEvent(of: .value, with: { (snapshot) in
            let value = snapshot.value as? [String : Any]
            self.username = value?["username"] as? String
        })

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
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
                        let contributionRef = Database.database().reference().child("users").child(User.current.uid).updateChildValues(["contribution_count" : "\(contribution)"])
                    }
                    let contentArray = Content(title: snap["title"] as! String, summary: snap["text"] as! String, thumbnailURL: snap["thumbnail"] as! String, key: key)
                    self.content.append(contentArray)
                    self.collectionView.reloadData()
                }
            }
        })
    }
}


extension ProfileViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return content.count
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ProfileContributionCell", for: indexPath) as! ProfileContributionCell
        
        let url = URL(string: content[indexPath.item].thumbnailURL)
        cell.thumbnailImage.kf.setImage(with: url)
        cell.titleLabel.text = content[indexPath.item].title
        
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
}
extension ProfileViewController: ProfileHeaderViewDelegate {
    func didTapSettingsButton(_ button: UIButton, on headerView: ProfileHeaderView) {
        let alertController = UIAlertController(title: nil, message: nil, preferredStyle: .actionSheet)
        
        let signOutAction = UIAlertAction(title: "Sign Out", style: .default) { _ in
            print("log out user")
        }
        alertController.addAction(signOutAction)
        
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
        alertController.addAction(cancelAction)
        
        present(alertController, animated: true)
    }
}
