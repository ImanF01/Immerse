////
////  AddMaterialTableViewController.swift
////  Immerse
////
////  Created by Iman F on 7/19/17.
////  Copyright © 2017 Iman F (group project). All rights reserved.
////
//
//import UIKit
//import Firebase
//
//class AddMaterialTableViewController: UITableViewController, UITextFieldDelegate {
//    
//    var ref: DatabaseReference!
//    var numberTapped = [String]()
//    var count = 1
//    var addition = [Add]() {
//        didSet {
//            tableView.reloadData()
//        }
//    }
//    
//    let add: Add? = nil
//
//    @IBAction func plusButton(_ sender: UIBarButtonItem) {
//        count += 1
//        
//        numberTapped.append("\(count)")
//        
//        tableView.beginUpdates()
//        let indexPath:IndexPath = IndexPath(row:(self.numberTapped.count - 1), section:0)
//        tableView.insertRows(at: [indexPath], with: .bottom)
//        tableView.endUpdates()
//        tableView.scrollToRow(at: indexPath, at: .bottom, animated: true)
//        tableView.reloadData()
//    }
//
//    @IBAction func saveButtonTapped(_ sender: Any) {
////        let sender = sender as! UIButton
////        let index = sender.tag
////        
////        let ref = Database.database().reference().child("notes").child("note").child("supplemental material")
//
//        guard let title = cell.titleTextField.text,
//            let url = cell.urlTextField.text,
//            let desc = cell.descriptionTextView.text else { return }
//        
//        //ref.setValue(["title": title, "URL": url, "description" : desc])
//    }
// 
//
//   override func viewDidLoad() {
//        super.viewDidLoad()
//        tableView?.allowsMultipleSelection = true
//        self.hideKeyboard()
//    
//    }
//
//    override func didReceiveMemoryWarning() {
//        super.didReceiveMemoryWarning()
//        // Dispose of any resources that can be recreated.
//    }
//    override func viewWillAppear(_ animated: Bool)
//    {
//        super.viewWillAppear(animated)
//        
//    }
//
//
//
//    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//        return count
//    }
//
//    
//    
//    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
//        let cell = tableView.dequeueReusableCell(withIdentifier: "AddMaterialTableViewCell", for: indexPath) as! AddMaterialTableViewCell
//        cell.saveButton.tag = indexPath.row
//        cell.titleTextField.delegate = self
//        cell.titleTextField.tintColor = UIColor(red:0.00, green:0.34, blue:0.27, alpha:1.0)
//        cell.urlTextField.tintColor = UIColor(red:0.00, green:0.34, blue:0.27, alpha:1.0)
//        cell.titleTextField.text = add?.title
//        cell.urlTextField.text = add?.contentURL
//        cell.descriptionTextView.text = add?.textView
//
//        return cell
//
//    }
//    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
//        if editingStyle == .delete {
//            addition.remove(at: indexPath.row)
//        }
////        } else if editingStyle == .insert {
////            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
////        }
//    }
//    
//
//    func textFieldDidEndEditing(_ textField: UITextField) {
//        print(textField.text)
//    }
//
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
//}
