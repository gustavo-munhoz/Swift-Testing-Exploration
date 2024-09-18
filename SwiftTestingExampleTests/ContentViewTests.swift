//
//  ContentViewTests.swift
//  SwiftTestingExampleTests
//
//  Created by Gustavo Munhoz Correa on 18/09/24.
//

import Testing
@testable import SwiftTestingExample

struct ContentViewTests {
    
    @available(iOS 24.0, *)
    @Test("Task list is shared")
    func shareTaskList() async throws {
        #expect(true)
    }
}
