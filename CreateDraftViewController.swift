//
//  CreatePageViewController.swift
//  Immerse
//
//  Created by Iman F on 7/11/17.
//  Copyright © 2017 Iman F (group project). All rights reserved.
//

import UIKit
import RichEditorView

class CreateDraftViewController: UIViewController {
    
    
    @IBOutlet weak var editorView: RichEditorView!
    
    lazy var toolbar: RichEditorToolbar = {
        let toolbar = RichEditorToolbar(frame: CGRect(x: 0, y: 0, width: self.view.bounds.width, height: 44))
        toolbar.options = [RichEditorDefaultOption.bold, RichEditorDefaultOption.undo, RichEditorDefaultOption.redo, RichEditorDefaultOption.italic, RichEditorDefaultOption.underline, RichEditorDefaultOption.indent]
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
    
}


