//
//  Alert.swift
//  Spotify
//
//  Created by Melik Demiray on 18.12.2024.
//

import Foundation
import UIKit

extension UIViewController {
    func showAlert(
        title: String, message: String, completion: @escaping () -> Void
    ) {
        let alert = UIAlertController(
            title: title, message: message, preferredStyle: .alert)
        alert.addAction(
            UIAlertAction(
                title: "OK", style: .default,
                handler: { _ in
                    completion()
                }))
        present(alert, animated: true, completion: nil)
    }

    func showAlert(title: String, message: String) {
        let alert = UIAlertController(
            title: title, message: message, preferredStyle: .alert)
        alert.addAction(
            UIAlertAction(title: "OK", style: .default, handler: nil))
        present(alert, animated: true, completion: nil)
    }
}
