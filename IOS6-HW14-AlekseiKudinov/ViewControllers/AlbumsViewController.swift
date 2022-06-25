//
//  AlbumsViewController.swift
//  IOS6-HW14-AlekseiKudinov
//
//  Created by Алексей Кудинов on 11.06.2022.
//

import UIKit

class AlbumsViewController: UIViewController {

    enum Section {
        case albumBody
    }

    var albumsCollectionView: UICollectionView? = nil
    var dataSource: UICollectionViewDiffableDataSource<Section, AlbumItemModel>? = nil

    //MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationItem.leftBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: nil)
        title = "Альбомы"
        configurateCollectionView()
        configureDataSource()
    }

    func configurateCollectionView() {
        let collectionView = UICollectionView(frame: view.frame, collectionViewLayout: generateLayout())
        view.addSubview(collectionView)
        collectionView.autoresizingMask = [.flexibleHeight, .flexibleWidth]
        collectionView.register(AlbumItemCell.self, forCellWithReuseIdentifier: AlbumItemCell.reuseIdentifer)
        albumsCollectionView = collectionView
        collectionView.register(HeaderCollectionReusableView.self,
                                forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader,
                                withReuseIdentifier: HeaderCollectionReusableView.identifier)
    }

    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryViewOfKind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        guard let header = collectionView.dequeueReusableSupplementaryView(
            ofKind: UICollectionView.elementKindSectionHeader,
            withReuseIdentifier: HeaderCollectionReusableView.identifier,
            for: indexPath) as? HeaderCollectionReusableView else {
            return HeaderCollectionReusableView()
        }
        header.configure()
        header.label.text = "Мои альбомы"
        header.button.text = "Все"

        return header
    }

    func collectionView(_ collectionView: UICollectionView, layout collectioniewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        return CGSize(width: view.frame.size.width,
                      height: 50)
    }

    func configureDataSource() {
        dataSource = UICollectionViewDiffableDataSource<Section, AlbumItemModel>(collectionView: albumsCollectionView ?? UICollectionView()) {
            (collectionView: UICollectionView, indexPath: IndexPath, albumItem: AlbumItemModel) -> UICollectionViewCell? in
            guard let cell = collectionView.dequeueReusableCell(
                withReuseIdentifier: AlbumItemCell.reuseIdentifer,
                for: indexPath) as? AlbumItemCell else { fatalError("Ячейка не создана") }

            cell.photo.image = albumItem.photo.image
            cell.title = albumItem.titleLabel
            cell.subTitle = albumItem.imageCountLabel
            return cell
        }

        let snapshot = snapshotForCurrentState()
        dataSource?.apply(snapshot, animatingDifferences: false)
    }

    func snapshotForCurrentState() -> NSDiffableDataSourceSnapshot<Section, AlbumItemModel> {
        var snapshot = NSDiffableDataSourceSnapshot<Section,AlbumItemModel>()
        snapshot.appendSections([Section.albumBody])

        let items = itemsForAlbums()
        snapshot.appendItems(items)

        return snapshot
    }

    private func itemsForAlbums() -> [AlbumItemModel] {
        return [
            AlbumItemModel(photo: UIImageView(image: UIImage(named: "first")),
                           titleLabel: "Недавние",
                           imageCountLabel: "456"),
            AlbumItemModel(photo: UIImageView(image: UIImage(named: "second")),
                           titleLabel: "Избранное",
                           imageCountLabel: "132"),
            AlbumItemModel(photo: UIImageView(image: UIImage(named: "third")),
                           titleLabel: "Sochi",
                           imageCountLabel: "372"),
            AlbumItemModel(photo: UIImageView(image: UIImage(named: "fourth")),
                           titleLabel: "Instagram",
                           imageCountLabel: "142"),
            AlbumItemModel(photo: UIImageView(image: UIImage(named: "fifth")),
                           titleLabel: "Vacation",
                           imageCountLabel: "235"),
            AlbumItemModel(photo: UIImageView(image: UIImage(named: "sixth")),
                           titleLabel: "Desert",
                          imageCountLabel: "187"),
            AlbumItemModel(photo: UIImageView(image: UIImage(named: "seventh")),
                          titleLabel: "Cars",
                          imageCountLabel: "98"),
            AlbumItemModel(photo: UIImageView(image: UIImage(named: "eighth")),
                          titleLabel: "Dubai",
                          imageCountLabel: "236"),
            //            AlbumItemModel(UIImage(named: "nineth")!),
            //            AlbumItemModel(UIImage(named: "tenth")!),
            //            AlbumItemModel(UIImage(named: "eleventh")!),
            //            AlbumItemModel(UIImage(named: "twelfth")!)
        ]
    }

    //MARK: - Initial


    
    //MARK: - Settings

    func generateLayout() -> UICollectionViewLayout {

        let itemSize = NSCollectionLayoutSize(
            widthDimension: .fractionalWidth(1.0),
            heightDimension: .fractionalHeight(1.0))
        let fullPhotoItem = NSCollectionLayoutItem(layoutSize: itemSize)
        fullPhotoItem.contentInsets = NSDirectionalEdgeInsets(
            top: 4,
            leading: 4,
            bottom: 4,
            trailing: 4)

        let groupSize = NSCollectionLayoutSize(
            widthDimension: .fractionalWidth(1.0),
            heightDimension: .fractionalHeight(1.0))
        let group = NSCollectionLayoutGroup.vertical(
            layoutSize: groupSize,
            subitem: fullPhotoItem,
            count: 2
        )
        group.interItemSpacing = .fixed(40.0)

        let rootGroupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .absolute(450))
        let rootGroup = NSCollectionLayoutGroup.horizontal(layoutSize: rootGroupSize, subitem: group, count: 2)

        let section = NSCollectionLayoutSection(group: rootGroup)
        section.orthogonalScrollingBehavior = .continuous
        let layout = UICollectionViewCompositionalLayout(section: section)
        
        return layout
    }
}


