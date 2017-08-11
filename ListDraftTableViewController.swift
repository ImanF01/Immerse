//
//  ListDraftTableViewController.swift
//  Immerse
//
//  Created by Iman F on 7/16/17.
//  Copyright © 2017 Iman F (group project). All rights reserved.
//


import UIKit
import FirebaseDatabase

class ListDraftTableViewController: UITableViewController {
    var drafts = [Draft](){
        didSet {
            tableView.reloadData()
        }
    }
    var draft: Draft?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        let ref = Database
            .database().reference().child("drafts").child(User.current.uid)
        ref.observeSingleEvent(of: .value, with: { (snapshot) in
            guard let snapshot = snapshot.children.allObjects as? [DataSnapshot] else {
                return
            }
            print(snapshot)
            self.drafts.removeAll()
            if snapshot.count > 0 {
                for x in 0...snapshot.count - 1 {
                    let key = snapshot[x].key
                    let snap = snapshot[x].value as! [String: Any]
                    let draft = Draft(title: snap["title"] as! String, content: snap["text"] as! String, key: key, imageURL: snap["thumbnail"] as! String)
                    self.drafts.append(draft)
                }
            }
        })
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return drafts.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "listDraftTableViewCell", for: indexPath) as! ListDraftTableViewCell
        let row = indexPath.row
        let draft = drafts[row]
        cell.noteTitleLabel.text = draft.title
        cell.noteModificationTimeLabel.text = draft.modificationTime.convertToString()
        
        return cell
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let identifier = segue.identifier {
            if identifier == "displayDraft" {
                print("Table view cell tapped")
                let indexPath = tableView.indexPathForSelectedRow!
                let draft = drafts[indexPath.row]
                let displayDraftViewController = segue.destination as! DisplayDraftViewController
                displayDraftViewController.draft = draft
                displayDraftViewController.noteEditing = true
                displayDraftViewController.key = drafts[indexPath.row].key
                
            } else if identifier == "addDraft" {
                print("+ button tapped")
                let displayDraft = segue.destination as! DisplayDraftViewController
                displayDraft.noteEditing = false
                displayDraft.recommendLabel.isHidden = !(displayDraft.recommendLabel.isHidden)
                
            }
        }
    }
    
    @IBAction func unwindToListDraftViewController(_ segue: UIStoryboardSegue) {
        
    }
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            let key = drafts[indexPath.row].key
            let ref = Database.database().reference().child("drafts").child(User.current.uid).child(key)
            ref.removeValue(completionBlock: { (error, refer) in
                if error != nil {
                    print("error \(String(describing: error))")
                }
                else {
                    print(refer)
                    print("Child Removed Correctly")
                }
            })
            drafts.remove(at: indexPath.row)
        }
    }
}

