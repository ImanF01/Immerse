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
import Kingfisher

class DisplayDraftViewController: UIViewController,UINavigationControllerDelegate, UIImagePickerControllerDelegate
{
    var noteEditing = false
    var key: String?
    var draft: Draft?
    var count = 0
    static var imageURL: String?
    var con = [Content]()
    var content: Content?
    @IBOutlet weak var imageView: UIImageView!
    let photoHelper = PhotoHelper()
    @IBOutlet weak var draftTitleTextField: UITextField!
    @IBOutlet weak var textView: UITextView!
    
    @IBAction func publishButtonTapped(_ sender: Any) {
        count += 1
        if let title = draftTitleTextField.text, let summary = textView.text, let url = draft?.imageURL {
        let content = Content(title: title, summary: summary, thumbnailURL: url)
        print(con)
        self.con.append(content)
        }
    }
    @IBOutlet weak var extraInfo: UIButton!
    @IBAction func extraInfoButton(_ sender: Any) {
        if (draftTitleTextField.text?.isEmpty)! && textView.text.isEmpty {
            let alertController = UIAlertController(title: "Error", message: "Fill in the title and summary before continuing.", preferredStyle: UIAlertControllerStyle.alert)
            let cancelAction = UIAlertAction(title: "Cancel", style: UIAlertActionStyle.cancel) { (result : UIAlertAction) -> Void in
                print("Cancel")
            }
            let okAction = UIAlertAction(title: "OK", style: UIAlertActionStyle.default) { (result : UIAlertAction) -> Void in
                print("OK")
            }
            alertController.addAction(cancelAction)
            alertController.addAction(okAction)
            self.present(alertController, animated: true, completion: nil)
        }
    }
    @IBAction func uploadImage(_ sender: Any) {
        photoHelper.presentActionSheet(from: self)
        photoHelper.completionHandler = { (image) in
            StorageService.uploadImage(image, at: StorageReference.newPostImageReference(), completion: { (downloadURL) in
                guard let downloadURL =  downloadURL else { return }
                let urlString = downloadURL.absoluteString
                self.imageView.image = image
                DisplayDraftViewController.imageURL = urlString
                
            })
        }
    }
    override func viewDidLoad()
    {
        super.viewDidLoad()
        draftTitleTextField.text = draft?.title ?? ""
        textView.text = draft?.content ?? ""
        self.hideKeyboard()
        draftTitleTextField.tintColor = UIColor(red:0.00, green:0.34, blue:0.27, alpha:1.0)
    }

    override func viewWillAppear(_ animated: Bool)
    {
        super.viewWillAppear(animated)

        let imgURL = URL(string: draft?.imageURL ?? "")
        imageView.kf.setImage(with: imgURL)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?)
    {
        if segue.identifier == "save"
        {
            if self.noteEditing {
                let ref = Database.database().reference().child("drafts").child(User.current.uid).child(key!)
//                let draftURL = draft.ima
                ref.setValue([ "title" : draftTitleTextField.text, "text" : textView.text, "thumbnail" : draft?.imageURL])
            } else {
                let ref = Database.database().reference().child("drafts").child(User.current.uid).childByAutoId()
                ref.setValue([ "title" : draftTitleTextField.text, "text" : textView.text, "thumbnail" : DisplayDraftViewController.imageURL])
            }
            
            
            if let draft = draft
            {
                draft.title = draftTitleTextField.text ?? ""
                draft.content = textView.text ?? ""
                draft.imageURL = DisplayDraftViewController.imageURL ?? ""
                let listDraftTableViewController = segue.destination as! ListDraftTableViewController
                listDraftTableViewController.tableView.reloadData()
            } else
            {
                let newDraft = Draft(title: draftTitleTextField.text ?? "", content: textView.text ?? "", imageURL: DisplayDraftViewController.imageURL ?? "")
                newDraft.modificationTime = Date()
            }
        } else if segue.identifier == "toExtraInfo" {
            let destination = segue.destination as! UINavigationController
            let destinationVC = destination.topViewController as! AddMaterialTableViewController
            destinationVC.draft = draft
            print("extra info segue clicked")
            
        }
        
    }
    override func hideKeyboard()
    {
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(
            target: self,
            action: #selector(UIViewController.dismissKeyboard))
        
        view.addGestureRecognizer(tap)
    }
    
    override func dismissKeyboard()
    {
        view.endEditing(true)
    }
    
}
