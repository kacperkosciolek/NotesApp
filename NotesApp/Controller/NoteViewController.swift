//
//  NoteViewController.swift
//  NotesApp
//
//  Created by Kacper on 17/09/2021.
//  Copyright © 2021 Kacper Kosciolek. All rights reserved.
//

import UIKit
import CoreData

class NoteViewController: UIViewController {

    @IBOutlet weak var noteTextView: UITextView!
    
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
 
    var myNotes = [Note]()
    
    var selectedCategory : Category? {
        didSet {
            loadNotes()
        }
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        noteTextView.delegate = self
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .save, target: self, action: #selector(handleSave))
        noteTextView.becomeFirstResponder()
        noteTextView.textContainerInset = UIEdgeInsets(top: 30, left: 30, bottom: 0, right: 30)
    }
    @objc func handleSave() {
        let newNote = Note(context: self.context)
        newNote.text = noteTextView.text
        newNote.parentCategory = selectedCategory
        myNotes.append(newNote)

        do {
            try context.save()
        } catch {
            print("Error saving notes \(error)")
        }
    }
    func loadNotes() {
        let request : NSFetchRequest<Note> = Note.fetchRequest()
        let categoryPredicate = NSPredicate(format: "parentCategory.title MATCHES %@", selectedCategory!.title!)
        request.predicate = categoryPredicate
        
        do {
            myNotes = try context.fetch(request)
        } catch {
            print("Error loading notes \(error)")
        }
    }
}
extension NoteViewController: UITextViewDelegate {
    func textViewDidBeginEditing(_ textView: UITextView) {
        noteTextView.text = myNotes.last?.text
    }
}
