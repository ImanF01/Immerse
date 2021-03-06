//
//  AddMaterialTableViewController.swift
//  Immerse
//
//  Created by Iman F on 7/19/17.
//  Copyright © 2017 Iman F (group project). All rights reserved.
//
import UIKit
import Firebase
import FirebaseDatabase
import GrowingTextView

class AddMaterialTableViewController: UITableViewController, GrowingTextViewDelegate {
    var titleText: String?
    var descriptionText: String?
    var urlText: String?
    var isEditMode = false
    var editIndex = -1
    var key: String?
    var indexPath: Int?
    var draftKey: String?
    var add: Add?
    var draft: Draft?
    var addition = [Add](){
        didSet {
            tableView.reloadData()
        }
    }
    
    @IBOutlet weak var publishButton: UIBarButtonItem!
    //        if let descriptionText = self.descriptionText, let titleText = self.titleText, let urlText = self.urlText
    //        {
    //            if (descriptionText.isEmpty || titleText.isEmpty || urlText.isEmpty)
    //            {
    //                publishButton.isEnabled = false
    //                let alertController = UIAlertController(title: "Wait", message: "Fill in all fields before publishing", preferredStyle: UIAlertControllerStyle.alert)
    //                let cancelAction = UIAlertAction(title: "Cancel", style: UIAlertActionStyle.cancel) { (result : UIAlertAction) -> Void in
    //                    print("Cancel")
    //                }
    //                let okAction = UIAlertAction(title: "OK", style: UIAlertActionStyle.default) { (result : UIAlertAction) -> Void in
    //                    print("OK")
    //                }
    //                alertController.addAction(cancelAction)
    //                alertController.addAction(okAction)
    //                self.present(alertController, animated: true, completion: nil)
    //            }
    //        }
    //        else {
    //        publishButton.isEnabled = true
    @IBAction func publishButtonTapped(_ sender: Any){
        if let descriptionText = self.descriptionText, let titleText = self.titleText, let urlText = self.urlText {
            let ref = Database.database().reference().child("publish").child("posts")
            
                ref.observeSingleEvent(of: .value, with: { (snapshot) in
                    
                    if !(snapshot.hasChild(self.draftKey!)) {
                        let alertController = UIAlertController(title: "Wait", message: "Before publishing extra info, publish your summary first", preferredStyle: UIAlertControllerStyle.alert)
                        let cancelAction = UIAlertAction(title: "Cancel", style: UIAlertActionStyle.cancel) { (result : UIAlertAction) -> Void in
                            print("Cancel")
                        }
                        let okAction = UIAlertAction(title: "OK", style: UIAlertActionStyle.default) { (result : UIAlertAction) -> Void in
                            print("OK")
                        }
                        let backView = alertController.view.subviews.last?.subviews.last
                        backView?.layer.cornerRadius = 10.0
                        okAction.setValue(UIColor(red:0.00, green:0.34, blue:0.27, alpha:1.0), forKey: "titleTextColor")
                        alertController.addAction(okAction)
                        
                        cancelAction.setValue(UIColor(red:0.00, green:0.34, blue:0.27, alpha:1.0), forKey: "titleTextColor")
                        alertController.addAction(cancelAction)
                        self.present(alertController, animated: true, completion: nil)

                    }
                    else {
                        let ref = Database.database().reference().child("publish").child(User.current.uid).child(self.draftKey!).child("extra info").child(self.key!)
                        let postRef = Database.database().reference().child("publish").child("posts").child(self.draftKey!).child("extra info").child(self.key!)
                        
                        ref.setValue(["title" : titleText, "description" : descriptionText, "URL" : urlText])
                        postRef.setValue(["title" : titleText, "description" : descriptionText, "URL" : urlText])
                    }
                })
            }
        }
    
    
    
    @IBAction func plusButtonTapped(_ sender: Any) {
        let indexPath = IndexPath(row: 0, section: 0)
        let cell = tableView.cellForRow(at: indexPath) as! FormTableViewCell
        cell.titleTextView.text = ""
        cell.descriptionTextView.text = ""
        cell.urlLabel.text = ""
        if let descriptionText = self.descriptionText, let titleText = self.titleText, let urlText = self.urlText
        {
            if (!(descriptionText.isEmpty) || !(titleText.isEmpty) || !(urlText.isEmpty))
            {
                self.descriptionText = ""
                self.titleText = ""
                self.urlText = ""
            }
        }
        isEditMode = false
        
    }
    @IBAction func saveButtonTapped(_ sender: Any) {
        if !isEditMode {
            if let descriptionText = self.descriptionText, let titleText = self.titleText, let urlText = self.urlText {
                let newRef = Database.database().reference().child("drafts").child(User.current.uid).child(draftKey!).child("extra info").childByAutoId()
                newRef.setValue(["title" : titleText, "description" : descriptionText, "URL" : urlText])
                
                if (!(descriptionText.isEmpty) && !(titleText.isEmpty) && !(urlText.isEmpty)) {
                    let keyRef = Database.database().reference().child("drafts").child(User.current.uid).child(draftKey!).child("extra info")
                    keyRef.observeSingleEvent(of: .value, with: { (snapshot) in
                        guard let snapshot = snapshot.children.allObjects as?
                            [DataSnapshot] else {
                                return
                        }
                        let key = snapshot[snapshot.count - 1].key
                        self.add = Add(title: titleText, textView: descriptionText, contentURL: urlText, key: key)
                        self.addition.append(self.add!)
                        
                    })
                    self.descriptionText = ""
                    self.titleText = ""
                    self.urlText = ""
                }
            }
            else
            {
                let alertController = UIAlertController(title: "Wait", message: "Fill in all fields before saving.", preferredStyle: UIAlertControllerStyle.alert)
                let okAction = UIAlertAction(title: "OK", style: UIAlertActionStyle.default) { (result : UIAlertAction) -> Void in
                    print("OK")
                }
                let backView = alertController.view.subviews.last?.subviews.last
                backView?.layer.cornerRadius = 10.0
                okAction.setValue(UIColor(red:0.00, green:0.34, blue:0.27, alpha:1.0), forKey: "titleTextColor")
                alertController.addAction(okAction)
                self.present(alertController, animated: true, completion: nil)
            }
        } else {
            //If reference is needed then don't replace with new Add object but edit the values individualy like so:
            // addition[editIndex].title = titleText
            let key = addition[indexPath!].key
            let ref = Database.database().reference().child("drafts").child(User.current.uid).child(draftKey!).child("extra info").child(key)
            if let descriptionText = self.descriptionText, let titleText = self.titleText, let urlText = self.urlText {
                addition[editIndex] = Add(title: titleText, textView: descriptionText, contentURL: urlText)
                ref.setValue(["title" : titleText, "description" : descriptionText, "URL" : urlText])
            }
        }
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        //        self.hideKeyboard()
        
    }
    override func viewWillAppear(_ animated: Bool)
    {
        super.viewWillAppear(animated)
        editIndex = -1
        let ref = Database.database().reference().child("drafts").child(User.current.uid).child(draftKey!).child("extra info")
        ref.observeSingleEvent(of: .value, with: { (snapshot) in
            guard let snapshot = snapshot.children.allObjects as?
                [DataSnapshot] else {
                    return
            }
            if snapshot.count > 0 {
                for y in 0...snapshot.count - 1 {
                    let key = snapshot[y].key
                    let snap = snapshot[y].value as! [String : Any]
                    let add = Add(title: snap["title"] as! String, textView: snap["description"] as! String, contentURL: snap["URL"] as! String,key: key)
                    self.addition.append(add)
                }
            }
        })
    }
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        if indexPath.row != 0 {
            editIndex = indexPath.row - 1
            self.key = addition[indexPath.row - 1].key
            self.descriptionText = addition[editIndex].textView
            self.titleText = addition[editIndex].title
            self.urlText = addition[editIndex].contentURL
            
            tableView.reloadData()
            
            isEditMode = true
        }
        
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return addition.count + 1
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.row == 0 {
            let cell : FormTableViewCell = tableView.dequeueReusableCell(withIdentifier: "FormTableViewCell") as! FormTableViewCell
            cell.titleTextView.text = titleText ?? ""
            cell.titleTextView.delegate = self
            cell.descriptionTextView.text = descriptionText ?? ""
            cell.descriptionTextView.delegate = self
            cell.urlLabel.text = urlText ?? ""
            cell.urlLabel.delegate = self
            print("First cell displayed")
            return cell
        }
        else {
            let cell = tableView.dequeueReusableCell(withIdentifier: "AddMaterialTableViewCell", for: indexPath) as! AddMaterialTableViewCell
            let row = indexPath.row - 1
            self.indexPath = row
            let add = addition[row]
            cell.titleLabel.text = add.title
            cell.descriptionLabel.text = add.textView
            cell.urlLabel.text = add.contentURL
            return cell
            
        }
    }
    
    func textViewDidChange(_ textView: UITextView) {
        if textView.tag == 0 {
            self.descriptionText = textView.text
        }
        else if textView.tag == 1{
            self.titleText = textView.text
        }
        else {
            self.urlText = textView.text
        }
    }
    
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        if indexPath.row == 0 {
            return false
        } else {
            return true
        }
    }
    
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        
        if editingStyle == .delete {
            //            if let index = tableView.indexPathForSelectedRow {
            let ref = Database.database().reference().child("drafts").child(User.current.uid).child(draftKey!).child("extra info").child(addition[indexPath.item - 1].key)
            ref.removeValue(completionBlock: { (error, refer) in
                if error != nil {
                    print("error \(String(describing: error))")
                }
                else {
                    print(refer)
                    print("Child Removed Correctly")
                }
            })
            addition.remove(at: indexPath.row - 1)
        }
    }
    //    }
}
//extension NSMutableAttributedString {
//
//    public func setAsLink(textToFind:String, linkURL:String) -> Bool {
//
//        let foundRange = self.mutableString.range(of: textToFind)
//        if foundRange.location != NSNotFound {
//            self.addAttribute(NSLinkAttributeName, value: linkURL, range: foundRange)
//            return true
//        }
//        return false
//    }
//}

//extension UIViewController
//{
//    func hideKeyboard()
//    {
//        let tap: UITapGestureRecognizer = UITapGestureRecognizer(
//            target: self,
//            action: #selector(UIViewController.dismissKeyboard))
//
//        view.addGestureRecognizer(tap)
//    }
//
//    func dismissKeyboard()
//    {
//        view.endEditing(true)
//    }
//
//}
