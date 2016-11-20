//
//  UserDefaultsInterface.swift
//  Note
//
//  Created by Alexandr Lobanov on 11/16/16.
//  Copyright © 2016 Alexandr Lobanov. All rights reserved.
//

import UIKit

enum NoteError {
    case saved
    case noteExist
    case error
    case done
    case suddenShit
}

let userDefaults = UserDefaultsInterface()

class UserDefaultsInterface {
    
    fileprivate let kNoteList = "noteList"
    fileprivate var userDefaults = UserDefaults.standard
    
    func saveNote(_ title:String, _ description: String, handler:((NoteError)->Void)){
        switch self.isExist(noteWitjTittle: title) {
        case .done:
            self.userDefaults.set(description, forKey: title)
            self.saveKeyNote(title)
        case .noteExist:
            handler(.noteExist)
        case .error:
            handler(.error)
        default:
            handler(.suddenShit)
        }
        handler(.saved)
        self.userDefaults.synchronize()
    }
    
    func getNote(withTitle title:String) -> String {
        return self.userDefaults.string(forKey: title) ?? ""
    }
    
    func removeNote(_ title:String) {
        self.userDefaults.removeObject(forKey: title)
        self.removeKeyfromList(note: title)
        self.userDefaults.synchronize()
    }
    
    fileprivate func removeKeyfromList(note title:String) {
        if var list = self.userDefaults.value(forKey: kNoteList) as? [String] {
            for i in 0..<list.count {
                if list[i] == title {
                    list.remove(at: i)
                    break
                }
            }
            self.userDefaults.setValue(list, forKey: kNoteList)
        }
    }
    
    fileprivate func saveKeyNote(_ key:String) {
        if var list = self.userDefaults.value(forKey: kNoteList) as? [String] {
            list.append(key)
            self.userDefaults.setValue(list, forKey: kNoteList)
        }else {
            var array = [String]()
            array.append(key)
            self.userDefaults.set(array, forKey: kNoteList)
        }
        self.userDefaults.synchronize()

    }
    
    fileprivate func isExist(noteWitjTittle title:String) -> NoteError {
        guard let list = self.userDefaults.value(forKey: kNoteList) as? [String]  else { return .error }
        for i in 0..<list.count {
            if list[i] == title {
                return .noteExist
            }
        }
        return .done
    }
    
    func getAllNotesTitles() -> [String]? {
        guard let titles = self.userDefaults.object(forKey: kNoteList) as? [String] else { return nil }
        return titles
    }
    
}
