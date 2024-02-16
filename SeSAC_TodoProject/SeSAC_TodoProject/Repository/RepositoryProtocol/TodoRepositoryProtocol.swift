//
//  TodoRepositoryProtocol.swift
//  SeSAC_TodoProject
//
//  Created by Deokhun KIM on 2/16/24.
//

import UIKit

import RealmSwift

protocol TodoRepositoryProtocol {
    var realm: Realm { get }
    func createItem(_: Todo) //create
    func fetch(type: Todo) -> Results<Todo> //read
    func update(item: Todo) //update
    func delete(item: Todo) //delete
    func deleteAll(_: Todo)
}
