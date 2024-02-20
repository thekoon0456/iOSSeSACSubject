//
//  Todo.swift
//  SeSAC_TodoProject
//
//  Created by Deokhun KIM on 2/15/24.
//

import Foundation

import RealmSwift

class TodoList: Object {
    @Persisted(primaryKey: true) var id: ObjectId
    @Persisted var todoListTitle: String
    @Persisted var todo: List<Todo>
    
    convenience init(todoListTitle: String, todo: List<Todo>) {
        self.init()
        self.todoListTitle = todoListTitle
        self.todo = todo
    }
}

class Todo: Object {
    @Persisted(primaryKey: true) var id: ObjectId
    @Persisted var title: String
    @Persisted var memo: String?
    @Persisted var endDate: Date?
    @Persisted var tag: String?
    @Persisted var priority: Int? //0 낮음, 1 보통, 2 높음
    @Persisted var imageName: String?
    @Persisted var isComplete: Bool
    @Persisted var isFlag: Bool
    
    convenience init(
        title: String,
        memo: String?,
        endDate: Date?,
        tag: String?,
        priority: Int? = 1,
        imageName: String?,
        isComplete: Bool = false,
        isFlag: Bool = false
    ) {
        self.init()
        self.title = title
        self.memo = memo
        self.endDate = endDate
        self.tag = tag
        self.priority = priority
        self.imageName = imageName
        self.isComplete = isComplete
        self.isFlag = isFlag
    }
}

// MARK: - Priority

enum Priority: Int, CaseIterable {
    case low
    case medium
    case high
    
    var title: String {
        switch self {
        case .low:
            "낮음"
        case .medium:
            "보통"
        case .high:
            "높음"
        }
    }
}
