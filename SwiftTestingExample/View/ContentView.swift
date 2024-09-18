//
//  ContentView.swift
//  SwiftTestingExample
//
//  Created by Gustavo Munhoz Correa on 18/09/24.
//

import SwiftUI

struct ContentView: View {
    @StateObject private var viewModel = TaskViewModel(userDefaultsKey: "tasks")
    @State private var taskTitle: String = ""

    var body: some View {
        NavigationView {
            VStack {
                HStack {
                    TextField("New task", text: $taskTitle)
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                    Button(action: {
                        withAnimation {
                            viewModel.addTask(title: taskTitle)
                            taskTitle = ""
                        }
                    }) {
                        Text("Create")
                    }
                }
                .padding()

                List {
                    ForEach(viewModel.tasks) { task in
                        HStack {
                            Text(task.title)
                                .strikethrough(task.isCompleted)
                            Spacer()
                            Button(action: {
                                withAnimation {
                                    viewModel.toggleCompletion(task: task)
                                }
                            }) {
                                Image(systemName: task.isCompleted ? "checkmark.circle.fill" : "circle")
                                
                            }
                            .buttonStyle(BorderlessButtonStyle())
                        }
                    }
                    .onDelete(perform: viewModel.deleteTask)
                }
                
                if #available(iOS 24.0, *) {
                    Button(action: {
                        shareTaskList()
                    }) {
                        Text("Share task list")
                            .padding(12)
                            .background(Color.blue)
                            .foregroundColor(.white)
                            .cornerRadius(8)
                    }
                } else {
                    Text("Update to iOS 15 to share your task list")
                        .padding()
                        .foregroundColor(.gray)
                }
            }
            .navigationTitle("My tasks")
        }
    }
    
    func shareTaskList() {
        print("Sharing task list")
    }
}

#Preview {
    ContentView()
}
