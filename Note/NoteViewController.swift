//
//  NoteViewController.swift
//  Note
//
//  Created by Alexandr Lobanov on 11/16/16.
//  Copyright © 2016 Alexandr Lobanov. All rights reserved.
//

import UIKit

class NoteViewController: UIViewController, UITextViewDelegate{
    
    var note:Note? 
    @IBOutlet weak var textViewDescr: UITextView! { didSet{ self.textViewDescr.delegate = self } }
    @IBOutlet weak var textViewTitle: UITextField!
    @IBOutlet weak var barButtonSave: UIBarButtonItem!
    
    fileprivate var noteInterface = NoteHeplerInterface()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.fiilWihtNote()
        self.textViewTitle.addTarget(self, action: #selector(textFieldDidChange), for: .editingChanged)
    }
    
    fileprivate func fiilWihtNote() {
        if let note = self.note {
            self.textViewTitle.text = note.title
            self.textViewDescr.text = note.descriptionNote
        }
    }
    
    @objc fileprivate func isValid() ->Bool {
        guard !self.textViewDescr.text.isEmpty else { return false }
        guard !(self.textViewTitle.text?.isEmpty)! else { return false }
        if let note = self.note {
            if note.descriptionNote == self.textViewDescr.text && note.title == self.textViewTitle.text {
                return false
            }
        }
        return true
    }
    
    func textFieldDidChange() {
        self.barButtonSave.isEnabled = self.isValid()
    }
    
    func textViewDidChange(_ textView: UITextView) {
        self.barButtonSave.isEnabled = self.isValid()
    }
    
    fileprivate func handledResult(_ result: NoteError) {
        switch result {
        case .done, .saved:
            _ = self.navigationController?.popViewController(animated: true)
        case .error:
            self.showAlert(withTitle: "Error", message: "Some goes bad")
        case .noteExist:
            self.showAlert(withTitle: "Note exist", message: "Change tittle")
        case .suddenShit:
             self.showAlert(withTitle: "Unexpextable thing", message: "oops(")
        }
    }

    fileprivate func showAlert(withTitle title:String, message:String) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let ok = UIAlertAction(title: "Ok", style: .default, handler:{ alertACtion in
            
        })
        
        alert.addAction(ok)
        self.present(alert, animated: true, completion: nil)
    }
    
    @IBAction func saveNoteAction(_ sender: Any) {
        if let note = self.note {
            noteInterface.remove(note)
            note.descriptionNote = self.textViewDescr.text
            note.title = self.textViewTitle.text
            noteInterface.add(note: note, handler: {result in
                self.handledResult(result)
            })
        } else {
            let newNote = Note(withTitle: self.textViewTitle.text!, noteDescription: self.textViewDescr.text)
            noteInterface.add(note: newNote, handler: {result in
                self.handledResult(result)
            })
        }
        
    }
}
