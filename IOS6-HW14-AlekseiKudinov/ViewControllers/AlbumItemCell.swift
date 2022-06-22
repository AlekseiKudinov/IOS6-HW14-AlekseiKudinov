//
//  AlbumItemCell.swift
//  IOS6-HW14-AlekseiKudinov
//
//  Created by Алексей Кудинов on 13.06.2022.
//

import UIKit

class AlbumItemCell: UICollectionViewCell {
    static let reuseIdentifer = "AlbumItemViewCell"

    var photo = UIImageView()
    let titleLabel = UILabel()
    let imageCountLabel = UILabel()
    var title: String? {
      didSet {
        configure()
      }
    }
    var subTitle: String? {
      didSet {
        configure()
      }
    }


    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
    }

    required init?(coder: NSCoder) {
        fatalError()
    }
}

extension AlbumItemCell {

    func configure() {
        photo.translatesAutoresizingMaskIntoConstraints = false
        photo.contentMode = .scaleAspectFill
        photo.layer.masksToBounds = true
        photo.layer.cornerRadius = 6
        contentView.addSubview(photo)
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        titleLabel.text = title
        titleLabel.font = UIFont.preferredFont(forTextStyle: .subheadline)
        titleLabel.adjustsFontForContentSizeCategory = true
        contentView.addSubview(titleLabel)
        imageCountLabel.translatesAutoresizingMaskIntoConstraints = false
        imageCountLabel.text = subTitle
        imageCountLabel.font = UIFont.preferredFont(forTextStyle: .subheadline)
        imageCountLabel.adjustsFontForContentSizeCategory = true
        imageCountLabel.textColor = .placeholderText
        contentView.addSubview(imageCountLabel)

        let spacing = CGFloat(10)

        NSLayoutConstraint.activate([
            photo.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            photo.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            photo.topAnchor.constraint(equalTo: contentView.topAnchor),
            photo.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),

            titleLabel.topAnchor.constraint(equalTo: photo.bottomAnchor, constant: spacing),
            titleLabel.leadingAnchor.constraint(equalTo: photo.leadingAnchor),
            titleLabel.trailingAnchor.constraint(equalTo: photo.trailingAnchor),

            imageCountLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor),
            imageCountLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            imageCountLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
        ])
    }
}
