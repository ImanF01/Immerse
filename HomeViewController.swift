
//  HomeViewController.swift
//  Immerse
//
//  Created by Iman F on 7/11/17.
//  Copyright © 2017 Iman F (group project). All rights reserved.


import UIKit
import Hero
import Kingfisher

class HomeViewController: UIViewController {
    
    @IBOutlet weak var collectionView: UICollectionView!
    
    var con = [Content]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
//        print("Content = \(content)")
    }
   

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        //     if let currentCell = sender as? PublishedContentCollectionViewCell,
        //            let vc = segue.destination as? SummaryViewController {
        //            vc.city = currentCell.city
    }
}
extension HomeViewController: UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return con.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = (collectionView.dequeueReusableCell(withReuseIdentifier: "PublishedContentCollectionViewCell", for: indexPath) as? PublishedContentCollectionViewCell)!
        cell.content = con[indexPath.item]
//        cell?.titleLabel.text = con.title
//        let url = URL(string: con.thumbnailURL)
//        cell?.imageView.kf.setImage(with: url)
        return cell
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: view.bounds.width, height: view.bounds.height / CGFloat(con.count))
    }
}
