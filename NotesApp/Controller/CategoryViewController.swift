//
//  CategoryViewController.swift
//  NotesApp
//
//  Created by Kacper on 30/08/2021.
//  Copyright © 2021 Kacper Kosciolek. All rights reserved.
//



import UIKit
import CoreData

class CategoryViewController: UIViewController {

    @IBOutlet weak var categoriesTableView: UITableView!
    @IBOutlet weak var modalView: UIView!
    
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
    var categories = [Category]()

    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(handleAdd))
        self.navigationItem.setHidesBackButton(true, animated: true)
        categoriesTableView.delegate = self
        categoriesTableView.dataSource = self
        categoriesTableView.register(UINib(nibName: CategoryCell.cellID, bundle: nil), forCellReuseIdentifier: CategoryCell.cellID)
        loadCategories()
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        if categories.count > 0 {
            let indexPath = IndexPath(row: self.categories.count - 1, section: 0)
            self.categoriesTableView.scrollToRow(at: indexPath, at: .top, animated: true)
            if UIDevice().userInterfaceIdiom == .phone && UIScreen.main.nativeBounds.height == 1334 {
                categoriesTableView.contentInset = UIEdgeInsets(top: 0, left: 0, bottom: 240, right: 0);
            }
        }
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let destinationVC = segue.destination as! NoteViewController

        if let indexPath = categoriesTableView.indexPathForSelectedRow {
            destinationVC.selectedCategory = categories[indexPath.row]
        }
    }
    @objc func handleAdd() {
        navigationController?.popViewController(animated: true)
    }
    func loadCategories() {
        let request : NSFetchRequest<Category> = Category.fetchRequest()

        do {
            categories = try context.fetch(request)
        } catch {
            print("Error loading categories \(error)")
        }
        if categories.count == 0 {
            modalView.isHidden = false
            categoriesTableView.isHidden = true
        }
        categoriesTableView.reloadData()
    }
}
extension CategoryViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return categories.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = categoriesTableView.dequeueReusableCell(withIdentifier: CategoryCell.cellID, for: indexPath) as! CategoryCell
        cell.categoryTitle.text = categories[indexPath.row].title
        let formatter = DateFormatter()
        formatter.dateFormat = "dd-MM-yy"
        cell.categoryDate.text = formatter.string(from: categories[indexPath.row].date!)
        cell.selectionStyle = .none
        
        cell.buttonAction = { _ in
            self.context.delete(self.categories[indexPath.row])
            self.loadCategories()
        }
        return cell
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.performSegue(withIdentifier: "goToNote", sender: self)
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return CategoryCell.cellHeight
    }
}
