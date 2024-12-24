//
//  ChooseArtistVM.swift
//  Spotify
//
//  Created by Melik Demiray on 19.12.2024.
//

import Foundation

protocol ChooseArtistVMProtocol {
    var delegate: ChooseArtistVMDelegate? { get set }
    var getArtistsName: [String] { get }
    var getArtistImages: [String] { get }
    var getIsSearching: Bool { get }

    func searchArtist(with searchText: String)
}

protocol ChooseArtistVMDelegate: AnyObject {
    func updateCollectionView()
    func showEmptyLabel()
    func hideEmptyLabel()
}

final class ChooseArtistVM {

    weak var delegate: ChooseArtistVMDelegate?

    private let artistsName = ["The Weeknd", "Sagopa Kajmer", "Tarkan", "Billie Ellish", "Ed Sheeran"]
    private let artistImages = ["weeknd", "sagopa", "tarkan", "billie", "ed"]
    private var filteredArtistsName = [String]()
    private var filteredArtistImages = [String]()
    private var isSearching = false

    init() {
        filteredArtistsName = artistsName
        filteredArtistImages = artistImages
    }
}

extension ChooseArtistVM: ChooseArtistVMProtocol {

    var getIsSearching: Bool { isSearching }
    var getArtistsName: [String] { filteredArtistsName }
    var getArtistImages: [String] { filteredArtistImages }

    func searchArtist(with searchText: String) {
        if searchText.isEmpty {
            // Arama metni boşsa, tüm listeyi göster
            filteredArtistsName = artistsName
            filteredArtistImages = artistImages
            isSearching = false
        } else {
            // Sanatçı isimlerine göre indexleri bul
            let filteredIndices = artistsName.enumerated().filter {
                $0.element.lowercased().contains(searchText.lowercased())
            }.map { $0.offset }

            // Bulunan indexleri kullanarak her iki diziyi de filtrele
            filteredArtistsName = filteredIndices.map { artistsName[$0] }
            filteredArtistImages = filteredIndices.map { artistImages[$0] }
            isSearching = true
            filteredArtistsName.count == 0 ? delegate?.showEmptyLabel() : delegate?.hideEmptyLabel()
        }

        delegate?.updateCollectionView()
    }
}
