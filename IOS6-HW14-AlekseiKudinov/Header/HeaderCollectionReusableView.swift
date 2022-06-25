//
//  HeaderCollectionReusableView.swift
//  IOS6-HW14-AlekseiKudinov
//
//  Created by Алексей Кудинов on 25.06.2022.
//

import UIKit

class HeaderCollectionReusableView: UICollectionReusableView {

    static let identifier = "HeaderCollectionReusableView"

    lazy var separators: UIView = {
        let separator = UIView()
        separator.backgroundColor = .systemGray
        return separator
    }()

    lazy var label: UILabel = {
        let label = UILabel()
        label.textAlignment = .left
        label.font = .systemFont(ofSize: 22, weight: .semibold)
        label.textColor = .black
        return label
    }()

    lazy var button: UILabel = {
        let button = UILabel()
        button.textAlignment = .right
        button.font = .systemFont(ofSize: 18, weight: .regular)
        button.textColor = .systemBlue
        return button
    }()
}

extension HeaderCollectionReusableView {

    public func configure() {

        addSubview(label)
        addSubview(separators)
        addSubview(button)

        label.translatesAutoresizingMaskIntoConstraints = false
        separators.translatesAutoresizingMaskIntoConstraints = false
        button.translatesAutoresizingMaskIntoConstraints = false

        NSLayoutConstraint.activate([
            label.leadingAnchor.constraint(equalTo: leadingAnchor),
            label.trailingAnchor.constraint(equalTo: trailingAnchor),
            label.topAnchor.constraint(equalTo: topAnchor),
            label.bottomAnchor.constraint(equalTo: bottomAnchor),

            separators.leadingAnchor.constraint(equalTo: layoutMarginsGuide.leadingAnchor),
            separators.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            separators.bottomAnchor.constraint(equalTo: label.topAnchor),
            separators.heightAnchor.constraint(equalToConstant: 1),

            button.topAnchor.constraint(equalTo: label.topAnchor),
            button.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -15),
            button.bottomAnchor.constraint(equalTo: label.bottomAnchor)
        ])
    }
}
