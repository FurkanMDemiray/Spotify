//
//  StarVC.swift
//  Spotify
//
//  Created by Melik Demiray on 16.12.2024.
//

import UIKit

class StarVC: UIViewController {

    @IBOutlet private weak var appleView: UIView!
    @IBOutlet private weak var facebookView: UIView!
    @IBOutlet private weak var googleView: UIView!
    @IBOutlet private weak var welcomeLabel: UILabel!
    @IBOutlet private weak var signUpButton: UIButton!
    @IBOutlet private weak var logInButton: UIButton!

    var viewModel: StartVMProtocol! {
        didSet {
            viewModel.delegate = self
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = ColorTheme.black
        setConfigures()

    }

    //MARK: - Configurations

    private func configureLabel() {
        welcomeLabel.text = "Millions Of Songs.\nFree On Spotify."
    }

    private func configureViews() {
        let views = [appleView, facebookView, googleView]

        for view in views {
            guard let view = view else { continue }
            view.layer.cornerRadius = 23
            view.layer.borderWidth = 1
            view.layer.borderColor = UIColor.white.cgColor
            view.clipsToBounds = true
            view.backgroundColor = ColorTheme.black

            view.heightAnchor.constraint(equalToConstant: 46).isActive = true

            let gesture = UITapGestureRecognizer(
                target: self, action: #selector(didTapView(_:)))
            view.addGestureRecognizer(gesture)
            view.isUserInteractionEnabled = true

        }
    }

    private func configureSignUpButton() {
        signUpButton.layer.removeAllAnimations()
    }

    private func configureLogInButton() {
        logInButton.layer.removeAllAnimations()
    }

    private func setConfigures() {
        configureLabel()
        configureViews()
        configureSignUpButton()
        configureLogInButton()
    }

    @objc private func didTapView(_ sender: UITapGestureRecognizer) {
        guard let tappedView = sender.view else { return }

        buttonAnimate(tappedView)
        // Handle view-specific actions
        switch tappedView {
        case appleView:
            print("Apple")
        case facebookView:
            print("Facebook")
        case googleView:
            print("Google")
        default:
            break
        }
    }

    private func buttonAnimate(_ view: UIView) {
        UIView.animate(
            withDuration: 0.1,
            animations: {
                // Scale down
                view.transform = CGAffineTransform(
                    scaleX: 0.95, y: 0.95)
            }
        ) { _ in
            UIView.animate(withDuration: 0.1) {
                // Scale back to original size
                view.transform = .identity
            }
        }

    }

    //MARK: - Actions

    @IBAction private func signUpButtonClicked(_ sender: Any) {
        buttonAnimate(signUpButton)
        let vc = SignUPV()
        let viewModel = SignUPVM()
        vc.viewModel = viewModel
        // full screen  modal presentation
        vc.modalPresentationStyle = .fullScreen
        present(vc, animated: true)
    }
    @IBAction private func logInButtonClicked(_ sender: Any) {
        buttonAnimate(logInButton)
        //TODO: Handle log in button click
    }
}

extension StarVC: StartVMDelegate {

}
