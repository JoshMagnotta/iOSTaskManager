//
//  AuthManager.swift
//  TaskManager
//
//  Created by Joshua Magnotta on 11/18/25.
//

import Foundation

class AuthManager {
    static let shared = AuthManager()
    private init() {}

    private let baseURL = "https://task-api-vmbs.onrender.com"

    // MARK: - Signup
    func signup(email: String, password: String, completion: @escaping (Result<String, Error>) -> Void) {

        guard let url = URL(string: "\(baseURL)/auth/signup") else { return }

        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")

        let body = AuthRequest(email: email, password: password)

        request.httpBody = try? JSONEncoder().encode(body)

        URLSession.shared.dataTask(with: request) { data, response, error in

            if let error = error {
                completion(.failure(error))
                return
            }

            guard let httpResponse = response as? HTTPURLResponse else { return }

            // 201 success
            if httpResponse.statusCode == 201,
               let data = data,
               let decoded = try? JSONDecoder().decode(SignupResponse.self, from: data) {
                completion(.success(decoded.message))
                return
            }

            if httpResponse.statusCode == 409 {
                completion(.failure(NSError(domain: "", code: 409, userInfo: [NSLocalizedDescriptionKey : "Email already used"])))
                return
            }

            completion(.failure(NSError(domain: "", code: 0, userInfo: [NSLocalizedDescriptionKey : "Unknown error"])))

        }.resume()
    }

    // MARK: - Login
    func login(email: String, password: String, completion: @escaping (Result<String, Error>) -> Void) {

        guard let url = URL(string: "\(baseURL)/auth/login") else { return }

        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")

        let body = AuthRequest(email: email, password: password)
        request.httpBody = try? JSONEncoder().encode(body)

        URLSession.shared.dataTask(with: request) { data, response, error in

            if let error = error {
                completion(.failure(error))
                return
            }

            guard let httpResponse = response as? HTTPURLResponse else { return }

            if httpResponse.statusCode == 200,
               let data = data,
               let decoded = try? JSONDecoder().decode(LoginResponse.self, from: data) {
                completion(.success(decoded.accessToken))
                return
            }

            if httpResponse.statusCode == 401 {
                completion(.failure(NSError(domain: "", code: 401, userInfo: [NSLocalizedDescriptionKey : "Email or password incorrect"])))
                return
            }

            completion(.failure(NSError(domain: "", code: 0, userInfo: [NSLocalizedDescriptionKey : "Unknown error"])))

        }.resume()
    }
}
