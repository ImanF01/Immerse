//
//  ListDraftTableViewController.swift
//  Immerse
//
//  Created by Iman F on 7/16/17.
//  Copyright © 2017 Iman F (group project). All rights reserved.
//

import UIKit
//import Hero

class ListDraftTableViewController: UITableViewController {
    var drafts = [Draft](){
        didSet {
    tableView.reloadData()
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
//        self.tableView.allowsMultipleSelection = true   multiple selection
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return drafts.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "listDraftTableViewCell", for: indexPath) as! ListDraftTableViewCell
        let row = indexPath.row
        let draft = drafts[row]
//        cell.accessoryType = cell.isSelected ? .checkmark : .none    multiple selection
//        cell.selectionStyle = .none
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
            } else if identifier == "addDraft" {
                print("+ button tapped")
            }
        }
    }
//    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {  multiple selection
//            tableView.cellForRow(at: indexPath)?.accessoryType = .checkmark
//        }
//        
//    override func tableView(_ tableView: UITableView, didDeselectRowAt indexPath: IndexPath) {  multiple selection
//            tableView.cellForRow(at: indexPath)?.accessoryType = .none
//        }
    
//    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
//        let displayDraftViewController = self.storyboard!.instantiateViewController(withIdentifier: "displayDraftTableViewController")
//        let listDraftTableViewController = self.storyboard!.instantiateViewController(withIdentifier: "listDraftTableViewController")
//        listDraftTableViewController.heroModalAnimationType = .uncover(direction: .up)
//        hero_replaceViewController(with: displayDraftViewController)
//    }
    @IBAction func unwindToListDraftViewController(_ segue: UIStoryboardSegue) {
      
    }
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            drafts.remove(at: indexPath.row)
        }
    }
    
}
