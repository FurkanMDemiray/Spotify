//
//  StartVM.swift
//  Spotify
//
//  Created by Melik Demiray on 16.12.2024.
//

import Foundation

protocol StartVMProtocol {
    var delegate: StartVMDelegate? { get set }
}

protocol StartVMDelegate: AnyObject {

}

final class StartVM {

    weak var delegate: StartVMDelegate?

}

extension StartVM: StartVMProtocol {

}
