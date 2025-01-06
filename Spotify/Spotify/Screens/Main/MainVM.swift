//
//  MainVM.swift
//  Spotify
//
//  Created by Melik Demiray on 1.01.2025.
//

import Foundation

protocol MainVMProtocol {
    var delegate: MainVMDelegate? { get set }
}

protocol MainVMDelegate: AnyObject {

}

final class MainVM {

    weak var delegate: MainVMDelegate?
}

extension MainVM: MainVMProtocol {
}




