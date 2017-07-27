
//  HomeViewController.swift
//  Immerse
//
//  Created by Iman F on 7/11/17.
//  Copyright © 2017 Iman F (group project). All rights reserved.


import UIKit
import Hero

class HomeViewController: UIViewController {
    
    @IBOutlet weak var collectionView: UICollectionView!
    var content = [Content]() {
        didSet {
            collectionView.reloadData()
        }
    }
    var stringPassed = ""
//    var data = PassingData()
    
    override func viewDidLoad() {
        
    }
   

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
   //     if let currentCell = sender as? PublishedContentCollectionViewCell,
//            let vc = segue.destination as? SummaryViewController {
//            vc.city = currentCell.city
        }
}
extension HomeViewController: UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "PublishedContentCollectionViewCell", for: indexPath) as? PublishedContentCollectionViewCell
//       cell?.content = content[indexPath.item]
        cell?.titleLabel.text = stringPassed
        print("The title is \(String(describing: cell?.titleLabel.text))")
        return cell!
    }
    
//    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
//        return CGSize(width: view.bounds.width, height: view.bounds.height / CGFloat(cities.count))
//    }
}
