//
//  AlbumItemModel.swift
//  IOS6-HW14-AlekseiKudinov
//
//  Created by Алексей Кудинов on 13.06.2022.
//

import UIKit

class AlbumItemModel: Hashable {

    enum CellType: CaseIterable {
        case album
        case list
    }

    private let identifier = UUID()

    var imageView: UIImage
    var titleLabel: String
    var imageCountLabel: String
    var cellType: CellType

    init(imageView: UIImage, titleLabel: String, imageCountLabel: String, cellType: CellType) {
        self.imageView = imageView
        self.titleLabel = titleLabel
        self.imageCountLabel = imageCountLabel
        self.cellType = cellType
    }

    static func itemsForAlbums() -> [AlbumItemModel] {
        return [
            AlbumItemModel(imageView: UIImage(named: "first")!,
                           titleLabel: "Недавние",
                           imageCountLabel: "456",
                           cellType: .album),
            AlbumItemModel(imageView: UIImage(named: "second")!,
                           titleLabel: "Избранное",
                           imageCountLabel: "132",
                           cellType: .album),
            AlbumItemModel(imageView: UIImage(named: "third")!,
                           titleLabel: "Sochi",
                           imageCountLabel: "372",
                           cellType: .album),
            AlbumItemModel(imageView: UIImage(named: "fourth")!,
                           titleLabel: "Instagram",
                           imageCountLabel: "142",
                           cellType: .album),
            AlbumItemModel(imageView: UIImage(named: "fifth")!,
                           titleLabel: "Vacation",
                           imageCountLabel: "235",
                           cellType: .album),
            AlbumItemModel(imageView: UIImage(named: "sixth")!,
                           titleLabel: "Desert",
                           imageCountLabel: "187",
                           cellType: .album),
            AlbumItemModel(imageView: UIImage(named: "seventh")!,
                           titleLabel: "Cars",
                           imageCountLabel: "98",
                           cellType: .album),
            AlbumItemModel(imageView: UIImage(named: "eighth")!,
                           titleLabel: "Dubai",
                           imageCountLabel: "236",
                           cellType: .album),
            AlbumItemModel(imageView: UIImage(named: "nineth")!,
                           titleLabel: "Safari",
                           imageCountLabel: "38",
                           cellType: .album),
            AlbumItemModel(imageView: UIImage(named: "tenth")!,
                           titleLabel: "Me, My self and I",
                           imageCountLabel: "23",
                           cellType: .album),
            AlbumItemModel(imageView: UIImage(named: "eleventh")!,
                           titleLabel: "Hotel",
                           imageCountLabel: "14",
                           cellType: .album),
            AlbumItemModel(imageView: UIImage(named: "twelfth")!,
                           titleLabel: "Lifestyle",
                           imageCountLabel: "152",
                           cellType: .album)
        ]
    }

    static func itemsForList() -> [AlbumItemModel] {
        
        return [
            AlbumItemModel(imageView: (UIImage(systemName: "video")?.withTintColor(.systemBlue))!,
                           titleLabel: "Видео",
                           imageCountLabel: "231",
                           cellType: .list),
            AlbumItemModel(imageView: (UIImage(systemName: "person.crop.square")?.withTintColor(.systemBlue))!,
                           titleLabel: "Селфи",
                           imageCountLabel: "145",
                           cellType: .list),
            AlbumItemModel(imageView: (UIImage(systemName: "livephoto")?.withTintColor(.systemBlue))!,
                           titleLabel: "Фото Live Photos",
                           imageCountLabel: "256",
                           cellType: .list),
            AlbumItemModel(imageView: (UIImage(systemName: "cube")?.withTintColor(.systemBlue))!,
                           titleLabel: "Портреты",
                           imageCountLabel: "132",
                           cellType: .list),
            AlbumItemModel(imageView: (UIImage(systemName: "pano")?.withTintColor(.systemBlue))!,
                           titleLabel: "Панорамы",
                           imageCountLabel: "15",
                           cellType: .list),
            AlbumItemModel(imageView: (UIImage(systemName: "timelapse")?.withTintColor(.systemBlue))!,
                           titleLabel: "Таймлапс",
                           imageCountLabel: "17",
                           cellType: .list),
            AlbumItemModel(imageView: (UIImage(systemName: "camera.viewfinder")?.withTintColor(.systemBlue))!,
                           titleLabel: "Снимки экрана",
                           imageCountLabel: "56",
                           cellType: .list),
            AlbumItemModel(imageView: (UIImage(systemName: "square.and.arrow.down")?.withTintColor(.systemBlue))!,
                           titleLabel: "Импортированные",
                           imageCountLabel: "54",
                           cellType: .list),
            AlbumItemModel(imageView: (UIImage(systemName: "eye.slash")?.withTintColor(.systemBlue))!,
                           titleLabel: "Скрытые",
                           imageCountLabel: "0",
                           cellType: .list),
            AlbumItemModel(imageView: (UIImage(systemName: "trash")?.withTintColor(.systemBlue))!,
                           titleLabel: "Недавно удаленные",
                           imageCountLabel: "144",
                           cellType: .list),
        ]
    }

    //MARK: -Hashable

    func hash(into hasher: inout Hasher) {
        hasher.combine(identifier)
    }

    static func == (lhs: AlbumItemModel, rhs: AlbumItemModel) -> Bool {
        return lhs.identifier == rhs.identifier
    }

}
