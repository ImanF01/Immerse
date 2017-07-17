//
//  ListDraftTableViewController.swift
//  Immerse
//
//  Created by Iman F on 7/16/17.
//  Copyright © 2017 Iman F (group project). All rights reserved.
//

import UIKit
import Hero

class ListDraftTableViewController: UITableViewController {
    var drafts = [Draft](){
        didSet {
    tableView.reloadData()
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
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
            } else if identifier == "addDraft" {
                print("+ button tapped")
            }
        }
    }
    @IBAction func unwindToListDraftViewController(_ segue: UIStoryboardSegue) {
        
      
    }
    
}
