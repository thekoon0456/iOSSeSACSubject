//
//  TodoListSectionRepositoryProtocol.swift
//  SeSAC_TodoProject
//
//  Created by Deokhun KIM on 2/21/24.
//

import Foundation

import RealmSwift

protocol TodoListSectionRepositoryProtocol {
    associatedtype T: Object
    
    func createItem(_: T)
    func fetch() -> Results<T>
    func update(_: T)
    func delete(_: T)
    func deleteAll(_: T)
}
