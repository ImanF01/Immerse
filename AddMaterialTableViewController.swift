//
//  AddMaterialTableViewController.swift
//  Immerse
//
//  Created by Iman F on 7/19/17.
//  Copyright © 2017 Iman F (group project). All rights reserved.
//
import UIKit
import SkyFloatingLabelTextField
import Kingfisher

class AddMaterialTableViewController: UITableViewController, UITextViewDelegate {
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
    
    @IBAction func saveButtonTapped(_ sender: Any) {
        print("this is the addition array: \(addition)")
        if let titleText = self.titleText, let descriptionText = self.descriptionText{
            if (!(titleText.isEmpty) || !(descriptionText.isEmpty)) {
                    add = Add(title: titleText, textView: descriptionText)
                    self.addition.append(add!)
                }
            } else {
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
       // let form = FormTableViewCell()
//        form.titleTextField.text = add?.title ?? ""
//        form.descriptionTextView.text = add?.textView ?? ""
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
            cell.titleTextField.text = ""
            cell.descriptionTextView.text = ""
            cell.descriptionTextView.delegate = self
            cell.titleTextField.delegate = self
            
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
            self.titleText = textView.text
        } else {
            self.descriptionText = textView.text
        }


    }
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
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
