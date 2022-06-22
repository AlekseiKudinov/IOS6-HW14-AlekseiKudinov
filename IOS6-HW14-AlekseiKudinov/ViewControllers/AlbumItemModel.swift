//
//  AlbumItemModel.swift
//  IOS6-HW14-AlekseiKudinov
//
//  Created by Алексей Кудинов on 13.06.2022.
//

import UIKit

class AlbumItemModel: Hashable {

    private let identifier = UUID()

    var photo: UIImageView
    var titleLabel: String
    var imageCountLabel: String

    init(photo: UIImageView, titleLabel: String, imageCountLabel: String) {
        self.photo = photo
        self.titleLabel = titleLabel
        self.imageCountLabel = imageCountLabel
    }

    //MARK: -Hashable

    func hash(into hasher: inout Hasher) {
      hasher.combine(identifier)
    }

    static func == (lhs: AlbumItemModel, rhs: AlbumItemModel) -> Bool {
      return lhs.identifier == rhs.identifier
    }

}
