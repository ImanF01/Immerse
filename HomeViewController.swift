
//  HomeViewController.swift
//  Immerse
//
//  Created by Iman F on 7/11/17.
//  Copyright © 2017 Iman F (group project). All rights reserved.


import UIKit
import Kingfisher
import FirebaseDatabase

class HomeViewController: UIViewController {
    
    @IBOutlet weak var collectionView: UICollectionView!
    static var con = [Content]()
    override func viewDidLoad() {
        super.viewDidLoad()
//        self.hideKeyboard()
    }
   
    override func prepare(for segue: UIStoryboardSegue, sender: Any?)
    {
        let vc = segue.destination as! SummaryViewController
        let indexPath = collectionView.indexPathsForSelectedItems!
        let indexPathInt = indexPath[indexPath.count - 1]
        vc.key = HomeViewController.con[indexPathInt.item].key
    
    }
    
    @IBAction func optionButtonTapped(_ sender: Any) {
        print("option button tapped")
    }
    

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        let ref = Database.database().reference().child("publish").child("posts")
        ref.observeSingleEvent(of: .value, with: { (snapshot) in
            guard let snapshot = snapshot.children.allObjects as? [DataSnapshot] else {
                return
            }
            print(snapshot)
            HomeViewController.con.removeAll()
            
            if snapshot.count > 0 {
                for x in 0...snapshot.count - 1 {
                    let key = snapshot[x].key
                    let snap = snapshot[x].value as! [String: Any]
                    let content = Content(title: snap["title"] as! String, summary: snap["text"] as! String, thumbnailURL: snap["thumbnail"] as! String, key: key)
                    HomeViewController.con.append(content)
                    self.collectionView.reloadData()
                }
            }
        })
    }
//    override func hideKeyboard()
//    {
//        let tap: UITapGestureRecognizer = UITapGestureRecognizer(
//            target: self,
//            action: #selector(UIViewController.dismissKeyboard))
//        
//        view.addGestureRecognizer(tap)
//    }
//    
//    override func dismissKeyboard()
//    {
//        view.endEditing(true)
//    }
    
}
extension HomeViewController: UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout  {
   

    var collectionViewContentSize: CGSize {
        return CGSize(width: 375, height: 200)
    }

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return HomeViewController.con.count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = (collectionView.dequeueReusableCell(withReuseIdentifier: "PublishedContentCollectionViewCell", for: indexPath) as? PublishedContentCollectionViewCell)!
        cell.optionButton.layer.cornerRadius = 2
        cell.optionButton.clipsToBounds = true
        let url = URL(string: HomeViewController.con[indexPath.item].thumbnailURL)
        cell.imageView.kf.setImage(with: url)
        cell.titleLabel.text = HomeViewController.con[indexPath.item].title
        return cell
    }

}
