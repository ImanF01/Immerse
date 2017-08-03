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
    var addition = [Add](){
        didSet {
            tableView.reloadData()
        }
    }
    
    var add: Add?
    var draft: Draft?
    @IBAction func saveButtonTapped(_ sender: Any) {
        if let descriptionText = self.descriptionText, let titleText = self.titleText, let urlText = self.urlText {
            print("titleText = \(titleText)")
            let newRef = Database.database().reference().child("drafts").child(User.current.uid).child((draft?.key)!).child("extra info").childByAutoId()
            newRef.setValue(["title" : titleText, "description" : descriptionText, "URL" : urlText])
            
            if (!(descriptionText.isEmpty) && !(titleText.isEmpty) && !(urlText.isEmpty)) {
                add = Add(title: titleText, textView: descriptionText, contentURL: urlText)
                print(addition)
                self.addition.append(add!)
                self.descriptionText = ""
                self.titleText = ""
                self.urlText = ""
            }
        }
        else
        {
            print("error")
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.hideKeyboard()
        
    }
    override func viewWillAppear(_ animated: Bool)
    {
        super.viewWillAppear(animated)
        let ref = Database.database().reference().child("drafts").child(User.current.uid).child((draft?.key)!).child("extra info")
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
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return addition.count + 1
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.row == 0 {
            let cell : FormTableViewCell = tableView.dequeueReusableCell(withIdentifier: "FormTableViewCell") as! FormTableViewCell
            cell.titleTextView.text = ""
            cell.titleTextView.delegate = self
            cell.descriptionTextView.text = ""
            cell.descriptionTextView.delegate = self
            cell.urlLabel.text = ""
            cell.urlLabel.delegate = self
            print("First cell displayed")
            return cell
        }
        else {
            let cell = tableView.dequeueReusableCell(withIdentifier: "AddMaterialTableViewCell", for: indexPath) as! AddMaterialTableViewCell
            let row = indexPath.row - 1
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
    
    
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            let key = addition[indexPath.row].key
            let ref = Database.database().reference().child("drafts").child(User.current.uid).child((draft?.key)!).child("extra info").child(key)
            ref.removeValue(completionBlock: { (error, refer) in
                if error != nil {
                    print("error \(String(describing: error))")
                }
                else {
                    print(refer)
                    print("Child Removed Correctly")
                }
            })
            addition.remove(at: indexPath.row)
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
