//
//  LabelBuilder.swift
//  Spotify
//
//  Created by Melik Demiray on 14.01.2025.
//

import Foundation
import UIKit

class UILabelBuilder {
    private let label = UILabel()

    func text(_ text: String) -> UILabelBuilder {
        label.text = text
        return self
    }

    func font(_ font: UIFont) -> UILabelBuilder {
        label.font = font
        return self
    }

    func textColor(_ color: UIColor) -> UILabelBuilder {
        label.textColor = color
        return self
    }

    func textAlignment(_ alignment: NSTextAlignment) -> UILabelBuilder {
        label.textAlignment = alignment
        return self
    }

    func numberOfLines(_ lines: Int) -> UILabelBuilder {
        label.numberOfLines = lines
        return self
    }

    func build() -> UILabel {
        return label
    }
}

// MARK: - Stack View Builder
class UIStackViewBuilder {
    private let stackView = UIStackView()

    func axis(_ axis: NSLayoutConstraint.Axis) -> UIStackViewBuilder {
        stackView.axis = axis
        return self
    }

    func distribution(_ distribution: UIStackView.Distribution) -> UIStackViewBuilder {
        stackView.distribution = distribution
        return self
    }

    func alignment(_ alignment: UIStackView.Alignment) -> UIStackViewBuilder {
        stackView.alignment = alignment
        return self
    }

    func spacing(_ spacing: CGFloat) -> UIStackViewBuilder {
        stackView.spacing = spacing
        return self
    }

    func addArrangedSubview(_ view: UIView) -> UIStackViewBuilder {
        stackView.addArrangedSubview(view)
        return self
    }

    func build() -> UIStackView {
        return stackView
    }
}
