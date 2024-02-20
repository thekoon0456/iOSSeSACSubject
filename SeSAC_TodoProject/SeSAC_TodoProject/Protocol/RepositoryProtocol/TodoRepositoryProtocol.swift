//
//  TodoRepositoryProtocol.swift
//  SeSAC_TodoProject
//
//  Created by Deokhun KIM on 2/16/24.
//

import UIKit

import RealmSwift

protocol TodoRepositoryProtocol {
    associatedtype T: Todo
    
    func createItem(_: T) //create
    func fetch() -> Results<T> //read
    func update(_: T) //update
    func delete(_: T) //delete
    func deleteAll(_: T)
}
