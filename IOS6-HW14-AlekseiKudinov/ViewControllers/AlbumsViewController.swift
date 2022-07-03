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
        case thirdSection
        case fourthSection
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
        collectionView.register(AlbumItemCell.self,
                                forCellWithReuseIdentifier: AlbumItemCell.reuseIdentifer)
        collectionView.register(ListItemCell.self,
                                forCellWithReuseIdentifier: ListItemCell.reuseIdentifer)
        albumsCollectionView = collectionView
        collectionView.register(HeaderCollectionReusableView.self,
                                forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader,
                                withReuseIdentifier: HeaderCollectionReusableView.identifier)
    }

    func configureDataSource() {
        dataSource = UICollectionViewDiffableDataSource<Section, AlbumItemModel>(collectionView: albumsCollectionView ?? UICollectionView()) {
            (collectionView: UICollectionView, indexPath: IndexPath, albumItem: AlbumItemModel) -> UICollectionViewCell? in

            self.dataSource?.supplementaryViewProvider = { (
                collectionView: UICollectionView,
                kind: String,
                indexPath: IndexPath) -> UICollectionReusableView? in

                guard let supplementaryView = collectionView.dequeueReusableSupplementaryView(
                    ofKind: kind,
                    withReuseIdentifier: HeaderCollectionReusableView.identifier,
                    for: indexPath) as? HeaderCollectionReusableView else { fatalError("Хедер не создан") }
                supplementaryView.configure()

            switch indexPath.section {
            case 0:
                supplementaryView.label.text = "Мои альбомы"
                supplementaryView.button.text = "Все"
            case 1:
                supplementaryView.label.text = "Люди и места"
                supplementaryView.button.text = "Все"
            case 2:
                supplementaryView.label.text = "Типы медиафайлов"
                supplementaryView.button.isHidden = true
            case 3:
                supplementaryView.label.text = "Другое"
                supplementaryView.button.isHidden = true
                supplementaryView.separators.isHidden = true
            default:
                break
            }
                return supplementaryView
            }

            switch albumItem.cellType {

            case .album:
                guard let cell = collectionView.dequeueReusableCell(
                    withReuseIdentifier: AlbumItemCell.reuseIdentifer,
                    for: indexPath) as? AlbumItemCell else { fatalError("Ячейка не создана") }
                cell.photo.image = albumItem.imageView
                cell.titleLabel.text = albumItem.titleLabel
                cell.imageCountLabel.text = albumItem.imageCountLabel
                return cell

            case .list:
                guard let cell = collectionView.dequeueReusableCell(
                    withReuseIdentifier: ListItemCell.reuseIdentifer,
                    for: indexPath) as? ListItemCell else { fatalError("Ячейка не создана") }
                cell.photo.image = albumItem.imageView
                cell.titleLabel.text = albumItem.titleLabel
                cell.imageCountLabel.text = albumItem.imageCountLabel
                return cell
            }
        }

        let snapshot = snapshotForCurrentState()
        dataSource?.apply(snapshot, animatingDifferences: false)
    }

    func snapshotForCurrentState() -> NSDiffableDataSourceSnapshot<Section, AlbumItemModel> {
        var snapshot = NSDiffableDataSourceSnapshot<Section,AlbumItemModel>()

        let itemsForFirstSection = Array(AlbumItemModel.itemsForAlbums().prefix(8))
        let itemsForSecondSection = Array(AlbumItemModel.itemsForAlbums().suffix(4))
        let itemsForThirdSection = Array(AlbumItemModel.itemsForList().prefix(7))
        let itemsForFourthSection = Array(AlbumItemModel.itemsForList().suffix(3))

        snapshot.appendSections([Section.firstSection])
        snapshot.appendItems(itemsForFirstSection)

        snapshot.appendSections([Section.secondSection])
        snapshot.appendItems(itemsForSecondSection)

        snapshot.appendSections([Section.thirdSection])
        snapshot.appendItems(itemsForThirdSection)

        snapshot.appendSections([Section.fourthSection])
        snapshot.appendItems(itemsForFourthSection)

        return snapshot
    }
    
    //MARK: - Settings

    func generateLayout() -> UICollectionViewLayout {
      let layout = UICollectionViewCompositionalLayout { (sectionIndex: Int,
        layoutEnvironment: NSCollectionLayoutEnvironment) -> NSCollectionLayoutSection in

          let sectionLayoutKind = Section.allCases[sectionIndex]
          switch (sectionLayoutKind) {
          case .firstSection: return self.generateFirstSectionLayout()
          case .secondSection: return self.generateSecondSectionLayout()
          case .thirdSection: return self.generateThirdSectionLayout(layout: layoutEnvironment)
          case .fourthSection: return self.generateFourthSectionLayout(layout: layoutEnvironment)
          }
      }
      return layout
    }

    func generateFirstSectionLayout() -> NSCollectionLayoutSection {
        let itemSize = NSCollectionLayoutSize(
            widthDimension: .fractionalWidth(1.0),
            heightDimension: .fractionalHeight(1.0)
        )
        let item = NSCollectionLayoutItem(layoutSize: itemSize)
        item.contentInsets = NSDirectionalEdgeInsets(
            top: 5,
            leading: 5,
            bottom: 5,
            trailing: 5
        )

        let groupSize = NSCollectionLayoutSize(
            widthDimension: .fractionalWidth(0.9/2),
            heightDimension: .fractionalHeight(1.0)
        )
        let group = NSCollectionLayoutGroup.vertical(
            layoutSize: groupSize,
            subitem: item,
            count: 2
        )
        group.interItemSpacing = .fixed(45.0)

        let rootGroupSize = NSCollectionLayoutSize(
            widthDimension: .fractionalWidth(1.0),
            heightDimension: .absolute(450)
        )
        let rootGroup = NSCollectionLayoutGroup.horizontal(
            layoutSize: rootGroupSize,
            subitem: group, count: 2
        )

        let section = NSCollectionLayoutSection(group: rootGroup)
        section.interGroupSpacing = .zero
        section.contentInsets = NSDirectionalEdgeInsets(
            top: .zero,
            leading: .zero,
            bottom: 70,
            trailing: .zero
        )
        section.orthogonalScrollingBehavior = .continuousGroupLeadingBoundary

        let headerSize = NSCollectionLayoutSize(
            widthDimension: .fractionalWidth(1.0),
            heightDimension: .absolute(45)
        )
        let header = NSCollectionLayoutBoundarySupplementaryItem(
            layoutSize: headerSize,
            elementKind: UICollectionView.elementKindSectionHeader,
            alignment: .top
        )
        section.boundarySupplementaryItems = [header]
        return section
    }

    func generateSecondSectionLayout() -> NSCollectionLayoutSection {
        let itemSize = NSCollectionLayoutSize(
            widthDimension: .absolute(210),
            heightDimension: .absolute(210))
        let item = NSCollectionLayoutItem(layoutSize: itemSize)
        item.contentInsets = NSDirectionalEdgeInsets(
            top: 5,
            leading: 5,
            bottom: 5,
            trailing: 5
        )

        let groupSize = NSCollectionLayoutSize(
            widthDimension: .absolute(210),
            heightDimension: .absolute(210)
        )
        let group = NSCollectionLayoutGroup.vertical(
            layoutSize: groupSize,
            subitem: item, count: 1
        )
        group.contentInsets = NSDirectionalEdgeInsets(
            top: 5,
            leading: 5,
            bottom: 5,
            trailing: 5
        )

        let headerSize = NSCollectionLayoutSize(
            widthDimension: .fractionalWidth(1.0),
            heightDimension: .absolute(45))
        let header = NSCollectionLayoutBoundarySupplementaryItem(
            layoutSize: headerSize,
            elementKind: UICollectionView.elementKindSectionHeader,
            alignment: .top)

        let section = NSCollectionLayoutSection(group: group)
        section.contentInsets = NSDirectionalEdgeInsets(
            top: .zero,
            leading: .zero,
            bottom: 50,
            trailing: .zero
        )
        section.orthogonalScrollingBehavior = .continuousGroupLeadingBoundary
        section.boundarySupplementaryItems = [header]
        return section
    }

    func generateThirdSectionLayout(layout: NSCollectionLayoutEnvironment) -> NSCollectionLayoutSection {
        let section = NSCollectionLayoutSection.list(
            using: .init(appearance: .plain),
            layoutEnvironment: layout
        )

        let headerSize = NSCollectionLayoutSize(
            widthDimension: .fractionalWidth(1.0),
            heightDimension: .absolute(45)
        )
        let header = NSCollectionLayoutBoundarySupplementaryItem(
            layoutSize: headerSize,
            elementKind: UICollectionView.elementKindSectionHeader,
            alignment: .top
        )

        section.boundarySupplementaryItems = [header]
        return section
    }

    func generateFourthSectionLayout(layout: NSCollectionLayoutEnvironment) -> NSCollectionLayoutSection {
        let section = NSCollectionLayoutSection.list(
            using: .init(appearance: .plain),
            layoutEnvironment: layout
        )

        let headerSize = NSCollectionLayoutSize(
            widthDimension: .fractionalWidth(1.0),
            heightDimension: .absolute(45)
        )
        let header = NSCollectionLayoutBoundarySupplementaryItem(
            layoutSize: headerSize,
            elementKind: UICollectionView.elementKindSectionHeader,
            alignment: .top)

        section.boundarySupplementaryItems = [header]
        return section
    }

}


