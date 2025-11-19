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

            if httpResponse.statusCode == 201,
               let data = data,
               let decoded = try? JSONDecoder().decode(SignupResponse.self, from: data) {

                completion(.success(decoded.message))
                return
            }

            if httpResponse.statusCode == 400 || httpResponse.statusCode == 409 {
                if let data = data,
                   let decodedError = try? JSONDecoder().decode(AuthErrorResponse.self, from: data) {
                    completion(.failure(NSError(domain: "", code: httpResponse.statusCode, userInfo: [
                        NSLocalizedDescriptionKey: decodedError.error
                    ])))
                } else {
                    completion(.failure(NSError(domain: "", code: httpResponse.statusCode, userInfo: [
                        NSLocalizedDescriptionKey: "Invalid signup information"
                    ])))
                }
                return
            }


            completion(.failure(NSError(domain: "", code: 0, userInfo: [NSLocalizedDescriptionKey : "Unknown error"])))

        }.resume()
    }

    // MARK: - Login
    func login(email: String, password: String, completion: @escaping (Result<String, Error>) -> Void) {
        let url = URL(string: "\(baseURL)/auth/login")!
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")

        let body = AuthRequest(email: email, password: password)

        do {
            request.httpBody = try JSONEncoder().encode(body)
        } catch {
            return completion(.failure(error))
        }

        URLSession.shared.dataTask(with: request) { data, response, error in
            
            if let error = error {
                return completion(.failure(error))
            }
            
            guard let httpResponse = response as? HTTPURLResponse,
                  let data = data else {
                return completion(.failure(NSError(domain: "", code: -1, userInfo: [NSLocalizedDescriptionKey: "No response"])))
            }

            if httpResponse.statusCode == 200 {
                do {
                    let decoded = try JSONDecoder().decode(LoginResponse.self, from: data)
                    completion(.success(decoded.accessToken))
                } catch {
                    completion(.failure(error))
                }
            } else {
                do {
                    let decodedError = try JSONDecoder().decode(AuthErrorResponse.self, from: data)
                    completion(.failure(NSError(domain: "", code: httpResponse.statusCode, userInfo: [
                        NSLocalizedDescriptionKey: decodedError.error
                    ])))
                } catch {
                    completion(.failure(NSError(domain: "", code: httpResponse.statusCode, userInfo: [
                        NSLocalizedDescriptionKey: "Unknown server error"
                    ])))
                }
            }

        }.resume()
    }

}
