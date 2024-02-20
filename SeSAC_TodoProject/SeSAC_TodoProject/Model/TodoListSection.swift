//
//  TodoListSection.swift
//  SeSAC_TodoProject
//
//  Created by Deokhun KIM on 2/21/24.
//

import Foundation

import RealmSwift

class TodoListSection: Object {
    @Persisted(primaryKey: true) var id: ObjectId
    @Persisted var todoListTitle: String
    @Persisted var todo: List<Todo>
    
    convenience init(todoListTitle: String) {
        self.init()
        self.todoListTitle = todoListTitle
    }
}
