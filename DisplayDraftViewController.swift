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
import GrowingTextView

class DisplayDraftViewController: UIViewController,UINavigationControllerDelegate, UIImagePickerControllerDelegate
{
    var noteEditing = false
    var key: String?
    var draft: Draft?
    var count = 0
    var imageURL: String?
    var con = [Content]()
    var content: Content?
    @IBOutlet weak var imageView: UIImageView!
    let photoHelper = PhotoHelper()
    @IBOutlet weak var draftTitleTextField: UITextField!
    @IBOutlet weak var textView: GrowingTextView!
    @IBOutlet weak var activityIndicatorView: UIActivityIndicatorView!
    
    
  
    @IBAction func publishButtonTapped(_ sender: Any) {
        count += 1
        let content = Content(title: draftTitleTextField.text!, summary: textView.text, thumbnailURL: (draft?.imageURL)!)
        print(con)
        self.con.append(content)
        
    }
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
    @IBOutlet weak var uploadImage: UIButton!
    @IBAction func uploadImage(_ sender: Any) {
        photoHelper.presentActionSheet(from: self)
        photoHelper.completionHandler = { (image) in
             self.uploadImage.isHidden = true
            self.activityIndicatorView.activityIndicatorViewStyle = .whiteLarge
            self.activityIndicatorView.startAnimating()
            StorageService.uploadImage(image, at: StorageReference.newPostImageReference(), completion: { (downloadURL) in
                guard let downloadURL =  downloadURL else { return }
                let urlString = downloadURL.absoluteString
                self.imageView.image = image
                self.imageURL = urlString
                self.activityIndicatorView.stopAnimating()
                
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
        imageView.kf.setImage(with: imgURL, options: [.transition(.fade(0.2))])
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?)
    {
        if segue.identifier == "save"
        {
            if ((self.imageView.image == nil) || (draftTitleTextField.text?.isEmpty)! || textView.text.isEmpty) {
                let alertController = UIAlertController(title: "Error", message: "Wait for the image to load and fill in the title and summary.", preferredStyle: UIAlertControllerStyle.alert)
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
            if self.noteEditing {
                let ref = Database.database().reference().child("drafts").child(User.current.uid).child(key!)
                ref.setValue([ "title" : draftTitleTextField.text, "text" : textView.text, "thumbnail" : self.imageURL])
            } else {
                if ((self.imageView.image != nil) && !(draftTitleTextField.text?.isEmpty)! && !textView.text.isEmpty) {
                    let ref = Database.database().reference().child("drafts").child(User.current.uid).childByAutoId()
                    ref.setValue([ "title" : draftTitleTextField.text, "text" : textView.text, "thumbnail" : imageURL])
                }
            }
            
            if let draft = draft
            {
                draft.title = draftTitleTextField.text ?? ""
                draft.content = textView.text ?? ""
                draft.imageURL = imageURL ?? ""
                let listDraftTableViewController = segue.destination as! ListDraftTableViewController
                listDraftTableViewController.tableView.reloadData()
            } else
            {
                let newDraft = Draft(title: draftTitleTextField.text ?? "", content: textView.text ?? "", imageURL: imageURL ?? "")
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
