//
//  FirebaseManager.swift
//  Spotify
//
//  Created by Melik Demiray on 18.12.2024.
//

import Firebase
import FirebaseAuth
import Foundation

protocol FirebaseManagerProtocol {
    //func fetchData(completion: @escaping (Result<[String: Any], Error>) -> Void)
    //func saveData(data: [String: Any], completion: @escaping (Result<Void, Error>) -> Void)

    // Authentication
    func signIn(
        email: String, password: String,
        completion: @escaping (Result<String, Error>) -> Void)
    func signUp(
        email: String, password: String,
        completion: @escaping (Result<String, Error>) -> Void)
    func signOut(completion: @escaping (Result<Void, Error>) -> Void)
    func getCurrentUser() -> String?
}

class FirebaseManager: FirebaseManagerProtocol {

    static let shared = FirebaseManager()
    //private let db = Firestore.firestore()
    private let auth = Auth.auth()

    private init() {}
    // MARK: - Authentication Methods

    func signIn(
        email: String, password: String,
        completion: @escaping (Result<String, Error>) -> Void
    ) {
        auth.signIn(withEmail: email, password: password) { result, error in
            if let error = error {
                completion(.failure(error))
            } else if let user = result?.user {
                completion(.success(user.uid))
            }
        }
    }

    func signUp(
        email: String, password: String,
        completion: @escaping (Result<String, Error>) -> Void
    ) {
        auth.createUser(withEmail: email, password: password) { result, error in
            if let error = error {
                completion(.failure(error))
            } else if let user = result?.user {
                completion(.success(user.uid))
            }
        }
    }

    func signOut(completion: @escaping (Result<Void, Error>) -> Void) {
        do {
            try auth.signOut()
            completion(.success(()))
        } catch {
            completion(.failure(error))
        }
    }

    func getCurrentUser() -> String? {
        return auth.currentUser?.uid
    }
}
