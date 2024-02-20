//
//  TodoRepository.swift
//  SeSAC_TodoProject
//
//  Created by Deokhun KIM on 2/16/24.
//

import UIKit

import RealmSwift

//객체의 역할을 나누고 고민해보기!
//데이터를 변환하는 작업까지 여기서
final class TodoRepository: TodoRepositoryProtocol {
    
    typealias T = Todo
    
    private let realm = try! Realm()
    
    var list: Results<T>!
    var filteredList: Results<T>!
    
    init() {
        self.list = realm.objects(T.self)
        self.filteredList = realm.objects(T.self)
    }
    
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

    func fetchToday() -> Results<T> {
        let today = Calendar.current.startOfDay(for: Date())
        let tomorrow = Calendar.current.date(byAdding: .day, value: 1, to: today) ?? Date()
        return realm.objects(Todo.self).filter("endDate >= %@ AND endDate < %@", today, tomorrow)
    }
    
    func fetchPlan() -> Results<T> {
        let today = Calendar.current.startOfDay(for: Date())
        let tomorrow = Calendar.current.date(byAdding: .day, value: 1, to: today) ?? Date()
        return realm.objects(Todo.self).filter("endDate >= %@", tomorrow)
    }
    
    func fetchFlag() -> Results<T> {
        return realm.objects(T.self).where { $0.isFlag == true }
    }
    
    func fetchComplete() -> Results<T> {
        return realm.objects(T.self).where { $0.isComplete == true }
    }
    
    //searchFetch
    
    func fetchSearch(title: String) {
        filteredList = realm.objects(T.self).where { $0.title.contains(title, options: .caseInsensitive)}
    }
    
    func fetchSearchReset() {
        filteredList = realm.objects(T.self)
    }
    
    //calendarFetch
    
    func fetchToday(date: Date) {
        list = realm.objects(T.self).filter(getTodayPredicate(date: date))
    }
    
    //DetailFetch
    
    func fetchSorted(keyPath: String, ascending: Bool) -> Results<T> {
        return realm.objects(T.self).sorted(byKeyPath: keyPath, ascending: ascending)
    }
    
    func fetchEndDate() {
        filteredList = fetchSorted(keyPath: "endDate", ascending: true)
    }
    
    func fetchTitle() {
        filteredList = fetchSorted(keyPath: "title", ascending: true)
    }
    
    func fetchLowPriority() {
        filteredList = realm.objects(T.self).where { $0.priority == 0 }
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
    
    func updateImage(_ item: T, image: String?) {
        do {
            try realm.write {
                item.imageName = image
            }
        } catch {
            print(error.localizedDescription)
        }
    }
    
    func updateFlag(_ item: T) {
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
    
    // MARK: - Delete
    
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

// MARK: - Helper

extension TodoRepository {
    
    //collectionView Counter
    func getCellCount(idx: Int) -> Int? {
        let count: Int?
        switch TodoSection.allCases[idx] {
        case .today:
            count = fetchToday().count
        case .plan:
            count = fetchPlan().count
        case .whole:
            count = fetch().count
        case .flag:
            count = fetchFlag().count
        case .complete:
            count = fetchComplete().count
        }
        return count
    }
    
    //calendar filter
    func getTodayPredicate(date: Date) -> NSPredicate {
        let start = Calendar.current.startOfDay(for: date)
        let end = Calendar.current.date(byAdding: .day, value: 1, to: start) ?? Date()
        return NSPredicate(format: "endDate >= %@ && endDate < %@ ",
                           start as NSDate, end as NSDate)
    }

}

//                todoRepo.filteredList = .list.where { $0.priority == 0 }
