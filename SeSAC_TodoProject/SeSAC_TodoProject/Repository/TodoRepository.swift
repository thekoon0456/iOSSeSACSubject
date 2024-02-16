//
//  TodoRepository.swift
//  SeSAC_TodoProject
//
//  Created by Deokhun KIM on 2/16/24.
//

import UIKit

import RealmSwift

final class TodoRepository {
    
    typealias T = Todo
    
    private let realm = try! Realm()
    
    func printURL() {
        print(realm.configuration.fileURL)
    }
    
    func createItem(_ item: T) {
        do {
            try realm.write {
                realm.add(item)
                print("DEBUG: realm Create")
            }
        } catch {
            print(error.localizedDescription)
        }
    }
    
    func fetch(type: T.Type) -> Results<T> {
        return realm.objects(T.self)
    }
    
    func updateTitle(_ item: T, title: String) {
        do {
            try realm.write {
                item.title = title
            }
        } catch {
            print(error.localizedDescription)
        }
    }
    
    func updateMemo(_ item: T, memo: String?) {
        do {
            try realm.write {
                item.memo = memo
            }
        } catch {
            print(error.localizedDescription)
        }
    }
    
    func updateEndDate(_ item: T, endDate: Date?) {
        do {
            try realm.write {
                item.endDate = endDate
            }
        } catch {
            print(error.localizedDescription)
        }
    }
    
    func updateTag(_ item: T, tag: String?) {
        do {
            try realm.write {
                item.tag = tag
            }
        } catch {
            print(error.localizedDescription)
        }
    }
    
    func updatePriority(_ item: T, priority: Int?) {
        do {
            try realm.write {
                item.priority = priority
            }
        } catch {
            print(error.localizedDescription)
        }
    }
    
    func updateImage(_ item: T, image: Data?) {
        do {
            try realm.write {
                item.image = image
            }
        } catch {
            print(error.localizedDescription)
        }
    }
    
    func updateFlag(_ item: T, isFlag: Bool) {
        do {
            try realm.write {
                item.isFlag.toggle()
            }
        } catch {
            print(error.localizedDescription)
        }
    }
    
    func updateComplete(_ item: T) {
        do {
            try realm.write {
                item.isComplete.toggle()
            }
        } catch {
            print(error.localizedDescription)
        }
    }
    
    func updateAll(key: String, value: Any) {
        do {
            try realm.write {
                realm.objects(T.self).setValue(value, forKey: key)
            }
        } catch {
            print(error.localizedDescription)
        }
    }
    
    func delete(_ item: T) {
        do {
            try realm.write {
                realm.delete(item)
            }
        } catch {
            print(error.localizedDescription)
        }
    }
    
    func deleteAll(_ item: T) {
        do {
            try realm.write {
                realm.deleteAll()
            }
        } catch {
            print(error.localizedDescription)
        }
    }
}

