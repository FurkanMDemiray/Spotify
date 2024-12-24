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
}

protocol ChooseArtistVMDelegate: AnyObject {

}

final class ChooseArtistVM {

    weak var delegate: ChooseArtistVMDelegate?

    private let artistsName = ["The Weeknd", "Sagopa Kajmer", "Tarkan", "Billie Ellish", "Ed Sheeran"]
    private let artistImages = ["weeknd", "sagopa", "tarkan", "billie", "ed"]
}

extension ChooseArtistVM: ChooseArtistVMProtocol {

    var getArtistsName: [String] { artistsName }
    var getArtistImages: [String] { artistImages }


}
