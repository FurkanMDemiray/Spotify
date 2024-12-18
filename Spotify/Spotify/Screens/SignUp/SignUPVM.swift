//
//  SignUPVM.swift
//  Spotify
//
//  Created by Melik Demiray on 18.12.2024.
//

import Foundation

protocol SignUPVMProtocol {
    var delegate: SignUPVMDelegate? { get set }
    var getState: States { get set }
    var getEmail: String { get set }
    var getPassword: String { get set }

    func signUp(_ email: String, _ password: String)
}

protocol SignUPVMDelegate: AnyObject {

}

final class SignUPVM {

    weak var delegate: SignUPVMDelegate?
    private let firebaseManager: FirebaseManagerProtocol
    private var email: String = ""
    private var password: String = ""
    private var state: States = .email

    init(firebaseManager: FirebaseManagerProtocol = FirebaseManager.shared) {
        self.firebaseManager = firebaseManager
    }

}

extension SignUPVM: SignUPVMProtocol {
    var getEmail: String {
        get {
            email
        }
        set {
            email = newValue
        }
    }

    var getPassword: String {
        get {
            password
        }
        set {
            password = newValue
        }
    }

    var getState: States {
        get {
            state
        }
        set {
            state = newValue
        }
    }

    func signUp(_ email: String, _ password: String) {
        // Call FirebaseManager to sign up
        firebaseManager.signUp(email: email, password: password) {
            [weak self] result in
            guard let self else { return }

            switch result {
            case .success:
                // Show success message
                print("email: \(email) password: \(password)")
                break
            case .failure(let error):
                // Show error message
                print(error)
                break
            }

        }
    }

}

enum States {
    case email
    case password
}
