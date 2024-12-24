//
//  ChooseArtistVM.swift
//  Spotify
//
//  Created by Melik Demiray on 19.12.2024.
//

import Foundation

protocol ChooseArtistVMProtocol {
    var delegate: ChooseArtistVMDelegate? { get set }
}

protocol ChooseArtistVMDelegate: AnyObject {

}

final class ChooseArtistVM {

    weak var delegate: ChooseArtistVMDelegate?
}

extension ChooseArtistVM: ChooseArtistVMProtocol {

}
