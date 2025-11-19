//
//  AuthRequest.swift
//  TaskManager
//
//  Created by Joshua Magnotta on 11/18/25.
//


import Foundation

struct AuthRequest: Codable {
    let email: String
    let password: String
}
