//
//  PlayCardView.swift
//  Spotify
//
//  Created by Melik Demiray on 23.01.2025.
//

import UIKit

protocol PlayCardViewProtocol {
    var delegate: PlayCardViewDelegate? { get set }
}

protocol PlayCardViewDelegate: AnyObject {
    func didTapPlayButton()
}


class PlayCardView: UIView {

    weak var delegate: PlayCardViewDelegate?

    private let cardView: UIView = {
        let view = UIView()
        view.backgroundColor = ColorTheme.lightBlack
        view.layer.cornerRadius = 10
        view.layer.masksToBounds = true
        return view
    }()

    //MARK: - Song Info
    private let songName = UILabelBuilder()
        .text("Song Name")
        .font(UIFont(name: "AvenirNext-Bold", size: 14)!)
        .textColor(.white)
        .build()

    private let singerName = UILabelBuilder()
        .text("Singer Name")
        .font(UIFont(name: "AvenirNext-Regular", size: 12)!)
        .textColor(.white.withAlphaComponent(0.7))
        .build()

    private let singerImage = UIImageViewBuilder()
        .contentMode(.scaleAspectFill)
        .clipsToBounds(true)
        .cornerRadius(30)
        .build()

    private let songInfoVStack = UIStackViewBuilder()
        .axis(.vertical)
        .alignment(.leading)
        .distribution(.fill)
        .spacing(8)
        .build()

    private let songInfoHStack = UIStackViewBuilder()
        .axis(.horizontal)
        .alignment(.center)
        .distribution(.fill)
        .spacing(8)
        .build()

    //MARK: Buttons

    private let buttonsHStack = UIStackViewBuilder()
        .axis(.horizontal)
        .alignment(.center)
        .distribution(.equalSpacing)
        .spacing(16)
        .build()

    private let playButton = UIImageViewBuilder()
        .image(UIImage(systemName: "play.fill"))
        .tintColor(.white)
        .contentMode(.scaleAspectFill)
        .build()

    private let pcButton = UIImageViewBuilder()
        .image(UIImage(systemName: "play.desktopcomputer"))
        .tintColor(.gray)
        .contentMode(.scaleAspectFill)
        .build()

    private let cardHStack = UIStackViewBuilder()
        .axis(.horizontal)
        .alignment(.center)
        .distribution(.equalSpacing)
        .spacing(8)
        .build()

    override init(frame: CGRect) {
        super.init(frame: frame)
        setUpUI()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func configureSingerImageView() {
        singerImage.image = UIImage(named: "ed")
    }

    private func configureSongInfoVStack() {
        songInfoVStack.addArrangedSubview(songName)
        songInfoVStack.addArrangedSubview(singerName)
    }

    private func configureInfoHStack() {
        songInfoHStack.addArrangedSubview(singerImage)
        songInfoHStack.addArrangedSubview(songInfoVStack)
    }

    private func configureButtonsHStack() {
        buttonsHStack.addArrangedSubview(pcButton)
        buttonsHStack.addArrangedSubview(playButton)
    }

    private func addGestureToPlayButton() {
        let gesture = UITapGestureRecognizer(target: self, action: #selector(didTapPlayButton))
        playButton.isUserInteractionEnabled = true
        playButton.addGestureRecognizer(gesture)
    }

    private func configureCardHStack() {
        cardHStack.addArrangedSubview(songInfoHStack)
        cardHStack.addArrangedSubview(buttonsHStack)
    }

    private func configureCardView() {
        addSubview(cardView)
        cardView.addSubview(cardHStack)
    }

    private func setTAMIC() {
        cardView.translatesAutoresizingMaskIntoConstraints = false
        songInfoHStack.translatesAutoresizingMaskIntoConstraints = false
        singerImage.translatesAutoresizingMaskIntoConstraints = false
        songInfoVStack.translatesAutoresizingMaskIntoConstraints = false
        songName.translatesAutoresizingMaskIntoConstraints = false
        singerName.translatesAutoresizingMaskIntoConstraints = false
        buttonsHStack.translatesAutoresizingMaskIntoConstraints = false
        playButton.translatesAutoresizingMaskIntoConstraints = false
        pcButton.translatesAutoresizingMaskIntoConstraints = false
        cardHStack.translatesAutoresizingMaskIntoConstraints = false
    }

    private func configureConstrainst() {
        NSLayoutConstraint.activate([

            // CardView constraints to fill the parent view
            cardView.topAnchor.constraint(equalTo: topAnchor),
            cardView.leadingAnchor.constraint(equalTo: leadingAnchor),
            cardView.trailingAnchor.constraint(equalTo: trailingAnchor),
            cardView.bottomAnchor.constraint(equalTo: bottomAnchor),

            // CardHStack constraints inside CardView with padding
            cardHStack.topAnchor.constraint(equalTo: cardView.topAnchor, constant: 8),
            cardHStack.leadingAnchor.constraint(equalTo: cardView.leadingAnchor, constant: 16),
            cardHStack.trailingAnchor.constraint(equalTo: cardView.trailingAnchor, constant: -16),
            cardHStack.bottomAnchor.constraint(equalTo: cardView.bottomAnchor, constant: -8),

            // SongInfoHStack constraints - align to left
            songInfoHStack.leadingAnchor.constraint(equalTo: cardHStack.leadingAnchor),
            songInfoHStack.centerYAnchor.constraint(equalTo: cardHStack.centerYAnchor),

            // ButtonsHStack constraints - align to right
            buttonsHStack.trailingAnchor.constraint(equalTo: cardHStack.trailingAnchor),
            buttonsHStack.centerYAnchor.constraint(equalTo: cardHStack.centerYAnchor),

            // SingerImage size constraints
            singerImage.widthAnchor.constraint(equalToConstant: 60),
            singerImage.heightAnchor.constraint(equalToConstant: 60),

            // PlayButton size constraints
            playButton.widthAnchor.constraint(equalToConstant: 30),
            playButton.heightAnchor.constraint(equalToConstant: 30),

            // PCButton size constraints
            pcButton.widthAnchor.constraint(equalToConstant: 30),
            pcButton.heightAnchor.constraint(equalToConstant: 30),

            ])
    }

    private func setUpUI() {
        setTAMIC()
        configureSingerImageView()
        configureSongInfoVStack()
        configureInfoHStack()
        configureButtonsHStack()
        addGestureToPlayButton()
        configureCardHStack()
        configureCardView()
        configureConstrainst()
    }

    @objc private func didTapPlayButton() {
        delegate?.didTapPlayButton()
    }

    func updatePlayButtonState(isPlaying: Bool) {
        let imageName = isPlaying ? "pause.fill" : "play.fill"
        playButton.image = UIImage(systemName: imageName)
    }

}

extension PlayCardView: PlayCardViewProtocol {

}

