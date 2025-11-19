//
//  SignupResponse.swift
//  TaskManager
//
//  Created by Joshua Magnotta on 11/18/25.
//


import Foundation

struct SignupResponse: Codable {
    let message: String
}

struct LoginResponse: Codable {
    let accessToken: String
}
