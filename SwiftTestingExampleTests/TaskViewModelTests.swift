//
//  TaskViewModelTests.swift
//  SwiftTestingExampleTests
//
//  Created by Gustavo Munhoz Correa on 18/09/24.
//

import Testing
import Foundation
@testable import SwiftTestingExample

final class TaskViewModelTests {
    
    static private let testsKey = "testsKey"
    
    // MARK: - Init and Deinit replace SetUp and TearDown from XCTest -
    
    /// Executes actions to set up testing.
    /// This includes creating properties, setting values, etc.
    init() {
        UserDefaults.standard.removeObject(forKey: Self.testsKey)        
    }
    
    /// Executes actions after testing has been completed.
    /// This includes deleting store properties or values, etc.
    deinit {
        UserDefaults.standard.removeObject(forKey: Self.testsKey)
    }
    
    @Test func addTask() {
        let viewModel = TaskViewModel(userDefaultsKey: Self.testsKey)
        
        viewModel.addTask(title: "Study SwiftUI")
        
        #expect(viewModel.tasks.count == 1)
        #expect(viewModel.tasks.first?.title == "Study SwiftUI")
        #expect(viewModel.tasks.first?.isCompleted == false)
    }
    
    @Test("Task is marked as completed")
    func toggleCompletion() {
        let viewModel = TaskViewModel(userDefaultsKey: Self.testsKey)
        viewModel.addTask(title: "Study SwiftUI")
        
        let task = viewModel.tasks.first!
        viewModel.toggleCompletion(task: task)
        
        #expect(viewModel.tasks.first?.isCompleted == true)
    }
    
    @Test("Tasks are persisted in UserDefaults")
    func taskPersistence() {
        var viewModel = TaskViewModel(userDefaultsKey: Self.testsKey)
        viewModel.addTask(title: "Study SwiftUI")
        
        viewModel = TaskViewModel(userDefaultsKey: Self.testsKey)
        
        #expect(viewModel.tasks.count == 1)
        #expect(viewModel.tasks.first?.title == "Study SwiftUI")
    }
    
    @Test("Task is deleted")
    func taskDeletion() {
        let viewModel = TaskViewModel(userDefaultsKey: Self.testsKey)
        viewModel.addTask(title: "Study SwiftUI")
        
        viewModel.deleteTask(at: .init(integer: 0))
        
        #expect(viewModel.tasks.isEmpty)
    }
    
    @Test("Tasks are fetched from server")
    func fetchTasks() async throws {
        let viewModel = TaskViewModel(userDefaultsKey: Self.testsKey)
        
        try await viewModel.fetchTasks()
        
        #expect(viewModel.tasks.count > 0)
    }
}
