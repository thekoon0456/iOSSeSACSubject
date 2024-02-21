//
//  TodoListSectionRepository.swift
//  SeSAC_TodoProject
//
//  Created by Deokhun KIM on 2/21/24.
//

import Foundation

import RealmSwift

//객체의 역할을 나누고 고민해보기!
//데이터를 변환하는 작업까지 여기서
final class TodoListSectionRepository: TodoListSectionRepositoryProtocol {
    
    typealias T = TodoListSection

    var list: Results<T>!
    
    var todoList: List<Todo>!
    
    init() {
        self.list = realm.objects(T.self)
    }
    
    private let realm = try! Realm()
    
    func printURL() {
        print(realm.configuration.fileURL ?? "")
    }
    
    // MARK: - Create
    
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
    
    // MARK: - Read
    
    func fetch() -> Results<T> {
        return realm.objects(T.self)
    }
    
    func fetchCurrentList() -> Results<T> {
        return list
    }
    
    // MARK: - Update
    
    func update(_ item: T) {
        do {
            try realm.write {
                realm.add(item, update: .modified)
            }
        } catch {
            print(error.localizedDescription)
        }
    }
    
    func updateTodoList(_ item: T, todo: Todo) {
        do {
            try realm.write {
                item.todo.append(todo)
                print(item)
                print(todo)
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
    
    //updateTodo
    
    func updateTitle(_ item: Todo, title: String) {
        do {
            try realm.write {
                item.title = title
            }
        } catch {
            print(error.localizedDescription)
        }
    }
    
    func updateMemo(_ item: Todo, memo: String?) {
        do {
            try realm.write {
                item.memo = memo
            }
        } catch {
            print(error.localizedDescription)
        }
    }
    
    func updateImage(_ item: Todo, image: String?) {
        do {
            try realm.write {
                item.imageName = image
            }
        } catch {
            print(error.localizedDescription)
        }
    }
    
    // MARK: - Delete
    
    func delete(_ item: T) {
        do {
            try realm.write {
                realm.delete(item.todo)
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

//
//
//protocol <#Name#>RepositoryProtocol {
//    associatedtype T: Object
//    
//    func createItem(_: T)
//    func fetch() -> Results<T>
//    func update(_: T)
//    func delete(_: T)
//    func deleteAll(_: T)
//}
//
////객체의 역할을 나누고 고민해보기!
////데이터를 변환하는 작업까지 여기서
//final class <#Name#>Repository: <#Name#>RepositoryProtocol {
//    
//    typealias T = <#Type#>
//    
//    private let realm = try! Realm()
//    
//    func printURL() {
//        print(realm.configuration.fileURL ?? "")
//    }
//    
//    // MARK: - Create
//    
//    func createItem(_ item: T) {
//        do {
//            try realm.write {
//                realm.add(item)
//                print("DEBUG: realm Create")
//            }
//        } catch {
//            print(error.localizedDescription)
//        }
//    }
//    
//    // MARK: - Read
//    
//    func fetch() -> Results<T> {
//        return realm.objects(T.self)
//    }
//    
//    func fetchToday() -> Results<T> {
//        let today = Calendar.current.startOfDay(for: Date())
//        let tomorrow = Calendar.current.date(byAdding: .day, value: 1, to: today) ?? Date()
//        return realm.objects(Todo.self).filter("endDate >= %@ AND endDate < %@", today, tomorrow)
//    }
//    
//    func fetchPlan() -> Results<T> {
//        let today = Calendar.current.startOfDay(for: Date())
//        let tomorrow = Calendar.current.date(byAdding: .day, value: 1, to: today) ?? Date()
//        return realm.objects(Todo.self).filter("endDate >= %@", tomorrow)
//    }
//    
//    func fetchFlag() -> Results<T> {
//        return realm.objects(T.self).where { $0.isFlag == true }
//    }
//    
//    func fetchComplete() -> Results<T> {
//        return realm.objects(T.self).where { $0.isComplete == true }
//    }
//    
//    // MARK: - Update
//    
//    func update(_ item: T) {
//        do {
//            try realm.write {
//                realm.add(item, update: .modified)
//            }
//        } catch {
//            print(error.localizedDescription)
//        }
//    }
//    
//    func update<#Name#>(_ item: T, <#Name#>: String?) {
//        do {
//            try realm.write {
//                item.<#Name#> = <#Name#>
//            }
//        } catch {
//            print(error.localizedDescription)
//        }
//    }
//    
//    func updateAll(key: String, value: Any) {
//        do {
//            try realm.write {
//                realm.objects(T.self).setValue(value, forKey: key)
//            }
//        } catch {
//            print(error.localizedDescription)
//        }
//    }
//    
//    // MARK: - Delete
//    
//    func delete(_ item: T) {
//        do {
//            try realm.write {
//                realm.delete(item)
//            }
//        } catch {
//            print(error.localizedDescription)
//        }
//    }
//    
//    func deleteAll(_ item: T) {
//        do {
//            try realm.write {
//                realm.deleteAll()
//            }
//        } catch {
//            print(error.localizedDescription)
//        }
//    }
//}
//
