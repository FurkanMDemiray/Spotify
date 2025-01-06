//
//  ChooseArtistV.swift
//  Spotify
//
//  Created by Melik Demiray on 19.12.2024.
//

import UIKit

//MARK: - ChooseArtistV
class ChooseArtistV: UIViewController {

    @IBOutlet private weak var emptyLabel: UILabel!
    @IBOutlet private weak var searchBar: UISearchBar!
    @IBOutlet private weak var collectionView: UICollectionView!

    var viewModel: ChooseArtistVMProtocol! {
        didSet {
            viewModel.delegate = self
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = ColorTheme.black
        setUpConfigures()
    }

    //MARK: - Configure Functions
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

    private func configureSearchBar() {
        searchBar.searchTextField.textColor = .white
        searchBar.searchTextField.tintColor = .white
        searchBar.barTintColor = ColorTheme.black
        searchBar.searchTextField.backgroundColor = ColorTheme.lightBlack
    }

    private func setEmptyLabel() {
        emptyLabel.text = "No artist found."
        emptyLabel.isHidden = true
    }

    private func setUpConfigures() {
        configureCollectionView()
        configureNavigationTitle()
        configureSearchBar()
        setEmptyLabel()
    }

    @IBAction private func doneButtonClicked(_ sender: Any) {
        viewModel.doneButtonClicked()
    }

}

//MARK: - SearchBar
extension ChooseArtistV: UISearchBarDelegate {

    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        viewModel.searchArtist(with: searchText)
    }
}

//MARK: - CollectionView
extension ChooseArtistV: UICollectionViewDelegate, UICollectionViewDataSource {

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if viewModel.getIsSearching {
            return viewModel.getArtistsName.count
        } else {
            return 30
        }
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: Constants.cellIdentifier.rawValue, for: indexPath) as? ArtistCell else { return UICollectionViewCell() }

        let actualIndex = indexPath.item % viewModel.getArtistsName.count

        cell.configureCell(
            with: viewModel.getArtistsName[actualIndex],
            artistImage: viewModel.getArtistImages[actualIndex]
        )

        if viewModel.getSelectedIndexPaths.contains(indexPath) {
            cell.selectCell()
        }
        else {
            cell.deselectCell()
        }

        return cell
    }

    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {

        if viewModel.getSelectedIndexPaths.contains(indexPath) {
            viewModel.getSelectedIndexPaths.removeAll { $0 == indexPath }
        } else {
            viewModel.getSelectedIndexPaths.append(indexPath)
        }
        updateCollectionView()
    }

}

//MARK: - CollectionViewFlowLayout
extension ChooseArtistV: UICollectionViewDelegateFlowLayout {

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {

        let screenWidth = UIScreen.main.bounds.width
        let cellWidth = screenWidth / 3 - 8

        return CGSize(width: cellWidth, height: cellWidth)
    }
}

//MARK: - ChooseArtistVMDelegate
extension ChooseArtistV: ChooseArtistVMDelegate {
    func navigateToMainScreen() {
        let vc = MainV()
        vc.viewModel = MainVM()
        navigationController?.pushViewController(vc, animated: true)
    }
    
    func showEmptyLabel() {
        emptyLabel.isHidden = false
    }

    func hideEmptyLabel() {
        emptyLabel.isHidden = true
    }

    func updateCollectionView() {
        DispatchQueue.main.async { [weak self] in
            self?.collectionView.reloadData()
        }
    }
}

private enum Constants: String {
    case cellIdentifier = "ArtistCell"
}
