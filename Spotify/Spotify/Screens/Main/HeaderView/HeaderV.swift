//
//  HeaderV.swift
//  Spotify
//
//  Created by Melik Demiray on 1.01.2025.
//

import UIKit

protocol HeaderVDelegate: AnyObject {
    func didTapProfileImage()
}

protocol HeaderVProtocol {
    var delegate: HeaderVDelegate? { get set }
}

class HeaderV: UIView, HeaderVProtocol {
    //MARK: - Delegate
    weak var delegate: HeaderVDelegate?


    //MARK: - Properties
    private let hStackView: UIStackView = {
        let stack = UIStackView()
        stack.axis = .horizontal
        stack.alignment = .leading
        stack.distribution = .fill
        stack.spacing = 8
        stack.translatesAutoresizingMaskIntoConstraints = false
        return stack
    }()

    private let profileImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(systemName: "person")
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        imageView.layer.cornerRadius = imageView.frame.height / 2
        imageView.layer.borderWidth = 1
        imageView.layer.borderColor = ColorTheme.black?.cgColor
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()

    private let allButton: UIButton = {
        let button = UIButton()
        var configuration = UIButton.Configuration.filled()
        configuration.cornerStyle = .capsule
        configuration.baseBackgroundColor = ColorTheme.gray
        configuration.baseForegroundColor = .white

        button.configuration = configuration
        button.setTitle("All", for: .normal)
        button.titleLabel?.font = UIFont(name: "AvenirNext-Regular", size: 16)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()

    private let musicButton: UIButton = {
        let button = UIButton()
        var configuration = UIButton.Configuration.filled()
        configuration.cornerStyle = .capsule
        configuration.baseBackgroundColor = ColorTheme.gray
        configuration.baseForegroundColor = .white

        button.configuration = configuration
        button.setTitle("Music", for: .normal)
        button.titleLabel?.font = UIFont(name: "AvenirNext-Regular", size: 16)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()

    private let podcastButton: UIButton = {
        let button = UIButton()
        var configuration = UIButton.Configuration.filled()
        configuration.cornerStyle = .capsule
        configuration.baseBackgroundColor = ColorTheme.gray
        configuration.baseForegroundColor = .white

        button.configuration = configuration
        button.setTitle("Podcasts", for: .normal)
        button.titleLabel?.font = UIFont(name: "AvenirNext-Regular", size: 16)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()

    //MARK: - Helpers
    private func configureStackView() {
        hStackView.addArrangedSubview(profileImageView)
        hStackView.addArrangedSubview(allButton)
        hStackView.addArrangedSubview(musicButton)
        hStackView.addArrangedSubview(podcastButton)
        addSubview(hStackView)

        NSLayoutConstraint.activate([
            hStackView.topAnchor.constraint(equalTo: topAnchor, constant: 8),
            hStackView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 8),
            hStackView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -8),

            profileImageView.widthAnchor.constraint(equalToConstant: 40),
            profileImageView.heightAnchor.constraint(equalToConstant: 40)
            ])

        profileImageView.layer.cornerRadius = 20
    }

    private func addGestureToProfileImageView() {
        let gesture = UITapGestureRecognizer(target: self, action: #selector(profileImageViewTapped))
        profileImageView.addGestureRecognizer(gesture)
        profileImageView.isUserInteractionEnabled = true
    }

    @objc private func profileImageViewTapped() {
        delegate?.didTapProfileImage()
    }

    init() {
        super.init(frame: .zero)
        configureStackView()
        addGestureToProfileImageView()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}
