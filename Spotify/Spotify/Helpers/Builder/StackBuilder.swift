//
//  StackBuilder.swift
//  Spotify
//
//  Created by Melik Demiray on 14.01.2025.
//

import Foundation
import UIKit

class StackBuilder {
    private var stackView: UIStackView

    init() {
        stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
    }

    func axis(_ axis: NSLayoutConstraint.Axis) -> StackBuilder {
        stackView.axis = axis
        return self
    }

    func spacing(_ spacing: CGFloat) -> StackBuilder {
        stackView.spacing = spacing
        return self
    }

    func distribution(_ distribution: UIStackView.Distribution) -> StackBuilder {
        stackView.distribution = distribution
        return self
    }

    func alignment(_ alignment: UIStackView.Alignment) -> StackBuilder {
        stackView.alignment = alignment
        return self
    }

    func backgroundColor(_ color: UIColor) -> StackBuilder {
        stackView.backgroundColor = color
        return self
    }

    func addArrangedSubview(_ view: UIView) -> StackBuilder {
        stackView.addArrangedSubview(view)
        return self
    }

    func addArrangedSubviews(_ views: [UIView]) -> StackBuilder {
        views.forEach { stackView.addArrangedSubview($0) }
        return self
    }

    func isLayoutMarginsRelativeArrangement(_ isRelative: Bool) -> StackBuilder {
        stackView.isLayoutMarginsRelativeArrangement = isRelative
        return self
    }

    func layoutMargins(_ margins: UIEdgeInsets) -> StackBuilder {
        stackView.layoutMargins = margins
        return self
    }

    func build() -> UIStackView {
        return stackView
    }
}


