//
//  AlbumsViewController.swift
//  IOS6-HW14-AlekseiKudinov
//
//  Created by Алексей Кудинов on 11.06.2022.
//

import UIKit

class AlbumsViewController: UIViewController {

    enum Section: CaseIterable {
        case firstSection
        case secondSection
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
}

extension AlbumsViewController {

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

        dataSource?.supplementaryViewProvider = { (
          collectionView: UICollectionView,
          kind: String,
          indexPath: IndexPath) -> UICollectionReusableView? in

          guard let supplementaryView = collectionView.dequeueReusableSupplementaryView(
            ofKind: kind,
            withReuseIdentifier: HeaderCollectionReusableView.identifier,
            for: indexPath) as? HeaderCollectionReusableView else { fatalError("Хедер не создан") }
            supplementaryView.configure()

            switch indexPath.section  {
            case 0:
                supplementaryView.label.text = "Мои альбомы"
                supplementaryView.button.text = "Все"
            case 1:
                supplementaryView.label.text = "Люди и места"
                supplementaryView.button.text = "Все"
            default:
                break
            }
          return supplementaryView
        }


        let snapshot = snapshotForCurrentState()
        dataSource?.apply(snapshot, animatingDifferences: false)
    }

    func snapshotForCurrentState() -> NSDiffableDataSourceSnapshot<Section, AlbumItemModel> {
        var snapshot = NSDiffableDataSourceSnapshot<Section,AlbumItemModel>()

        let itemsForFirstSection = Array(itemsForAlbums().prefix(8))
        let itemsForSecondSection = Array(itemsForAlbums().suffix(4))

        snapshot.appendSections([Section.firstSection])
        snapshot.appendItems(itemsForFirstSection)

        snapshot.appendSections([Section.secondSection])
        snapshot.appendItems(itemsForSecondSection)

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
            AlbumItemModel(photo: UIImageView(image: UIImage(named: "nineth")),
                           titleLabel: "Safari",
                           imageCountLabel: "38"),
            AlbumItemModel(photo: UIImageView(image: UIImage(named: "tenth")),
                           titleLabel: "Me, My self and I",
                           imageCountLabel: "23"),
            AlbumItemModel(photo: UIImageView(image: UIImage(named: "eleventh")),
                           titleLabel: "Hotel",
                           imageCountLabel: "14"),
            AlbumItemModel(photo: UIImageView(image: UIImage(named: "twelfth")),
                           titleLabel: "Lifestyle",
                           imageCountLabel: "152")
        ]
    }

    //MARK: - Initial


    
    //MARK: - Settings

    func generateLayout() -> UICollectionViewLayout {
      let layout = UICollectionViewCompositionalLayout { (sectionIndex: Int,
        layoutEnvironment: NSCollectionLayoutEnvironment) -> NSCollectionLayoutSection in

        let sectionLayoutKind = Section.allCases[sectionIndex]
        switch (sectionLayoutKind) {
        case .firstSection: return self.generateFirstSectionLayout()
        case .secondSection: return self.generateSecondSectionLayout()
        }
      }
      return layout
    }

    func generateFirstSectionLayout() -> NSCollectionLayoutSection {
        let itemSize = NSCollectionLayoutSize(
            widthDimension: .fractionalWidth(1.0),
            heightDimension: .fractionalHeight(1.0))

        let item = NSCollectionLayoutItem(layoutSize: itemSize)
        item.contentInsets = NSDirectionalEdgeInsets(
            top: 4,
            leading: 4,
            bottom: 4,
            trailing: 4)

        let groupSize = NSCollectionLayoutSize(
            widthDimension: .fractionalWidth(0.9/2),
            heightDimension: .fractionalHeight(1.0))

        let group = NSCollectionLayoutGroup.vertical(
            layoutSize: groupSize,
            subitem: item,
            count: 2)

        group.interItemSpacing = .fixed(45.0)

        let rootGroupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .absolute(450))
        let rootGroup = NSCollectionLayoutGroup.horizontal(layoutSize: rootGroupSize, subitem: group, count: 2)

        let section = NSCollectionLayoutSection(group: rootGroup)
        section.interGroupSpacing = .zero
        section.contentInsets = NSDirectionalEdgeInsets(
            top: .zero,
            leading: .zero,
            bottom: 70,
            trailing: .zero)
        section.orthogonalScrollingBehavior = .continuousGroupLeadingBoundary

        let headerSize = NSCollectionLayoutSize(
            widthDimension: .fractionalWidth(1.0),
            heightDimension: .absolute(45))
        let header = NSCollectionLayoutBoundarySupplementaryItem(
            layoutSize: headerSize,
            elementKind: UICollectionView.elementKindSectionHeader,
            alignment: .top)

        section.boundarySupplementaryItems = [header]


//        let layout = UICollectionViewCompositionalLayout(section: section)
        
        return section
    }

    func generateSecondSectionLayout() -> NSCollectionLayoutSection {
        let itemSize = NSCollectionLayoutSize(
            widthDimension: .fractionalWidth(1.0),
            heightDimension: .fractionalHeight(1.0))

        let item = NSCollectionLayoutItem(layoutSize: itemSize)
        item.contentInsets = NSDirectionalEdgeInsets(
            top: 4,
            leading: 4,
            bottom: 4,
            trailing: 4)

        let groupSize = NSCollectionLayoutSize(
            widthDimension: .fractionalWidth(0.9/2),
            heightDimension: .fractionalHeight(0.9/2))

        let group = NSCollectionLayoutGroup.vertical(
            layoutSize: groupSize,
            subitem: item,
            count: 1)

        let rootGroupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .absolute(450))
        let rootGroup = NSCollectionLayoutGroup.horizontal(layoutSize: rootGroupSize, subitem: group, count: 2)

        let section = NSCollectionLayoutSection(group: rootGroup)
        section.orthogonalScrollingBehavior = .continuous

        let headerSize = NSCollectionLayoutSize(
            widthDimension: .fractionalWidth(1.0),
            heightDimension: .absolute(45))
        let header = NSCollectionLayoutBoundarySupplementaryItem(
            layoutSize: headerSize,
            elementKind: UICollectionView.elementKindSectionHeader,
            alignment: .top)

        section.boundarySupplementaryItems = [header]

        return section
    }

}


