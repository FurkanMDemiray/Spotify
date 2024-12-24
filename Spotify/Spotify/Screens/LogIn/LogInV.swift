//
//  LogInV.swift
//  Spotify
//
//  Created by Melik Demiray on 19.12.2024.
//

import UIKit

class LogInV: UIViewController {

    @IBOutlet private weak var passwordTextField: UITextField!
    @IBOutlet private weak var emailTextField: UITextField!

    var viewModel: LoginVMProtocol! {
        didSet {
            viewModel.delegate = self
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = ColorTheme.black
        configureNavigationTitle()
        configureTextFields()
    }

    private func configureTextFields() {
        emailTextField.tintColor = .white
        passwordTextField.tintColor = .white

        emailTextField.textColor = .white
        passwordTextField.textColor = .white
    }

    private func configureNavigationTitle() {

        // modify font and color of title
        let textAttributes = [
            NSAttributedString.Key.foregroundColor: UIColor.black
        ]
        navigationController?.navigationBar.titleTextAttributes = textAttributes
        navigationController?.navigationBar.topItem?.title = "Log In"

    }

    @IBAction private func logInButtonClicked(_ sender: Any) {
        viewModel.loginButtonClicked(
            email: emailTextField.text ?? "",
            password: passwordTextField.text ?? "")
    }
}

extension LogInV: LoginVMDelegate {
    func navigateToChooseArtistScreen() {
        let vc = ChooseArtistV()
        vc.viewModel = ChooseArtistVM()
        navigationController?.pushViewController(vc, animated: true)
    }

    func showAlertCompletion(_ title: String, _ message: String, completion: @escaping () -> Void) {
        self.showAlert(title: title, message: message, completion: completion)
    }

    func showAlert(_ title: String, _ message: String) {
        self.showAlert(title: title, message: message)
    }

}
