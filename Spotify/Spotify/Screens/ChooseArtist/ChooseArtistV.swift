//
//  ChooseArtistV.swift
//  Spotify
//
//  Created by Melik Demiray on 19.12.2024.
//

import UIKit

class ChooseArtistV: UIViewController {

    @IBOutlet weak var collectionView: UICollectionView!

    var viewModel: ChooseArtistVMProtocol! {
        didSet {
            viewModel.delegate = self
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = ColorTheme.black
        configureCollectionView()
        configureNavigationTitle()
    }

    private func configureNavigationTitle() {
        // modify font and color of title
        let textAttributes = [
            NSAttributedString.Key.foregroundColor: UIColor.white
        ]
        navigationController?.navigationBar.titleTextAttributes = textAttributes
        navigationController?.navigationBar.topItem?.title = "Choose Artist"
    }

    private func configureCollectionView() {
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.backgroundColor = ColorTheme.black

        collectionView.register(
            UINib(nibName: Constants.cellIdentifier.rawValue, bundle: nil),
            forCellWithReuseIdentifier: Constants.cellIdentifier.rawValue
        )
    }

}

extension ChooseArtistV: UICollectionViewDelegate, UICollectionViewDataSource {

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 21
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: Constants.cellIdentifier.rawValue, for: indexPath) as? ArtistCell else { return UICollectionViewCell() }

        let actualIndex = indexPath.item % viewModel.getArtistsName.count

        cell.configureCell(
            with: viewModel.getArtistsName[actualIndex],
            artistImage: viewModel.getArtistImages[actualIndex]
        )
        return cell
    }

}

extension ChooseArtistV: UICollectionViewDelegateFlowLayout {

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {

        let screenWidth = UIScreen.main.bounds.width
        let cellWidth = screenWidth / 3 - 8

        return CGSize(width: cellWidth, height: cellWidth)
    }
}

extension ChooseArtistV: ChooseArtistVMDelegate {

}

private enum Constants: String {
    case cellIdentifier = "ArtistCell"
}
