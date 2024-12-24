//
//  LoginVM.swift
//  Spotify
//
//  Created by Melik Demiray on 19.12.2024.
//

import Foundation

protocol LoginVMProtocol {
    var delegate: LoginVMDelegate? { get set }

    func loginButtonClicked(email: String, password: String)
}

protocol LoginVMDelegate: AnyObject {
    func showAlertCompletion(
        _ title: String, _ message: String, completion: @escaping () -> Void)
    func showAlert(_ title: String, _ message: String)
    func navigateToChooseArtistScreen()
}

final class LogInVM {

    weak var delegate: LoginVMDelegate?

    private let firebaseManager: FirebaseManagerProtocol

    init(firebaseManager: FirebaseManagerProtocol = FirebaseManager.shared) {
        self.firebaseManager = firebaseManager
    }

}

extension LogInVM: LoginVMProtocol {
    func loginButtonClicked(email: String, password: String) {
        // Call FirebaseManager to login
        firebaseManager.signIn(email: email, password: password) {
            [weak self] result in
            guard let self else { return }

            switch result {
            case .success:
                self.delegate?.navigateToChooseArtistScreen()
                //                self.delegate?.showAlertCompletion(
                //                    "Success",
                //                    "You have successfully logged in.",
                //                    completion: {
                //                        self.delegate?.navigateToChooseArtistScreen()
                //                    })
                break
            case .failure(let error):
                self.delegate?.showAlert(
                    "Error",
                    error.localizedDescription)
                break
            }
        }

    }

}
