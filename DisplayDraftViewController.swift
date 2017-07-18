//
//  DisplayDraftViewController.swift
//  Immerse
//
//  Created by Iman F on 7/16/17.
//  Copyright © 2017 Iman F (group project). All rights reserved.
//

import UIKit
import RichEditorView

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
//        
//        editorView.delegate = self
//            as? RichEditorDelegate
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
        let listDraftTableViewController = segue.destination as! ListDraftTableViewController
        if segue.identifier == "save"
        {
            if let draft = draft
            {
                draft.title = draftTitleTextField.text ?? ""
                draft.content = textView.text ?? ""
                listDraftTableViewController.tableView.reloadData()
            } else
            {
                let newDraft = Draft()
                newDraft.title = draftTitleTextField.text ?? ""
                newDraft.content = textView.text ?? ""
                newDraft.modificationTime = Date()
                listDraftTableViewController.drafts.append(newDraft)
            }
        }
    }
}
//extension DisplayDraftViewController: RichEditorDelegate {
    
//    func richEditor(_ editor: RichEditorView, contentDidChange content: String) {
//        if content.isEmpty {
//            textView.text = ""
//        } else {
//            textView.text = content
//            
//        }
//    }




