//
//  Todo.swift
//  Todo
//  
//  Created by NAKASUJI HIROKI on 2025/02/27
//  
//

import SwiftData
import Foundation

@Model
class TodoItem {
    var title: String
    var isDone: Bool = false
    var notes: String?
    var remindDate: Date?
    var limit: Date?
    var tags: [Tag]?
    
    init(title: String, notes: String? = nil, remindDate: Date? = nil, limit: Date? = nil, tags: [Tag]? = nil) {
        self.title = title
        self.notes = notes
        self.remindDate = remindDate
        self.limit = limit
        self.tags = tags
    }
}
