//
//  AlbumsViewController.swift
//  IOS6-HW14-AlekseiKudinov
//
//  Created by Алексей Кудинов on 11.06.2022.
//

import UIKit

class AlbumsViewController: UIViewController {


    //MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = .white
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationItem.leftBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: nil)
        title = "Альбомы"
    }

    //MARK: - Initial
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }

    //MARK: - Settings

    private func setupHierarchy() {

    }

    private func setupLayout() {
        
    }
}
