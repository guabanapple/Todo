//
//  Tag.swift
//  Todo
//  
//  Created by NAKASUJI HIROKI on 2025/02/27
//  
//

import SwiftData

@Model
class Tag {
    var name: String
    
    init(name: String) {
        self.name = name
    }
}
