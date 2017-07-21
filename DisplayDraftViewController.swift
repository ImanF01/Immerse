//
//  DisplayDraftViewController.swift
//  Immerse
//
//  Created by Iman F on 7/16/17.
//  Copyright © 2017 Iman F (group project). All rights reserved.
//

import UIKit
import RichEditorView
import Firebase

class DisplayDraftViewController: UIViewController
{
    var draft: Draft?
//    @IBOutlet weak var editorView: RichEditorView!
    @IBOutlet weak var draftTitleTextField: UITextField!
    @IBOutlet weak var textView: UITextView!
//    lazy var toolbar: RichEditorToolbar = {
//        let toolbar = RichEditorToolbar(frame: CGRect(x: 0, y: 0, width: self.view.bounds.width, height: 44))
//        toolbar.options = [RichEditorDefaultOption.bold, RichEditorDefaultOption.italic,RichEditorDefaultOption.undo, RichEditorDefaultOption.redo,RichEditorDefaultOption.orderedList]
//        return toolbar
//    }()
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        draftTitleTextField.tintColor = UIColor(red:0.00, green:0.34, blue:0.27, alpha:1.0)

//        editorView.delegate = self
//        editorView.inputAccessoryView = toolbar
//        
//        toolbar.delegate = self as? RichEditorToolbarDelegate
//        toolbar.editor = editorView
//        
//        let item = RichEditorOptionItem(image: nil, title: "Clear") { toolbar in
//         toolbar.editor?.html = ""
//        }
//        
//        var options = toolbar.options
//        options.append(item)
//        toolbar.options = options
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
            let ref = Database.database().reference().child("notes").childByAutoId()
            ref.setValue(["title": draftTitleTextField.text, "text": textView.text])
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
                listDraftTableViewController.drafts.append(newDraft)
            }
        } else if segue.identifier == "extraInfo" {
            print("extra info segue clicked")
        
        }
        
    }
}
//extension DisplayDraftViewController: RichEditorDelegate {
//
//    func richEditor(_ editor: RichEditorView, contentDidChange content: String) {
//        if content.isEmpty {
//            textView.text = ""
//        } else {
//            textView.text = content
//            
//        }
//    }
//}



