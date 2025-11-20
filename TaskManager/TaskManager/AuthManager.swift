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

    func signup(email: String, password: String, completion: @escaping (Result<String, Error>) -> Void) {

        guard let url = URL(string: "\(baseURL)/auth/signup") else { return }

        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")

        let body: [String: Any] = [
            "email": email,
            "password": password
        ]
        
        request.httpBody = try? JSONSerialization.data(withJSONObject: body)

        URLSession.shared.dataTask(with: request) { data, response, error in

            if let error = error {
                completion(.failure(error))
                return
            }

            let httpResponse = response as? HTTPURLResponse
            let status = httpResponse?.statusCode ?? 0
            
            if status == 201,
               let data = data,
               let decoded = try? JSONDecoder().decode(SignupResponse.self, from: data) {

                completion(.success(decoded.message))
                return
            }

            if status == 400 || status == 409 {
                completion(.failure(NSError(domain: "", code: status, userInfo: [
                    NSLocalizedDescriptionKey : "Email already used"
                ])))
                return
            }


            completion(.failure(NSError(domain: "", code: 0, userInfo: [NSLocalizedDescriptionKey : "Unknown error"])))

        }.resume()
    }

    func login(email: String, password: String, completion: @escaping (Result<String, Error>) -> Void) {
        let url = URL(string: "\(baseURL)/auth/login")!
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")

        let body: [String: Any] = [
            "email": email,
            "password": password
        ]
        
        request.httpBody = try? JSONSerialization.data(withJSONObject: body)


        URLSession.shared.dataTask(with: request) { data, response, error in
            
            if let error = error {
                return completion(.failure(error))
            }
            
            let httpResponse = response as? HTTPURLResponse
            let status = httpResponse?.statusCode ?? 0

            if status == 200 {
                if let json = try? JSONSerialization.jsonObject(with: data!) as? [String: Any],
                   let token = json["accessToken"] as? String {
                    completion(.success(token))
                }
            }
            if status == 401 {
                completion(.failure(NSError(domain: "", code: 401, userInfo: [
                    NSLocalizedDescriptionKey: "Invalid email or password"
                ])))
                return
            }
            else {
                do {
                    let decodedError = try JSONDecoder().decode(AuthErrorResponse.self, from: data!)
                    completion(.failure(NSError(domain: "", code: status, userInfo: [
                        NSLocalizedDescriptionKey: decodedError.error
                    ])))
                } catch {
                    completion(.failure(NSError(domain: "", code: status, userInfo: [
                        NSLocalizedDescriptionKey: "Unknown server error"
                    ])))
                }
            }

        }.resume()
    }

}
