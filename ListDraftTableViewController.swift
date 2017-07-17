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

    override func viewDidLoad() {
        super.viewDidLoad()
    }


    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 10
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "listDraftTableViewCell", for: indexPath) as! ListDraftTableViewCell
        cell.noteTitleLabel.text = "note's title"
        cell.noteModificationTimeLabel.text = "note's modification time"
        
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
