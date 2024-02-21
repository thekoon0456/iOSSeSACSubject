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
    @Persisted var imageName: String
    @Persisted var colorName: String
    @Persisted var todoListTitle: String
    @Persisted var todo: List<Todo>
    
    convenience init(colorName: String, imageName: String, todoListTitle: String) {
        self.init()
        self.colorName = colorName
        self.imageName = imageName
        self.todoListTitle = todoListTitle
    }
}
