//
//  ExtraInfoViewController.swift
//  Immerse
//
//  Created by Iman F on 8/6/17.
//  Copyright © 2017 Iman F (group project). All rights reserved.
//

import UIKit
import FirebaseDatabase

class ExtraInfoViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    var contentKey: String?
    var titleText: String?
    var urlText: String?
    var descriptionText: String?
    
    var extraInfo = [ExtraInfo]()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
//        self.automaticallyAdjustsScrollViewInsets = false
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    @IBAction func optionsButtonTapped(_ sender: Any) {
        
        let alertController = UIAlertController(title: nil, message: nil, preferredStyle: .actionSheet)
        
        let flagAction = UIAlertAction(title: "Report as Inappropriate", style: .default) { _ in
            let ref = Database.database().reference().child("flagged").child("extra info").childByAutoId()
            ref.setValue(["title" : self.titleText, "url" : self.urlText, "description" : self.descriptionText])
                let okAlert = UIAlertController(title: nil, message: "The post has been flagged.", preferredStyle: .alert)
                okAlert.addAction(UIAlertAction(title: "Ok", style: .default))
                self.present(okAlert, animated: true)
        }
        alertController.addAction(flagAction)
        
    let cancelAction = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
    alertController.addAction(cancelAction)
    present(alertController, animated: true, completion: nil)
    
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        let ref = Database.database().reference().child("publish").child("posts").child(contentKey!).child("extra info")
        ref.observeSingleEvent(of: .value, with: { (snapshot) in
            guard let snapshot = snapshot.children.allObjects as? [DataSnapshot] else {
                return
            }
            print(snapshot)
            self.extraInfo.removeAll()
            
            if snapshot.count > 0 {
                for x in 0...snapshot.count - 1 {
                    let key = snapshot[x].key
                    let snap = snapshot[x].value as! [String: Any]
                    let info = ExtraInfo(title: snap["title"] as! String, url: snap["URL"] as! String, description: snap["description"] as! String, key: key)
                    self.extraInfo.append(info)
                    self.tableView.reloadData()
                }
            }
        })
    }


}
extension ExtraInfoViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return extraInfo.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ExtraInfoTableViewCell", for: indexPath) as! ExtraInfoTableViewCell
        cell.titleLabel.text = extraInfo[indexPath.row].title
        self.titleText = cell.titleLabel.text
        cell.urlLabel.text = extraInfo[indexPath.row].url
        self.urlText = cell.urlLabel.text
        cell.descriptionLabel.text = extraInfo[indexPath.row].description
        self.descriptionText = cell.descriptionLabel.text
        
    return cell
    }
}
