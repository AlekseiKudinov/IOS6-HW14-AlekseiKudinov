//
//  ListItemCell.swift
//  IOS6-HW14-AlekseiKudinov
//
//  Created by Алексей Кудинов on 30.06.2022.
//

import UIKit

class ListItemCell: UICollectionViewCell {
    static let reuseIdentifer = "ListItemCell"

    var photo = UIImageView()

    var titleLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.preferredFont(forTextStyle: .title3)
        label.adjustsFontForContentSizeCategory = true
        label.textColor = .systemBlue
        return label
    }()

    var chevron: UIImageView = {
        let image = UIImageView()
        image.image = UIImage(systemName: "chevron.right")
        image.tintColor = .placeholderText
        return image
    }()

    var imageCountLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.preferredFont(forTextStyle: .subheadline)
        label.adjustsFontForContentSizeCategory = true
        label.textColor = .placeholderText
        return label
    }()

    override init(frame: CGRect) {
        super.init(frame: .zero)
        configure()
    }

    required init?(coder: NSCoder) {
        fatalError()
    }
}

extension ListItemCell {

    func configure(){
        addSubview(photo)
        photo.translatesAutoresizingMaskIntoConstraints = false
        photo.leadingAnchor.constraint(equalTo: leadingAnchor,
                                           constant: 20).isActive = true
        photo.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true

        addSubview(titleLabel)
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        titleLabel.leadingAnchor.constraint(equalTo: photo.trailingAnchor,
                                            constant: 17).isActive = true
        titleLabel.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true

        addSubview(chevron)
        chevron.translatesAutoresizingMaskIntoConstraints = false
        chevron.trailingAnchor.constraint(equalTo: contentView.trailingAnchor,
                                               constant: -20).isActive = true
        chevron.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true

        addSubview(imageCountLabel)
        imageCountLabel.translatesAutoresizingMaskIntoConstraints = false
        imageCountLabel.trailingAnchor.constraint(equalTo: chevron.trailingAnchor,
                                              constant: -30).isActive = true
        imageCountLabel.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
    }
}


