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
        textField.placeholder = "Please enter your email"
    }

    @IBAction func nextButtonClicked(_ sender: Any) {

        guard let text = textField.text else { return }

        switch viewModel.getState {
        case .email:
            viewModel.getEmail = text
            viewModel.getState = .password
            break
        case .password:
            textField.text = ""
            textField.placeholder = "Please enter your password"
            viewModel.getPassword = text
            viewModel.signUp(viewModel.getEmail, viewModel.getPassword)
        }

        print(viewModel.getEmail, viewModel.getPassword,viewModel.getState)

    }
}

extension SignUPV: SignUPVMDelegate {

}
