//
//  UserSession.swift
//  TaskManager
//
//  Created by Joshua Magnotta on 11/18/25.
//


class UserSession {
    static let shared = UserSession()
    private init() {}

    var email: String?
    var accessToken: String?
}
