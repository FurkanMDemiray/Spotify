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

    func nextButtonClicked(text: String)
}

protocol SignUPVMDelegate: AnyObject {
    func showAlert(_ title: String, _ message: String)
    func showAlertCompletion(
        _ title: String, _ message: String, completion: @escaping () -> Void)
    func updateLabels()
    func navigateToChooseArtistScreen()
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

    //MARK: Private Functions

    private func signUp(_ email: String, _ password: String) {
        // Call FirebaseManager to sign up
        firebaseManager.signUp(email: email, password: password) {
            [weak self] result in
            guard let self else { return }

            switch result {
            case .success:
                self.delegate?.showAlertCompletion(
                    "Success",
                    "You have successfully signed up.",
                    completion: {
                        self.delegate?.navigateToChooseArtistScreen()
                    })
                break
            case .failure(let error):
                self.delegate?.showAlert(
                    "Error",
                    error.localizedDescription)
                break
            }

        }
    }

    private func checkEmailIsValid(_ email: String) -> Bool {
        let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
        let emailPred = NSPredicate(format: "SELF MATCHES %@", emailRegEx)
        return emailPred.evaluate(with: email)
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

    //MARK: Functions

    func nextButtonClicked(text: String) {
        if !checkEmailIsValid(text) && getState == .email {
            delegate?.showAlert(
                "Invalid Email",
                "Please enter a valid email."
            )
        } else if getState == .password {
            getPassword = text
            signUp(getEmail, getPassword)
        } else if checkEmailIsValid(text) {
            getEmail = text
            getState = .password
            delegate?.updateLabels()
        }
    }

}

enum States {
    case email
    case password
}
