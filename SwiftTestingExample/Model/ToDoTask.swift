//
//  ToDoTask.swift
//  SwiftTestingExample
//
//  Created by Gustavo Munhoz Correa on 18/09/24.
//

import Foundation

struct ToDoTask: Identifiable, Codable {
    let id: UUID
    var title: String
    var isCompleted: Bool

    init(id: UUID = UUID(), title: String, isCompleted: Bool = false) {
        self.id = id
        self.title = title
        self.isCompleted = isCompleted
    }
}
