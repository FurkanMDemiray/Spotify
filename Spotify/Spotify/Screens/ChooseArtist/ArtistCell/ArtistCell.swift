//
//  Cell.swift
//  Spotify
//
//  Created by Melik Demiray on 19.12.2024.
//

import UIKit

final class ArtistCell: UICollectionViewCell {

    @IBOutlet private weak var backGroundView: UIView!
    @IBOutlet private weak var imageView: UIImageView!
    @IBOutlet private weak var label: UILabel!

    private let artistsName = ["The Weeknd", "Sagopa Kajmer", "Tarkan", "Billie Ellish", "Ed Sheeran"]
    private let artistImages = ["weeknd", "sagopa", "tarkan", "billie", "ed"]

    override func awakeFromNib() {
        super.awakeFromNib()
        configureImageVIew()
        configureCell()
        backGroundView.backgroundColor = ColorTheme.black
    }

    private func configureImageVIew() {
        imageView.layer.cornerRadius = imageView.frame.height / 2
        imageView.layer.borderWidth = 1
        // border color with opaticy
        imageView.layer.borderColor = UIColor.white.withAlphaComponent(0.1).cgColor
        // shadow
        imageView.layer.shadowColor = UIColor.white.cgColor
        imageView.clipsToBounds = true
        imageView.contentMode = .scaleAspectFill
    }

    private func configureCell() {
        let randomIndex = Int.random(in: 0..<artistsName.count)
        label.text = artistsName[randomIndex]
        imageView.image = UIImage(named: artistImages[randomIndex])
    }

}
