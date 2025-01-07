//
//  LastPlayedV.swift
//  Spotify
//
//  Created by Melik Demiray on 7.01.2025.
//

import UIKit

class LastPlayedV: UIView {

    private let collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        layout.minimumInteritemSpacing = 8
        layout.minimumLineSpacing = 8
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.register(LastPlayedCell.self, forCellWithReuseIdentifier: LastPlayedCell.identifier)
        collectionView.backgroundColor = ColorTheme.black
        collectionView.showsVerticalScrollIndicator = false
        collectionView.isScrollEnabled = false
        return collectionView
    }()

    private func configureCollectionView() {
        collectionView.delegate = self
        collectionView.dataSource = self
    }

    private let label: UILabel = {
        let label = UILabel()
        label.text = "Last Played"
        label.textColor = .white
        label.font = .systemFont(ofSize: 20, weight: .bold)
        return label
    }()

    private func configureConstraints() {
//        addSubview(label)
//        label.translatesAutoresizingMaskIntoConstraints = false

        addSubview(collectionView)
        collectionView.translatesAutoresizingMaskIntoConstraints = false

        NSLayoutConstraint.activate([
            collectionView.topAnchor.constraint(equalTo: topAnchor, constant: 8),
            collectionView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 8),
            collectionView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -8),
            collectionView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -8)
            ])
    }

    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = ColorTheme.black
        configureCollectionView()
        configureConstraints()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension LastPlayedV: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 8
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: LastPlayedCell.identifier, for: indexPath) as? LastPlayedCell else { return UICollectionViewCell() }
        return cell
    }
}

extension LastPlayedV: UICollectionViewDelegateFlowLayout {

    // MARK: - Size of cell
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = (collectionView.frame.width - 16) / 2
        let height = (collectionView.frame.height - 32) / 4
        return CGSize(width: width, height: height)
    }
}
