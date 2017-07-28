//
//  DisplayDraftViewController.swift
//  Immerse
//
//  Created by Iman F on 7/16/17.
//  Copyright © 2017 Iman F (group project). All rights reserved.
//

import UIKit
import Firebase
import FirebaseDatabase

class DisplayDraftViewController: UIViewController
{
    var noteEditing = false
    var key: String?
    var draft: Draft?
    var count = 0
    var data = PassingData()
    @IBOutlet weak var draftTitleTextField: UITextField!
    @IBOutlet weak var textView: UITextView!
    
    @IBAction func publishButtonTapped(_ sender: Any) {
        
        count += 1
//        let ref = Database
       }

    override func viewDidLoad()
    {
        super.viewDidLoad()
        draftTitleTextField.tintColor = UIColor(red:0.00, green:0.34, blue:0.27, alpha:1.0)
    }
    override func viewWillAppear(_ animated: Bool)
    {
        super.viewWillAppear(animated)
        draftTitleTextField.text = draft?.title ?? ""
        textView.text = draft?.content ?? ""
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?)
    {
        if segue.identifier == "save"
        {
            if self.noteEditing {
                let ref = Database.database().reference().child("drafts").child(User.current.uid).child(key!)
                ref.setValue([ "title" : draftTitleTextField.text, "text" : textView.text])
            } else {
                let ref = Database.database().reference().child("drafts").child(User.current.uid).childByAutoId()
                ref.setValue([ "title" : draftTitleTextField.text, "text" : textView.text])
            }


            if let draft = draft
            {
                draft.title = draftTitleTextField.text ?? ""
                draft.content = textView.text ?? ""
                let listDraftTableViewController = segue.destination as! ListDraftTableViewController
                listDraftTableViewController.tableView.reloadData()
            } else
            {
                let newDraft = Draft(title: draftTitleTextField.text ?? "", content: textView.text ?? "")
                newDraft.modificationTime = Date()
                let listDraftTableViewController = segue.destination as! ListDraftTableViewController
                //listDraftTableViewController.drafts.append(newDraft)
            }
        } else if segue.identifier == "extraInfo" {
            print("extra info segue clicked")
        
        }
        
    }
}



