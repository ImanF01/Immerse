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
//    var refKey: String?
    var add: Add?
    var imageURL: String?
    @IBOutlet weak var imageView: UIImageView!
    let photoHelper = PhotoHelper()
    @IBOutlet weak var draftTitleTextField: UITextField!
    @IBOutlet weak var textView: GrowingTextView!
    @IBOutlet weak var activityIndicatorView: UIActivityIndicatorView!
    @IBOutlet weak var publishButton: UIBarButtonItem!
    @IBOutlet weak var recommendLabel: UILabel!
    
    @IBAction func publishButtonTapped(_ sender: Any) {
        publishButton.isEnabled = false
        if (draftTitleTextField.text?.isEmpty)! || textView.text.isEmpty || (imageView.image == nil) {
            let alertController = UIAlertController(title: "Wait", message: "Fill in all fields before publishing", preferredStyle: UIAlertControllerStyle.alert)
            let okAction = UIAlertAction(title: "OK", style: UIAlertActionStyle.default) { (result : UIAlertAction) -> Void in
                print("OK")
            }
            let backView = alertController.view.subviews.last?.subviews.last
            backView?.layer.cornerRadius = 10.0
            okAction.setValue(UIColor(red:0.00, green:0.34, blue:0.27, alpha:1.0), forKey: "titleTextColor")
            alertController.addAction(okAction)
            self.present(alertController, animated: true, completion: nil)
        } else {
            publishButton.isEnabled = true
            let ref = Database.database().reference().child("publish").child(User.current.uid).child((draft?.key)!)
            let postRef =  Database.database().reference().child("publish").child("posts").child((self.draft?.key)!)
            if self.imageURL != nil {
                if let title = draftTitleTextField.text, let text = textView.text, let url = self.imageURL {
                        if self.imageURL != nil {
                            ref.setValue([ "title" : title, "text" : text, "thumbnail" : url])
                            postRef.setValue([ "title" : title, "text" : text, "thumbnail" : url])
                        }
                        else
                        {
                            ref.setValue([ "title" : title, "text" : text, "thumbnail" : self.draft?.imageURL ?? ""])
                            postRef.setValue([ "title" : title, "text" : text, "thumbnail" : self.draft?.imageURL])
                        }
                }
            } else {
                if let title = draftTitleTextField.text, let text = textView.text, let url = draft?.imageURL
                {
                    ref.updateChildValues([ "title" : title, "text" : text, "thumbnail" : url], withCompletionBlock: { (error, ref) in
                        if error != nil
                        {
                            print("HI")
                            return
                        }
                        let postRef =  Database.database().reference().child("publish").child("posts").child((self.draft?.key)!)
                        
                        if self.imageURL != nil
                        {
                            ref.setValue([ "title" : self.draftTitleTextField.text, "text" : self.textView.text, "thumbnail" : self.imageURL])
                            postRef.setValue([ "title" : self.draftTitleTextField.text, "text" : self.textView.text, "thumbnail" : self.imageURL])
                        }
                        else
                        {
                            ref.setValue([ "title" : self.draftTitleTextField.text, "text" : self.textView.text, "thumbnail" : self.draft?.imageURL])
                            postRef.setValue([ "title" : self.draftTitleTextField.text, "text" : self.textView.text, "thumbnail" : self.draft?.imageURL])
                        }
                    })
                }
            }
        }
    }
    
    @IBAction func extraInfoButton(_ sender: Any) {
        if (draftTitleTextField.text?.isEmpty)! || textView.text.isEmpty || (imageView.image == nil){
            let alertController = UIAlertController(title: "Wait", message: "Fill in the information before adding supplemental materials about it", preferredStyle: UIAlertControllerStyle.alert)
            let okAction = UIAlertAction(title: "OK", style: UIAlertActionStyle.default) { (result : UIAlertAction) -> Void in
                print("OK")
            }
            let backView = alertController.view.subviews.last?.subviews.last
            backView?.layer.cornerRadius = 10.0
            okAction.setValue(UIColor(red:0.00, green:0.34, blue:0.27, alpha:1.0), forKey: "titleTextColor")
            alertController.addAction(okAction)
            self.present(alertController, animated: true, completion: nil)
        }
    }
    @IBAction func uploadImage(_ sender: Any) {
        photoHelper.presentActionSheet(from: self)
        photoHelper.completionHandler = { (image) in
            self.activityIndicatorView.activityIndicatorViewStyle = .whiteLarge
            self.activityIndicatorView.startAnimating()
            StorageService.uploadImage(image, at: StorageReference.newPostImageReference(), completion: { (downloadURL) in
                guard let downloadURL =  downloadURL else { return }
                let urlString = downloadURL.absoluteString
                self.imageView.image = image
                self.imageURL = urlString
                self.activityIndicatorView.stopAnimating()
                self.recommendLabel.isHidden = !(self.recommendLabel.isHidden)
            })
        }
    }
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        
        draftTitleTextField.text = draft?.title ?? ""
        self.recommendLabel.isHidden = self.recommendLabel.isHidden
        textView.text = draft?.content ?? ""
        self.hideKeyboard()
        draftTitleTextField.tintColor = UIColor(red:0.00, green:0.34, blue:0.27, alpha:1.0)
    }
    
    
    override func viewWillAppear(_ animated: Bool)
    {
        super.viewWillAppear(animated)
        self.recommendLabel.isHidden = !(self.recommendLabel.isHidden)
        let imgURL = URL(string: draft?.imageURL ?? "")
        imageView.kf.setImage(with: imgURL, options: [.transition(.fade(0.2))])
    }
    
    @IBAction func saveButtonTapped(_ sender: Any)
    {
        if ((self.imageView.image == nil) || (draftTitleTextField.text?.isEmpty)! || textView.text.isEmpty)
        {
            let alertController = UIAlertController(title: "Wait", message: "Wait for the image to load and fill in the title and summary", preferredStyle: UIAlertControllerStyle.alert)
            let okAction = UIAlertAction(title: "OK", style: UIAlertActionStyle.default) { (result : UIAlertAction) -> Void in
                print("OK")
            }
            let backView = alertController.view.subviews.last?.subviews.last
            backView?.layer.cornerRadius = 10.0
            okAction.setValue(UIColor(red:0.00, green:0.34, blue:0.27, alpha:1.0), forKey: "titleTextColor")
            alertController.addAction(okAction)
            self.present(alertController, animated: true, completion: nil)
            
        }
        if self.noteEditing
        {
            let ref = Database.database().reference().child("drafts").child(User.current.uid).child(key!)
            if self.imageURL != nil
            {
                ref.setValue([ "title" : draftTitleTextField.text, "text" : textView.text, "thumbnail" : self.imageURL])
            } else
            {
                ref.setValue([ "title" : draftTitleTextField.text, "text" : textView.text, "thumbnail" : draft?.imageURL])
                
            }
        } else {
            if ((self.imageView.image != nil) && !(draftTitleTextField.text?.isEmpty)! && !textView.text.isEmpty)
            {
                let alertController = UIAlertController(title: "Save successful", message: "Your draft has been saved", preferredStyle: UIAlertControllerStyle.alert)
                let backView = alertController.view.subviews.last?.subviews.last
                backView?.layer.cornerRadius = 10.0
                let okAction = UIAlertAction(title: "OK", style: UIAlertActionStyle.default) { (result : UIAlertAction) -> Void in
                    print("OK")
                }
                okAction.setValue(UIColor(red:0.00, green:0.34, blue:0.27, alpha:1.0), forKey: "titleTextColor")
                alertController.addAction(okAction)
                self.present(alertController, animated: true, completion: nil)
                let ref = Database.database().reference().child("drafts").child(User.current.uid).childByAutoId()
                ref.setValue([ "title" : draftTitleTextField.text, "text" : textView.text, "thumbnail" : imageURL])
            }
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?)
    {
        if segue.identifier == "toExtraInfo"
        {
            let destination = segue.destination as! UINavigationController
            let destinationVC = destination.topViewController as! AddMaterialTableViewController
            
            destinationVC.draftKey = key
        }
    }
}

extension UIViewController
{
    func hideKeyboard()
    {
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(
            target: self,
            action: #selector(UIViewController.dismissKeyboard))
        
        view.addGestureRecognizer(tap)
    }
    
    func dismissKeyboard()
    {
        view.endEditing(true)
    }
    
}

