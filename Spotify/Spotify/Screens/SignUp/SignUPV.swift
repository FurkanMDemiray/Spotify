//
//  SignUP.swift
//  Spotify
//
//  Created by Melik Demiray on 18.12.2024.
//

import UIKit

class SignUPV: UIViewController {

    @IBOutlet private weak var titleLabel: UILabel!
    @IBOutlet private weak var warningLabel: UILabel!
    @IBOutlet private weak var textField: UITextField!
    @IBOutlet private weak var backImage: UIImageView!

    var viewModel: SignUPVMProtocol! {
        didSet {
            viewModel.delegate = self
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = ColorTheme.black
        setLabels()
    }

    private func setLabels() {
        textField.placeholder = "Please enter your email"
        titleLabel.text = "What's your email?"
        warningLabel.text = "You'll need to confirm this email later."
    }

    @IBAction func nextButtonClicked(_ sender: Any) {
        guard let text = textField.text else { return }
        viewModel.nextButtonClicked(text: text)
    }
}

extension SignUPV: SignUPVMDelegate {
    func showAlert(_ title: String, _ message: String) {
        self.showAlert(
            title: title, message: message)
    }

    func updateLabels() {
        DispatchQueue.main.async { [weak self] in
            guard let self else { return }

            titleLabel.text = "Create a password"
            warningLabel.text = "Password must be at least 6 characters long."
            textField.text = ""
            textField.placeholder = "Please enter your password"
        }
    }
}
