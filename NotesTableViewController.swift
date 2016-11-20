//
//  NotesTableViewController.swift
//  Note
//
//  Created by Alexandr Lobanov on 11/16/16.
//  Copyright © 2016 Alexandr Lobanov. All rights reserved.
//

import UIKit

class NotesTableViewController: UIViewController, NoteDelegate {

    @IBOutlet weak var notesTableView: UITableView!
    fileprivate var tableViewDatasource:TableViewDataSource?
    fileprivate let kAddNoteVC = "addNoteViewController"

    override func viewDidLoad() {
        super.viewDidLoad()
        self.tableViewDatasource = TableViewDataSource(withTableView: self.notesTableView)
        self.tableViewDatasource?.delegate = self
    }

    override func viewWillAppear(_ animated: Bool) {
        self.notesTableView.reloadData()
    }
    
    @IBAction func addNoteAction(_ sender: Any) {
        let destination = self.storyboard?.instantiateViewController(withIdentifier: kAddNoteVC)
        self.navigationController?.pushViewController(destination!, animated: true)
    }
//MARK: NoteDelegate
    func selectedNote(_ note: Note) {
        let destination = self.storyboard?.instantiateViewController(withIdentifier: kAddNoteVC) as! NoteViewController
        destination.note = note
        self.navigationController?.pushViewController(destination, animated: true)
    }
}
