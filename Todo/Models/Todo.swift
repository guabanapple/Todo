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
    var remindDate: Date
    var limit: Date?
    var tags: [Tag]?
    
    init(title: String, notes: String? = nil, remindDate: Date = Date(), limit: Date? = nil, tags: [Tag]? = nil) {
        self.title = title
        self.notes = notes
        self.remindDate = Self.removeTimeFromDate(remindDate)
        self.limit = limit
        self.tags = tags
    }
    
    private static func removeTimeFromDate(_ date: Date) -> Date {
        let calendar = Calendar.current
        return calendar.startOfDay(for: date)
    }
}

extension Date {
    func isSameDate(as date: Date) -> Bool {
        let calendar = Calendar.current
        return calendar.isDate(self, inSameDayAs: date)
    }
    
    
    func isPastDate() -> Bool {
        let calendar = Calendar.current
        return self < calendar.startOfDay(for: Date())
    }

    func isFutureDate() -> Bool {
        let calendar = Calendar.current
        return self > calendar.startOfDay(for: Date())
    }
}
