//
//  CategoryModalVC.swift
//  NotesApp
//
//  Created by Kacper on 31/08/2021.
//  Copyright © 2021 Kacper Kosciolek. All rights reserved.
//

import UIKit
import CoreData


class CategoryModalVC: UIViewController {

    @IBOutlet weak var titleTextField: UITextField!
    
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    var categories = [Category]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let tapGesture = UITapGestureRecognizer(target: view, action: #selector(UIView.endEditing))
        view.addGestureRecognizer(tapGesture)
        
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.isNavigationBarHidden = true
        titleTextField.text = ""
        titleTextField.layer.borderWidth = 0
        titleTextField.layer.borderColor = .none
    }
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        navigationController?.isNavigationBarHidden = false
    }
    @IBAction func confirmBtn(_ sender: UIButton) {
        if titleTextField.text != "" {
            let newCategory = Category(context: self.context)
            newCategory.title = titleTextField.text
            newCategory.date = Date()
            self.categories.append(newCategory)
            saveCategories()
        } else {
            titleTextField.layer.borderWidth = 1
            titleTextField.layer.borderColor = UIColor.red.cgColor
        }
    }
    @IBAction func cancelBtn(_ sender: UIButton) {
        self.performSegue(withIdentifier: "goToCategories", sender: self)
    }
    func saveCategories() {
        do {
            try context.save()
        } catch {
            print("Error saving category \(error)")
        }
    }
}


