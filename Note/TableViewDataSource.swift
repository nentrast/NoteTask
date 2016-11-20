//
//  TableViewDataSource.swift
//  Note
//
//  Created by Alexandr Lobanov on 11/20/16.
//  Copyright © 2016 Alexandr Lobanov. All rights reserved.
//

import UIKit

protocol NoteDelegate: class {
    func selectedNote(_ note:Note)
}

class TableViewDataSource: NSObject, UITableViewDelegate, UITableViewDataSource {

    fileprivate var tableview: UITableView!
    fileprivate var datasource = NoteHeplerInterface()
    weak var delegate: NoteDelegate?

    init(withTableView talbeView:UITableView) {
        super.init()
        self.tableview = talbeView
        self.tableview.delegate = self
        self.tableview.dataSource = self
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let count = datasource.getAllNotes().count 
        return count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "noteName", for: indexPath)
        let note = self.datasource.getAllNotes()[indexPath.row]
        cell.textLabel?.text = note.title
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let selectedNote = self.datasource.getAllNotes()[indexPath.row]
        self.delegate?.selectedNote(selectedNote)
        
    }
}
