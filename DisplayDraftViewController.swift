//
//  DisplayDraftViewController.swift
//  Immerse
//
//  Created by Iman F on 7/16/17.
//  Copyright © 2017 Iman F (group project). All rights reserved.
//

import UIKit
import RichEditorView

class DisplayDraftViewController: UIViewController {

    @IBOutlet weak var editorView: RichEditorView!
    
    lazy var toolbar: RichEditorToolbar = {
        let toolbar = RichEditorToolbar(frame: CGRect(x: 0, y: 0, width: self.view.bounds.width, height: 44))
        toolbar.options = [RichEditorDefaultOption.bold, RichEditorDefaultOption.italic,RichEditorDefaultOption.undo, RichEditorDefaultOption.redo,RichEditorDefaultOption.orderedList]
        return toolbar
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        editorView.delegate = self as? RichEditorDelegate
        editorView.inputAccessoryView = toolbar
        
        toolbar.delegate = self as? RichEditorToolbarDelegate
        toolbar.editor = editorView
        
        // We will create a custom action that clears all the input text when it is pressed
        let item = RichEditorOptionItem(image: nil, title: "Clear") { toolbar in
            toolbar.editor?.html = ""
        }
        
        var options = toolbar.options
        options.append(item)
        toolbar.options = options
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let identifier = segue.identifier {
            if identifier == "cancel" {
                print("Cancel button tapped")
            } else if identifier == "save" {
                print("Save button tapped")
            }
        }

    }
    
}
