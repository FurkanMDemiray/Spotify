//
//  NewReleaseView.swift
//  Spotify
//
//  Created by Melik Demiray on 14.01.2025.
//

import UIKit

class NewReleaseView: UIView {

    private let newReleaseLabel = UILabelBuilder()
        .text("New Releases")
    // avenirNext-Bold
    .font(UIFont(name: "AvenirNext-Regular", size: 12)!)
        .textColor(.white)
        .build()

    private let singerNameLabel = UILabelBuilder()
        .text("Singer Name")
        .font(UIFont(name: "AvenirNext-Bold", size: 14)!)
        .textColor(.white)
        .build()

    private let singerNameLabel2 = UILabelBuilder()
        .text("Singer Name")
        .font(UIFont(name: "AvenirNext-Bold", size: 14)!)
        .textColor(.white)
        .build()

    private let singerImage = UIImageViewBuilder()
        .contentMode(.scaleAspectFill)
        .clipsToBounds(true)
        .cornerRadius(30)
        .build()

    private let singerVStack = StackBuilder()
        .axis(.vertical)
        .spacing(8)
        .alignment(.leading)
        .distribution(.fill)
        .build()

    private let singerHstack = StackBuilder()
        .axis(.horizontal)
        .spacing(8)
        .alignment(.center)
        .distribution(.fill)
        .build()

    private let albumImage = UIImageViewBuilder()
        .contentMode(.scaleToFill)
        .clipsToBounds(true)
        .build()

    private let playButton = UIImageViewBuilder()
        .contentMode(.scaleAspectFill)
        .clipsToBounds(true)
        .cornerRadius(20) // height widht = 40
    .build()

    private let addFavoriteButton = UIImageViewBuilder()
        .contentMode(.scaleAspectFill)
        .clipsToBounds(true)
        .cornerRadius(15) // height widht = 30
    .build()

    private let songNameLabel = UILabelBuilder()
        .text("Song Name")
        .font(UIFont(name: "AvenirNext-Bold", size: 12)!)
        .textColor(.white)
        .build()

    private let songInfoVStack = StackBuilder()
        .axis(.vertical)
        .spacing(4)
        .alignment(.leading)
        .distribution(.fill)
        .build()

    private let buttonsHStack = StackBuilder()
        .axis(.horizontal)
        .spacing(8)
        .alignment(.center)
        .distribution(.equalSpacing)
        .build()

    private let infoAndButtonsContainerVStack = StackBuilder()
        .axis(.vertical)
        .spacing(8)
        .alignment(.center)
        .distribution(.equalSpacing)
        .backgroundColor(ColorTheme.lightBlack!)
        .build()

    private let songContainerHStack = StackBuilder()
        .axis(.horizontal)
        .alignment(.center)
        .distribution(.fill)
        .build()

    override init(frame: CGRect) {
        super.init(frame: frame)
        setUpUI()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func addTAMIC() {
        newReleaseLabel.translatesAutoresizingMaskIntoConstraints = false
        singerNameLabel.translatesAutoresizingMaskIntoConstraints = false
        singerImage.translatesAutoresizingMaskIntoConstraints = false
        singerVStack.translatesAutoresizingMaskIntoConstraints = false
        singerHstack.translatesAutoresizingMaskIntoConstraints = false
        albumImage.translatesAutoresizingMaskIntoConstraints = false
        playButton.translatesAutoresizingMaskIntoConstraints = false
        addFavoriteButton.translatesAutoresizingMaskIntoConstraints = false
        songNameLabel.translatesAutoresizingMaskIntoConstraints = false
        songInfoVStack.translatesAutoresizingMaskIntoConstraints = false
        buttonsHStack.translatesAutoresizingMaskIntoConstraints = false
        songContainerHStack.translatesAutoresizingMaskIntoConstraints = false
    }

    private func configureSingerVStack() {
        singerVStack.addArrangedSubview(singerNameLabel)
        singerVStack.addArrangedSubview(newReleaseLabel)
    }

    private func configureSingerHStack() {
        singerHstack.addArrangedSubview(singerImage)
        singerHstack.addArrangedSubview(singerVStack)
    }

    private func configureSongInfoVStack() {
        songInfoVStack.addArrangedSubview(songNameLabel)
        songInfoVStack.addArrangedSubview(singerNameLabel2)
    }

    private func configureButtonsHStack() {
        buttonsHStack.addArrangedSubview(addFavoriteButton)
        buttonsHStack.addArrangedSubview(playButton)
    }

    private func configureInfoAndButtonsContainerVStack() {
        infoAndButtonsContainerVStack.addArrangedSubview(songInfoVStack)
        infoAndButtonsContainerVStack.addArrangedSubview(buttonsHStack)
        // only righbottom and topright corner radius
        infoAndButtonsContainerVStack.layer.maskedCorners = [.layerMaxXMaxYCorner, .layerMaxXMinYCorner]
        infoAndButtonsContainerVStack.layer.cornerRadius = 10
    }

    private func configureSongContainerHStack() {
        songContainerHStack.addArrangedSubview(albumImage)
        songContainerHStack.addArrangedSubview(infoAndButtonsContainerVStack)
        songContainerHStack.layer.cornerRadius = 20
    }

    private func configureSingerImageView() {
        singerImage.image = UIImage(named: "ed")
    }

    private func configureAlbumImage() {
        albumImage.image = UIImage(named: "album")
        albumImage.layer.maskedCorners = [.layerMinXMaxYCorner, .layerMinXMinYCorner]
        albumImage.layer.cornerRadius = 10
    }

    private func configurePlayButton() {
        playButton.image = UIImage(systemName: "play.circle.fill")
        playButton.tintColor = .white
    }

    private func configureAddFavoriteButton() {
        addFavoriteButton.image = UIImage(systemName: "plus.circle")
        addFavoriteButton.tintColor = .white
    }

    private func addSubViews() {
        addSubview(singerHstack)
        addSubview(songContainerHStack)
    }	

    private func configureConstraints() {

        // MARK: - Singer HStack
        NSLayoutConstraint.activate([
            singerHstack.topAnchor.constraint(equalTo: topAnchor, constant: 8),
            singerHstack.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 8),
            singerHstack.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -8),
            singerHstack.heightAnchor.constraint(equalToConstant: 70),
            //singerHstack.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -8),

            singerImage.widthAnchor.constraint(equalToConstant: 60),
            singerImage.heightAnchor.constraint(equalToConstant: 60)

            ])

        //MARK: - SongInfoVStack
        NSLayoutConstraint.activate([
            songInfoVStack.topAnchor.constraint(equalTo: infoAndButtonsContainerVStack.topAnchor, constant: 16),
            songInfoVStack.leadingAnchor.constraint(equalTo: infoAndButtonsContainerVStack.leadingAnchor, constant: 16),
            songInfoVStack.trailingAnchor.constraint(equalTo: infoAndButtonsContainerVStack.trailingAnchor, constant: -16)
            ])

        //MARK: - ButtonsHStack
        NSLayoutConstraint.activate([
            buttonsHStack.trailingAnchor.constraint(equalTo: infoAndButtonsContainerVStack.trailingAnchor, constant: -16),
            buttonsHStack.leadingAnchor.constraint(equalTo: infoAndButtonsContainerVStack.leadingAnchor, constant: 16),
            buttonsHStack.bottomAnchor.constraint(equalTo: songContainerHStack.bottomAnchor, constant: -16)
            ,
            ])

        //MARK: - Info and Buttons Container VStack
        NSLayoutConstraint.activate([
            infoAndButtonsContainerVStack.topAnchor.constraint(equalTo: singerHstack.bottomAnchor, constant: 8),
            infoAndButtonsContainerVStack.bottomAnchor.constraint(equalTo: bottomAnchor),
            ])

        // MARK: - Song Container HStack
        NSLayoutConstraint.activate([
            songContainerHStack.topAnchor.constraint(equalTo: singerHstack.bottomAnchor, constant: 8),
            songContainerHStack.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 8),
            songContainerHStack.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -8),
            //songContainerHStack.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -8),
            songContainerHStack.heightAnchor.constraint(equalToConstant: 150),
            songContainerHStack.widthAnchor.constraint(equalTo: widthAnchor, constant: -16),

            albumImage.widthAnchor.constraint(equalToConstant: 125),
            albumImage.heightAnchor.constraint(equalToConstant: 150),

            playButton.widthAnchor.constraint(equalToConstant: 40),
            playButton.heightAnchor.constraint(equalToConstant: 40),

            addFavoriteButton.widthAnchor.constraint(equalToConstant: 30),
            addFavoriteButton.heightAnchor.constraint(equalToConstant: 30)
            ])
    }

    private func setUpUI() {
        configureSingerVStack()
        configureSingerHStack()
        configureSingerImageView()
        configureAlbumImage()
        configurePlayButton()
        configureAddFavoriteButton()
        configureSongInfoVStack()
        configureButtonsHStack()
        configureInfoAndButtonsContainerVStack()
        configureSongContainerHStack()
        addTAMIC()
        addSubViews()
        configureConstraints()
    }
}
