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
import SkyFloatingLabelTextField
import Kingfisher

class AddMaterialTableViewController: UITableViewController, UITextViewDelegate{
    var titleText: String?
    var descriptionText: String?
    //    @IBOutlet weak var urlTextField: SkyFloatingLabelTextField!
    var addition = [Add](){
        didSet {
           // tableView.reloadSections(NSIndexSet(index: 2) as IndexSet, with: .none)
            tableView.reloadData()
        }
    }

    var add: Add?
    var draft: Draft?
    @IBAction func saveButtonTapped(_ sender: Any) {
        if let descriptionText = self.descriptionText, let titleText = self.titleText {
            print("titleText = \(titleText)")
            let newRef = Database.database().reference().child("drafts").child(User.current.uid).child((draft?.key)!).child("extra info").childByAutoId()
            newRef.setValue(["title" : titleText, "description" : descriptionText])

            if (!(descriptionText.isEmpty) && !(titleText.isEmpty)) {
                add = Add(title: titleText, textView: descriptionText)
                print(addition)
                self.addition.append(add!)
                self.descriptionText = ""
                self.titleText = ""
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
//        let ref = Database.database().reference().child("drafts").child(User.current.uid).child("extra info")
//        ref.observeSingleEvent(of: .value, with: { (snapshot) in
//            guard let snapshot = snapshot.children.allObjects as?
//                [DataSnapshot] else {
//                    return
//            }
//            if snapshot.count > 0 {
//                for y in 0...snapshot.count - 1 {
//                    let key = snapshot[y].key
//                    let snap = snapshot[y].value as! [String : Any]
//                    let add = Add(title: snap["title"] as! String, textView: snap["description"] as! String, key: key)
//                    self.addition.append(add)
//                }
//            }
//        })
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
            print("First cell displayed")
            return cell
        }
        else {
        let cell = tableView.dequeueReusableCell(withIdentifier: "AddMaterialTableViewCell", for: indexPath) as! AddMaterialTableViewCell
        let row = indexPath.row - 1
        let add = addition[row]
        cell.titleLabel.text = add.title
        cell.descriptionLabel.text = add.textView
        //        let url = URL(string: add.contentURL)
        //        cell.thumbnailImage.kf.setImage(with: url)
        return cell
            
        }
    }
    
    func textViewDidChange(_ textView: UITextView) {
        if textView.tag == 0 {
            self.descriptionText = textView.text
        }
        else {
            self.titleText = textView.text
        }
    }
//    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
//        if editingStyle == .delete {
//            addition.remove(at: indexPath.row)
//            
//        }
//    }
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
