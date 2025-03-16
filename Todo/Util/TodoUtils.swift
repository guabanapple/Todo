//
//  TodoUtils.swift
//  Todo
//
//  Created by NAKASUJI HIROKI on 2025/03/16
//
//

import Foundation

struct TodoUtils {
    private static let dateFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.locale = Locale(identifier: "ja_JP")
        formatter.calendar = Calendar(identifier: .gregorian)
        return formatter
    }()
    
    static func formatDate(_ date: Date?, includeTime: Bool) -> String? {
        guard let date = date else { return nil }
        
        let calendar = Calendar.current
        let isThisYear = calendar.isDate(date, equalTo: Date(), toGranularity: .year)
        
        if includeTime {
            dateFormatter.dateFormat = isThisYear ? "M月d日(E) HH:mm" : "yyyy年M月d日(E) HH:mm"
        } else {
            dateFormatter.dateFormat = isThisYear ? "M月d日(E)" : "yyyy年M月d日(E)"
        }
        return dateFormatter.string(from: date)
    }
    
    static func trim(_ value: String) -> String {
        return value.trimmingCharacters(in: .whitespacesAndNewlines)
    }
}
