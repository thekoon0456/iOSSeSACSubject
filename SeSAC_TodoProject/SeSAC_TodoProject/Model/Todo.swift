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
    @Persisted var priority: String?
    @Persisted var image: Data?
    
    convenience init(title: String,
                     memo: String?,
                     endDate: Date?,
                     tag: String?,
                     priority: String? = "보통", //0 낮음, 1 보통, 2 높음
                     image: Data?) {
        self.init()
        self.title = title
        self.memo = memo
        self.endDate = endDate
        self.tag = tag
        self.priority = priority
        self.image = image
    }
}
