//
//  MainV.swift
//  Spotify
//
//  Created by Melik Demiray on 1.01.2025.
//

import UIKit

class MainV: UIViewController {

    // MARK: - Properties
    var viewModel: MainVMProtocol! {
        didSet {
            viewModel.delegate = self
        }
    }

    // MARK: - UI Properties
    private let scrollView: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        scrollView.backgroundColor = ColorTheme.black
        scrollView.showsVerticalScrollIndicator = true
        scrollView.alwaysBounceVertical = true
        return scrollView
    }()

    private let contentView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = ColorTheme.black
        return view
    }()

    private let stackView: UIStackView = {
        let stack = UIStackView()
        stack.translatesAutoresizingMaskIntoConstraints = false
        stack.axis = .vertical
        stack.spacing = 8
        stack.distribution = .fill
        stack.alignment = .fill
        return stack
    }()

    //MARK: Header Menu
    private let headerView: HeaderV = {
        let view = HeaderV()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()

    //MARK: Side Menu
    private let sideMenuView: SideMenu = {
        let view = SideMenu()
        view.isHidden = true
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()

    //MARK: Last Played View
    private let lastPlayedView: LastPlayedV = {
        let view = LastPlayedV()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()

    //MARK: New Release
    private let newReleaseView: NewReleaseView = {
        let view = NewReleaseView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()

    //MARK: - PlayCard
    private let playCard: PlayCardView = {
        let view = PlayCardView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()

    private func setDelegates() {
        sideMenuView.delegate = self
        headerView.delegate = self
        playCard.delegate = self
    }

    // MARK: - LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setDelegates()
        setupUI()
        addSampleContent()
    }

    // MARK: - Helpers
    private func setupUI() {
        view.backgroundColor = ColorTheme.black

        // Add scrollView to main view
        view.addSubview(scrollView)

        // Add playCard to main view (scrollView'dan sonra ekliyoruz ki üstte görünsün)
        view.addSubview(playCard)

        // Add side menu to main view
        view.addSubview(sideMenuView)

        // Optionally update profile
        sideMenuView.updateUsername("Furkan")
        sideMenuView.updateProfileImage(UIImage(named: "ed"))

        // Add contentView to scrollView
        scrollView.addSubview(contentView)

        // Add stackView to contentView
        contentView.addSubview(stackView)

        // Set up constraints
        NSLayoutConstraint.activate([
            // ScrollView constraints - playCard için bottom padding ekliyoruz
            scrollView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            scrollView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            scrollView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            scrollView.bottomAnchor.constraint(equalTo: playCard.topAnchor, constant: -8), // PlayCard'a kadar

            // PlayCard constraints
            playCard.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 8),
            playCard.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -8),
            playCard.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -8),
            playCard.heightAnchor.constraint(equalToConstant: 80), // Yüksekliği sabit

            // ContentView constraints
            contentView.topAnchor.constraint(equalTo: scrollView.topAnchor),
            contentView.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor),
            contentView.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor),
            contentView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor),
            contentView.widthAnchor.constraint(equalTo: scrollView.widthAnchor),

            // StackView constraints
            stackView.topAnchor.constraint(equalTo: contentView.topAnchor),
            stackView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            stackView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            stackView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),

            // SideMenu constraints
            sideMenuView.topAnchor.constraint(equalTo: view.topAnchor),
            sideMenuView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            sideMenuView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            sideMenuView.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.8)
            ])
    }

    private func addSampleContent() {
        stackView.addArrangedSubview(headerView)
        stackView.addArrangedSubview(lastPlayedView)
        stackView.addArrangedSubview(newReleaseView)

        // Update height to accommodate 4 rows (4 * 200 + padding)
        lastPlayedView.heightAnchor.constraint(equalToConstant: 300).isActive = true
    }

    // Function to show the side menu with slide animation
    private func showSideMenu() {
        DispatchQueue.main.async { [weak self] in
            guard let self else { return }

            self.sideMenuView.isHidden = false
            self.sideMenuView.transform = CGAffineTransform(translationX: -self.sideMenuView.frame.width, y: 0)
            UIView.animate(withDuration: 0.3, animations: {
                self.sideMenuView.transform = .identity
            })
        }
    }

    // Function to hide the side menu with slide animation
    private func hideSideMenuAnimation() {
        DispatchQueue.main.async { [weak self] in
            guard let self else { return }

            UIView.animate(withDuration: 0.3, animations: {
                self.sideMenuView.transform = CGAffineTransform(translationX: -self.sideMenuView.frame.width, y: 0)
            }, completion: { _ in
                    self.sideMenuView.isHidden = true
                })
        }
    }
}

extension MainV: MainVMDelegate {
    func updatePlayButtonState(isPlaying: Bool) {
        playCard.updatePlayButtonState(isPlaying: isPlaying)
    }
}

extension MainV: HeaderVDelegate {
    func didTapProfileImage() {
        DispatchQueue.main.async() { [weak self] in
            guard let self else { return }
            showSideMenu()
            sideMenuView.updateUsername("Furkan")
            sideMenuView.updateProfileImage(UIImage(systemName: "person.fill"))
        }
    }
}

extension MainV: SideMenuDelegate {
    func hideSideMenu() {
        DispatchQueue.main.async() {
            self.hideSideMenuAnimation()
        }
    }

    func didTapMenuOption(option: SideMenuOption) {
        //
    }

}

extension MainV: PlayCardViewDelegate {
    func didTapPlayButton() {
        viewModel.playSound()
    }
}



