//
//  SideMenu.swift
//  Spotify
//
//  Created by Melik Demiray on 1.01.2025.
//

import UIKit

protocol SideMenuDelegate: AnyObject {
    func didTapMenuOption(option: SideMenuOption)
    func hideSideMenu()
}

protocol SideMenuProtocol {
    var delegate: SideMenuDelegate? { get set }
}

enum SideMenuOption: Int, CaseIterable {
    case home
    case search
    case library
}

class SideMenu: UIView, SideMenuProtocol {

    weak var delegate: SideMenuDelegate?

    private let profileView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()

    private let profileImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        imageView.backgroundColor = .gray // Placeholder color
        imageView.layer.cornerRadius = 20
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()

    private let nameLabel: UILabel = {
        let label = UILabel()
        label.text = "Damon98"
        label.font = .systemFont(ofSize: 18, weight: .semibold)
        label.textColor = .white
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    private let viewProfileButton: UIButton = {
        let button = UIButton()
        button.setTitle("View profile", for: .normal)
        button.setTitleColor(.lightGray, for: .normal)
        button.titleLabel?.font = .systemFont(ofSize: 14)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()

    private let menuStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.spacing = 24
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()

    private func addGestureToProfileImage() {
        let gesture = UITapGestureRecognizer(target: self, action: #selector(didTapProfileImage))
        profileImageView.addGestureRecognizer(gesture)
        profileImageView.isUserInteractionEnabled = true
    }

    @objc private func didTapProfileImage() {
        delegate?.hideSideMenu()
    }

    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
        addGestureToProfileImage()
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupUI()
    }

    private func setupUI() {
        backgroundColor = ColorTheme.gray

        // Add views
        addSubview(profileView)
        profileView.addSubview(profileImageView)
        profileView.addSubview(nameLabel)
        profileView.addSubview(viewProfileButton)
        addSubview(menuStackView)

        // Add menu items
        addMenuItem(title: "What's new", systemImage: "bolt.fill")
        addMenuItem(title: "Listening history", systemImage: "clock.fill")
        addMenuItem(title: "Settings and privacy", systemImage: "gearshape.fill")

        // Setup constraints
        NSLayoutConstraint.activate([
            // Profile view constraints
            profileView.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor),
            profileView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16),
            profileView.trailingAnchor.constraint(equalTo: trailingAnchor),
            profileView.heightAnchor.constraint(equalToConstant: 80),

            // Profile image constraints
            profileImageView.leadingAnchor.constraint(equalTo: profileView.leadingAnchor),
            profileImageView.topAnchor.constraint(equalTo: profileView.topAnchor, constant: 12),
            profileImageView.widthAnchor.constraint(equalToConstant: 40),
            profileImageView.heightAnchor.constraint(equalToConstant: 40),

            // Name label constraints
            nameLabel.leadingAnchor.constraint(equalTo: profileImageView.trailingAnchor, constant: 8),
            nameLabel.topAnchor.constraint(equalTo: profileView.topAnchor, constant: 8),

            // View profile button constraints
            viewProfileButton.leadingAnchor.constraint(equalTo: profileImageView.trailingAnchor, constant: 8),
            viewProfileButton.topAnchor.constraint(equalTo: nameLabel.bottomAnchor, constant: 4),

            // Menu stack view constraints
            menuStackView.topAnchor.constraint(equalTo: profileView.bottomAnchor, constant: 24),
            menuStackView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16),
            menuStackView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -16)
            ])
    }

    private func addMenuItem(title: String, systemImage: String) {
        let button = createMenuButton(title: title, systemImage: systemImage)
        menuStackView.addArrangedSubview(button)
    }

    private func createMenuButton(title: String, systemImage: String) -> UIButton {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false

        let imageConfig = UIImage.SymbolConfiguration(pointSize: 22, weight: .regular)
        let image = UIImage(systemName: systemImage, withConfiguration: imageConfig)

        button.setImage(image, for: .normal)
        button.setTitle("  " + title, for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.tintColor = .white
        button.titleLabel?.font = .systemFont(ofSize: 16)
        button.contentHorizontalAlignment = .left
        button.heightAnchor.constraint(equalToConstant: 44).isActive = true

        return button
    }

    // Public method to update username
    func updateUsername(_ username: String) {
        nameLabel.text = username
    }

    // Public method to update profile image
    func updateProfileImage(_ image: UIImage?) {
        profileImageView.image = image
    }
}
