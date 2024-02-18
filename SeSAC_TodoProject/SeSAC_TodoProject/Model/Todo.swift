//
//  Todo.swift
//  SeSAC_TodoProject
//
//  Created by Deokhun KIM on 2/15/24.
//

import Foundation

import RealmSwift

class Todo: Object {
    @Persisted(primaryKey: true) var id: ObjectId
    @Persisted var title: String
    @Persisted var memo: String?
    @Persisted var endDate: Date?
    @Persisted var tag: String?
    @Persisted var priority: Int? //0 낮음, 1 보통, 2 높음
    @Persisted var image: Data?
    @Persisted var isComplete: Bool
    @Persisted var isFlag: Bool
    
    convenience init(
        title: String,
        memo: String?,
        endDate: Date?,
        tag: String?,
        priority: Int? = 1,
        image: Data?,
        isComplete: Bool = false,
        isFlag: Bool = false
    ) {
        self.init()
        self.title = title
        self.memo = memo
        self.endDate = endDate
        self.tag = tag
        self.priority = priority
        self.image = image
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
