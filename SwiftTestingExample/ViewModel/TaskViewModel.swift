//
//  TaskViewModel.swift
//  SwiftTestingExample
//
//  Created by Gustavo Munhoz Correa on 18/09/24.
//

import Foundation

class TaskViewModel: ObservableObject {
    private let userDefaultsKey: String
    
    @Published var tasks: [ToDoTask] = [] {
        didSet {
            saveTasks(for: userDefaultsKey)
        }
    }

    init(userDefaultsKey key: String) {
        userDefaultsKey = key
        loadTasks(for: userDefaultsKey)
    }

    // MARK: - Synchronous methods
    
    func addTask(title: String) {
        let newTask = ToDoTask(title: title)
        tasks.append(newTask)
    }

    func toggleCompletion(task: ToDoTask) {
        if let index = tasks.firstIndex(where: { $0.id == task.id }) {
            tasks[index].isCompleted.toggle()
        }
    }

    private func saveTasks(for key: String) {
        do {
            let data = try JSONEncoder().encode(tasks)
            UserDefaults.standard.set(data, forKey: key)
        } catch {
            print("Error saving tasks: \(error)")
        }
    }

    private func loadTasks(for key: String) {
        guard let data = UserDefaults.standard.data(forKey: key) else { return }
        do {
            tasks = try JSONDecoder().decode([ToDoTask].self, from: data)            
        } catch {
            print("Error loading tasks: \(error)")
        }
    }
    
    func deleteTask(at offsets: IndexSet) {
        tasks.remove(atOffsets: offsets)
    }
    
    // MARK: - Asynchronous methods
    func fetchTasks() async throws {
        try await Task.sleep(for: .seconds(1), clock: .continuous)
        
        let fetchedTasks = [
            ToDoTask(title: "Task from server 1"),
            ToDoTask(title: "Task from server 2"),
            ToDoTask(title: "Task from server 3")
        ]
        
        await MainActor.run {
            tasks.append(contentsOf: fetchedTasks)
        }
    }
}
