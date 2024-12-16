//
//  StarVC.swift
//  Spotify
//
//  Created by Melik Demiray on 16.12.2024.
//

import UIKit

class StarVC: UIViewController {

    var viewModel: StartVMProtocol! {
        didSet {
            viewModel.delegate = self
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor(hex: "1B1A1C")

    }

}

extension StarVC: StartVMDelegate {

}
