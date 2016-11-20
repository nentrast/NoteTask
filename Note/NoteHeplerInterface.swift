	//
//  NoteHeplerInterface.swift
//  Note
//
//  Created by Alexandr Lobanov on 11/16/16.
//  Copyright © 2016 Alexandr Lobanov. All rights reserved.
//

import UIKit

    class Note {
    
    var title:String!
    var descriptionNote:String!
    
    init(withTitle title:String, noteDescription description:String) {
        self.descriptionNote = description
        self.title = title
    }
}

class NoteHeplerInterface {

    func getAllNotes() -> [Note] {
        guard let titles = userDefaults.getAllNotesTitles() else { return [] }
        var array = [Note]()
        for title in titles {
            let descriptionNote = userDefaults.getNote(withTitle: title)
            let note = Note(withTitle: title, noteDescription: descriptionNote)
            array.append(note)
        }
        return array
    }
    
    func remove(_ note: Note) {
        userDefaults.removeNote(note.title)
    }
    
    func getNote(withTitle title:String) -> Note {
        let descroption = userDefaults.getNote(withTitle: title)
        let note = Note(withTitle: title, noteDescription: descroption)
        return note
    }
    
    func add(note: Note, handler: ((NoteError) -> Void)?) {
        guard let handler = handler else {  userDefaults.saveNote(note.title, note.descriptionNote, handler: { result in }); return }
        userDefaults.saveNote(note.title, note.descriptionNote, handler: handler)
    }
    
}
