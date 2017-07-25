//
//  AddMaterialViewController.swift
//  Immerse
//
//  Created by Iman F on 7/24/17.
//  Copyright © 2017 Iman F (group project). All rights reserved.
//

import UIKit
import SkyFloatingLabelTextField
import Kingfisher

class AddMaterialViewController: UIViewController, UITableViewDelegate, UITableViewDataSource{

    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var titleTextField: SkyFloatingLabelTextField!
//    @IBOutlet weak var urlTextField: SkyFloatingLabelTextField!
    @IBOutlet weak var descriptionTextView: UITextView!
    
    var addition = [Add]() {
        didSet {
            tableView.reloadData()
        }
    }
    var add: Add?

    override func viewDidLoad() {
        super.viewDidLoad()
        self.hideKeyboard()
        
    }
    override func viewWillAppear(_ animated: Bool)
    {
        super.viewWillAppear(animated)
        titleTextField.text = add?.title ?? ""
        descriptionTextView.text = add?.textView ?? ""
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return addition.count
    }
    
    @IBAction func saveButtonTapped(_ sender: Any) {
        print("Save button tapped")
        var add = Add()
       // let addMaterial = AddMaterialTableViewCell()
        add.title = titleTextField.text ?? ""
        add.textView = descriptionTextView.text ?? ""
//        let url = URL(string: (add?.contentURL)!)
//        addMaterial.thumbnailImage.kf.setImage(with: url)
        addition.append(add)
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "AddMaterialTableViewCell", for: indexPath) as! AddMaterialTableViewCell
        let row = indexPath.row
        let add = addition[row]
        cell.titleLabel.text = add.title
        cell.descriptionLabel.text = add.textView
//        let url = URL(string: add.contentURL)
//        cell.thumbnailImage.kf.setImage(with: url)
        return cell
        
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

  
