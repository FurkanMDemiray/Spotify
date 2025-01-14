//
//  ImageBuilder.swift
//  Spotify
//
//  Created by Melik Demiray on 14.01.2025.
//

import Foundation
import UIKit

class UIImageViewBuilder {
    private let imageView = UIImageView()

    func image(_ image: UIImage?) -> UIImageViewBuilder {
        imageView.image = image
        return self
    }

    func contentMode(_ mode: UIView.ContentMode) -> UIImageViewBuilder {
        imageView.contentMode = mode
        return self
    }

    func clipsToBounds(_ clips: Bool) -> UIImageViewBuilder {
        imageView.clipsToBounds = clips
        return self
    }

    func tintColor(_ color: UIColor) -> UIImageViewBuilder {
        imageView.tintColor = color
        return self
    }

    func cornerRadius(_ radius: CGFloat) -> UIImageViewBuilder {
        imageView.layer.cornerRadius = radius
        return self
    }

    func build() -> UIImageView {
        return imageView
    }
}
