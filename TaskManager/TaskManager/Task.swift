//
//  Task.swift
//  TaskManager
//
//  Created by Joshua Magnotta on 11/9/25.
//

import Foundation

struct Task: Codable {
    let title: String
    let category: String
    let dueDate: Date
    let details: String?
}
