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
    
    var extraInfo = [ExtraInfo]()
    
    
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
        let ref = Database.database().reference().child("publish").child(User.current.uid).child(contentKey!).child("extra info")
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
    cell.urlLabel.text = extraInfo[indexPath.row].url
    cell.descriptionLabel.text = extraInfo[indexPath.row].description
        
    return cell
    }
}
